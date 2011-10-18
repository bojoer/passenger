#  Phusion Passenger - http://www.modrails.com/
#  Copyright (c) 2010 Phusion
#
#  "Phusion Passenger" is a trademark of Hongli Lai & Ninh Bui.
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

dependencies = [
	'ext/common/agents/Watchdog/Main.cpp',
	'ext/common/ServerInstanceDir.h',
	'ext/common/ResourceLocator.h',
	'ext/common/Utils/VariantMap.h',
	LIBBOOST_OXT,
	LIBCOMMON
]
file AGENT_OUTPUT_DIR + 'PassengerWatchdog' => dependencies do
	sh "mkdir -p #{AGENT_OUTPUT_DIR}" if !File.directory?(AGENT_OUTPUT_DIR)
	create_executable(AGENT_OUTPUT_DIR + 'PassengerWatchdog',
		'ext/common/agents/Watchdog/Main.cpp',
		"-Iext -Iext/common #{PlatformInfo.portability_cflags} #{EXTRA_CXXFLAGS} " <<
		"#{LIBCOMMON} " <<
		"#{LIBBOOST_OXT} " <<
		"#{PlatformInfo.portability_ldflags} " <<
		"#{AGENT_LDFLAGS} " <<
		"#{EXTRA_LDFLAGS}")
end

dependencies = [
	'ext/common/agents/HelperAgent/Main.cpp',
	'ext/common/agents/HelperAgent/ScgiRequestParser.h',
	'ext/common/agents/HelperAgent/BacktracesServer.h',
	'ext/common/StaticString.h',
	'ext/common/Account.h',
	'ext/common/AccountsDatabase.h',
	'ext/common/MessageServer.h',
	'ext/common/FileDescriptor.h',
	'ext/common/SpawnManager.h',
	'ext/common/Logging.h',
	'ext/common/ResourceLocator.h',
	'ext/common/Utils/ProcessMetricsCollector.h',
	'ext/common/Utils/VariantMap.h',
	'ext/common/ApplicationPool/Interface.h',
	'ext/common/ApplicationPool/Pool.h',
	'ext/common/ApplicationPool/Server.h',
	LIBBOOST_OXT,
	LIBCOMMON,
	:libev
]
file AGENT_OUTPUT_DIR + 'PassengerHelperAgent' => dependencies do
	sh "mkdir -p #{AGENT_OUTPUT_DIR}" if !File.directory?(AGENT_OUTPUT_DIR)
	create_executable "#{AGENT_OUTPUT_DIR}PassengerHelperAgent",
		'ext/common/agents/HelperAgent/Main.cpp',
		"-Iext -Iext/common #{LIBEV_CFLAGS} " <<
		"#{PlatformInfo.portability_cflags} " <<
		"#{EXTRA_CXXFLAGS}  " <<
		"#{LIBCOMMON} " <<
		"#{LIBBOOST_OXT} " <<
		"#{LIBEV_LIBS} " <<
		"#{PlatformInfo.portability_ldflags} " <<
		"#{AGENT_LDFLAGS} " <<
		"#{EXTRA_LDFLAGS}"
end

dependencies = [
	'ext/common/agents/LoggingAgent/Main.cpp',
	'ext/common/agents/LoggingAgent/LoggingServer.h',
	'ext/common/agents/LoggingAgent/RemoteSender.h',
	'ext/common/agents/LoggingAgent/DataStoreId.h',
	'ext/common/agents/LoggingAgent/FilterSupport.h',
	'ext/common/ServerInstanceDir.h',
	'ext/common/Logging.h',
	'ext/common/EventedServer.h',
	'ext/common/EventedClient.h',
	'ext/common/Utils/VariantMap.h',
	'ext/common/Utils/BlockingQueue.h',
	LIBCOMMON,
	LIBBOOST_OXT,
	:libev
]
file AGENT_OUTPUT_DIR + 'PassengerLoggingAgent' => dependencies do
	sh "mkdir -p #{AGENT_OUTPUT_DIR}" if !File.directory?(AGENT_OUTPUT_DIR)
	create_executable(AGENT_OUTPUT_DIR + 'PassengerLoggingAgent',
		'ext/common/agents/LoggingAgent/Main.cpp',
		"-Iext -Iext/common #{LIBEV_CFLAGS} " <<
		"#{PlatformInfo.curl_flags} " <<
		"#{PlatformInfo.zlib_flags} " <<
		"#{PlatformInfo.portability_cflags} #{EXTRA_CXXFLAGS} " <<
		"#{LIBCOMMON} " <<
		"#{LIBBOOST_OXT} " <<
		"#{LIBEV_LIBS} " <<
		"#{PlatformInfo.curl_libs} " <<
		"#{PlatformInfo.zlib_libs} " <<
		"#{PlatformInfo.portability_ldflags} " <<
		"#{AGENT_LDFLAGS} " <<
		"#{EXTRA_LDFLAGS}")
end

dependencies = [
	'ext/common/agents/SpawnPreparer.cpp',
	LIBCOMMON,
	LIBBOOST_OXT
]
file AGENT_OUTPUT_DIR + 'SpawnPreparer' => dependencies do
	sh "mkdir -p #{AGENT_OUTPUT_DIR}" if !File.directory?(AGENT_OUTPUT_DIR)
	create_executable(AGENT_OUTPUT_DIR + 'SpawnPreparer',
		'ext/common/agents/SpawnPreparer.cpp',
		"-Iext -Iext/common " <<
		"#{PlatformInfo.portability_cflags} #{EXTRA_CXXFLAGS} " <<
		"#{LIBCOMMON} " <<
		"#{LIBBOOST_OXT} " <<
		"#{PlatformInfo.portability_ldflags} " <<
		"#{EXTRA_LDFLAGS}")
end

file AGENT_OUTPUT_DIR + 'EnvPrinter' => 'ext/common/agents/EnvPrinter.c' do
	sh "mkdir -p #{AGENT_OUTPUT_DIR}" if !File.directory?(AGENT_OUTPUT_DIR)
	create_c_executable(AGENT_OUTPUT_DIR + 'EnvPrinter',
		'ext/common/agents/EnvPrinter.c')
end

task 'common:clean' do
	sh "rm -rf #{AGENT_OUTPUT_DIR}PassengerWatchdog #{AGENT_OUTPUT_DIR}PassengerWatchdog.dSYM"
	sh "rm -rf #{AGENT_OUTPUT_DIR}PassengerHelperAgent #{AGENT_OUTPUT_DIR}PassengerHelperAgent.dSYM"
	sh "rm -rf #{AGENT_OUTPUT_DIR}PassengerLoggingAgent #{AGENT_OUTPUT_DIR}PassengerLoggingAgent.dSYM"
	sh "rm -rf #{AGENT_OUTPUT_DIR}SpawnPreparer #{AGENT_OUTPUT_DIR}SpawnPreparer.dSYM"
	sh "rm -rf #{AGENT_OUTPUT_DIR}EnvPrinter #{AGENT_OUTPUT_DIR}EnvPrinter.dSYM"
end