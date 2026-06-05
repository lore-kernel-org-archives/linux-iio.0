Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC94B8DF1;
	Fri,  5 Jun 2026 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650113; cv=none; b=AQLexxGs37hDU8S2GStnbPYrDw/8gK7huLuJQI9XZJ1axThqKPt5f5w2hm7vLHViCltVW1xyim8dY5Z/MANio4H7za3HihPp6/DVPTGSbBcTMCOmc+qkLX+MEntqJ8wtgxT/sEn8Mem1Vz3eYm3f18ipgMNIwIg0asTpFfijdBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650113; c=relaxed/simple;
	bh=OwNImBxZWjT7FlNBpkpifMklWVn6NT/NURd1B8Jk4Es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YHqT9jI2iFBFknA4WXapWWhJo6QVbRFZeuozOqIGCdxSVIYDS+ke9yD2iuovxLNd/fkafpm4h8iaYXipSv/Doa40qN9apWF/sN99oiUgATDQhvG7bOG8JbXqMvLPosh0KHVWn6FIcOu80n9Z3EivhSG59XPatAj41wUd0Cxv/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wrkk+az7; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wrkk+az7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6AA0DC58472;
	Fri,  5 Jun 2026 09:01:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C9C395FED1;
	Fri,  5 Jun 2026 09:01:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CFDB7106A2038;
	Fri,  5 Jun 2026 11:01:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780650108; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5lJcCTJfAQmhLwfgf1C/wVrlTzaj9azQJ2Rtzz7Eq9k=;
	b=wrkk+az7ArrnQbACXjeXZaBRFtDqRS/U5Ak0p+OdWAEpeB53hukob5gfIy+L4AbbaeGe8G
	E5szLAqMC0BaFcW1BiGPrRSZopLK3u96eOV4c67pFhr3EJwxgtf2QJ380F+FuJ6ZDPKcUg
	pRggXTnTgJi8AdEagYmR5kHUApUICtGMi32KQLXrQB5cS7omjf8z2vugQu2MRpozTy2OrN
	5asHxH1FasCpzUpiBXoq7ie+apgWnfaq3TdxdMyFezieV4Do1O8HDwIdwMwljrqTLJv7Xo
	fViT1S+ahWkGRtoD73MURYgCE83AqneKg3oKw94ilqe6ExOI+doC7DSaUPlYJQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Fri, 05 Jun 2026 11:01:36 +0200
Subject: [PATCH 2/2] iio: temperature: tmp117: add TI TMP119 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-tmp119-v1-2-349f45f17d12@bootlin.com>
References: <20260605-tmp119-v1-0-349f45f17d12@bootlin.com>
In-Reply-To: <20260605-tmp119-v1-0-349f45f17d12@bootlin.com>
To: Puranjay Mohan <puranjay@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Wil Stark <wil_stark@keysight.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

From: Wil Stark <wil_stark@keysight.com>

Add support for the TMP119 temperature sensor, which has the same
programming model as the TMP117.

Signed-off-by: Wil Stark <wil_stark@keysight.com>
[rgantois: Rebased from v6.6.58 to v7.1.0-rc6]
[rgantois: Commit log]
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/iio/temperature/tmp117.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 8972083d903a2..8e9621171c516 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -38,6 +38,7 @@
 
 #define TMP116_DEVICE_ID		0x1116
 #define TMP117_DEVICE_ID		0x0117
+#define TMP119_DEVICE_ID		0x2117
 
 struct tmp117_data {
 	struct i2c_client *client;
@@ -170,6 +171,7 @@ static int tmp117_probe(struct i2c_client *client)
 		match_data = &tmp116_channels_info;
 		break;
 	case TMP117_DEVICE_ID:
+	case TMP119_DEVICE_ID:
 		match_data = &tmp117_channels_info;
 		break;
 	default:
@@ -204,6 +206,7 @@ static int tmp117_probe(struct i2c_client *client)
 static const struct of_device_id tmp117_of_match[] = {
 	{ .compatible = "ti,tmp116", .data = &tmp116_channels_info },
 	{ .compatible = "ti,tmp117", .data = &tmp117_channels_info },
+	{ .compatible = "ti,tmp119", .data = &tmp117_channels_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tmp117_of_match);
@@ -211,6 +214,7 @@ MODULE_DEVICE_TABLE(of, tmp117_of_match);
 static const struct i2c_device_id tmp117_id[] = {
 	{ "tmp116", (kernel_ulong_t)&tmp116_channels_info },
 	{ "tmp117", (kernel_ulong_t)&tmp117_channels_info },
+	{ "tmp119", (kernel_ulong_t)&tmp117_channels_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp117_id);

-- 
2.54.0

