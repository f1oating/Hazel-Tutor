#pragma once

#include <iostream>
#include <memory>
#include <utility>
#include <algorithm>
#include <functional>

#include <string>
#include <vector>
#include <sstream>
#include <array>
#include <unordered_map>
#include <unordered_set>

#include "Hazel/Core/Log.h"

#include "Hazel/Debug/Instrumentor.h"

#ifdef HZ_PLATFORM_WINDOWS
	#include <Windows.h>
#endif