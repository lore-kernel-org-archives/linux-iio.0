Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795470539;
	b=QDcj98VzvPFvRSNxUmy54aRCgxWUZwE4y5ILrQucZAaZCNsYS2yXpIMTf5CnCoe3s36K
	 kouLOyvAiciXO3FzlKIy/G852kILuHdzWw4Bv3VMgGvMWFbZbdTP5JKSok7GDP7rMrUQr
	 XMDDqJD9NyQsX7t5PEcBwVL7mKPrh91UgBPmtgXN/nJQRwerR76spKv/gtVrP95AqZj13
	 +dPZFWy6pLS/RQuwFhLmFhMWu2owIcrJr9impT44hU92/bG0BauuoY7phXT3Dnq750j0h
	 bUjURRP/2Kbd6FIG5ry6AD6bo1JOXRVPQUBo8YDJC3tWaWwxen/MAc1BQxfzcZwByhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470539;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=evVeVx/L5RLM4XiqIAzHNl2mgkIKWAlxJ35sqnSJqq0=;
	b=bfRy981WMeOmrhiGhs/nKgqvuZQ48dv5ioM219z29MPsjDIrt7vqRxmaK0+kCZ24Ct/A
	 EoyGj4rtRg0SnKWcTyyX9o8nvYIJYFyAD3BaejRUHsUupd2LsxN2fj6Jl4aDQlv5xnLIt
	 rsgX9TRwnwLrjNap9LA50JCxRhMz/0/DAz87iCv0iMnooTDeJfrxRfGErOYs0Rf0SzszA
	 kv5taPknIW8F1CC9lKZnDedxXZg4KX4V5WwTqxjMRqPZRqc9ElZUdge8CTFYvnaLwdSN+
	 q1EuSFahpv6fVbMh+Zd4yWFZXDX5Ti0I6ie/AQVGK8huMXlJbTTLskmtKlYvN0z2dhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwdK5OLe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD95606A31E;
	Mon, 23 Nov 2026 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwdK5OLe
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795470538;
	b=wZxFXIetRCFELoaVDqBvv8cT/TNvC/Ycct0cR2e4Ro+XAUyy4aqmiQiP5PfsAK+Eyjfg
	 gVX9ZvnofdhXCN25r73pCDlexEaSiolP5Z1X1zteoV66TiTrk53GQO67IH6VdrRZTRP8B
	 U7gFy6TJRyGhUrDZejiGZQDKVXEVwGuO8+A0rMLBplhcsQ1EiJXviCLMrY4NmOoFBooYc
	 bJbVCmqxowbs3ZawXh3jo/jJ7/40lgv5v7w9oidbC+Xg+Zw5ytPfzSyvOQg6nN8+8vzez
	 XYO79Ssql/q/KndP38odk8f10atsBbSXKTV+SryWj9zC2b54shpEWQRNyka1SP7L7EQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795470538;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=evVeVx/L5RLM4XiqIAzHNl2mgkIKWAlxJ35sqnSJqq0=;
	b=lWQ6qB6KhGKj3AAxD6Nrmm4GHnUBOA+OH5V2xpknbuEpbuTpxpgnLZiwsWh0beEeVoRq
	 0L8JEaSfuT5u+iJUUecacj37gJG/343Z69d0ywkm8fJBaCq64bwGYN7FcEzcJXXWHnx4y
	 9KzzYOhCjhFpkaIDiwkpjxylGpX+i8FOxhuJyxUH1p2tTmP9AsHs5m9ZSZkeeddilBKFe
	 cUkneXczA+KZHGsGBCXIAttgnG1NRJUxjH6dv+tbAPhAvWaWUQqFVaGX7r5pJnDOuz9Bq
	 7UhC0hG/q/O3rt0uz7DzDuYCXzJKmPmJdreRGD7G+y4u0CASJe9bsGBOtCI6TxOcYKQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 655831F000C0;
	Mon, 23 Nov 2026 21:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795470538;
	bh=evVeVx/L5RLM4XiqIAzHNl2mgkIKWAlxJ35sqnSJqq0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=UwdK5OLe7i0wlytFoEJZvhf4z7NRy0IjdP+AzaxPx6lbuH6W014XJ4izEqaq0TEy2
	 rnY/yZED5fFnyoSLmPCWx+RtjH4bos0lVnqkOCD1DLAhnZ5+RxZQ9755YpmsbBO/8b
	 j2/NCjP5nZiHxYb7LhI7KxKKG7wZUVDPMRD94POx6nzETxQe1BgdkREs7n2MeZlJ4u
	 wkRWFxUZfI1iTmk3F6nRZzJrN7sjnSnI7XAGIpkAPdvqnOJrTVeqy7cseEj2XwRO3K
	 GZ8hvBVxHWX1rhfEZwRLh70z50lstTj8WB+dWyoE2doTnJA1F985a52eaFJXg5VFvx
	 KODG4QNfCcKPA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BE5934C774;
	Mon, 23 Nov 2026 21:48:48 +0000 (UTC)
