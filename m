Return-Path: <SRS0=t+T8=DP=tobin.cc=me@kernel.org>
From: "Tobin C. Harding" <me@tobin.cc>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: fix SPHINX kernel-docs build warning
Date: Tue, 19 Dec 2017 16:59:35 +1100
Message-Id: <1513663175-25163-1-git-send-email-me@tobin.cc>
List-ID: <linux-iio@vger.kernel.org>

When building kernel documentation sphinx emits the following warnings

No description found for parameter 'iio_dev'
Excess function parameter 'indio_dev' description in 'iio_device_register'

These warnings are caused by a macro with a different argument identifier to the
one listed in the kernel-docs.

Change macro argument to be the same as the docs.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 include/linux/iio/iio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 20b61347ea58..1234e5571d45 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -606,8 +606,8 @@ const struct iio_chan_spec
  * iio_device_register() - register a device with the IIO subsystem
  * @indio_dev:		Device structure filled by the device driver
  **/
-#define iio_device_register(iio_dev) \
-	__iio_device_register((iio_dev), THIS_MODULE)
+#define iio_device_register(indio_dev) \
+	__iio_device_register((indio_dev), THIS_MODULE)
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod);
 void iio_device_unregister(struct iio_dev *indio_dev);
 /**
-- 
2.7.4
