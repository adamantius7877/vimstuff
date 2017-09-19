#! /bin/bash

# Variables
vimdir=$HOME/.vim
vimrc=$HOME/.vimrc
vimbundle=$vimdir/bundle
vimautoload=$vimdir/autoload

# BEGIN Functions
function removeDirectory
{
    rm -fR $1
}

function addToVimrc
{
    local grepcall=$(grep "$1" $vimrc)
    if [ ! "$grepcall" = "$1" ]; then
        echo $1 >> $vimrc
    fi
}

function writeRestOfVimrc
{
    echo "Writing vimrc..."
    addToVimrc "syntax on" 
    addToVimrc "set t_Co=256" 
    addToVimrc "set shiftwidth=4" 
    addToVimrc "set tabstop=4" 
    addToVimrc "set number" 
    addToVimrc "filetype plugin indent on" 
    addToVimrc "set relativenumber"
    addToVimrc "set expandtab"
}

function install_Pathogen
{
    if [ ! -f $vimautoload/pathogen.vim ]; then
        # Get the plugin
        git clone https://github.com/tpope/vim-pathogen.git $vimdir/vim-pathogen
        mv $vimdir/vim-pathogen/autoload/pathogen.vim $vimautoload
        removeDirectory $vimdir/vim-pathogen
        
        # Update vimrc
        addToVimrc "call pathogen#infect()" 
        addToVimrc "call pathogen#helptags()"
    else
        echo "Pathogen already detected, skipping."
    fi
}

function install_AtomDark
{
    if [ ! -f $vimdir/colors/atom-dark-256.vim ]; then
        # This is for the coloring
        git clone https://github.com/gosukiwi/vim-atom-dark.git $vimdir/vim-atom-dark
        cp -R $vimdir/vim-atom-dark/colors $vimdir/colors/
        removeDirectory $vimdir/vim-atom-dark

        # Update vimrc
        addToVimrc "colorscheme atom-dark-256" 
    else
        echo "Atom dark already detected, skipping."
    fi
}

function install_PythonMode
{
    if [ ! -d $vimbundle/python-mode ]; then
        # Get the plugin
        git clone https://github.com/klen/python-mode.git $vimbundle/python-mode 
    else
        echo "Python-mode already detected, skipping."
    fi
}

function install_NERDTree
{
    if [ ! -d $vimbundle/nerdtree ]; then
        # Get the plugin
        git clone https://github.com/scrooloose/nerdtree.git $vimbundle/nerdtree
    else
        echo "NERDTree already detected, skipping."
    fi
}

function install_YouCompleteMe
{
    if [ ! -d $vimbundle/YouCompleteMe ]; then
        # First insall prerequisites
        sudo apt-get install build-essential cmake python-dev -y
        # Get the plugin
        git clone https://github.com/Valloric/YouCompleteMe.git $vimbundle/YouCompleteMe
        cd $vimbundle/YouCompleteMe
        git submodule update --init --recursive 
        # Install the plugin
        /bin/bash $vimbundle/YouCompleteMe/install.sh --clang-completer
        # Update vimrc
        addToVimrc "let g:pymode_rope_completion = 0"
    else
        echo "YouCompleteMe already detected, skipping."
    fi
}

function install_TwitVim
{
    if [ ! -d $vimbundle/TwitVim ]; then
        # Get the plugin
        git clone https://github.com/vim-scripts/TwitVim.git $vimbundle/TwitVim 
        
    else
        echo "TwitVim already detected, skipping."
    fi
}

function install_dbext
{
    if [ ! -d $vimbundle/dbext ]; then
        # Get the plugin
        git clone https://github.com/vim-scripts/dbext.vim.git $vimbundle/dbext 
        
    else
        echo "dbext already detected, skipping."
    fi
}

# END Functions

# Make sure git and vim are installed
if [ ! -f /usr/bin/vim ]; then
    sudo apt-get install vim -y
fi
if [ ! -f /usr/bin/git ]; then
    sudo apt-get install git -y
fi

# Create the vim directories needed for both vim and the plugins
if [ ! -d $vimdir ]; then
    mkdir $vimdir
fi
if [ ! -d $vimbundle ]; then
    mkdir $vimbundle
fi
if [ ! -d $vimautoload ]; then
    mkdir $vimautoload
fi

# Create the vimrc file
#  Note:  Initial vimrc file will be done here, but plugin specific statements will be added in their respective sections
if [ ! -f $vimrc ]; then
    touch $vimrc
fi

# Install all plugins
install_Pathogen
install_AtomDark
install_PythonMode
install_NERDTree
install_YouCompleteMe
install_TwitVim
install_dbext

# Add the rest of the vimrc options
writeRestOfVimrc
