Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21637E317
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915081; cv=none; b=ls1261gptK6iZ69TYjd1L1ZM+N829WTPQQdpOS7WluhkOpzOdruaXddJeBgAKm2gx7zZ5zpoBlACJDmPyYavovRpYfI5XXbaSo/Bbowonk6X2JGDsZLaQbpQzB50ByRdgxMrVhv4aAVdztrU+UQGekATjRDVXehR2vi/ceL1f4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915081; c=relaxed/simple;
	bh=3AV+ps6EwvWuPnkmEuMQHEqXd01rXxUa8mWVFvh7hyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/d9Uc5gJlIYWHOKvbLEVX5Ms3C0Mbpmjsz9x5U1Nbv2YSZ0yqTA5q/6hFlrZXtyjINh2TZfwde6O6aF1giQEB3Lo/9dA+aU3PqWyZ821QosrGZAu1BX+IbjmGK7dmgeKsucjJom8IsemWiJ/lEZLB23mQ9Np/8agdDLc4aJNAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeQSIt8L; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeQSIt8L"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2467287a91.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 20:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783915079; x=1784519879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEhF1/knVdM88rzwDUG3Vwh5GZfToHHXGSRevQ99B4E=;
        b=AeQSIt8LNm54Loac9AiIWOgDjKnYzud/QK62CiXRhDDGjEKbNK0FqMO3iX1v49738Z
         X/a8d11+7HCERHRxgUI7EL+aMpeTORPPCMYKYjWZjhwLGfkmRXstGaCn+1JbvFjIWqGC
         IZBy43x/05odic4Rf4s4fVo1msrhKEKpKnqW0XWzPA8drxB9f5ZboBLmqPW6qjSl4SII
         r4Y8t+ZZEReMTAsxfrJo6J2bwt+XCbsUvKBwTXTHBKRS1380iOx7M4Po7izhLBwOs6Ua
         JRL7pLvKTr5IagWzkbqW0nT3clojS++pJTSOBDVWnGxzJwK2IEfJC0sLbkBZ/taX1fgc
         u6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783915079; x=1784519879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CEhF1/knVdM88rzwDUG3Vwh5GZfToHHXGSRevQ99B4E=;
        b=MA4h5i3ws1wc2/NIhoKBfeLbmR4Bwk8k9VlGqwgvT0cc91Pxv0TYgrszLI5AFTSg0z
         9vcDb27oX6v04dn/xPK077AcOHgAa7d0+IH+iRH2DXaTzkVOPnQhAkNCPgXGS6zYB6GE
         +9Opo//ExrRrCWC93GCfwsZxNddg5AWWK95w9NISpGuMIlvfw9cAJwsnQmjFagUOfX4j
         ABHIqDzIRtpQ+vkUXnB47UnrnVYa/7HfUxONoxewSBDphlwaQUncVwRbMpWK4a7jR7yr
         GM6n1k7nClYJ2z9LR49KqNDfNIHqewXxMmADmptOG551Y94cpOQ9Bqk/IR5dcZdaRs7Z
         NocQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro2OsG5q1zWzEeKbIuCuPToZhPQeTGD+BUWbbq17jApYsXdRGnkLX4SBlFV+/VsBw469RcwmyiGOBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKieGOc9jJFeULKsRkLNQWJV4OfokQQdS20dpR0eqCxfFpwhY
	QsiIldWPfB+tDsB4lF2ZFaYdaqYvObvOgASZ7kmjfJ7ox41VFZlqCPU=
X-Gm-Gg: AfdE7cn2VReh71/LnJCmnKe9KMJH0UFs96m/rmvPoIUyoJXPnvBBHuWNh9SuVuo3kET
	xVkiq3EFzcWjvK3vHqH7zNeIKTzwVKb/sOwM9lzcvG89bBuH2wvaX0At7X5w2LtBE3BMKaJNbkC
	nshdn3Bj2MZC0927o3giIfAKZd4UG+3e79D1E8eNSN7UAvWVcTfkkjU6Tgpy+HXrpXvL0GJqEUq
	mgMqkzfggBdRZPv9KGeGlSozs9oG0YElZDfT/vLgOj3vXoPnLvJgpFtWhLH83dSwQIUEPj1R29h
	izvYJ8/vU5ro2raxfUJiaz7QEVEo0smWPvWOEKKVJZLkyPLJiIh7UfGGnDTuIZedNI6jdCsGesj
	IVvNd7bZybFC8ETfPpyHQg1cOaAwo9LI8eymjLFfYZTayLg+w6lxhzCHzs3uPD5DvdpJo5d+j9D
	jL/nCxAUjR62dExcNmg8SC7JVei8ePhCaGAJqk0JBBg7n+HqUhmD/dWFseLtMua2s=
X-Received: by 2002:a17:90b:3bd0:b0:37f:9cdf:f0ac with SMTP id 98e67ed59e1d1-38dc77f1987mr7274394a91.27.1783915079198;
        Sun, 12 Jul 2026 20:57:59 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm60862704eec.4.2026.07.12.20.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 20:57:58 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2 4/4] iio: light: opt4001: Fix power down clearing bits of the wrong register
Date: Mon, 13 Jul 2026 09:27:36 +0530
Message-Id: <20260713035736.11346-5-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260713035736.11346-1-nikhilgtr@gmail.com>
References: <20260713035736.11346-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

opt4001_power_down() intends to clear the operating mode bits in the
CTRL register but reads OPT4001_DEVICE_ID instead of OPT4001_CTRL, so
the value written back to CTRL contains device ID bits rather than the
current configuration.

Fix and simplify this by using regmap_clear_bits() on the CTRL register
directly in the devm action, and drop opt4001_power_down() which has no
other users.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Fixes: 9a9608418292 ("iio: light: Add support for TI OPT4001 light sensor")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/opt4001.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index 9f877c5798b9..b7e9d361c2e3 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -223,33 +223,14 @@ static int opt4001_set_conf(struct opt4001_chip *chip)
 	return ret;
 }
 
-static int opt4001_power_down(struct opt4001_chip *chip)
-{
-	struct device *dev = &chip->client->dev;
-	int ret;
-	unsigned int reg;
-
-	ret = regmap_read(chip->regmap, OPT4001_DEVICE_ID, &reg);
-	if (ret) {
-		dev_err(dev, "Failed to read configuration\n");
-		return ret;
-	}
-
-	/* MODE_OFF is 0x0 so just set bits to 0 */
-	reg &= ~OPT4001_CTRL_OPER_MODE_MASK;
-
-	ret = regmap_write(chip->regmap, OPT4001_CTRL, reg);
-	if (ret)
-		dev_err(dev, "Failed to set configuration to power down\n");
-
-	return ret;
-}
-
 static void opt4001_chip_off_action(void *data)
 {
 	struct opt4001_chip *chip = data;
+	int ret;
 
-	opt4001_power_down(chip);
+	ret = regmap_clear_bits(chip->regmap, OPT4001_CTRL, OPT4001_CTRL_OPER_MODE_MASK);
+	if (ret)
+		dev_err(&chip->client->dev, "Failed to power down\n");
 }
 
 static const struct iio_chan_spec opt4001_channels[] = {
-- 
2.39.5

