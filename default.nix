with (import <nixpkgs> {});
let
  LLP = with pkgs; [
    #gcc12
    openssl
    pkg-config
    cudatoolkit
    cudaPackages.cudnn
    cudaPackages.cudnn.dev
    #cudaPackages.cudatoolkit-legacy-runfile
    #dlib
    blas 
    openblas
    lapack
    linuxPackages.nvidia_x11
    cmake
    rustc
    cargo
    ffmpeg-full
    sox
    
    cudaPackages.cuda_cudart
    cudaPackages.cuda_nvcc
    cudaPackages.libcublas
    cudaPackages.libcurand
    cudaPackages.libcusolver
    #cudaPackages.cudnn
    cudaPackages.cuda_cccl
    
    opencv
    python3
  ];
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath LLP;
in  
stdenv.mkDerivation {
  name = "candle-env";
  buildInputs = LLP;
  src = null;
  shellHook = ''
    SOURCE_DATE_EPOCH=$(date +%s)
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}
    export CUDA_ROOT=${cudatoolkit.out}
    export CUDNN_LIB=${cudaPackages.cudnn.dev}
    export NVCC_CCBIN=${gcc12}/bin
  '';
}
