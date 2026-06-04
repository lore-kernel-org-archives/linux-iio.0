Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90C421896;
	Thu,  4 Jun 2026 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572144; cv=none; b=R+2a9xyAZgM0Rn4V8LjWVuUPxjlLgA3IYsW/g4PWhDHPZoYEPnKS3cIM9d/G0w0Xi3ak8hoMN/g+bMFbsrL0ft1OOgrSY1nmYM0LAoSwqk9dHCNIX9+pgYDTDqfEEUQL6rgNinpGmRztWsLVJYxSlp/em0VcR6YzchF535Mifcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572144; c=relaxed/simple;
	bh=LviN0js/J51mc7vVJzM8c3WStlg7Na17Ml/rtnjfsQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9JAFcveoTApttQhLZIkfrqaZ0ir6qyMsvVk2/ldFvELmrl9b7VZ8GRlCvVDZ63v2+aRP63nnnB5Os5SlFXRLM+47YCWLAgjVEeL3OWr4YnQGqteO1/pImbBDVizaVu+tQGq8TIRnkqrjfzbpJMr+H1gDLszsu9JneW8ssE/KBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=aqocD0cj; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="aqocD0cj"
Received: from email.seznam.cz
	by smtpc-mxd-85fb448c55-l247v
	(smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
	id 3fe538e3878a156c3d1ba27f;
	Thu, 04 Jun 2026 13:22:06 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780572126; bh=Xl3MBF/0pLxwVsNer3XqT5Kk9Su+hAVTcWUYEOzpWxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=aqocD0cj+HwOpRmgP7fKUbTeP+pxbLUH4PLY0t5wzNG/rCq7BwWXfdNWBGEAoMRjo
	 R0sjeYqqEu1sgFBijYyaBNGtFLLxNB17/EHJtEgZn/gG0x3EtCl4jwy2olBRSgJjZW
	 R9mOkvfO1vv1inRo9M9fLGxwixgOF/Hn00lOfKNRlls7e3GDohlOqzBSKjbq+5iX/T
	 fPDhzwMLXB0RFTrWjlY0WEdnsEt0wvcuhuiFhEN9hxlZbgw3q08QR2R72v2oSNlACC
	 c4OuZaZJo9Oh8Rl89dZIZdE2+8G3ckmr1C/1tF6QiNEgV/Wl50aLrkKI0uL9nFcG+e
	 HKTlRWhcta86g==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-d5tsb (szn-email-smtpd/2.0.73) with ESMTPA
	id 240cf239-a2a0-4e1b-966a-3763235ca034;
	Thu, 04 Jun 2026 13:22:01 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] iio: resolver: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:19:09 +0200
Message-ID: <20260604111921.106936-11-vo.kratky@seznam.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604111921.106936-1-vo.kratky@seznam.cz>
References: <20260604111921.106936-1-vo.kratky@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Found by Coccinelle.

No functional change intended.

Signed-off-by: Vojtěch Krátký <vo.kratky@seznam.cz>
---
 drivers/iio/resolver/ad2s1200.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
index c00a60cb31a5..3a6a66553839 100644
--- a/drivers/iio/resolver/ad2s1200.c
+++ b/drivers/iio/resolver/ad2s1200.c
@@ -145,15 +145,15 @@ static int ad2s1200_probe(struct spi_device *spi)
 
 	st->sample = devm_gpiod_get(&spi->dev, "adi,sample", GPIOD_OUT_LOW);
 	if (IS_ERR(st->sample)) {
-		dev_err(&spi->dev, "Failed to claim SAMPLE gpio: err=%ld\n",
-			PTR_ERR(st->sample));
+		dev_err(&spi->dev, "Failed to claim SAMPLE gpio: err=%pe\n",
+			st->sample);
 		return PTR_ERR(st->sample);
 	}
 
 	st->rdvel = devm_gpiod_get(&spi->dev, "adi,rdvel", GPIOD_OUT_LOW);
 	if (IS_ERR(st->rdvel)) {
-		dev_err(&spi->dev, "Failed to claim RDVEL gpio: err=%ld\n",
-			PTR_ERR(st->rdvel));
+		dev_err(&spi->dev, "Failed to claim RDVEL gpio: err=%pe\n",
+			st->rdvel);
 		return PTR_ERR(st->rdvel);
 	}
 
-- 
2.54.0

