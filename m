Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iio: inkern: clean up error return code
Date: Tue, 18 Sep 2012 04:56:06 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EF539F@DQHE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

 When the IIO consumer tries to get specific IIO channel,
 few error cases can be happened.
 (a) Memory allocation failure
 (b) No matched ADC channel error
 (c) Invalid input arguments
 This patch enables cleaning up error handling in case of (a) and (b).

 In error handling code,
 (a): the reference count of the IIO device should be decreased.
 (b): the allocated memory should be freed with restoring the reference cou=
nt.
 Therefore iio_deivce_put() is called in both cases.
 This can be handled in the last error statement.

 Additionally, integer variable is used for stating each error case explici=
tly.
 Then, the error returns as ERR_PTR() with this value.

Signed-off-by: Milo(Woogyom) Kim <milo.kim@ti.com>
---
 drivers/iio/inkern.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index aff034b..656d4d4 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -111,6 +111,7 @@ struct iio_channel *iio_channel_get(const char *name, c=
onst char *channel_name)
 {
 	struct iio_map_internal *c_i =3D NULL, *c =3D NULL;
 	struct iio_channel *channel;
+	int err;
=20
 	if (name =3D=3D NULL && channel_name =3D=3D NULL)
 		return ERR_PTR(-ENODEV);
@@ -131,8 +132,10 @@ struct iio_channel *iio_channel_get(const char *name, =
const char *channel_name)
 		return ERR_PTR(-ENODEV);
=20
 	channel =3D kzalloc(sizeof(*channel), GFP_KERNEL);
-	if (channel =3D=3D NULL)
+	if (channel =3D=3D NULL) {
+		err =3D -ENOMEM;
 		goto error_no_mem;
+	}
=20
 	channel->indio_dev =3D c->indio_dev;
=20
@@ -141,19 +144,19 @@ struct iio_channel *iio_channel_get(const char *name,=
 const char *channel_name)
 			iio_chan_spec_from_name(channel->indio_dev,
 						c->map->adc_channel_label);
=20
-		if (channel->channel =3D=3D NULL)
+		if (channel->channel =3D=3D NULL) {
+			err =3D -EINVAL;
 			goto error_no_chan;
+		}
 	}
=20
 	return channel;
=20
 error_no_chan:
-	iio_device_put(c->indio_dev);
 	kfree(channel);
-	return ERR_PTR(-EINVAL);
 error_no_mem:
 	iio_device_put(c->indio_dev);
-	return ERR_PTR(-ENOMEM);
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(iio_channel_get);
=20
--=20
1.7.9.5


Best Regards,
Milo
