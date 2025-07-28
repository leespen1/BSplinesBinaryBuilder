using BinaryBuilder
using Pkg: PackageSpec

name = "BSplines"
version = v"0.1.12"

sources = [
    DirectorySource("./src"), 
]

script = raw"""
cd ${WORKSPACE}/srcdir
gfortran -O3 -shared -fPIC -fdefault-real-8 bsplvb.f bsplvd.f -o libbsplines.${dlext}
install -D libbsplines.${dlext} ${libdir}/libbsplines.${dlext}
"""                                      

## Just the host platform
#host_plat = HostPlatform()
#host_plat_nojulia = Platform(arch(host_plat), os(host_plat))
#platforms = [host_plat_nojulia]
## All platforms, will take a long time (and maybe run out of disk)
#platforms = supported_platforms() 
## Main platfroms
platforms = [
    Platform("x86_64", "linux"),
    Platform("x86_64", "windows"),
    Platform("x86_64", "macos"),
    Platform("aarch64", "macos"),
]
platforms = expand_gfortran_versions(platforms)

products = [
    LibraryProduct("libbsplines", :libbsplines),
]

dependencies = [
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
    dependencies,
    julia_compat="1.6",
)
