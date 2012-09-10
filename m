Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] iio: inkern: clear allocated memory
Date: Mon, 10 Sep 2012 08:02:20 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EF45DC@DQHE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

 Use kzalloc() rathern than kmalloc() for initializing iio_dev and
 iio_chan_spec.

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
