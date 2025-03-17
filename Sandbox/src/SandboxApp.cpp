#include <iostream>
#include <memory>
#include <utility>
#include <algorithm>
#include <functional>

#include <string>
#include <vector>
#include <sstream>
#include <unordered_map>
#include <unordered_set>
#include <Hazel.h>

class Sandbox : public Hazel::Application
{
public:
	Sandbox()
	{

	}

	~Sandbox()
	{

	}

};

Hazel::Application* Hazel::CreateApplication()
{
	return new Sandbox();
}