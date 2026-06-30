Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642C14014AA
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811610; cv=none; b=V7yeSi9z29JwvQB8H/zOBS7NeqUBb6ptVrHPkknkhhTsY9IybMVWh0+lnusVohajIq4BySluAjTdY7laoXa6LDNt5Hy+evMxeAq9mxrl0HBw7e8oxExRa6k1zPig2I6pFejNIVeuFB2RF0k2fr5AInVgyqTuohqGCqD0tlId3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811610; c=relaxed/simple;
	bh=c8wmLIu3uRXg//Al5eUFcWoZj1e9M2f28Pl8RsqVAx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PBFBMULr+0y78l2oe9gJwPRNx/4YB5frGeCfFN8o8btwGVIpzZ4OGv3eTizR49DyGOpu3QMOcEV2V0wOSHa3ezdbgxHj7jNq0O2CGX1OLdhVmh7Snw+HC3O0bOxCKp6n2vb3s8zTF2HXof7VWZfpMRyDOJJQNjY2uX/GU4sBHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SewhgDT8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SewhgDT8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 99778C5CD4C;
	Tue, 30 Jun 2026 09:26:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2837460233;
	Tue, 30 Jun 2026 09:26:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB6FB106F1D41;
	Tue, 30 Jun 2026 11:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782811606; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mt4NkHR9JVVbaE9t8ym4RvhwpVL66pkid5egJE9nv0Q=;
	b=SewhgDT86D8eCTWZvS1TS24yHIp/vzKedimyTS92as4YfNM9eqmesZibhR8QxhtV4oB25t
	KtAoYIRwSjKQe2jnVaFnlcDpNBlQItZVrawfvq9aIoVBD2EszR+ddDfPnTkpmxQMUN8BI+
	c8LafFAuXoeJkFoZ39SkQrpXpjlzWaw6p8b7s0zeuxmLli7rdGKyzn3UhnSpP3f/FY+NG6
	CROlXzKgoXW74eWtWo7S9CsZtGOJSLc59HFSLP4q4R2i3veuko+IKhBQG4ZwwAqlJIStdC
	fwppA1vkkoW74bOC6yt/Cro7PJMgXon3wIgomr6XwJrHK37gySuAPEj2I76Axg==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 30 Jun 2026 11:26:35 +0200
Subject: [PATCH v3 2/2] iio: temperature: tmp117: add TI TMP119 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-tmp119-v3-2-cfdb50e2e99f@bootlin.com>
References: <20260630-tmp119-v3-0-cfdb50e2e99f@bootlin.com>
In-Reply-To: <20260630-tmp119-v3-0-cfdb50e2e99f@bootlin.com>
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
[rgantois: Rebased from v6.6.58 to v7.2-rc1]
[rgantois: Commit log]
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/iio/temperature/tmp117.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 6bc18616ad15e..74cb8d62bef3c 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -9,6 +9,7 @@
  * Note: This driver assumes that the sensor has been calibrated beforehand.
  */
 
+#include <linux/array_size.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -38,6 +39,7 @@
 
 #define TMP116_DEVICE_ID		0x1116
 #define TMP117_DEVICE_ID		0x0117
+#define TMP119_DEVICE_ID		0x2117
 
 struct tmp117_data {
 	struct i2c_client *client;
@@ -139,6 +141,12 @@ static const struct tmp11x_info tmp117_channels_info = {
 	.num_channels = ARRAY_SIZE(tmp117_channels)
 };
 
+static const struct tmp11x_info tmp119_channels_info = {
+	.name = "tmp119",
+	.channels = tmp117_channels,
+	.num_channels = ARRAY_SIZE(tmp117_channels)
+};
+
 static const struct iio_info tmp117_info = {
 	.read_raw = tmp117_read_raw,
 	.write_raw = tmp117_write_raw,
@@ -172,6 +180,9 @@ static int tmp117_probe(struct i2c_client *client)
 	case TMP117_DEVICE_ID:
 		match_data = &tmp117_channels_info;
 		break;
+	case TMP119_DEVICE_ID:
+		match_data = &tmp119_channels_info;
+		break;
 	default:
 		dev_info(&client->dev,
 			 "Unknown device id (0x%x), use fallback compatible\n",
@@ -204,6 +215,7 @@ static int tmp117_probe(struct i2c_client *client)
 static const struct of_device_id tmp117_of_match[] = {
 	{ .compatible = "ti,tmp116", .data = &tmp116_channels_info },
 	{ .compatible = "ti,tmp117", .data = &tmp117_channels_info },
+	{ .compatible = "ti,tmp119", .data = &tmp119_channels_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tmp117_of_match);
@@ -211,6 +223,7 @@ MODULE_DEVICE_TABLE(of, tmp117_of_match);
 static const struct i2c_device_id tmp117_id[] = {
 	{ .name = "tmp116", .driver_data = (kernel_ulong_t)&tmp116_channels_info },
 	{ .name = "tmp117", .driver_data = (kernel_ulong_t)&tmp117_channels_info },
+	{ .name = "tmp119", .driver_data = (kernel_ulong_t)&tmp119_channels_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp117_id);

-- 
2.54.0

