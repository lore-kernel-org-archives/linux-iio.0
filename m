Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D233BBCF
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934440; cv=none; b=lu1dwh7eIvfWXHsdDDZm5muxG/t1MPNcAgz4lVwHRcfWIfKuUbj/DHzQFIgnmZVJbH5+1tfZjV3hGZzhuf/dUIg8pl8Qb0Uu8FI+qrb/LUG9kR8Ki9U22HONg8hZle+gpjd2ZLPjmXqrb5Z2bmyhROb5cTgeuVLZSYdTXOFCxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934440; c=relaxed/simple;
	bh=nFFCoQRTk6bKpMwGqawFeqiihFgL4Rw5w468K89QyIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKc4FO5ViXrvAz/E4Y93cJEXCo8Ih2mNaBEMTHlfTKxjwLr/nu5XGldDKJql9/akFoqawC4Nhc4gprbZBzyIr7hH4YPOxV2TKEuOFZrsJSN5hlGCi8yR2QLmOBVnV0T18Jj50az0pSKN3mE+nzb3oKc986wiQDSLi4CNufXW1uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wst3HCtG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wst3HCtG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AAE511A37D6;
	Mon,  8 Jun 2026 16:00:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 786F85FFB7;
	Mon,  8 Jun 2026 16:00:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1F5C106A19BA;
	Mon,  8 Jun 2026 18:00:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780934436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KQM6ESoW60ubESTpKBaOza9yeUTfEcA8pRHfdQKBL2c=;
	b=wst3HCtG9uWq5yus5Ej64jyAcosHze8fhRdskPvMDrl9q15g8oakit0Fil1BrnYRlgvRWd
	g2g3PvvTLeCvu2izWb/kUEeVY3C+1OqlL1k2FGC+5WGVkMCyraE1rhF9QyDzUHArUGw0x6
	3O35mx1pND96QAPJoZK0Joj8OlYEv2/D25OseHR5qbAuKudH/dl98tZqeQXamQ68Su+Bva
	TRpSXaLT3eJXOyDTNyuNWtr/SND19KixsOVZ7ymphUOwu1/aU//GY+ppvLd/0O0iz+kysO
	16lFYob0RtUwxZU90qm/Lpf/Po5oxxtKaP4QiYwbUQPE8i+SBDogQa1UbOW4Kg==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 08 Jun 2026 18:00:25 +0200
Subject: [PATCH v2 2/2] iio: temperature: tmp117: add TI TMP119 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-tmp119-v2-2-30c3537d5097@bootlin.com>
References: <20260608-tmp119-v2-0-30c3537d5097@bootlin.com>
In-Reply-To: <20260608-tmp119-v2-0-30c3537d5097@bootlin.com>
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
 drivers/iio/temperature/tmp117.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 8972083d903a2..18ad40f3e7361 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -38,6 +38,7 @@
 
 #define TMP116_DEVICE_ID		0x1116
 #define TMP117_DEVICE_ID		0x0117
+#define TMP119_DEVICE_ID		0x2117
 
 struct tmp117_data {
 	struct i2c_client *client;
@@ -139,6 +140,12 @@ static const struct tmp11x_info tmp117_channels_info = {
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
@@ -170,6 +177,7 @@ static int tmp117_probe(struct i2c_client *client)
 		match_data = &tmp116_channels_info;
 		break;
 	case TMP117_DEVICE_ID:
+	case TMP119_DEVICE_ID:
 		match_data = &tmp117_channels_info;
 		break;
 	default:
@@ -204,6 +212,7 @@ static int tmp117_probe(struct i2c_client *client)
 static const struct of_device_id tmp117_of_match[] = {
 	{ .compatible = "ti,tmp116", .data = &tmp116_channels_info },
 	{ .compatible = "ti,tmp117", .data = &tmp117_channels_info },
+	{ .compatible = "ti,tmp119", .data = &tmp119_channels_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tmp117_of_match);
@@ -211,6 +220,7 @@ MODULE_DEVICE_TABLE(of, tmp117_of_match);
 static const struct i2c_device_id tmp117_id[] = {
 	{ "tmp116", (kernel_ulong_t)&tmp116_channels_info },
 	{ "tmp117", (kernel_ulong_t)&tmp117_channels_info },
+	{ "tmp119", (kernel_ulong_t)&tmp119_channels_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp117_id);

-- 
2.54.0

