Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/4] iio: clarify channel and indexed in struct iio_chan_spec
Date: Tue, 12 Jun 2012 14:42:24 +0200
Message-Id: <1339504946-16171-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339504946-16171-1-git-send-email-pmeerw@pmeerw.net>
References: <1339504946-16171-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

From: Peter Meerwald <p.meerwald@bct-electronic.com>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

---
 include/linux/iio/iio.h |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 9d9b55a..44b9660 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -196,7 +196,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 /**
  * struct iio_chan_spec - specification of a single channel
  * @type:		What type of measurement is the channel making.
- * @channel:		What number or name do we wish to assign the channel.
+ * @channel:		What number do we wish to assign the channel.
  * @channel2:		If there is a second number for a differential
  *			channel then this is it. If modified is set then the
  *			value here specifies the modifier.
@@ -227,9 +227,8 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
  *			channel2. Examples are IIO_MOD_X for axial sensors about
  *			the 'x' axis.
  * @indexed:		Specify the channel has a numerical index. If not,
- *			the value in channel will be suppressed for attribute
- *			but not for event codes. Typically set it to 0 when
- *			the index is false.
+ *			the channel index number will be suppressed for sysfs
+ *			attributes but not for event codes.
  * @differential:	Channel is differential.
  */
 struct iio_chan_spec {
-- 
1.7.5.4
