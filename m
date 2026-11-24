Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795544908;
	b=sVhe63FGynlxIgD2p+jGqCoIkePTlr6lDQEyj1ST0CH54K/ErA1t9ZCuMqO5eGkmalKU
	 FCi4BGfuMCYJrEDynH1ry5c6R+Or42kDHQMaHQlBQoV1hwlm7NfBx1DKa+swlk9YrMtk8
	 fnJ4om7PtlaIKKbtUAYrKkOwqAbVCiXbnGXgEeInGxEtcYyQs6hkjEl+/1miQW/69zOWL
	 tLkzIbKXwPhKWFtqJ7AtBK25BFN+I/pvxj0LD/jLOquTO8PA2KoQZum4vdMSfEt2uj7jR
	 PU7mdTWNyey8W3c13kCYrwDQTRUdqZhDpRXaQ2bVhnbKv5cOzghFWag9cyJNBOcVE1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544908;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=s0RWsaaYDhicCKUJ5pRxB0kYGFvyOIl7Ez0ptkVZUzI=;
	b=rniueKnb8DDpekEQ46HEk9Q2PXYMTzoVHIykMJNWM2zvUABTRz7eq0rr4cFXLPLD76fz
	 UJD9gtuPEeoOhvg1cIZlddz0cht6899YbLzOT+2Md0NmWRrjQSwAPcvYAO2BVyq84b7Qa
	 5CHkGJEKqhGkNyjT648yODQqV2h7z+Ub01abwYpZw3twY30dyZKsfRE8diZqlN1o0jzvA
	 qY0ffGXWFItvTrc3iYC9R/AaG1ad5qkNdU2gT6n1Sc0UQA+7ograApNOpgovbMZ4G1VSJ
	 Foog2G2bTbkYC9DggLwPLRd6ohK1UMA5rT1/5uNGyUdiaWVoNsavqqsk6Ls1UGOUHwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLPuW0pm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC73606A31E;
	Tue, 24 Nov 2026 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLPuW0pm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795544908;
	b=i0xsdvhCAvtVWphBE+E90uJXnk7kxrZpC4uzoQaaUQGIQQ0uXKUbYskBSxKIzzBwN/Tp
	 mNl2jZWkB/3kmY4SYQoVUvixKGRhbdH7AE2OAnGhkTR3tCVvQkWQGoWkEWnPNs0A0UwIk
	 HuxveSeD/HKnrIc1Dhycv4qHC5ZklucYQnVYROVbFNQzw1WvMNPSkast0z7ixrhNmYpy0
	 VhqhLBm3r1duZDrbvFa7ok9KZVU8sDIpVaTU9q42vgaN1EV3QJJtPMFsmK0KKcuT5qpcr
	 TrBkauARIjWNZpdbZVtCEB4uNTpPmVqRt2bX4xkRNcqUorRCtamt/TmJ7u4lQf88F5Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795544908;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=s0RWsaaYDhicCKUJ5pRxB0kYGFvyOIl7Ez0ptkVZUzI=;
	b=O25xzHkSjV6RBSlelnMZS9zPdktDGbd8S8vKYCCgt+d53HiWb5dJr3sGyGqVM7HUbnak
	 HkE9cOdFKeZ5ugUa3c9nG4Y9j+cY3N8qeXt6dAzRNL37rlzjvkJrvhT17T7ajqLuv/DoH
	 ceXFEq+2fJyol3BBZ1H4f7a/R50hQjAs1Vbc2FoPGlB3Ef+4V2GGAIHakL5sduw+gplB3
	 L4X1TxNdsS9Y5L+qniXOhVQ8I5j3V8DZr6Opd7D13OYWpde972ptF4fOmlFIYg8y8vX5i
	 h+htl6BLljCMloLiBLXPGvKfcb37AJLjCiozfq526oVQ058GEg6ncbsZ3GKPRJ0FNSw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A5F111F000C0;
	Tue, 24 Nov 2026 18:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795544908;
	bh=s0RWsaaYDhicCKUJ5pRxB0kYGFvyOIl7Ez0ptkVZUzI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=gLPuW0pm4dyNsB+rRUbe3OsMsx6aVcmGFv/CEokq4Hpt40nc2XD2itxP7kj1p7OCv
	 Ox9hVCgPfJfGpvRqXIAutFtzx0B0ZcoQ9LBvdI1whD8AmLoQUbLZUD5IkeByNgwTzo
	 V5adgHala97IneJp5TsJIpGzR/1DIKrYiz4M1okGG4vKJGOj57CJCCkRO4gu6hllD+
	 b58vOXSewdmY2I1MTHROyBEF9z4JThRzu+h1I8C5ZYGXzF4V4Zvvuqv45gku/4Mz91
	 y6p25N9k8JAx8zOZtJEJ0lfcogn7G+TbYFk499njLwI2bILqnygU4TovwBnz1KlLv4
	 iGkch/mqb7JDw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 07D274CB3C;
	Tue, 24 Nov 2026 18:28:25 +0000 (UTC)
From: Maximo Manriquez Lizarraga via B4 Relay <devnull+DelaySystem.tubot.lat@kernel.org>
Date: Tue, 24 Nov 2026 10:28:24 -0800
Subject: [PATCH v5] staging: iio: adc: ad7816: use dev_err_probe() for GPIO
 lookups
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-batch1-s3-warn-v5-1-badf90d5defe@tubot.lat>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOQW7DIBAF0KtErEuVGUjAWeUeVRcwjGOiyo6Au
 K0i372QbqxaXX7pvz/zEJlT5CxOu4dIPMccp7GGw8tO0ODGC8sYaha4xyPA3kjvCg0gs5KfLo0
 SbUedJeMBrKjolriPX8/Bt/ffnO/+ylTaSmsMMZcpfT8vztB6/47PIEHqnpRVGsgpey53P5XXD
 1dEG59xxWHLsXIwveaDBkDl/3K15nbDVeX9ETEgYGDecL3iqDZct+cNBRtM0MTdmi/L8gM2jOW
 QewEAAA==
