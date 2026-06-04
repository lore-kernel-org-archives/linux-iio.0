Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440D4374739;
	Thu,  4 Jun 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580566; cv=none; b=BxZqcSbtMzBKlwDmwjVfeotyWLiNrP3/+1Yi/HF2JkmcQoGycmHq+QaZ3ZsEh+v9SZwLhVhtBCTJruzS6LsM7CuZlmwXatD2+coSEHKZATPIN8+7Ri5AAenInMLFDicDZaGQU2w4etxQU55aY8s1XSQh/9yJ+yE+KeMBWcaomGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580566; c=relaxed/simple;
	bh=7LpKeYvXj1Nwar58xhmTnGSQWMIrgAYjPfNCyd9zxPE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VElR8LNb3WyxUjBxkB+cEqtvHIY0xdE6R5N/ffj/cZUKjir0HmJ9xnX6f+CI9i/k51vbZkSB2bgWmuvjymHhQGha3EEiAr4qgs65Qy0M4fom/2d0TVJHbM4o3ymkUknxmW4JnvEf37UH/NXJRa6dp8zoz1jFTC6sHKLGyoe6UbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 4 Jun
 2026 15:27:32 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.061; Thu, 4 Jun 2026 15:27:32 +0200
From: Andreas Kempe <andreas.kempe@actia.se>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Ernberg
	<john.ernberg@actia.se>, Andreas Kempe <andreas.kempe@actia.se>
Subject: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Thread-Topic: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Thread-Index: AQHc9CXmt5PDPY90VUWMABLjTdSxxQ==
Date: Thu, 4 Jun 2026 13:27:32 +0000
Message-ID: <20260604132646.1099072-1-andreas.kempe@actia.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.53.0
x-esetresult: clean, is OK
x-esetid: 37303A2955B1445F637766
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

As part of driver initialisation, e.g. st_lsm6dsx_init_shub() selects
the shub register page using st_lsm6dsx_set_page(). Selecting the shub
register page shadows the regular register space so whoami, among other
registers, is no longer accessible.

In applications where the IMU is permanently powered separately from the
processor, there is a window where a reset of the CPU leaves the IMU in
the shub register page. Once this occurs, any subsequent probe attempt
fails because of the register shadowing.

Using the ism330dlc, the error typically looks like

	st_lsm6dsx_i2c 3-006a: unsupported whoami [10]

with the unknown whoami read from a reserved register in the shub page.

The reset register is also shadowed by the page select, preventing a
simple reset from recovering the chip.

Add a readout of the shub register page selection and deselect the page
if needed before reading whoami. This allows the driver to recover and
probe correctly.

Signed-off-by: Andreas Kempe <andreas.kempe@actia.se>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 42 +++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx_core.c
index 630e2cae6f19..6fef99f2e9f1 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1692,10 +1692,27 @@ int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, b=
ool enable)
 	return err;
 }
=20
+static int st_lsm6dsx_get_page(struct st_lsm6dsx_hw *hw, bool *enable)
+{
+	const struct st_lsm6dsx_shub_settings *hub_settings;
+	unsigned int data;
+	int err;
+
+	hub_settings =3D &hw->settings->shub_settings;
+	err =3D regmap_read(hw->regmap, hub_settings->page_mux.addr, &data);
+	if (err < 0)
+		return err;
+
+	*enable =3D data & hub_settings->page_mux.mask;
+
+	return 0;
+}
+
 static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
 				   const char **name)
 {
 	int err, i, j, data;
+	bool enable;
=20
 	for (i =3D 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
 		for (j =3D 0; j < ST_LSM6DSX_MAX_ID; j++) {
@@ -1712,6 +1729,30 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx=
_hw *hw, int id,
 		return -ENODEV;
 	}
=20
+	hw->settings =3D &st_lsm6dsx_sensor_settings[i];
+
+	if (hw->settings->shub_settings.page_mux.addr) {
+		/*
+		 * whoami is not available in the shub register page.
+		 * Deselect the shub page if needed so whoami can be
+		 * correctly read.
+		 */
+		err =3D st_lsm6dsx_get_page(hw, &enable);
+		if (err < 0) {
+			dev_err(hw->dev, "failed to get shub page\n");
+			return err;
+		}
+
+		if (enable) {
+			dev_warn(hw->dev, "shub page selected; clearing it\n");
+			err =3D st_lsm6dsx_set_page(hw, false);
+			if (err < 0) {
+				dev_err(hw->dev, "failed to clear shub page\n");
+				return err;
+			}
+		}
+	}
+
 	err =3D regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data);
 	if (err < 0) {
 		dev_err(hw->dev, "failed to read whoami register\n");
@@ -1724,7 +1765,6 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_=
hw *hw, int id,
 	}
=20
 	*name =3D st_lsm6dsx_sensor_settings[i].id[j].name;
-	hw->settings =3D &st_lsm6dsx_sensor_settings[i];
=20
 	return 0;
 }
--=20
2.53.0
