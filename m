Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07753463B9B;
	Fri, 25 Sep 2026 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342298; cv=none; b=HS4/BfSSUpddHLVOnwI8s+IZEyeAUjgYtsFkC2tYeEXS3rejdw7EoS/6Xy3G4KNUerVdF9As151H3aYcWqjVrFImTDu4gJ5w0cJReVrZZyaI6X0BS5Yr0tegdxzFh2b4EGqA9Vo3Jg9IAErlS7Cf35r0D0LZ0UTU7QyklCK4ytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342298; c=relaxed/simple;
	bh=z9Cb/5ydDzGdUAp7ypD3C86bwHpVQBmVySNA/emUqAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ukRD5mq3fCEOYV1bjldRa4suHu9ovsZhhnjJhgDKn2zQn1dgWiLl86isihOsIUUz2BOFVRaGgT7k8z4dn06r3oSgRBN8WFoarsrXN5lflukLRZmgsWowbsgujUvgK8W0xZs3GsSwPVNd+6Rwn/8ij7TcWcMEOTgPC/bVhtBr2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XC0aV2Tm; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XC0aV2Tm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3n
	7WAeCATiudXDbcnRuB21xHyJpDcqkIgFrWc780mpI=; b=XC0aV2TmYrOUqjovFA
	ZiVI4NNLV9q6bm72IrCLoDwLgD7IsEktN0eoAX8JByj8AIXtJYog878smJkIqdkH
	3uXtfUfhFMh88zErVORkdqEO73DXnebVI8jpU+fCOZ4177ynlSDu4OvMzuj1A4n0
	tzBQNak9gKFwUUSD7sToT3UPc=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3fy9zdLZq8jiZBA--.52716S9;
	Fri, 25 Sep 2026 21:17:52 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 7/7] iio: pressure: bmp280: validate SPI match data
Date: Fri, 25 Sep 2026 21:17:36 +0800
Message-Id: <20260925131738.2200612-8-yaojiale02@163.com>
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
X-CM-TRANSID:PCgvCgC3fy9zdLZq8jiZBA--.52716S9
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWDGFykuF1UGw15GFyfJFb_yoWDXFb_CF
	1xZr4kXF4UCr1DKrW29w1UZryftrWqgr95WanaqrnavFW3Zr18AF1qvrWUW39ru348C3Wq
	g3WxGw18Aw1akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRirWrPUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8ACFv2q2dICDnwAA3+

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL,
but bmp280_spi_probe() immediately dereferences the result.

Validate the match data before selecting the regmap bus.

Fixes: faac4dda9a91 ("iio: pressure: bmp280: Use spi_get_device_match_data()")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/pressure/bmp280-spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index a02a621b8015..95d9635f4711 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -83,6 +83,8 @@ static int bmp280_spi_probe(struct spi_device *spi)
 	struct regmap *regmap;
 
 	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return -ENODATA;
 
 	if (chip_info->spi_read_extra_byte)
 		bmp_regmap_bus = &bmp380_regmap_bus;
-- 
2.34.1