X-Change-ID: 20261107-batch1-s3-warn-289c98c7b118
To: Michael.Hennerich@analog.com, gregkh@linuxfoundation.org, 
 andy@kernel.org, nuno.sa@analog.com, jic23@kernel.org, 
 dlechner@baylibre.com
Cc: linux@analog.com, linux-staging@lists.linux.dev, 
 linux-iio@vger.kernel.org, crofts@kernel.org, linux-kernel@vger.kernel.org, 
 krzk@kernel.org, Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3468;
 i=DelaySystem@tubot.lat; h=from:subject:message-id;
 bh=pIPxq0yfo0Ggng/63NlKt3XQGOq6qAvMytmuG849dko=;
 b=owGbwMvMwCH2SNl4+SzWXm/G02pJDNms191l9PJLrwXc8Xj1oVd/Ve3O84efJkWURKRarGevf
 NX5/ObRjlIWBjEOBlkxRRYxGZ739fd14qyt5pyAmcPKBDKEgYtTACbSNZ+Rof9D6bMtElH3Wex5
 OZb1lxozzplrnqK1S2NRZOQeifXTzzMyHKh4Zn8gwSg04XMc74ljPvYGDTNt1xuxPi1IflpmPfE
 bCwA=
X-Developer-Key: i=DelaySystem@tubot.lat; a=openpgp;
 fpr=161C0CEF7FDF2C5E3B3A9CC8E22333A79A058D4B
X-Endpoint-Received: by B4 Relay for DelaySystem@tubot.lat/default with
 auth_id=1447
X-Original-From: Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>
Reply-To: DelaySystem@tubot.lat
Content-Transfer-Encoding: 7bit

From: Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>

GPIO lookups can return -EPROBE_DEFER.  Convert the rdwr, convert,
and busy GPIO lookup failures in ad7816_probe() to dev_err_probe(),
which suppresses the error message on deferral and records the deferral
reason.

No functional change other than defer handling.

Signed-off-by: Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>
---
Changes in v5:
- Move struct device *dev to the top of probe to keep the declaration order (Andy Shevchenko).
- Leave the devm_gpiod_get() calls unchanged; only the error lines become dev_err_probe().
- Link to v4: https://patch.msgid.link/20261123-batch1-s3-warn-v4-1-47cd8d7d4ce9@tubot.lat

Changes in v4:
- Add struct device *dev at the top of probe and use it in the touched lines (Andy Shevchenko).
- Link to v3: https://patch.msgid.link/20261118-batch1-s3-warn-v3-1-f622d212deeb@tubot.lat

Changes in v3:
- Convert the missed busy-GPIO failure path to dev_err_probe() as well (Joshua Crofts).
- Link to v2: https://patch.msgid.link/20261117-batch1-s3-warn-v2-1-17f4e541123b@tubot.lat

Changes in v2:
- Resend under my real name (From/Signed-off-by: Maximo Manriquez Lizarraga).
- Apologies for the improper sign-off on v1; no code change.
- Link to v1: https://patch.msgid.link/20261107-batch1-s3-warn-v1-1-4fc38341ca38@tubot.lat
---
 drivers/staging/iio/adc/ad7816.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 2a15d7598abb..7d9a5f324466 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -362,6 +362,7 @@ static const struct iio_info ad7816_info = {
 
 static int ad7816_probe(struct spi_device *spi_dev)
 {
+	struct device *dev = &spi_dev->dev;
 	struct ad7816_chip_info *chip;
 	struct iio_dev *indio_dev;
 	int i, ret;
@@ -381,29 +382,20 @@ static int ad7816_probe(struct spi_device *spi_dev)
 
 	chip->id = spi_get_device_id(spi_dev)->driver_data;
 	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
-	if (IS_ERR(chip->rdwr_pin)) {
-		ret = PTR_ERR(chip->rdwr_pin);
-		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
-			ret);
-		return ret;
-	}
+	if (IS_ERR(chip->rdwr_pin))
+		return dev_err_probe(dev, PTR_ERR(chip->rdwr_pin),
+				     "Failed to request rdwr GPIO\n");
 	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert",
 					   GPIOD_OUT_HIGH);
-	if (IS_ERR(chip->convert_pin)) {
-		ret = PTR_ERR(chip->convert_pin);
-		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
-			ret);
-		return ret;
-	}
+	if (IS_ERR(chip->convert_pin))
+		return dev_err_probe(dev, PTR_ERR(chip->convert_pin),
+				     "Failed to request convert GPIO\n");
 	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
 		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
 						GPIOD_IN);
-		if (IS_ERR(chip->busy_pin)) {
-			ret = PTR_ERR(chip->busy_pin);
-			dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
-				ret);
-			return ret;
-		}
+		if (IS_ERR(chip->busy_pin))
+			return dev_err_probe(dev, PTR_ERR(chip->busy_pin),
+					     "Failed to request busy GPIO\n");
 	}
 
 	indio_dev->name = spi_get_device_id(spi_dev)->name;

---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261107-batch1-s3-warn-289c98c7b118

Best regards,
--  
Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>


