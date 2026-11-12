Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467895;
	b=BBcrluQ+HfzxEX4IWTfIf/NLzAy0MuBma9W6NxJXk29SCOiHqPhd8diwl0WQ8gV4knmm
	 TygUcnhz4jKsyV0FUzvZFhZVrxuH8AtJlyTcpAyJsZCkn1hRbikGsTC1PxvyP4/DwzM3z
	 ViHfbKnwCF8Dgg2vVCnv8NdfnG2imqFPmy7xSPz8HWtqf0RQTbJ/o6uHsvYaUNfkWzkx5
	 VHFrZgpzSTP3mG5al8Rng84vqDzZoHjuz6vUns2ZB3LAUnsIcuKtdCUUryMizd16kU2RD
	 LgargivcfsQpgYD40zH6WAQ4WPh4SAbsLDD9ymbCWiEikipaxa3rQqGOA0tEOGcMduA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467895;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VjD058FD9k7K6HtyZz2gobIdYAZt+7URCOmcP0bRQ00=;
	b=Xj2TOG5C3vKdTJfCIvXbQWFK5e5x+PdNeuY82IwP0g1gbBpiKEIkSjPZxfZ9fIFeqVeX
	 iHLENwv79WL9PCb2Z4UHTKXKkREUY09rhIKt9NZcjHxbNOYLtvTeVv5ZyZVH2jUp/gD73
	 HkMtwUpN6E3cQ3NSIP8dNoBe/rs0ndBadsG9VU3/DITtW+MUlgErwWImtesnaIaLJidaW
	 TfYaxm493UG8VoXd5TA5OzZE5mDcj3oZXPyb58BryZdP5sCR7STv6spWWA3B2c5NIQu9x
	 ZpfCZoOgxVj9435RE/rKVOv6qmfmiSASQyJSNd7kIwgOBBNHmAWVfSysdFnoJAz4F8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=l8peHf3J;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352E6606A338;
	Thu, 12 Nov 2026 07:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 352E6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=l8peHf3J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=l8peHf3JfQp7Ay2dHpm9k7bBGe9BMpyPuTP9uKEKIrkQ68bCeHSkd4t18uTzGKEPWpU8cK+RoYf9d
	 orVLcashcc88x0FIYZc76rcjcKnx3Q83bxMWrGcult4h7RZQ+wtZJBkvg5l8CceIi9vtaOETVtj86Z
	 25eEnjz5Cn6vPpcU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af5681aaaf-ab452;
	Thu, 12 Nov 2026 15:17:48 +0800 (CST)
X-RM-TRANSID:2ee36af5681aaaf-ab452
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af5681b328-f688b;
	Thu, 12 Nov 2026 15:17:48 +0800 (CST)
X-RM-TRANSID:2eea6af5681b328-f688b
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] iio: potentiostat: lmp91000: Handle configuration write errors
Date: Thu, 12 Nov 2026 15:17:47 +0800
Message-ID: <20261112071747.154626-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lmp91000_read_config() ignores errors when unlocking and programming
the TIA and reference registers. Probe can then succeed even though
the hardware configuration does not match the parameters used to
interpret measurements.

Check the configuration writes and return the first error. After a
successful unlock, attempt to restore write protection even if a
configuration write fails, and report a relock failure as well.

Fixes: 67e17300dc1d ("iio: potentiostat: add LMP91000 support")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/iio/potentiostat/lmp91000.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 00cb3fea97ca..4a29fe627af7 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -205,7 +205,7 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 {
 	struct device *dev = data->dev;
 	unsigned int reg, val;
-	int i, ret;
+	int i, ret, lock_ret;
 
 	ret = device_property_read_u32(dev, "ti,tia-gain-ohm", &val);
 	if (ret) {
@@ -250,13 +250,19 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 		return ret;
 	}
 
-	regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
-	regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
-	regmap_write(data->regmap, LMP91000_REG_REFCN,
-		     LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_ZERO);
-	regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
+	ret = regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
+	if (ret)
+		return ret;
 
-	return 0;
+	ret = regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
+	if (!ret)
+		ret = regmap_write(data->regmap, LMP91000_REG_REFCN,
+				   LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_ZERO);
+
+	/* Restore write protection even if programming the registers failed. */
+	lock_ret = regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
+
+	return ret ? ret : lock_ret;
 }
 
 static int lmp91000_buffer_cb(const void *val, void *private)
-- 
2.51.0



