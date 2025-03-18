workspace "Hazel-Tutor"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLFW"] = "Hazel-Tutor/vendor/GLFW/include"
IncludeDir["Glad"] = "Hazel-Tutor/vendor/Glad/include"
IncludeDir["imgui"] = "Hazel-Tutor/vendor/imgui"

include "Hazel-Tutor/vendor/GLFW"
include "Hazel-Tutor/vendor/Glad"
include "Hazel-Tutor/vendor/imgui"

project "Hazel-Tutor"
	location "Hazel-Tutor"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hzpch.h"
	pchsource "Hazel/src/hzpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/vendor/spdlog/include",
		"%{prj.name}/src",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.imgui}"
	}

	links 
	{ 
		"GLFW",
		"Glad",
		"imgui",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		buildoptions "/MDd /utf-8"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		buildoptions "/MD /utf-8"
		optimize "On"	

	filter "configurations:Dist"
		defines "HZ_DIST"
		buildoptions "/MD /utf-8"
		optimize "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Hazel-Tutor/vendor/spdlog/include",
		"Hazel-Tutor/src"
	}

	links
	{
		"Hazel-Tutor"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		buildoptions "/MDd /utf-8"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		buildoptions "/MD /utf-8"
		optimize "On"	

	filter "configurations:Dist"
		defines "HZ_DIST"
		buildoptions "/MD /utf-8"
		optimize "On"