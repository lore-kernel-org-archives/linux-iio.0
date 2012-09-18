Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] iio: inkern: put the IIO device when it fails to
 allocate memory
Date: Tue, 18 Sep 2012 04:55:53 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EF5397@DQHE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

 The reference count of the IIO device is increased if the IIO map has
 matched consumer name.
 After then, it tries to allocate the iio_channel which is used by the cons=
umer.
 If it fails to allocate memory, the reference count should be decreased.

 This patch enables restoring the reference count of the IIO device.

Signed-off-by: Milo(Woogyom) Kim <milo.kim@ti.com>
---
 drivers/iio/inkern.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 13748c0..aff034b 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -132,7 +132,7 @@ struct iio_channel *iio_channel_get(const char *name, c=
onst char *channel_name)
=20
 	channel =3D kzalloc(sizeof(*channel), GFP_KERNEL);
 	if (channel =3D=3D NULL)
-		return ERR_PTR(-ENOMEM);
+		goto error_no_mem;
=20
 	channel->indio_dev =3D c->indio_dev;
=20
@@ -151,6 +151,9 @@ error_no_chan:
 	iio_device_put(c->indio_dev);
 	kfree(channel);
 	return ERR_PTR(-EINVAL);
+error_no_mem:
+	iio_device_put(c->indio_dev);
+	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL_GPL(iio_channel_get);
=20
--=20
1.7.9.5


Best Regards,
Milo
