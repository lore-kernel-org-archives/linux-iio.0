Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA8266B46
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673205; cv=none; b=hSMvbJHtbwY06f7xOBdbM1JxnP0N6PTumx8Zs+DeZGMF02gWJBBpsoxsXn/eoJJHk55St7AC94T8bvgrHf88xLZR1vVzMVl/n/QtdXeohXcYWeC2iARHBeHP/HWXw1FCPzLjnQ9mGKS4yp5A+Bw4O/LRRCBSD7biCYo+ls0uZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673205; c=relaxed/simple;
	bh=7C8/5+5gnNT6M2AlhPrzghavej9n+bAnqS/RcFC9G6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FIER84oNWCyDK8QUk+oIXyGSTEPiPEdqxyUV4x7WUO0glMEYgbv17qz2gDBKVbAftGKqlALIRPM3CzVhCaILI3hh37KJu0lfNP8paCdmNwxDQnoGyGdIsCL4a1yzh6vOyqdFMq7cIXUeVq8hVVLnyTPmb8FuI5jlt969gy8kXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QaObegVd; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QaObegVd"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e61d8d9a21so668396a34.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 18:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779673203; x=1780278003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lh3E+qhv3/kQfv40DBxNDJmOjlWOJTi5Ytzn7Ux4m5k=;
        b=QaObegVdZoY1IbQZ7JU5csJwd6ul72Zwo4CcHNukSyaidPrT4PjOF6vzTP58McZ9Vq
         U2gLCrOTQ4T29mfwuYHGd48FAV6MN0DyQMpEuUG/714oaIu7aGn948tyVoqaErpfT7p5
         wWxw4/HFvbquH+AS4Qj+lu2BoTG0q7IMAfiExnwKpF4MMCRwQ//XySaxfV0QDq/IaaGq
         VNipx9qBTAcsmNcUaGQJfMYhCk8ZVPUUql+9ZVcqUYP880ewCyPLqhe0qJUJypMxCCmJ
         3vYSRGaHQD5k2tCgV/25OtYoqgBGwTTIsLsKmCzuT33QcpVUHifWxO3dxTYFY+8JuNsr
         FiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673203; x=1780278003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lh3E+qhv3/kQfv40DBxNDJmOjlWOJTi5Ytzn7Ux4m5k=;
        b=m3RYuBjBEJnk2G9CZOR2eAH/EFhPVlZGAkhiZO4f470geofw5kU4258IuvAvjBYuA+
         HE3dsvGzYrVsL9AjPFqXQd+m/Cs0tMe2ciSYs7ISSh6OSF2lHO6bwjTvVvG3VR5iAfKw
         gIVacpcg6Pgd3Qnueyp7WLl8PALJMlrQxp3Iei3J2M9jleioe2nbCb2007jxlXtHj44T
         gBM10WfIKSl55bTwRhoNj6cg25lR1uU+Drzz0d5Fi9VHWltOdLP+0izVtVAL17gra8eL
         vS7bpe+QNISgtKdMte5wiMDBSOrL+JbqD7Hv218as7yC7XKaB1k5uIq6GsArpIL0rlnW
         Capw==
X-Gm-Message-State: AOJu0YwwCeFA5gzqEKmfFNvtf48tsAFQ+/OQb1tOVOAdCP42W7ctBsL3
	nneeiWurbGBG6Yu/Vn/5ph5kZjOZeornz38zRUc3mlZhZ3xGireSTbzd7rdP4tkkC2A=
X-Gm-Gg: Acq92OEtjychjgmaLNXAiBGA84j3ysn+1uEnzUCz934aRXA9LKUDbwlxtM1BTMlI4eK
	F1iWre05cfP1VqQke+bwTCH8zc8yR3qa+Gc33lBiHrIrBA+6Cj/TLNq/BhhfBWGjZ4nHjTYfcDq
	zsJpvHbR2Z5FoOoku+jeYlJzex07AsbHy/sUQRJ2mLI4OpQwXCYUseMi3KtXmrJIp/cAsv5OYSC
	Pg9k7S2YBMxz3OtNdXmdsz3v7fTse3CuSktwMZ5Wi4Js2QgqC4AXvXVwbjeMyOujplNl6ZAOJpr
	qbwNXb2guWdw10VPPp3fNQ6eBVJhzCjE0ccqJCVhKDMN0RNcmipdcLbvMh/c4RWDuoMtB2jTYnS
	o+YX3E8G4bknxaqyPMSkzI9S1NcCWFWxdrCSkc4u3NM0cGNEBpg6rgrtudRAtl0I0pCQxscI5B1
	nBYRU2qb8tJC8pqb4Z/RVcf1hV41bi
X-Received: by 2002:a05:6830:6b0d:b0:7d7:da05:f2d2 with SMTP id 46e09a7af769-7e5fee1654emr7987729a34.16.1779673202703;
        Sun, 24 May 2026 18:40:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:713b:3006:84c3:c1bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6060b2dffsm6250206a34.0.2026.05.24.18.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 18:40:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 24 May 2026 20:38:40 -0500
Subject: [PATCH v2 8/9] iio: light: cros_ec_light_prox: simplify timestamp
 channel definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-iio-timestamp-cleanup-v2-8-c37c9408b7f7@baylibre.com>
References: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
In-Reply-To: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
To: Jyoti Bhayana <jbhayana@google.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=7C8/5+5gnNT6M2AlhPrzghavej9n+bAnqS/RcFC9G6U=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqE6hSvUsVar0/xUDDV+QUJ/9QMjDeZul6qiVC8
 FnvZCNDU8CJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCahOoUgAKCRDCzCAB/wGP
 wGyxB/0Qj/N6aCMaKcrDRbJ5BmZ+vj037ba3Q6iW+PZkKjvGsd9n4PoFI7wD6diSeSxvG2GERAV
 0x7y5cPwTJeGgFrLU4Qo8z9NcqmY/opoPqkC68DGf1g4gTHMT2AFHuEgfGeY7XqOwhRn02ByyZ7
 +BgbYfMmx9PIrdrvLqgkhF11SndRrlvItLg165vQBWRtZa5DSb8jybr8+fyduA8COR7s0xmuXU5
 PQaOeq17CpIVkbeYd+2zJNY5zR//JrrRaAgbcQ1iXR86OAIlopDA2T+cAjRX1sezQfNGetxEBw8
 nhehymX7MVyKCKWxDzyMp+MovU+rt5IIKdRMjaV9OqcsI0Pj
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

Also drop obvious comment while we're at it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/light/cros_ec_light_prox.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 815806ceb5c8..d09dea9c0782 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -223,14 +223,8 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Timestamp */
 	channel++;
-	channel->type = IIO_TIMESTAMP;
-	channel->channel = -1;
-	channel->scan_index = 1;
-	channel->scan_type.sign = 's';
-	channel->scan_type.realbits = 64;
-	channel->scan_type.storagebits = 64;
+	*channel = IIO_CHAN_SOFT_TIMESTAMP(1);
 
 	indio_dev->channels = state->channels;
 

-- 
2.43.0

