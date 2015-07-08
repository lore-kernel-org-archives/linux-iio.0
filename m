Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com,
	pmeerw@pmeerw.net,
	knaack.h@gmx.de,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH] DocBook documentation for IIO
Date: Wed,  8 Jul 2015 15:04:47 +0300
Message-Id: <1436357088-30743-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

In our effort to support vendors writing drivers for their own
sensors we introduce IIO documentation in DocBook format.

It documents Industrial I/O core including IIO devices, buffers, triggers and
triggered buffers. It also offers a short list of online resources
for the IIO subsystem.

This is far from being complete any suggestions are welcomed. At a first
glance we also need to add documentation for events. We are also working
on auto-generating template drivers based on the type of the IIO sensors.

Generated html files should be available online here http://dbaluta.github.io/
or you could run make htmldocs in the root of your kernel repo to get them.

Daniel Baluta (1):
  DocBook: Add initial documentation for IIO

 Documentation/DocBook/Makefile |   2 +-
 Documentation/DocBook/iio.tmpl | 588 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 589 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/DocBook/iio.tmpl

-- 
1.9.1
