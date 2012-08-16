Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PATCH 1/3] iio: add iio_read_channel_offset() consumer api
Date: Thu, 16 Aug 2012 07:39:20 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EEFD6E@DQHE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

This allows the iio consumer to get the offset of the channel.
The value of offset can be used when calculating the result such
as 'result =3D raw * scale + offset'.

Signed-off-by: Milo(Woogyom) Kim <milo.kim@ti.com>
---
 drivers/iio/inkern.c         |   21 +++++++++++++++++++++
 include/linux/iio/consumer.h |    9 +++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index b5afc2f..bd09245 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -269,6 +269,27 @@ err_unlock:
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_scale);
=20
+int iio_read_channel_offset(struct iio_channel *chan, int *val)
+{
+	int val2, ret;
+
+	mutex_lock(&chan->indio_dev->info_exist_lock);
+	if (chan->indio_dev->info =3D=3D NULL) {
+		ret =3D -ENODEV;
+		goto err_unlock;
+	}
+
+	ret =3D chan->indio_dev->info->read_raw(chan->indio_dev,
+					      chan->channel,
+					      val, &val2,
+					      IIO_CHAN_INFO_OFFSET);
+err_unlock:
+	mutex_unlock(&chan->indio_dev->info_exist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_read_channel_offset);
+
 int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *typ=
e)
 {
 	int ret =3D 0;
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index e2657e6..d9d69fa 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -93,4 +93,13 @@ int iio_get_channel_type(struct iio_channel *channel,
 int iio_read_channel_scale(struct iio_channel *chan, int *val,
 			   int *val2);
=20
+/**
+ * iio_read_channel_offset() - read offset from a given channel
+ * @channel:		The channel being queried.
+ * @val:		Offset Value read back.
+ *
+ * Note offset can be used in the consumer when calculating the result
+ * such as 'result =3D raw * scale + offset'.
+ */
+int iio_read_channel_offset(struct iio_channel *chan, int *val);
 #endif
--=20
1.7.2.5


Best Regards,
Milo
