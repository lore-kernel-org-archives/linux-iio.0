Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED7E3F54D1;
	Wed, 20 May 2026 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.223.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299887; cv=none; b=PNaTWcM9dzg40LDq9WE0MwBxNfurpvPh3S1NN3r7rSyykO1VvEzo7+DplJNb6zn66KWkfdpbfVHC3UwGpaqcUnOEDGAw3HWf7RJfMXy+CGxV41yp9aSIOjGIzG43AVh3A9s3rbiID5wtyY87pibLZhlqAu0zNPnWM0QLFs3HPy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299887; c=relaxed/simple;
	bh=8IA5du+CVOZjBx6w0G9IVBLoaYK2RtHfeLjX75Ox2t0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xdf7xrTYyGbEiwvDQSGipcYK9ECEqmCY4r3izYccy//LvB3AvfFRd8PmA/2MkYCHVtDLdVHXlpmxXf2qgL+XypC9hrrwQr/wf4ugXgtxeH/MKuzBXeQa/+pSxUiFSpVx22OIx5VBFeK6H3Xs+03hlQs4YRfkLtfKRqyUggBzFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; spf=pass smtp.mailfrom=al2klimov.de; dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b=r03WCYfi; arc=none smtp.client-ip=162.55.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b="r03WCYfi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=8IA5du+CVOZj
	Bx6w0G9IVBLoaYK2RtHfeLjX75Ox2t0=; h=date:subject:cc:to:from;
	d=al2klimov.de; b=r03WCYfimaaXclkYe4qOiwl9cRY0470HjBR+DnWzrKoDzWvTY5Dg
	WlOcLvVNPwL2+htU/jkkSyDup82SvrTTXeSME4zco5VI8BQ88TSSSBEQVFmdF08m1qiwdB
	OJLagYNTvNM72eWzNypCzDSD9jayuArQA05XMnYVvZcipFCtHKHn25pKg5K5UcAd0EtAD8
	X8JLiT4xrcbvTcOoCaLOmdqZ9f2//hRgBHkeR6OFSTDM2wHU79zTW/NkRSlDxxVJrja1Nn
	RToGLJo400/YubKihapO9V2lKc1BeXNiDDPmGRd5Jm5rLjxIui7G2JUgTKEj6JhAwSmEvT
	W553a/IRag==
Received: from cachy-ak (2a02-2455-18e9-e011-4d8a-aad2-c25c-50e5.dyn6.pyur.net [2a02:2455:18e9:e011:4d8a:aad2:c25c:50e5])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id f09d66c9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 20 May 2026 17:58:02 +0000 (UTC)
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Mircea Caprioru <mircea.caprioru@analog.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] iio: dac: ad5686: update of_match_table
Date: Wed, 20 May 2026 19:57:47 +0200
Message-ID: <20260520175748.537850-1-grandmaster@al2klimov.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When AD5673R/AD5677R support was added, of_match_table wasn't updated,
so these two devices couldn't be probed based on device tree contents
until now. I fixed this.

Fixes: 477bd010c20e ("iio: dac: ad5686: Add support for AD5673R/AD5677R")
Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 drivers/iio/dac/ad5696-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index d3327bca0e07..fb118a02f76e 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -91,7 +91,9 @@ static const struct of_device_id ad5686_of_match[] = {
 	{ .compatible = "adi,ad5337r" },
 	{ .compatible = "adi,ad5338r" },
 	{ .compatible = "adi,ad5671r" },
+	{ .compatible = "adi,ad5673r" },
 	{ .compatible = "adi,ad5675r" },
+	{ .compatible = "adi,ad5677r" },
 	{ .compatible = "adi,ad5691r" },
 	{ .compatible = "adi,ad5692r" },
 	{ .compatible = "adi,ad5693" },
-- 
2.54.0

