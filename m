Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34861 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990AbbGUIma (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 21 Jul 2015 04:42:30 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, corbet@lwn.net, rdunlap@infradead.org
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	herbert@gondor.apana.org.au, smueller@chronox.de, mmarek@suse.cz,
	daniel.baluta@intel.com, linux-doc@vger.kernel.org,
	cristina.opriceana@gmail.com
Subject: [PATCH v2] DocBook documentation for IIO
Date: Tue, 21 Jul 2015 11:43:35 +0300
Message-Id: <1437468216-12079-1-git-send-email-daniel.baluta@intel.com>
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

Changes since v1:
	* mostly typos and clarifications
	* addressed comments from Jonathan Corbet and Jonathan Cameron
	  * http://marc.info/?l=linux-iio&m=143704226629498&w=2
	  * http://marc.info/?l=linux-iio&m=143707511006898&w=2
	* for DocBook warnings reported by Randy, Cristina (Cc'ed)
	  will send a patch series fixes.

Daniel Baluta (1):
  DocBook: Add initial documentation for IIO

 Documentation/DocBook/Makefile |   2 +-
 Documentation/DocBook/iio.tmpl | 680 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 681 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/DocBook/iio.tmpl

-- 
1.9.1

