Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795026231;
	b=zFZ2w5Rj0Zf4uabyhG4gcC4n4LUJ9iS5YuyvwQqaNigzvj33fCKsoi5d8i0YKGZ4ZEmx
	 //dR9hIds/zv8iuXaxdMYs+GJkpM3Xpd8VSTxgSfLqeRg+l9MkkoooIYamNxPAOKWtp4P
	 FrQ6CQ3jFFKvGJYeyyzKLPtTDGVn54e6vI+SC5cJ9R2KWXapxkREsdYgHsfsQ0q8V8bxQ
	 V7lw9KKpRTLwIkgJznzz/z1xd64Q65Ru9eXiSymyUIIkrSkG/TVmLROw7aEts+E+Rbq24
	 nig8Lo8ZLcCH2set7Vtarw47aybJeZF0wYeT6cS1PBacTdD4Fww/mwxa1AC8N0Esy3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026231;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eXYD4X0CeO+62DbtTGXIAFqWJcku0Q4l2Qtcs6eLqvw=;
	b=kHzgXE7TT6kds4y8OuksdfqhNs+4Di9gLIRZJSuM7eBqgfW/O81hNaLSNY5iKOOQyqBh
	 Ry2uU/3BvCqzvwyXY6AZzI/41d1sfwIvCZn9KxwCgRa48Qt1Qs01HYzVZlV/IISWmIJ/q
	 hGGBSFU3FrIIPvyz16rEv4JjEv/quxhndbUtlFzqlbbIT8UR81CKIe31tDO+EeAm6n7Zq
	 q+c2P8n5pRSzpzXoggExIjjCoVlXmY8kv3egLpd/T7E8obLVcMLeb+rvjSHva1E8/3L6O
	 dJo+HPa/zOaQtJyYo+RS27R5mytpaIBxbMqcTF3nFiOygPhptvbSqGPg2p7fpK6NdUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ox0wqPwm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2430C60A2609;
	Wed, 18 Nov 2026 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ox0wqPwm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795026230;
	b=p6VDKsMk+y0RSGcJ0uXSl5n8nzDGr2YreBG9i0RMSzRbtE1HnBjCl4k8az7xrxaKSdFE
	 4Nyyo6FHm7w+WFdL3/8Fa1np5Ou12PeEyZngd2WXpltQRVifDdnDJTanROapkpSj+0vxk
	 boT+qZlZCORmpiwHCWDXkHXqbPgsgayeEWkMs6KnJOvv2cy8WMJKW4cVa1LKCJY0uYvBx
	 m/sK/QiGrD54K02pwqOLwCB16+WVI6+Q8mZoD30V/3eUnvKkI5ekIwn34JD81jePkF4se
	 /KxJnqsgVK36uVMPw+LmD8gWf22MSSy5Ig/aKtXrva1ZIcTO6MBBq6nCvXLHRv4X79w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795026230;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eXYD4X0CeO+62DbtTGXIAFqWJcku0Q4l2Qtcs6eLqvw=;
	b=X5rAMhpsY71W/2jvZTe74P6evMjYAKJfw0/nNgnOKFKp3ODwFqKkEvbHO/+gqkxdxHkn
	 JxBIQosmv3ekNawGmN0/FJ6OgZSDLcqJPcY8Tjl8b9IpfcCOYgOwTbfUHnQu7wARcX/Zb
	 5pS5/YTuxDyTxpbEAGtRduYBc7eJ1uy+UkwOd4XYOxEmG9ewJyyAxNZ4YTn7bGrthaQnH
	 3by1JoViWVh+zXQsUho0wRShWm36U5DKKb63Wi+4hWoLigFzDGpBO+6p6bmqjVleCNm6r
	 u7S1n3+/rqNlwnhE/M7wRJ8AxrCAvhYg6Mx+81DIF+iHCh9AYuEd9T/pOtz/JPVHIyQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 421721F000C4;
	Wed, 18 Nov 2026 18:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795026230;
	bh=eXYD4X0CeO+62DbtTGXIAFqWJcku0Q4l2Qtcs6eLqvw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Ox0wqPwmiZN4S5VQvvyD+woyx85uPwzhVcjsATxPkJL2BQyTLtKLkEB+bnbqnEnds
	 wdBdEcIQheFFLgkeT5Tp3v//BjIS9RW7x6wpKMYK/6Ksd4hQuKW/kUVhLwydsizBl0
	 NrC1Pq+ZE54fi7jvsEXdLpk1qPzv6wgVUA5lMDz4uCgfJ6Aj3yeFZlakY6UknvA/6l
	 rh/bqPKdSzJQtnguetZJYhA8vK8LNjH+jQWx9+NKeNZfNYdZ4hlwpApOsq2vFG107c
	 /UQpUML+3JR18wjveaDIwixPlBLxCS1vi4TFhTcJD87mX/kWu/870iTzJFdVOxLcR2
	 5T0Azfn2bZ0SQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B17D84AEF9;
	Wed, 18 Nov 2026 18:23:49 +0000 (UTC)
