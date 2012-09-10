Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iio: inkern: add error case in iio_channel_get()
Date: Mon, 10 Sep 2012 08:02:45 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EF45EB@DQHE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

 The datasheet name is defined in the IIO driver.
 On the other hand, the adc_channel_label is configured in
 the platform machine side.
 If the datasheet name is not matched with any adc_channel_label,
 the iio_channel_get() should be returned as error for preventing
 using invalid IIO channel data.

 Moreover, this patch detects NULL pointer dereference problem at early tim=
e.
 In general, the IIO driver just accesses to any member of the iio_chan_spe=
c
 in own xxx_read_raw() function.
 If the iio_chan_spec is invalid pointer, NULL dereference problem may occu=
r
 such like 'iio_chan_spec->channel' or 'iio_chan_spec->type'.
 If the iio_channel_get() gets failed in the IIO consumer,
 then no read_raw() operation proceeds.

Signed-off-by: Milo(Woogyom) Kim <milo.kim@ti.com>
---
 drivers/iio/inkern.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 1faa240..a5caf6b 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -136,11 +136,15 @@ struct iio_channel *iio_channel_get(const char *name,=
 const char *channel_name)
=20
 	channel->indio_dev =3D c->indio_dev;
=20
-	if (c->map->adc_channel_label)
+	if (c->map->adc_channel_label) {
 		channel->channel =3D
 			iio_chan_spec_from_name(channel->indio_dev,
 						c->map->adc_channel_label);
=20
+		if (channel->channel =3D=3D NULL)
+			return ERR_PTR(-ENODEV);
+	}
+
 	return channel;
 }
 EXPORT_SYMBOL_GPL(iio_channel_get);
--=20
1.7.9.5


Best Regards,
Milo
