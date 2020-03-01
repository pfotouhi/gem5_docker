#!/bin/bash


# Compile all benchmark in pannotia 
cd /pannotia
make

# Get the input graph for SSSP
cd dataset/sssp
wget http://users.diag.uniroma1.it/challenge9/data/USA-road-d/USA-road-d.NW.gr.gz
gunzip USA-road-d.NW.gr.gz

cd /gem5

# Validate that gem5 can be built
scons -j$(nproc) build/GCN3_X86/gem5.opt --ignore-style
ret=$?
if [ $ret -ne 0 ]; then
    exit 1
fi

# Test BC
build/GCN3_X86/gem5.opt configs/example/apu_se.py -n2 \
       	--benchmark-root=/pannotia/graph_app/bc/ \
	-cbc \
	--options="/pannotia/dataset/bc/1k_128k.gr /pannotia/graph_app/bc/kernel/kernel.cl 0"
ret=$?
if [ $ret -ne 0 ]; then
    exit 1
fi
exit 0

# Test Color_Max
build/GCN3_X86/gem5.opt configs/example/apu_se.py -n2 \
       	--benchmark-root=/pannotia/graph_app/color/ \
	-ccoloring_max \
	--options="/pannotia/dataset/color/ecology1.graph /pannotia/graph_app/color/kernel/kernel_max.cl 1"
ret=$?
if [ $ret -ne 0 ]; then
    exit 1
fi
exit 0

# Test Color_MaxMin
build/GCN3_X86/gem5.opt configs/example/apu_se.py -n2 \
       	--benchmark-root=/pannotia/graph_app/color/ \
	-ccoloring_maxmin \
	--options="/pannotia/dataset/color/ecology1.graph /pannotia/graph_app/color/kernel/kernel_maxmin.cl 1"
ret=$?
if [ $ret -ne 0 ]; then
    exit 1
fi
exit 0

# Test Floyd Warshall
build/GCN3_X86/gem5.opt configs/example/apu_se.py -n2 \
       	--benchmark-root=/pannotia/graph_app/fw/ \
	-cfloyd-warshall \
	--options="/pannotia/dataset/floydwarshall/512_65536.gr /pannotia/graph_app/fw/kernel/kernel.cl"
ret=$?
if [ $ret -ne 0 ]; then
    exit 1
fi
exit 0

# Test Floyd Warshall Block
build/GCN3_X86/gem5.opt configs/example/apu_se.py -n2 \
       	--benchmark-root=/pannotia/graph_app/fw/ \
	-cfloyd-warshall-block \
	--options="/pannotia/dataset/floydwarshall/512_65536.gr /pannotia/graph_app/fw/kernel/kernel_block.cl"
ret=$?
if [ $ret -ne 0 ]; then
    exit 1
fi
exit 0

# Test MIS
build/GCN3_X86/gem5.opt configs/example/apu_se.py -n2 \
       	--benchmark-root=/pannotia/graph_app/mis/ \
	-cmis \
	--options="/pannotia/dataset/mis/ecology1.graph /pannotia/graph_app/mis/kernel/kernel.cl 1"
ret=$?
if [ $ret -ne 0 ]; then
    exit 1
fi
exit 0

# Test Pagerank
build/GCN3_X86/gem5.opt configs/example/apu_se.py -n2 \
       	--benchmark-root=/pannotia/graph_app/prk/ \
	-cpagerank \
	--options="/pannotia/dataset/pagerank/coAuthorsDBLP.graph /pannotia/graph_app/prk/kernel/kernel.cl 1"
ret=$?
if [ $ret -ne 0 ]; then
    exit 1
fi
exit 0

# Test Pagerank SPMV
build/GCN3_X86/gem5.opt configs/example/apu_se.py -n2 \
       	--benchmark-root=/pannotia/graph_app/prk/ \
	-cpagerank_spmv \
	--options="/pannotia/dataset/pagerank/coAuthorsDBLP.graph /pannotia/graph_app/prk/kernel/kernel_spmv.cl"
ret=$?
if [ $ret -ne 0 ]; then
    exit 1
fi
exit 0

# Test SSSP CSR
build/GCN3_X86/gem5.opt configs/example/apu_se.py -n2 \
       	--benchmark-root=/pannotia/graph_app/sssp/ \
	-csssp_csr \
	--options="/pannotia/dataset/sssp/USA-road-d.NW.gr /pannotia/graph_app/sssp/kernel/kernel_csr.cl 0"
ret=$?
if [ $ret -ne 0 ]; then
    exit 1
fi
exit 0

# Test SSSP ELL
build/GCN3_X86/gem5.opt configs/example/apu_se.py -n2 \
       	--benchmark-root=/pannotia/graph_app/sssp/ \
	-csssp_ell \
	--options="/pannotia/dataset/sssp/USA-road-d.NW.gr /pannotia/graph_app/sssp/kernel/kernel_ell.cl 0"
ret=$?
if [ $ret -ne 0 ]; then
    exit 1
fi
exit 0