From: Maximo Manriquez Lizarraga via B4 Relay <devnull+DelaySystem.tubot.lat@kernel.org>
Date: Wed, 18 Nov 2026 10:22:17 -0800
Subject: [PATCH v3] staging: iio: adc: ad7816: use dev_err_probe() for GPIO
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
Message-Id: <20261118-batch1-s3-warn-v3-1-f622d212deeb@tubot.lat>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ7CIBQFr9KwFtMPaKkr72FcAP5ajCkGKGqa3
 l2omybG5SRv5k0koLcYyKGaiMdkg3VDBr6piOnVcEVqL5kJq9keoG6oVtH0QAOnT+UHymRrWmk
 aDSBJlh4eO/tagqfzl8Oob2hiqZRFb0N0/r08Jii7v/EEFKjoDJdcgFFcHuOoXdzeVSQlnthKh
 1+dZR2aTuBOADCu1/o8zx/ZkGR3/QAAAA==
X-Change-ID: 20261107-batch1-s3-warn-289c98c7b118
To: nuno.sa@analog.com, andy@kernel.org, gregkh@linuxfoundation.org, 
 jic23@kernel.org, dlechner@baylibre.com, Michael.Hennerich@analog.com
Cc: linux-staging@lists.linux.dev, linux-iio@vger.kernel.org, 
 linux@analog.com, krzk@kernel.org, linux-kernel@vger.kernel.org, 
 crofts@kernel.org, Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2746;
 i=DelaySystem@tubot.lat; h=from:subject:message-id;
 bh=AmqBcsa25DReGcyElJDVwLM4MEKGLB/bkwyZBeRmiyY=;
 b=owGbwMvMwCH2SNl4+SzWXm/G02pJDFl/35pe0kn71vJ75w/V/DXPZgc/8HVdZHlO+53kgt/Lp
 H5fF2Cb2FHKwiDGwSArpsgiJsPzvv6+Tpy11ZwTMHNYmUCGMHBxCsBE9uYwMry6ILJgTVGbdt3l
 3XYb6vO+/pH/+frhPcclj36tEi3/F3+W4a9c5LKFLhdqNopYHj37ZN0z99daO9i2eM6rfPU7SfR
 5tSU3AA==
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
Changes in v3:
- Convert the missed busy-GPIO failure path to dev_err_probe() as well (Joshua Crofts).
- Link to v2: https://patch.msgid.link/20261117-batch1-s3-warn-v2-1-17f4e541123b@tubot.lat

Changes in v2:
- Resend under my real name (From/Signed-off-by: Maximo Manriquez Lizarraga).
- Apologies for the improper sign-off on v1; no code change.
- Link to v1: https://patch.msgid.link/20261107-batch1-s3-warn-v1-1-4fc38341ca38@tubot.lat
---
 drivers/staging/iio/adc/ad7816.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 2a15d7598abb..dc9d89ca04ab 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -381,29 +381,20 @@ static int ad7816_probe(struct spi_device *spi_dev)
 
 	chip->id = spi_get_device_id(spi_dev)->driver_data;
 	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
-	if (IS_ERR(chip->rdwr_pin)) {
-		ret = PTR_ERR(chip->rdwr_pin);
-		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
-			ret);
-		return ret;
-	}
+	if (IS_ERR(chip->rdwr_pin))
+		return dev_err_probe(&spi_dev->dev, PTR_ERR(chip->rdwr_pin),
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
+		return dev_err_probe(&spi_dev->dev, PTR_ERR(chip->convert_pin),
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
+			return dev_err_probe(&spi_dev->dev, PTR_ERR(chip->busy_pin),
+					     "Failed to request busy GPIO\n");
 	}
 
 	indio_dev->name = spi_get_device_id(spi_dev)->name;

---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261107-batch1-s3-warn-289c98c7b118

Best regards,
--  
Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>


