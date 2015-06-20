Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/3] tools: iio: Set CC using $(CROSS_COMPILE)
Date: Sat, 20 Jun 2015 23:52:32 +0200
Message-Id: <1434837152-30830-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1434837152-30830-1-git-send-email-pmeerw@pmeerw.net>
References: <1434837152-30830-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 tools/iio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index bf7ae6d..7d0950d 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -1,4 +1,4 @@
-CC = gcc
+CC = $(CROSS_COMPILE)gcc
 CFLAGS = -Wall -g -D_GNU_SOURCE
 
 all: iio_event_monitor lsiio generic_buffer
-- 
1.9.1
