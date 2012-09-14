Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] iio: inkern: allocate zeroed memory
Date: Fri, 14 Sep 2012 01:24:19 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EF4C3E@DQHE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

 Use kzalloc() rather than kmalloc() for initializing the iio_channel struc=
ture.
 This patch enables the iio_dev and iio_chan_spec are set to NULL.
 This may prevent the page fault problem because the pointer of iio_chan_sp=
ec
 is initialized as NULL.

 The iio_chan_spec is updated only in case that the IIO map has
 specific channel label.
 When the map has no ADC channel label, then the value of iio_chan_spec
 remains as invalid pointer.
 To prevent this problem, the pointer should be initialized as NULL.

Signed-off-by: Milo(Woogyom) Kim <milo.kim@ti.com>
---
 drivers/iio/inkern.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index b5afc2f..1faa240 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -130,7 +130,7 @@ struct iio_channel *iio_channel_get(const char *name, c=
onst char *channel_name)
 	if (c =3D=3D NULL)
 		return ERR_PTR(-ENODEV);
=20
-	channel =3D kmalloc(sizeof(*channel), GFP_KERNEL);
+	channel =3D kzalloc(sizeof(*channel), GFP_KERNEL);
 	if (channel =3D=3D NULL)
 		return ERR_PTR(-ENOMEM);
=20
--=20
1.7.9.5


Best Regards,
Milo
