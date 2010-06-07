Return-Path: <21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
To: jic23@cam.ac.uk, gregkh@suse.de
CC: linux-iio@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH] iio: fix typo
Date: Mon, 7 Jun 2010 10:46:15 +0800
Message-ID: <1275878775-25681-1-git-send-email-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 drivers/staging/iio/industrialio-ring.c |    4 ++--
 drivers/staging/iio/ring_generic.h      |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index ada159b..ac56d9e 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -340,7 +340,7 @@ EXPORT_SYMBOL(iio_read_ring_length);
 }
 EXPORT_SYMBOL(iio_write_ring_length);
 
-ssize_t iio_read_ring_bps(struct device *dev,
+ssize_t iio_read_ring_bpd(struct device *dev,
 			  struct device_attribute *attr,
 			  char *buf)
 {
@@ -353,7 +353,7 @@ ssize_t iio_read_ring_bps(struct device *dev,
 
 	return len;
 }
-EXPORT_SYMBOL(iio_read_ring_bps);
+EXPORT_SYMBOL(iio_read_ring_bpd);
 
 ssize_t iio_store_ring_enable(struct device *dev,
 			      struct device_attribute *attr,
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 0e44375..1b22bdb 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -269,7 +269,7 @@ ssize_t iio_write_ring_length(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buf,
 			      size_t len);
-ssize_t iio_read_ring_bps(struct device *dev,
+ssize_t iio_read_ring_bpd(struct device *dev,
 			  struct device_attribute *attr,
 			  char *buf);
 ssize_t iio_store_ring_enable(struct device *dev,
-- 
1.5.6.3
