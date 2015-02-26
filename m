Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org
Cc: daniel.baluta@intel.com,
	octavian.purdila@intel.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 4/5] tools: iio: Define _GNU_SOURCE in Makefile
Date: Thu, 26 Feb 2015 10:49:26 +0200
Message-Id: <1424940567-24877-5-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1424940567-24877-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1424940567-24877-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Definition of _GNU_SOURCE is needed to get rid of some warnings, such
as:
warning: implicit declaration of function `asprintf'.

generic_buffer.c and iio_event_monitor.c define _GNU_SOURCE,
but it is also needed in lsiio.c and iio_utils.c. For this reason,
this patch adds the definition in Makefile and removes it from where
it already exists.

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 tools/iio/Makefile            | 2 +-
 tools/iio/generic_buffer.c    | 2 --
 tools/iio/iio_event_monitor.c | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index 83813ad..bf7ae6d 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -1,5 +1,5 @@
 CC = gcc
-CFLAGS = -Wall -g
+CFLAGS = -Wall -g -D_GNU_SOURCE
 
 all: iio_event_monitor lsiio generic_buffer
 
diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 01266c2..8f8f058 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -18,8 +18,6 @@
  *
  */
 
-#define _GNU_SOURCE
-
 #include <unistd.h>
 #include <stdlib.h>
 #include <dirent.h>
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index f19cff1..427c271 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -16,8 +16,6 @@
  *
  */
 
-#define _GNU_SOURCE
-
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdbool.h>
-- 
1.9.1
