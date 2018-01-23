# Copyright 2017 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================
########################################################
# tf_core_cpu library
########################################################
file(GLOB_RECURSE tf_core_cpu_srcs
    "${tensorflow_source_dir}/tensorflow/cc/saved_model/*.h"
    "${tensorflow_source_dir}/tensorflow/cc/saved_model/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/*.h"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/debug/*.h"
    "${tensorflow_source_dir}/tensorflow/core/debug/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/distributed_runtime/server_lib.h"
    "${tensorflow_source_dir}/tensorflow/core/distributed_runtime/server_lib.cc"
    "${tensorflow_source_dir}/tensorflow/core/graph/*.h"
    "${tensorflow_source_dir}/tensorflow/core/graph/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/grappler/*.h"
    "${tensorflow_source_dir}/tensorflow/core/grappler/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/grappler/*/*.h"
    "${tensorflow_source_dir}/tensorflow/core/grappler/*/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/public/*.h"
)

set(TF_SOURCE_ROOT "${tensorflow_source_dir}/tensorflow/")
if(${CMAKE_VERSION} VERSION_GREATER_EQUAL 3.8.0)
  source_group(TREE ${TF_SOURCE_ROOT} FILES ${tf_core_cpu_srcs}) 
endif()

file(GLOB_RECURSE tf_core_cpu_srcs_grappler_cost "${tensorflow_source_dir}/tensorflow/core/grappler/costs/*.cc")
file(GLOB_RECURSE tf_core_cpu_srcs_grappler_inputs "${tensorflow_source_dir}/tensorflow/core/grappler/inputs/*.cc")
file(GLOB_RECURSE tf_core_cpu_srcs_grappler_optimizers "${tensorflow_source_dir}/tensorflow/core/grappler/optimizers/*.cc")

list(REMOVE_ITEM tf_core_cpu_srcs ${tf_core_cpu_srcs_grappler_cost})
list(REMOVE_ITEM tf_core_cpu_srcs ${tf_core_cpu_srcs_grappler_inputs})
list(REMOVE_ITEM tf_core_cpu_srcs ${tf_core_cpu_srcs_grappler_optimizers})



file(GLOB_RECURSE tf_core_cpu_exclude_srcs
    "${tensorflow_source_dir}/tensorflow/cc/saved_model/*test*.h"
    "${tensorflow_source_dir}/tensorflow/cc/saved_model/*test*.cc"
    "${tensorflow_source_dir}/tensorflow/core/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/*test*.cc"
    "${tensorflow_source_dir}/tensorflow/core/*main.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/gpu/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/gpu_device_factory.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/direct_session.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/direct_session.h"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/session.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/session_factory.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/session_options.cc"
    "${tensorflow_source_dir}/tensorflow/core/graph/edgeset.h"
    "${tensorflow_source_dir}/tensorflow/core/graph/edgeset.cc"
    "${tensorflow_source_dir}/tensorflow/core/graph/graph.h"
    "${tensorflow_source_dir}/tensorflow/core/graph/graph.cc"
    "${tensorflow_source_dir}/tensorflow/core/graph/while_context.h"
    "${tensorflow_source_dir}/tensorflow/core/graph/while_context.cc"
    "${tensorflow_source_dir}/tensorflow/core/grappler/clusters/single_machine.h"
    "${tensorflow_source_dir}/tensorflow/core/grappler/clusters/single_machine.cc"
    "${tensorflow_source_dir}/tensorflow/core/grappler/inputs/trivial_test_graph_input_yielder.h"
    "${tensorflow_source_dir}/tensorflow/core/grappler/inputs/trivial_test_graph_input_yielder.cc"
)

list(REMOVE_ITEM tf_core_cpu_srcs ${tf_core_cpu_exclude_srcs})
list(REMOVE_ITEM tf_core_cpu_srcs_grappler_inputs ${tf_core_cpu_exclude_srcs})
list(REMOVE_ITEM tf_core_cpu_srcs_grappler_cost ${tf_core_cpu_exclude_srcs})
list(REMOVE_ITEM tf_core_cpu_grappler_optimizers ${tf_core_cpu_exclude_srcs})


if (tensorflow_ENABLE_GPU)
  file(GLOB_RECURSE tf_core_gpu_srcs
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/gpu/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/platform/default/gpu/cupti_wrapper.cc"
    "${tensorflow_source_dir}/tensorflow/core/platform/default/device_tracer.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/gpu_device_factory.cc"
    "${tensorflow_source_dir}/tensorflow/core/grappler/devices.h"
    "${tensorflow_source_dir}/tensorflow/core/grappler/devices.cc"
  )
  file(GLOB_RECURSE tf_core_gpu_exclude_srcs
     "${tensorflow_source_dir}/tensorflow/core/*test*.cc"
     "${tensorflow_source_dir}/tensorflow/core/*test*.cc"
  )
  list(REMOVE_ITEM tf_core_gpu_srcs ${tf_core_gpu_exclude_srcs})
  list(APPEND tf_core_cpu_srcs ${tf_core_gpu_srcs})
endif()

add_library(tf_core_cpu OBJECT ${tf_core_cpu_srcs})
add_library(tf_core_cpu_grappler_costs OBJECT ${tf_core_cpu_srcs_grappler_cost})
add_library(tf_core_cpu_grappler_inputs OBJECT ${tf_core_cpu_srcs_grappler_inputs})
add_library(tf_core_cpu_grappler_optimizers OBJECT ${tf_core_cpu_srcs_grappler_optimizers})


add_dependencies(tf_core_cpu tf_core_framework)
add_dependencies(tf_core_cpu_grappler_costs tf_core_framework)
add_dependencies(tf_core_cpu_grappler_inputs tf_core_framework)
add_dependencies(tf_core_cpu_grappler_optimizers tf_core_framework)
add_dependencies(tf_core_cpu tf_core_cpu_grappler_costs tf_core_cpu_grappler_inputs tf_core_cpu_grappler_optimizers)

