Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D11437846;
	Thu, 16 Jul 2026 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221414; cv=none; b=grO0aaq+xkH08tGxJ/AOuUiy8V3jWoiecj88Gg+8NYRgPKB468jLrYQSzYhtgZWi3ptWoiN+sH4RuxXq1MpU8Ys097z/JSK621OLdaV7UkL9pe1x2YOwIFZRv6i4ZbZ+s/IyZtFWnUrcCtiNRXHhDIuG5GSBByWWDg+cKXjTs18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221414; c=relaxed/simple;
	bh=H+hYir4Fn8uM+EM3gHtA9a1XSSatPBdTipsV1h9wi00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=doDBAE69FKg4lqs5Uwgf44Ibj2KalgrW4bO32xyUTfecNZVTntLU9UGYK9jo2ID+lq28GUzn5dvSMW7KKH46ZwvTshJdCvJ2Cd3xuUWje+tNgUvzDN9X6W6DKxsUM9twMd5N3XLaxSAdiJ85mwovl1V9Cx9LNYWpkWP/gSEYYYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=jhDmHLam; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="jhDmHLam"
Received: from email.seznam.cz
	by smtpc-mxd-7457b5647d-hg8d7
	(smtpc-mxd-7457b5647d-hg8d7 [2a02:598:96:8a00::1200:712])
	id 1654b945ae3b94ca14aa23d9;
	Thu, 16 Jul 2026 19:03:18 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1784221398; bh=hlBo0qzIENm3R3I+HjXcD+AnLA22wdk7T6o7fJ6knps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=jhDmHLamaxrPpnMAAJSobexlGDd4L7J75I662yDQkGM32gzGDgzdvK+TJk3XcAwhI
	 Gw/+SxK5luRLsHUiqI+wxp3rReQQRmBDqP/UmNvc2fqCbLi15gLCNqvylwnOanUSBw
	 keeV1pJOeWt6apWhdxyFJw8z8LNt7hKCY87z59sbS3DEhfr5SSoMov96trq1clHsHh
	 U0yzVDg3vo9K4X14KjWGiMe903u2ATauhiXBmFwPBQDOEwOThxes+zPBgcVRV2WBIv
	 Sjm6HsHEZmjeFrKLjqVaNqs2emahYWU/MHD6+ZTZZccGm3kQLYLrYHW5yuUBoD4ljg
	 4M+I8ACzgh/4Q==
Received: from archlinux.localdomain ([88.146.244.229])
	by smtpd-relay-ccf8b45b7-pj4jn (szn-email-smtpd/2.0.77) with ESMTPA
	id 157504a2-064c-4d27-b512-d97e57a98bb3;
	Thu, 16 Jul 2026 19:03:10 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vo.kratky@seznam.cz
Subject: [PATCH v2] iio: resolver: ad2s1200: use dev_err_probe()
Date: Thu, 16 Jul 2026 19:03:06 +0200
Message-ID: <20260716170306.166804-1-vo.kratky@seznam.cz>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use dev_err_probe() instead of dev_err() to simplify the error path
and cleanly handle deferred probing.

Signed-off-by: Vojtěch Krátký <vo.kratky@seznam.cz>
---
Changes in v2:
  - Removed curly brackets
  - aligned the error message with the parenthesis

 drivers/iio/resolver/ad2s1200.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
index 55bcbbd4021a..2390822f8546 100644
--- a/drivers/iio/resolver/ad2s1200.c
+++ b/drivers/iio/resolver/ad2s1200.c
@@ -143,18 +143,14 @@ static int ad2s1200_probe(struct spi_device *spi)
 	st->sdev = spi;
 
 	st->sample = devm_gpiod_get(&spi->dev, "adi,sample", GPIOD_OUT_LOW);
-	if (IS_ERR(st->sample)) {
-		dev_err(&spi->dev, "Failed to claim SAMPLE gpio: err=%ld\n",
-			PTR_ERR(st->sample));
-		return PTR_ERR(st->sample);
-	}
+	if (IS_ERR(st->sample))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->sample),
+				     "Failed to claim SAMPLE gpio\n");
 
 	st->rdvel = devm_gpiod_get(&spi->dev, "adi,rdvel", GPIOD_OUT_LOW);
-	if (IS_ERR(st->rdvel)) {
-		dev_err(&spi->dev, "Failed to claim RDVEL gpio: err=%ld\n",
-			PTR_ERR(st->rdvel));
-		return PTR_ERR(st->rdvel);
-	}
+	if (IS_ERR(st->rdvel))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->rdvel),
+				     "Failed to claim RDVEL gpio\n");
 
 	indio_dev->info = &ad2s1200_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.55.0