From: Maximo Manriquez Lizarraga via B4 Relay <devnull+DelaySystem.tubot.lat@kernel.org>
Date: Mon, 23 Nov 2026 13:47:16 -0800
Subject: [PATCH v4] staging: iio: adc: ad7816: use dev_err_probe() for GPIO
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
Message-Id: <20261123-batch1-s3-warn-v4-1-47cd8d7d4ce9@tubot.lat>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ7CIBCF4asY1mKcAS268h7GBdCpxZjWAK2ap
 ncX6qZqXL5kvn8GFsg7Cmy/GJin3gXXNmnI5YLZWjdn4q5Mm+EatwDrghsdbQ08CH7XvuGodna
 nbGEAFEvo5qlyjyl4PL136MyFbMyVfFG7EFv/nD72kO/+xnvgwGVlhRISrBbqEDvTxtVVR5bjP
 c44/HJMHIpK0kYCoDDfXMy5+uEi8WqLWCJgSfTBx3F8ASco9EI8AQAA
X-Change-ID: 20261107-batch1-s3-warn-289c98c7b118
To: andy@kernel.org, nuno.sa@analog.com, gregkh@linuxfoundation.org, 
 dlechner@baylibre.com, jic23@kernel.org, Michael.Hennerich@analog.com
Cc: linux-staging@lists.linux.dev, krzk@kernel.org, crofts@kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux@analog.com, 
 Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3394;
 i=DelaySystem@tubot.lat; h=from:subject:message-id;
 bh=3qSIiHaUfGU0fUooR+d3SlhKg7lFwrjdgQuTuX1Jf34=;
 b=owGbwMvMwCH2SNl4+SzWXm/G02pJDNksWw7sVfFuZHFZvGGavsr2VZEFSbd2hwu+tSie9zlNf
 XHWl4zrHaUsDGIcDLJiiixiMjzv6+/rxFlbzTkBM4eVCWQIAxenAEzExZThn3HQ2peCYm/KOP52
 9HD3zxdoj3D6rvnSJGvd+fry1T78+xgZ/lQoGsfKn2Bccz2z4Ujw8eIlf0T2GKw/u5XBR9008cQ
 8TgA=
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
 drivers/staging/iio/adc/ad7816.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 2a15d7598abb..2fd0c4658918 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -364,6 +364,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 {
 	struct ad7816_chip_info *chip;
 	struct iio_dev *indio_dev;
+	struct device *dev = &spi_dev->dev;
 	int i, ret;
 
 	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
@@ -380,30 +381,21 @@ static int ad7816_probe(struct spi_device *spi_dev)
 		chip->oti_data[i] = 203;
 
 	chip->id = spi_get_device_id(spi_dev)->driver_data;
-	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
-	if (IS_ERR(chip->rdwr_pin)) {
-		ret = PTR_ERR(chip->rdwr_pin);
-		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
-			ret);
-		return ret;
-	}
-	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert",
+	chip->rdwr_pin = devm_gpiod_get(dev, "rdwr", GPIOD_OUT_HIGH);
+	if (IS_ERR(chip->rdwr_pin))
+		return dev_err_probe(dev, PTR_ERR(chip->rdwr_pin),
+				     "Failed to request rdwr GPIO\n");
+	chip->convert_pin = devm_gpiod_get(dev, "convert",
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
-		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
+		chip->busy_pin = devm_gpiod_get(dev, "busy",
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


