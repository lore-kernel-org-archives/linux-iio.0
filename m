Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:59738 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbdDKLGq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Apr 2017 07:06:46 -0400
From: Sekhar Nori <nsekhar@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tools: iio: add ability to pass kernel headers
Date: Tue, 11 Apr 2017 16:36:18 +0530
Message-ID: <d5f344548931389ea4598be946bdc28af1790cc9.1491908438.git.nsekhar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Very often, especially when cross compiling, there is a need
to pass kernel headers different from those installed on the
build machine.

Add support for doing this for iio utils by using the
'INSTALL_HDR_PATH' environment variable. This is supported by
'make headers_install' for installing kernel headers at a
user specified location. So you will do:

$ make headers_install ARCH=arm INSTALL_HDR_PATH=<absolute-path>
$ make -C tools/iio ARCH=arm INSTALL_HDR_PATH=<absolute-path>

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 tools/iio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index 5446d625e17d..75607043d6e2 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -1,5 +1,5 @@
 CC = $(CROSS_COMPILE)gcc
-CFLAGS += -Wall -g -D_GNU_SOURCE
+CFLAGS += -Wall -g -D_GNU_SOURCE -I$(INSTALL_HDR_PATH)/include
 
 BINDIR=usr/bin
 INSTALL_PROGRAM=install -m 755 -p
-- 
2.9.0

