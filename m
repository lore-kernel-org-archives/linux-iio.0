Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:65072 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036820AbdDUMcO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2017 08:32:14 -0400
From: Sekhar Nori <nsekhar@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] tools/iio: Use include/uapi with __EXPORTED_HEADERS__
Date: Fri, 21 Apr 2017 18:01:25 +0530
Message-ID: <5cfc29b0d8fa6c5bd97e59f7ab0ff718132efdec.1492777014.git.nsekhar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the local uapi headers to keep in sync with "recently" added enum
values like IIO_UVINDEX.

Build tested using:
$ make -C <kernelsrcdir> tools/iio
$ make -C <kernelsrcdir>/tools iio
$ make -C <kernelsrcdir>/tools/iio

This follows a strategy similar to that used by tools/hv, tools/net and
tools/leds among others.

Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
Change since v1:
Shift to a strategy similar to that used by other makefiles in
tools/ folder. v1 posting here: https://patchwork.kernel.org/patch/9674937/

 tools/iio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index 5446d625e17d..8f08e03a9a5e 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -1,5 +1,5 @@
 CC = $(CROSS_COMPILE)gcc
-CFLAGS += -Wall -g -D_GNU_SOURCE
+CFLAGS += -Wall -g -D_GNU_SOURCE -D__EXPORTED_HEADERS__ -I../../include/uapi -I../../include
 
 BINDIR=usr/bin
 INSTALL_PROGRAM=install -m 755 -p
-- 
2.9.0

