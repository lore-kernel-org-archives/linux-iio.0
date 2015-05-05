Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:36331 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757017AbbEEImV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 May 2015 04:42:21 -0400
Received: by lagv1 with SMTP id v1so121860344lag.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2015 01:42:20 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: make tools more cross-compilation friendly
Date: Tue,  5 May 2015 10:42:12 +0200
Message-Id: <1430815332-26812-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When cross-compiling the IIO tools we need to opportunity to
specify a cross compiler prefix and some extra CFLAGS. This
patch enables this in the same way as for other stuff in
tools.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 tools/iio/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index bf7ae6d6612a..3a7a54f59713 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -1,5 +1,5 @@
-CC = gcc
-CFLAGS = -Wall -g -D_GNU_SOURCE
+CC = $(CROSS_COMPILE)gcc
+CFLAGS += -Wall -g -D_GNU_SOURCE
 
 all: iio_event_monitor lsiio generic_buffer
 
-- 
1.9.3

