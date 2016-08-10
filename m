Return-Path: <christophe.jaillet@wanadoo.fr>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: light: us5182d: Add missing error code assignment before test
Date: Wed, 10 Aug 2016 07:18:16 +0200
Message-Id: <1470806296-8739-1-git-send-email-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

It is likely that checking the result of 'pm_runtime_set_active' is
expected here.

Fixes: f0e5f57d3ac2 ("iio: light: us8152d: Add power management support")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/light/us5182d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 20c40f780964..18cf2e29e4d5 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -894,7 +894,7 @@ static int us5182d_probe(struct i2c_client *client,
 		goto out_err;
 
 	if (data->default_continuous) {
-		pm_runtime_set_active(&client->dev);
+		ret =3D pm_runtime_set_active(&client->dev);
 		if (ret < 0)
 			goto out_err;
 	}
-- 
2.7.4


---
L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=C3=
=A9rifi=C3=A9e par le logiciel antivirus Avast.
https://www.avast.com/antivirus
