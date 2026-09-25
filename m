Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1E3CC9F6;
	Fri, 25 Sep 2026 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342297; cv=none; b=bIQMXcNjBwotJO800IUux7DwHdCJiuvmmNeaBTcC5RBgwXVrMxYaixP8WGyzBC331GxZSEPtRoNYcrgQxUVGmKpZCdPF9qP4WLg3wEzElwq0LmtPuZ04/kqrK6WZ/LFqilrZmipD0pO0F8Cy3w9BRe8ci1++1QQQs7yblGQyEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342297; c=relaxed/simple;
	bh=gb6i8FzjevRIjvzpN9E3g5hh/QcDTZNQ4RlXQyLVGKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ys0aBw4PS8GX6GKuwKs2vpUJUOOcan7Wpzi+2G2/nlUY+DTpm8ZdlH2Fir5PXk6qEUjm3RckrqFOp/GFU3d1j4Jv5eO06SVvQweboGyHQ2PV26U+oc+iJTqnbGukeBKASvSW/ss1sHyV0dL9r5oYJL+My8i5SIIZbhN0qK72zJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kOGnFiRT; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kOGnFiRT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Rp
	PMYKB8KsAlddsQUtxh3FJtCq1RUYTUiISqyX70d88=; b=kOGnFiRTQTH71YotDI
	+OMmLvmXHI/a7sjPLD5FlGapj9YfmMdq+7kWPvvcuDO5SZXPbBb8yPV/ZMVTbGHQ
	jT3oPa1uU59Wo/4Je/ug7Kur2mRzyzma1sAtHhmFlPXnrOOkT3Fb6PMGw9fjnSb+
	Y8oN7UCvP0dIs559ahMyW5JaM=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3fy9zdLZq8jiZBA--.52716S3;
	Fri, 25 Sep 2026 21:17:42 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>,
	Rodrigo Alencar <rodrigo.alencar@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 1/7] iio: amplifiers: ad8366: reject devices without match data
Date: Fri, 25 Sep 2026 21:17:30 +0800
Message-Id: <20260925131738.2200612-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925131738.2200612-1-yaojiale02@163.com>
References: <20260925131738.2200612-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgC3fy9zdLZq8jiZBA--.52716S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWDGFykuF1UGw15GFW5GFg_yoWDArc_Cw
	n7Za4xXwn7Ars5KF12yr1SvrZ5KryxtrZYyr4vvayFgry7Xr1rXFn8Zr47Ar47uFyxJFn8
	WF1jgr4rAw13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZ5rctUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BaCvGq2dHaDAwAA3G

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL,
but ad8366_probe() later dereferences the result while setting up the
IIO device.

Reject devices without match data before using the chip information.

Fixes: d5e02d0d00b9 ("iio: amplifiers: ad8366: add device tree support")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/amplifiers/ad8366.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index e12f8604f59f..9adff120de1a 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -326,6 +326,8 @@ static int ad8366_probe(struct spi_device *spi)
 
 	st->spi = spi;
 	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODATA;
 
 	enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
 	if (IS_ERR(enable_gpio))
-- 
2.34.1

