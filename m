Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.78.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4EE3D6CB1;
	Thu,  4 Jun 2026 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572164; cv=none; b=PoQ9CXlg4jz4p2onFVBI2DegGi6bcSVcT+rhNSFab6hrQiYWVBRBvmSpWpbGgeVULkfykhaWhGdtwaG1b283HN52hOeMUyuNkJuUXZPgjfPAW2zmRJQhow2/7xwawIwT9e0gNLMp13mdrrxz6SQ7IqC9wSBz2YpKG6N3X9wMwbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572164; c=relaxed/simple;
	bh=zCMvDpEjWAfp5T0WEWc54awNJIng+ZP5pL4CMIrR7AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzDqxll1FDZ8h/LBDZRuMbutdhHPiTKTmzIsgrCO0UOosEJWoCldoo/nql4ndDdUL4GlQQvzYNKjQHqIZRs2yUDEShw8v6BbevEjGdN8pAqx/DO8OHQh7eVX7heH3vLYXucBvhgrBzkZ6qrTx9tY/PpUovcoY9T2tj4ydtU3S2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=tcxBCDxj; arc=none smtp.client-ip=77.75.78.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="tcxBCDxj"
Received: from email.seznam.cz
	by smtpc-mxd-5757bcb9c-s9zn4
	(smtpc-mxd-5757bcb9c-s9zn4 [2a02:598:128:8a00::1000:a07])
	id 704e2133c8210cbc72b0bbaf;
	Thu, 04 Jun 2026 13:22:26 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780572146; bh=uHgJxrTmqaRkf4GjBaCLQjGWxYYzSqZRoYsu4QpDm8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=tcxBCDxjZAZ7rzbnjrKsJYHu0Ixq1qto8gqylAHVtZGhuiwnHCDELPbIqQRE3+OZq
	 rysBrx6REzS4oFjyUIbLiRwXakdHWitKB6JJ0kDvFt1XtNcOzI8+BLk+/Fj834RWcu
	 tmsO1QqOyhxRMd/9Xau0iMYa9/vsf70ThvSBpuCk2L2dDyfbdCbJ0ZOCJqNMfdLN1R
	 dISPSf3jyNK9SN8tuXFlUCahEx6PgzgL8+6ZeBT1is0LqLDhsX+c+NKFff/fx31DhA
	 G9qCrW9t/ZW/IDEuT2C6PHJA564lgQGzwW5VZda/4RIxkir9Nk68COMXnRVLLzy+sK
	 jSflv3B4IIIzA==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-d5tsb (szn-email-smtpd/2.0.73) with ESMTPA
	id 445ac5c7-22f1-4c8c-aa3c-87ec0c142b4c;
	Thu, 04 Jun 2026 13:22:00 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] iio: proximity: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:19:08 +0200
Message-ID: <20260604111921.106936-10-vo.kratky@seznam.cz>
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
 drivers/iio/proximity/ping.c  |  4 ++--
 drivers/iio/proximity/srf04.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
index e3487094d7be..c54978c1a888 100644
--- a/drivers/iio/proximity/ping.c
+++ b/drivers/iio/proximity/ping.c
@@ -293,8 +293,8 @@ static int ping_probe(struct platform_device *pdev)
 
 	data->gpiod_ping = devm_gpiod_get(dev, "ping", GPIOD_OUT_LOW);
 	if (IS_ERR(data->gpiod_ping)) {
-		dev_err(dev, "failed to get ping-gpios: err=%ld\n",
-						PTR_ERR(data->gpiod_ping));
+		dev_err(dev, "failed to get ping-gpios: err=%pe\n",
+			data->gpiod_ping);
 		return PTR_ERR(data->gpiod_ping);
 	}
 
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index e97f9a20ac7a..06700a4cf275 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -264,23 +264,23 @@ static int srf04_probe(struct platform_device *pdev)
 
 	data->gpiod_trig = devm_gpiod_get(dev, "trig", GPIOD_OUT_LOW);
 	if (IS_ERR(data->gpiod_trig)) {
-		dev_err(dev, "failed to get trig-gpios: err=%ld\n",
-					PTR_ERR(data->gpiod_trig));
+		dev_err(dev, "failed to get trig-gpios: err=%pe\n",
+					data->gpiod_trig);
 		return PTR_ERR(data->gpiod_trig);
 	}
 
 	data->gpiod_echo = devm_gpiod_get(dev, "echo", GPIOD_IN);
 	if (IS_ERR(data->gpiod_echo)) {
-		dev_err(dev, "failed to get echo-gpios: err=%ld\n",
-					PTR_ERR(data->gpiod_echo));
+		dev_err(dev, "failed to get echo-gpios: err=%pe\n",
+					data->gpiod_echo);
 		return PTR_ERR(data->gpiod_echo);
 	}
 
 	data->gpiod_power = devm_gpiod_get_optional(dev, "power",
 								GPIOD_OUT_LOW);
 	if (IS_ERR(data->gpiod_power)) {
-		dev_err(dev, "failed to get power-gpios: err=%ld\n",
-						PTR_ERR(data->gpiod_power));
+		dev_err(dev, "failed to get power-gpios: err=%pe\n",
+						data->gpiod_power);
 		return PTR_ERR(data->gpiod_power);
 	}
 	if (data->gpiod_power) {
-- 
2.54.0

