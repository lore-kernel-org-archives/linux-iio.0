Return-Path: <21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
To: jic23@cam.ac.uk, gregkh@suse.de
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Barry Song <21cnbao@gmail.com>
Subject: [PATCH] iio: fix typo in userspace example codes and document
Date: Mon, 26 Apr 2010 12:19:01 +0800
Message-ID: <1272255541-11835-1-git-send-email-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 .../iio/Documentation/lis3l02dqbuffersimple.c      |    2 +-
 drivers/staging/iio/Documentation/userspace.txt    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Documentation/lis3l02dqbuffersimple.c b/drivers/staging/iio/Documentation/lis3l02dqbuffersimple.c
index 2b5cfc5..811dd14 100644
--- a/drivers/staging/iio/Documentation/lis3l02dqbuffersimple.c
+++ b/drivers/staging/iio/Documentation/lis3l02dqbuffersimple.c
@@ -20,7 +20,7 @@
 
 #include <linux/types.h>
 #include <dirent.h>
-#include "iio_util.h"
+#include "iio_utils.h"
 
 static const char *ring_access = "/dev/iio/lis3l02dq_ring_access";
 static const char *ring_event = "/dev/iio/lis3l02dq_ring_event";
diff --git a/drivers/staging/iio/Documentation/userspace.txt b/drivers/staging/iio/Documentation/userspace.txt
index 661015a..4838818 100644
--- a/drivers/staging/iio/Documentation/userspace.txt
+++ b/drivers/staging/iio/Documentation/userspace.txt
@@ -56,5 +56,5 @@ KERNEL="ring_event_line*", ID="spi1.0", DRIVER="lis3l02dq", NAME="iio/lis3l02dq_
 KERNEL="event_line*", ID="spi1.0", DRIVER="lis3l02dq", NAME="iio/lis3l02dq_event"
 KERNEL="ring_access*", ID="spi1.0", DRIVER="lis3l02dq", NAME="iio/lis3l02dq_ring_access"
 
-The files, lis3l02dqbuffersimple.c and iio_util.h in this directory provide an example
+The files, lis3l02dqbuffersimple.c and iio_utils.h in this directory provide an example
 of how to use the ring buffer and event interfaces.
-- 
1.5.6.3
