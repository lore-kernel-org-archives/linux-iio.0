Return-Path: <cristina.opriceana@gmail.com>
Date: Fri, 10 Jul 2015 17:10:21 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH] Staging: iio: dummy: Fix blank line warnings
Message-ID: <20150710141021.GA7015@Inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Multiple blank lines should not be used as indicated by checkpatch.pl.
Also, a line should be used after a function/structure declaration.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 drivers/staging/iio/iio_dummy_evgen.c         | 1 +
 drivers/staging/iio/iio_simple_dummy.c        | 2 --
 drivers/staging/iio/iio_simple_dummy.h        | 1 +
 drivers/staging/iio/iio_simple_dummy_buffer.c | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/iio_dummy_evgen.c b/drivers/staging/iio/iio_dummy_evgen.c
index c54d5b5..6d38854 100644
--- a/drivers/staging/iio/iio_dummy_evgen.c
+++ b/drivers/staging/iio/iio_dummy_evgen.c
@@ -214,6 +214,7 @@ static struct device iio_evgen_dev = {
 	.groups = iio_evgen_groups,
 	.release = &iio_evgen_release,
 };
+
 static __init int iio_dummy_evgen_init(void)
 {
 	int ret = iio_dummy_evgen_create();
diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 1629a8a..381f90f 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -611,7 +611,6 @@ static int iio_dummy_probe(int index)
 	 */
 	iio_dummy_devs[index] = indio_dev;
 
-
 	/*
 	 * Set the device name.
 	 *
@@ -675,7 +674,6 @@ static void iio_dummy_remove(int index)
 	 */
 	struct iio_dev *indio_dev = iio_dummy_devs[index];
 
-
 	/* Unregister the device */
 	iio_device_unregister(indio_dev);
 
diff --git a/drivers/staging/iio/iio_simple_dummy.h b/drivers/staging/iio/iio_simple_dummy.h
index e877a99..8d00224 100644
--- a/drivers/staging/iio/iio_simple_dummy.h
+++ b/drivers/staging/iio/iio_simple_dummy.h
@@ -119,6 +119,7 @@ static inline int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 {
 	return 0;
 };
+
 static inline
 void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
 {};
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index a651b89..00ed774 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -32,6 +32,7 @@ static const s16 fakedata[] = {
 	[diffvoltage3m4] = -2,
 	[accelx] = 344,
 };
+
 /**
  * iio_simple_dummy_trigger_h() - the trigger handler function
  * @irq: the interrupt number
@@ -178,7 +179,6 @@ error_free_buffer:
 	iio_kfifo_free(indio_dev->buffer);
 error_ret:
 	return ret;
-
 }
 
 /**
-- 
1.9.1
