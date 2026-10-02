Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88141493D57;
	Fri,  2 Oct 2026 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942105; cv=fail; b=lHekr8f7FMO67LcGWi5bGNB8JlD664bDsvnsNvac/Z85c9MKnirE8c/yC2g0JAFJNFGB3BAR9UplehCmwcfMyzzckx1iqmFktWrwLpeYq0b3Rs/q/3WUBj8AXerw6lYnhHfBXaHf7yE17SZeHt09+OJCNxzfs7Chbna8PZVtUB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942105; c=relaxed/simple;
	bh=OPuAmnIPdXGictRkXHhev5Wupd3e3XJHD+WWqf+Nfzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VdpbBmuI6CS0Y8X+itWzVkx7vXm8td0aGzWTsXoD3dqTeMJN3x6nkZxl+rRlE1XRKZ8lUU1qJCbJuVfLZCswdEN30g9pl18XcBtnjhXQbJPQibJUOOe77zwy/3cPrKDjmAASM9Ae7KW2B33ZjogmaFzq7XuwxYvJQdHRbuWqr6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Przr1kzJ; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Przr1kzJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J90gq2lqLTlFu9+r+m+ur3nrbdM1ZHaR3sti/QMjbQyiOBc7i7C6wnvXetEue4bq7hQxzO9/U8+ZreVatwlVDkaRo5oZpL+ZYyHcemz4U+LX9qIHmE5YgeBnd7vizZ/v4wyXWo1AjQ+YiZh6HxL/OY6qixBMJN3h5qmepdD9wJX41Gp3X9N42lId7amPe0B55hAMPdGsehMPU53AO0g+V5Ugmm9Wilivy/Uk2eGdcZxx20kYGJl9Upw74j1aMb5JA5iaKMOUkRJ9l4ezoF+WQRuqyLF+dZrrAodYA2LFbydUqMlchwksxai1cTvhjVJFDYaacmZCyse9aJoYkr+0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbK+ALs0TydSrTnFehGVJC3Rt0ONxYFF5aVVtu8+aPQ=;
 b=Jw5qvsSXDjZY+W7KCsVNiKACp2MYqZzUjmvw4ZvYiFL6xPdviJ02wLHG5t7vPnUAIENzL5+1cAW/PAIzABle+5XrLxQ6ly5gcgHFwE/2ytSq5p8SzG38yKRLfmrLMa1plzQlacKOMDiUst30j2zNySgiybvSloHuJwfyl6Q+UmQGl1EIUYJN0QBzqseBMXudjRA9bPYmlBqKyiAI8hCmZ9k0SIwECQvf6f9xsObpoEWhkW8UE6DKg9KrgySyPmIHmjXHMhIaGg8bUGbX4LgTE7Z9AM2GvI3B+dUPTV5N45zft9GGXITRKG/0SzrjhNlYiUyVZQI28sxg64PqZ/quHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbK+ALs0TydSrTnFehGVJC3Rt0ONxYFF5aVVtu8+aPQ=;
 b=Przr1kzJCAIXCwsERaXb+6eQtmStLmxO21IcDWTAKYpgAyypYuEo+UMh6/7oiJPHUBd4wK5As1gpzUKuwZ6jR+xWXBrTci+px8q5OLd6OcWTNlygL9qGuYwjvqpRY25D8ooRGt6H8dQyIoHl69jN0pS/H3nVa/+SUqdJZqRfTO8=
