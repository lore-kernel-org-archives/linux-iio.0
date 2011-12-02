Return-Path: <rupran@einserver.de>
From: Andreas Ruprecht <rupran@einserver.de>
To: devel@linuxdriverproject.org
Cc: gregkh@suse.de,
	jic23@cam.ac.uk,
	linux-iio@vger.kernel.org,
	rubini@gnudd.com,
	Andreas Ruprecht <rupran@einserver.de>
Subject: [PATCH v2 1/2] Staging: iio/accel: Changed data type of mask in store_measurement_mode() to u8
Date: Fri,  2 Dec 2011 17:56:55 +0100
Message-Id: <1322845015-22467-1-git-send-email-rupran@einserver.de>
In-Reply-To: <20111202164423.GA14982@mail.gnudd.com>
References: <20111202164423.GA14982@mail.gnudd.com>
List-ID: <linux-iio@vger.kernel.org>

In sca3000_store_measurement_mode() we parse a value from a string
buffer via kstrtou8, and store the parsed value into a u8 after
and-ing it with mask.

As we are only interested in the lowest two bits here and mask is
initialized with a fixed value 0x03, mask may as well be a u8.

Signed-off-by: Andreas Ruprecht <rupran@einserver.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
[v2]: Fixed a confusing typo in the description (bytes/bits)
---
 drivers/staging/iio/accel/sca3000_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index c3f1f6a..a33e742 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -381,7 +381,7 @@ sca3000_store_measurement_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
-	int mask = 0x03;
+	u8 mask = 0x03;
 	u8 val;
 
 	mutex_lock(&st->lock);
-- 
1.7.5.4
