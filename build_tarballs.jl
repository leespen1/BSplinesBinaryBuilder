using BinaryBuilder
using Pkg: PackageSpec

name = "bsplines"
version = v"0.1"

# Think ChatGPT uses FileSource incorrectlyhere
# Filesource is downloaded from the internet, DirectorySource is local
sources = [
    DirectorySource("./src"), 
]

#cd ${WORKSPACE}/srcdir/bsplines
script = raw"""
install -D LICENSE {prefix}/share/licenses/bsplines/LICENSE
mkdir -p "${libdir}"
gfortran -c -O3 -shared -fPIC -fdefault-real-8 bsplvb.f -o $libdir/libbsplvb.o
gfortran -c -O3 -shared -fPIC -fdefault-real-8 bsplvd.f -o $libdir/libbsplvd.o
gfortran -shared -o $libdir/libbsplines.${dlext} $libdir/libbsplvb.o $libdir/libbsplvd.o
"""                                      

# Only linux for now
platforms = [HostPlatform()]
#platforms = supported_platforms()
platforms = expand_gfortran_versions(platforms)

products = [
    LibraryProduct("libbsplines", :libbsplines)
]

dependencies = [
    # Silences a warning
    Dependency(PackageSpec(name="CompilerSupportLibraries_jll", uuid="e66e0078-7015-5450-92f7-15fbd957f2ae")),
]


build_tarballs(
    ARGS,
    name,
    version,
    sources,
    script,
    platforms,
    products,
    dependencies
)
