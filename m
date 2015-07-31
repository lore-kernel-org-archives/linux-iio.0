Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:29047 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807AbbGaOCY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 31 Jul 2015 10:02:24 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, corbet@lwn.net, rdunlap@infradead.org,
	cmo@melexis.com
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	herbert@gondor.apana.org.au, smueller@chronox.de, mmarek@suse.cz,
	daniel.baluta@intel.com, linux-doc@vger.kernel.org,
	cristina.opriceana@gmail.com
Subject: [PATCH v4] DocBook documentation for IIO
Date: Fri, 31 Jul 2015 17:04:20 +0300
Message-Id: <1438351461-19948-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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


Changes since v3:
	* addressed feedback from Crt Mori
	  * http://marc.info/?l=linux-iio&m=143815719008296&w=2

Changes since v2:
	* addressed feedback from Lars-Peter
	  * http://marc.info/?l=linux-iio&m=143774991802816&w=2
	* Many thanks to Lars-Peter Clausen for scan_index paragraph.

Changes since v1:
	* mostly typos and clarifications
	* addressed comments from Jonathan Corbet and Jonathan Cameron
	  * http://marc.info/?l=linux-iio&m=143704226629498&w=2
	  * http://marc.info/?l=linux-iio&m=143707511006898&w=2
	* for DocBook warnings reported by Randy, Cristina sent
	  this patchseries:
	  http://marc.info/?l=linux-iio&m=143774363900903&w=2

Daniel Baluta (1):
  DocBook: Add initial documentation for IIO

 Documentation/DocBook/Makefile |   2 +-
 Documentation/DocBook/iio.tmpl | 702 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 703 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/DocBook/iio.tmpl

-- 
1.9.1

