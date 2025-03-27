workspace "Hazel-Tutor"
	architecture "x64"
	startproject "Sandbox"

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
IncludeDir["glm"] = "Hazel-Tutor/vendor/glm"
IncludeDir["stb_image"] = "Hazel-Tutor/vendor/stb_image"

include "Hazel-Tutor/vendor/GLFW"
include "Hazel-Tutor/vendor/Glad"
include "Hazel-Tutor/vendor/imgui"

project "Hazel-Tutor"
	location "Hazel-Tutor"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hzpch.h"
	pchsource "Hazel/src/hzpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/stb_image/**.cpp",
		"%{prj.name}/vendor/stb_image/**.h",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl"
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

	includedirs
	{
		"%{prj.name}/vendor/spdlog/include",
		"%{prj.name}/src",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.imgui}",	
		"%{IncludeDir.glm}",
		"%{IncludeDir.stb_image}"
	}

	links 
	{ 
		"GLFW",
		"Glad",
		"imgui",
		"opengl32.lib"
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		buildoptions "/utf-8"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Release"
		buildoptions "/utf-8"
		optimize "On"	

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Release"
		buildoptions "/utf-8"
		optimize "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

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
		"Hazel-Tutor/src",
		"Hazel-Tutor/vendor",
		"%{IncludeDir.glm}"
	}

	links
	{
		"Hazel-Tutor"
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		buildoptions "/utf-8"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Release"
		buildoptions "/utf-8"
		optimize "On"	

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Release"
		buildoptions "/utf-8"
		optimize "On"