Received: from PAZP264CA0105.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::14)
 by GV1PR02MB11505.eurprd02.prod.outlook.com (2603:10a6:150:283::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 11:54:45 +0000
Received: from AM7PEPF00000056.EURPRD83.prod.outlook.com
 (2603:10a6:102:1fb:cafe::2b) by PAZP264CA0105.outlook.office365.com
 (2603:10a6:102:1fb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 11:54:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM7PEPF00000056.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 11:54:44 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 2 Oct
 2026 13:54:40 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 2 Oct
 2026 13:54:40 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 2 Oct 2026 13:54:40 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 6098B4A08;
	Fri,  2 Oct 2026 13:54:40 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 56144305CE1C; Fri,  2 Oct 2026 13:54:40 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Fri, 2 Oct 2026 13:54:28 +0200
Subject: [PATCH v5 4/6] iio: imu: inv_icm42607: Add support for ICM-42370-P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261002-b4-inv_icm42370p-v5-4-c65281b745c9@axis.com>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
In-Reply-To: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
	<joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4482;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=OPuAmnIPdXGictRkXHhev5Wupd3e3XJHD+WWqf+Nfzg=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsjaP7veylo0LEs4dv36tVkr447x+sqUqB4JFHBmVL56z
 KO0bKF/RykLgxgXg6yYIss5o+3R+5P/6c6RdroEM4eVCWQIAxenAExE7zQjw+OKm60zK88LPP+u
 m3ujbueD4LbMFMuduyX2v8lqYpQ7/YeRYWFo5O+klQcf8HwvMort/Je4IId/d1xH0AumJCeulSk
 cTAA=
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PEPF00000056:EE_|GV1PR02MB11505:EE_
X-MS-Office365-Filtering-Correlation-Id: cca9cb2b-c397-423f-3412-08df207bf397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|32650700020|7416014|82310400026|376014|36860700016|22082099003|18002099003|13003099007|3613699012|921020|56012099006|11063799006|260925021911599003|260925021311599003|260925022911599003|10067099003;
X-Microsoft-Antispam-Message-Info:
	n/aQm6avrOUCiS+KD6D4nQRb+fZiIneQAX1gvXpjR3n65Phoq4lrg3V5e21B9eUHeLmauV8MNBuy3TF1mMsQm/kbKDQa4l8lpKt48JcQwCOKBInY9jIuabgzODuhx0Yqp4rgQvEgnC3VyzQMYIKKAPXR8Wd6aLrLzG1bdZOFRdjnT0/wtrth7IoQh1Yx37vhqJYzBhl3mepdYOT6VdIrIYELODgNeGLhi5iD7LlaoBVvHgH/ydCalLN7ykwLunl+wj2i00JJ3uyFJuflhOmGsG6PVr+Eu/mHg0teNThaAzmxEtZEhXr7KDq9L21UbLrvD3ckyHn2FpdVOj1bequq5M1yUPzV0Qb7MrMsvhKK8dcll8iOAQf6i9yt5XPLGf5+H8TtWWoha8sZUhrPEmUi/V+7Rxr/bDexaKVse8ONdhyx/VHzXtLp28OIZgPLyhcTOGdeWjkvZm0czq6nfoLX0PZksQjF8Du0VTyfZsrqO2kJZE1GxApyVxn2jilZX4CWzCNC6BY+Gb5eS0PfyPit8ktF8eI96gY2VcW9LuzHhutQpA/lWauHu3IP4g/BXXg3knUIU3Nz1qkGJ/n6QCrd9WuvcEGtZCgokkq3T8Zk5kBsDlXwGmvfVHSABnHuZcEchnAYgP6A62WeMsmOfqH0VysApPsBlxv1FvhKGBnTZCeRekF2NYcPPIzgB5kX4kS5O2Gz91hQzaHKwsJT23Zgo2ZnA6AwvbRAj9adWGdlbuwPEP9R9iwV1kjW8AaLi3/dIxHjLu8X2t0TueStZVytxq5upxqvOnFDUalQA8P8bsg=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(32650700020)(7416014)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(13003099007)(3613699012)(921020)(56012099006)(11063799006)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GVuRSrhtWbjqxv3lXC5VD+p16kllutp1OIoyiHCaF2nEs46D/n0UyTu3bLaLhfaT7AhLps3TMuhCzLPxq45yCkMINFbfAk3Kr3gQjGK+Up13Xd4suqdNy+jk+n8AWl+lsUpDNL15lQWdZpURTDqMkP76zOrmxrgaCaHVRWr3UUOSlGyNXVMY1OMBMC8bUA1bsUDV69e7XA4Y0sjsQbTWqH8/iUiADVouLdw7K9c/CtKQYGL1R24AjxUQG3PwaHyjEFkunBgCG6K+knz1PWYzTV337eUxuW+CI4qmGPUACP6IH3i3kUpj79v0vw/CiWWdhzj6hl3kgRvHSa7hF8Z4AiyBeVSwD4SiROjDbJrBrCe375YhP74FQX5fMGv59ykf4UyTTCkSSFR2JjRaeJlUt90L8Lqr5ZF/BXYJp6Rxm4Bxe58cBUuPN/zDzKyB/gRv
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:54:44.9342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cca9cb2b-c397-423f-3412-08df207bf397
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000056.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB11505

Add support for the Invensense ICM-42370-P MEMS MotionTracking 3-axis
accelerometer with built-in temperature sensor. This device is almost
identical to the existing Invensense ICM-42607-P IMU, but lacks
gyroscope. The device supports I2C, SPI and I3C. Implement only I2C
support for now, and provide support for raw sensor reads via sysfs.
There is also a built-in temperature sensor but it can not be turned off
similar to the ICM-42607.

While at it, change so dev_err_probe() is returned
when the WHO_AM_I read fails.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h      |  2 ++
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 24 ++++++++++++++++++++++--
 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c  |  6 ++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index e4075288247b8..ca5f59eb436c0 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -367,6 +367,7 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_REG_FIFO_DATA			0x3F
 
 #define INV_ICM42607_REG_WHOAMI				0x75
+#define INV_ICM42370P_WHOAMI				0x0D
 #define INV_ICM42607P_WHOAMI				0x60
 #define INV_ICM42607_WHOAMI				0x67
 
@@ -393,6 +394,7 @@ typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 extern const struct regmap_config inv_icm42607_regmap_config;
 extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
+extern const struct inv_icm42607_hw inv_icm42370p_hw_data;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index d974cba66e1be..87b1499a3689f 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -92,6 +92,22 @@ static const struct inv_icm42607_conf inv_icm42607_default_conf = {
 	},
 };
 
+static const struct inv_icm42607_conf inv_icm42370_default_conf = {
+	.accel = {
+		.mode = INV_ICM42607_SENSOR_MODE_OFF,
+		.fs = INV_ICM42607_ACCEL_FS_4G,
+		.odr = INV_ICM42607_ODR_100HZ,
+		.filter = INV_ICM42607_FILTER_BW_25HZ,
+	},
+};
+
+const struct inv_icm42607_hw inv_icm42370p_hw_data = {
+	.whoami = INV_ICM42370P_WHOAMI,
+	.name = "icm42370p",
+	.conf = &inv_icm42370_default_conf,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42370p_hw_data, "IIO_ICM42607");
+
 const struct inv_icm42607_hw inv_icm42607_hw_data = {
 	.whoami = INV_ICM42607_WHOAMI,
 	.name = "icm42607",
@@ -476,7 +492,7 @@ static int inv_icm42607_setup(struct inv_icm42607_state *st,
 
 	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "WHOAMI read failed\n");
 
 	/* Warn, but don't fail. */
 	if (val != st->hw->whoami)
@@ -638,7 +654,11 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
-	/* Initialize IIO device for Accel */
+	/*
+	 * Invensense, ICM42607 and ICM42607P both have accelerometer
+	 * and gyroscope functionality. Whereas, Invensense, ICM42370P
+	 * has only accelerometer.
+	 */
 	st->indio_accel = inv_icm42607_accel_init(st);
 	if (IS_ERR(st->indio_accel))
 		return PTR_ERR(st->indio_accel);
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
index e903106af84a8..cfafba2e3e68e 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -63,6 +63,9 @@ static const struct i2c_device_id inv_icm42607_id[] = {
 	}, {
 		.name = "icm42607p",
 		.driver_data = (kernel_ulong_t)&inv_icm42607p_hw_data,
+	}, {
+		.name = "icm42370p",
+		.driver_data = (kernel_ulong_t)&inv_icm42370p_hw_data,
 	},
 	{ }
 };
@@ -75,6 +78,9 @@ static const struct of_device_id inv_icm42607_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42607p",
 		.data = &inv_icm42607p_hw_data,
+	}, {
+		.compatible = "invensense,icm42370p",
+		.data = &inv_icm42370p_hw_data,
 	},
 	{ }
 };

-- 
2.43.0

