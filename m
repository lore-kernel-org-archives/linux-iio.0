Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34820 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbcEXPHx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 24 May 2016 11:07:53 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [RFC PATCH v2] tools: iio: Rename generic_buffer to iio_generic_buffer
Date: Tue, 24 May 2016 18:03:55 +0300
Message-Id: <1464102235-11360-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This makes it clear that generic_buffer is an IIO tool
and also complies with filename conventions in tools/iio.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
Changes since v1:
	* use -M to detect renames and make the patch easier to review

 tools/iio/Makefile                                   | 6 +++---
 tools/iio/{generic_buffer.c => iio_generic_buffer.c} | 0
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename tools/iio/{generic_buffer.c => iio_generic_buffer.c} (100%)

diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index 3a7a54f..e8a009b 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -1,16 +1,16 @@
 CC = $(CROSS_COMPILE)gcc
 CFLAGS += -Wall -g -D_GNU_SOURCE
 
-all: iio_event_monitor lsiio generic_buffer
+all: iio_event_monitor lsiio iio_generic_buffer
 
 iio_event_monitor: iio_event_monitor.o iio_utils.o
 
 lsiio: lsiio.o iio_utils.o
 
-generic_buffer: generic_buffer.o iio_utils.o
+iio_generic_buffer: iio_generic_buffer.o iio_utils.o
 
 %.o: %.c iio_utils.h
 
 .PHONY: clean
 clean:
-	rm -f *.o iio_event_monitor lsiio generic_buffer
+	rm -f *.o iio_event_monitor lsiio iio_generic_buffer
diff --git a/tools/iio/generic_buffer.c b/tools/iio/iio_generic_buffer.c
similarity index 100%
rename from tools/iio/generic_buffer.c
rename to tools/iio/iio_generic_buffer.c
-- 
2.5.0

