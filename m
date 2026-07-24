Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013039.outbound.protection.outlook.com [40.107.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA489372B2F;
	Fri, 24 Jul 2026 03:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862424; cv=fail; b=DjISvqo1oKGyEE2IC00XnKrk/1pZCSdIIUBv7lGpgkAeCKHNkSW9cOTVZTSTulzY50K1LuEnfbHimOm+zXJpnzRXSGms1+MreIe3A5TmfIJpUUDHGZEpwZ179a+zj4h4mR2Ekg+8uTy22kfPCkojxgkNDmwPRMlltNBPmiLLx7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862424; c=relaxed/simple;
	bh=heOZrinICMvCF4PEEKIpDFQM/KdwmtsbbHVU7IMfWvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s/+lTWfiMHmnB3MqM16xOISSkmmL7UCNRj60ISTPtQ2lphrOwaPXXdGF2HNlxZyavmhpLdvHBfCQyKueVnO0jcx8ovKM6CI0XdQvn9lcNBrucCUCpnr7T1i1LMa66DYHzUZpBiTj3OPauUNGrA41sWjINKug2EQVY6ORw6r7TRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ES+Mc1ph; arc=fail smtp.client-ip=40.107.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ES+Mc1ph"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amX7KreaDacuJkxka45/mrc0pRxNiXvyCDdXxdw9V5uY5T/PJ/wB7cZheIC2LHqK77nePpmOMFVFHgO4FYCYw73qPw6m38jfgOCoZeppkgJy9mfK3lrVmkFyfxCoiOUWWjSryboygOORN48W7q2Y4EdjNK1vU6pBVkepS7bM7gTt//lzoZYqutaqAPst27UeQSnrlc5tkn6UxDrswwE7xkct/F/VHnTUjjEtLx8CL8DJLPoJXdSc7tmvmyM7ZLTWwdGT2juHZCQKCWnL+V1tWVV4kEktyNaM1nhFvYK22mqV2kIrCKaZQCikU7XzFtKCSd5TSGxJwUvsgd7CZnVuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTH6aqBSpS26rriJy62LSwhcq5VzoVsfJR4BGJ/aD30=;
 b=BNL8ZUQu0CwADK8GqcfEBdljdVJeAD7c5+RqbQ32zC8m/Aj/DBKTTDttvxm3qxonBpEH8ijWzv3IlIYTuAdm2iRHq1u2ugXkg7mzXRermcFakxmaWkqEq+hfoO7sqaJ0T4GC858OXq4B0mSNczcN5LZMs9R3rpEelVW8cgdwnuXWceCDi5Xy22lLHCPot5FwzR8F/ssCt9Wof2oJuVxRfnmDMeq1ziEhQNIM+c7Uvzk7xTh5aGEiawBjAE5I0MlK5nTEQTx3qBkdtNIPLsJrJpY5m0ZFrT44eMmmQ5PrZ7vXx/o1T6KxOH9iubphxMa3kdIHZv+ZhoOV8XARqiNMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTH6aqBSpS26rriJy62LSwhcq5VzoVsfJR4BGJ/aD30=;
 b=ES+Mc1phuWS8lf2eJrmiFMex69IaqYg7tfvzmHyZoTrHsIMqNb4UyoB6EOX4Csy60yQBARJeIdiFcM50UA9U/fQjejAGmbepCWiry9goLsGZucInaDL1kZYFSyufCrsXPMO2tqpJFEUk/gFRTIvYF2NTHA+ZWBmd6A1S8463XR/AqrBCtmjP1Ebhvk7pHqChe92e/9bM2BisLMkIM/kPawa7AQMGFzGAabpHFw6yfznCnTnCRzJnM3dzcUCQ7QllIZlRhqraZ9PE0AS8486scOjfP0BxZ+I5k15ibrtTkGqAGuBXMbSgtGsX1uwsWK8cWWSAvESXwx3ft26Y09jVzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY1PPFE340CD3DF.apcprd06.prod.outlook.com (2603:1096:408::92d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 03:06:52 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:06:51 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-iio@vger.kernel.org (open list:BOSCH SENSORTEC BMI270 IMU IIO DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 08/13] iio: imu: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 24 Jul 2026 11:03:43 +0800
Message-Id: <20260724030524.607185-9-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724030524.607185-1-panchuang@vivo.com>
References: <20260724030524.607185-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TY1PPFE340CD3DF:EE_
X-MS-Office365-Filtering-Correlation-Id: ab388b3b-eabe-4676-019e-08dee9309bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|10067099003|11063799006|56012099006|38350700014|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	H4Cb50iZw6CUaxnh+bdnq946CFjyN0Qk+EMyu/KgRtBs7qnp6kz++YomzCFIRYr2jsGvJ5WhwllDP2M3DOTbU0WzKeyGqrtsSwNjSPJCz1vlPhBA5i5bwLSN98UI/oymT34qAz9KiW3NzdqXgMDgGzzxPj+i2CQqo0gmPN0y56+HNolbP3gw39etqorR8SVIizH4fdAFeRe4606aDHB6gUaR4d1OWfd0UrSSwZTZH0w/7wC336Om4U6gbXvJoSxEbg8SP8dEMUeUMj64I//Y5QIHWN30QsexodEhC+bjZt9MMsJIlANtStSVN4C3Q/eTgvmi+FNtM847I2YMJ7jyKd9uMIzPaqlhotsFaYEG5IAwCt0tOR1Os3pg86m+ip3ewZXAtkAufsC9ot1koxyZT/10V6kWUU6eGW3ifUPsvAL5Hgrfjcfv1rK4RU56OeE91Rl/BHE8FhIWxlL36RFfRGzsEW9zw+eh+Cztf9Qhah8a2C1iL5EQ4YKD2D39i1Ba6RQzZfUqjACDVqxxP0NAD3wQEgfEX2uZ9k94J6u8YI2NQyPkLDY7Lmr1/WdVBj0CkVD3NqVskjnr4kx41GelFzUadVyKyY78vRq0qITjuywNaBt4SFm3GN/r+e9mPV497eNlKzOpwi4uucyH5H+IDLFXLi5G9A4/upvd8/Wp7sjjPtRjveBJ+cUIDaSwjU0KIlMleHrX48qKSos0a3RXKDCs1+aWG7IjjykXpbruLas=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(38350700014)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6i9RNQ+GRzSkjlH6fk+rmGdctad3bBoZrscAbVwZ109YpQYuI80xGBp/+Hty?=
 =?us-ascii?Q?JWQaO24X+kllcggVcLrnPhzc4EJ1VTVwLuy7OUat2LreTg+3cCxU/yngWLTY?=
 =?us-ascii?Q?Tsht7hB3lpf/aDZdAfOIaeI2E6jyp5adaxJBu2Q2ppx/qEmc21c9IwwfMSKl?=
 =?us-ascii?Q?opmBO+GCMuIZzSzPmb3FXXghUOFrLxB25WWV9BTErRj2GCIY71HSKE7neZyy?=
 =?us-ascii?Q?IRSf48xiFniVsopOx5DUjIoPJkTRAATIfweIv4bqPOtMJjdq7UABDJl7KI7j?=
 =?us-ascii?Q?YsZc75u05eF49mFBpxbqDTNNELfw8zzsBImXA96Jc6PyQzCgLoGGXodXKEmY?=
 =?us-ascii?Q?mbOviTf7AtIgE7srobQdqpWr5WSeKrO8Xbh0h1fFNaLoIKiut5FLSFQ8ISS3?=
 =?us-ascii?Q?TW2p+hRtGuLA3BOlUYLh+bjS+Qaerlcg5W0pX/63IyjKnLOt9Dt4zT486Eud?=
 =?us-ascii?Q?LgILY8n9dKf7ufGcxsDkyb8PXsizfm8n6BkKDo7p/IhcQW7GvVLNZ9ZllIh0?=
 =?us-ascii?Q?WspxMMabna8GMi4EGpiH3G9AxerdpY1tmQlg9JpzWnO1hbm/ClckqB1ouV3E?=
 =?us-ascii?Q?OpzpOnT9zpdPmr0mEVAMBgtXuor1kawRQP9I9gyLGrx1lWeE4WMU9p1pAuv/?=
 =?us-ascii?Q?Mbxo3YTZkImEsLyYUs6qAPNcXT3UART2alszAE498AhaH/HsSdhMzRA6S78K?=
 =?us-ascii?Q?PjAhia0b9RChxl9TfBxrv32Sos/vDkcN0IxNeP39TJzetRiHlk3fRvec0X0F?=
 =?us-ascii?Q?mY4H3IgcnobSauqJeEceiZVQuiMtNOG8qUo88DNx41temaoiVRZGEZFcV5np?=
 =?us-ascii?Q?GMJmh7w9ilT6MimoYJkL4meChVEcjhWdZaI8cSUU17QPZfw1vatuMsLR95Xz?=
 =?us-ascii?Q?1hQWgm4RwItWsqJ4im7KeGOsveaRDeHdUZobK7NDGxBVuYDEMcmO/fxoZ9Hy?=
 =?us-ascii?Q?onb4GTOU0tYv5OBjXzTCFCgIrSx6Buym/W/ql3NPK06ix/OfOqRXnQJQBA72?=
 =?us-ascii?Q?0kW14Rlno0SPCRntBjK8skFuYjIYXW0t1F4yAZUM6uiBUlRzYwnX1PL7YN96?=
 =?us-ascii?Q?ScZd4sUVHUC3yXd7m+KU2i/5q0Jpp8vf58SFJDwPQb4oyr6uq64X0wAYmJdk?=
 =?us-ascii?Q?tk3FMaDORAuERw0W3hbkZvAst6oqBnw/zI7ZkjmSZMZdcSkhKYOwqWAvMX63?=
 =?us-ascii?Q?qbA/ad1AauqCTwDlCUuvNR4285VrJgVwUlLH7hXLB+L1ORxlQ1we5xYAoReS?=
 =?us-ascii?Q?7WZfTqg0EIpBh0C8TqDE4bAJZDuqAL1iMo/DJUyxcEtc+mrz60g+DyMQJ22w?=
 =?us-ascii?Q?c+egY/PC2F/DO2PQMaUEDuZrre4apFhh8CW8VutqYNAiInFRnie1vf8zhdEX?=
 =?us-ascii?Q?3hATCAZm+AUNEAZZmMs+nXGCtk0mCRGHvyBUgbHBYUXqt4ZbuQZLYuZH+6SC?=
 =?us-ascii?Q?06pBt+0xA47EGEX9f2R2jMrnlwhq/od6X+ft5IKrstC68yGDGz+W7xPTblzI?=
 =?us-ascii?Q?+m3kYS8JafK02neBEAwcVbHmtWEqO1VTMa6E2BJSTZ07GsLXUlJI4MSbyD1W?=
 =?us-ascii?Q?GlBc/pwa+goPf32dmMkWyKbpMTtlw28b7MXjGd2OBlQ/DQ+CmIoYcKssP1+J?=
 =?us-ascii?Q?pWduxOiFGmqJQtEsRRPgjkCdBP3whx8yUZV9j1skRIGGOvdTKLpwLx1LhoJX?=
 =?us-ascii?Q?4N0eFsDURyR4adM+J+6tgQIYtxaxYhKVcqJDkdYGBCXWxtjy/4gFd9tOeyVh?=
 =?us-ascii?Q?bnu8Qrd9Tw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab388b3b-eabe-4676-019e-08dee9309bad
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:06:51.4566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0pZy8H3OIZXBq0WoN5hEMo7BBeeoPyVJBIb/U9QnhgXrkAfXLFu3RGoA3nDCJ3jD9t+6FAZxa37CYySm2VrfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFE340CD3DF

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_threaded_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err() and
dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c         | 2 +-
 drivers/iio/imu/bmi323/bmi323_core.c         | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 5 +----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 2ad230788532..fbcf6bb87acc 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -1434,7 +1434,7 @@ static int bmi270_trigger_probe(struct bmi270_data *data,
 					bmi270_irq_thread_handler,
 					IRQF_ONESHOT, "bmi270-int", indio_dev);
 	if (ret)
-		return dev_err_probe(data->dev, ret, "Failed to request IRQ\n");
+		return ret;
 
 	ret = devm_iio_trigger_register(data->dev, data->trig);
 	if (ret)
diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 72955a697a93..ebeb1b10c38c 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1946,7 +1946,7 @@ static int bmi323_trigger_probe(struct bmi323_data *data,
 					bmi323_irq_thread_handler,
 					IRQF_ONESHOT, "bmi323-int", indio_dev);
 	if (ret)
-		return dev_err_probe(data->dev, ret, "Failed to request IRQ\n");
+		return ret;
 
 	ret = devm_iio_trigger_register(data->dev, data->trig);
 	if (ret)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index f4edcb73ec8c..360f1365f892 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2852,11 +2852,8 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 					st_lsm6dsx_handler_thread,
 					irq_type | IRQF_ONESHOT,
 					"lsm6dsx", hw);
-	if (err) {
-		dev_err(hw->dev, "failed to request trigger irq %d\n",
-			hw->irq);
+	if (err)
 		return err;
-	}
 
 	return 0;
 }
-- 
2.34.1

