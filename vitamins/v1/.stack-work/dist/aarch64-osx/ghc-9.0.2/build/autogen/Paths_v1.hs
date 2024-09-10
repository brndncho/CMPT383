{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_v1 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/brandoncho/Downloads/coding/CMPT383/vitamins/v1/.stack-work/install/aarch64-osx/cb0e72626d8bc8d81775cb0932c6b8451850b9ae3f581ae69bbc147e5a4126d2/9.0.2/bin"
libdir     = "/Users/brandoncho/Downloads/coding/CMPT383/vitamins/v1/.stack-work/install/aarch64-osx/cb0e72626d8bc8d81775cb0932c6b8451850b9ae3f581ae69bbc147e5a4126d2/9.0.2/lib/aarch64-osx-ghc-9.0.2/v1-0.1.0.0-1cVKa1UikutFXyCOzQIOiH"
dynlibdir  = "/Users/brandoncho/Downloads/coding/CMPT383/vitamins/v1/.stack-work/install/aarch64-osx/cb0e72626d8bc8d81775cb0932c6b8451850b9ae3f581ae69bbc147e5a4126d2/9.0.2/lib/aarch64-osx-ghc-9.0.2"
datadir    = "/Users/brandoncho/Downloads/coding/CMPT383/vitamins/v1/.stack-work/install/aarch64-osx/cb0e72626d8bc8d81775cb0932c6b8451850b9ae3f581ae69bbc147e5a4126d2/9.0.2/share/aarch64-osx-ghc-9.0.2/v1-0.1.0.0"
libexecdir = "/Users/brandoncho/Downloads/coding/CMPT383/vitamins/v1/.stack-work/install/aarch64-osx/cb0e72626d8bc8d81775cb0932c6b8451850b9ae3f581ae69bbc147e5a4126d2/9.0.2/libexec/aarch64-osx-ghc-9.0.2/v1-0.1.0.0"
sysconfdir = "/Users/brandoncho/Downloads/coding/CMPT383/vitamins/v1/.stack-work/install/aarch64-osx/cb0e72626d8bc8d81775cb0932c6b8451850b9ae3f581ae69bbc147e5a4126d2/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "v1_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "v1_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "v1_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "v1_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "v1_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "v1_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
