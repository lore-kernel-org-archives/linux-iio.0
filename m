Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A9234BA50;
	Fri, 25 Sep 2026 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342295; cv=none; b=Biett7x5Vq/OyezWfSdxz+zXkh1NpKxauj84KIaV7dMz599MbkGf8/kWSK7CPZrzNiuqX81b5gYYEi/Tf+YyH9YHlnr7WqPTpnODBjhUPzlOr7lkLR8Yr3R4wmcP9tbbCAOk/RafqwqhxI4zKuTOvp7xnPdIBz/dV/xNDqurERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342295; c=relaxed/simple;
	bh=zvVEAZ1mK8LVnL3Pl5rFmpVZh6eDsG9D6w9pqLBc0BA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AMzaIazFmMNj/eKfWJG++H1xB1v0/PjRArorbM3/E1m5vsIxqkvQ9qAA/GdNo6+3D7J+DVhqOWkVQeZhJH3MOFmfNR19Y31O+DAiE7iFQ24ffl3DJEybEu0fBLUnp3fdvegR7DDKZ1hVLblOwwa9Dk9t9DUQvwg0SWPtudLyMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UOzkQ/Vv; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UOzkQ/Vv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8c
	mUwvQh64b0oO5LPr23TWnUKs7VBrYkq2s36X1zBTw=; b=UOzkQ/Vvdk5MGM1p6i
	6KGVy0dcGGLL0tPIoTUvCX6QJexde6ApY8xQXK7nqVxX/O9upag1qL2D8iUeTus8
	Xc0Yq/tDDUFlbM2Q/1ETbB9ehQFF7qqXu5lCr6at9tetFxcwNuhuxJjISqdSzrz7
	+AECT4mxycj3AX2+0OW6mDMEQ=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3fy9zdLZq8jiZBA--.52716S4;
	Fri, 25 Sep 2026 21:17:43 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 2/7] iio: dac: ad5755: validate SPI match data
Date: Fri, 25 Sep 2026 21:17:31 +0800
Message-Id: <20260925131738.2200612-3-yaojiale02@163.com>
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
X-CM-TRANSID:PCgvCgC3fy9zdLZq8jiZBA--.52716S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWDGFykuF1UGw15WFW8tFb_yoWfWFg_C3
	Wfu397XryUC3WkKF40gwn8Zr9akrWjgrZ5ZwsYvF4fKrWxur1rXFn2krWUJr4kuFWxtF1D
	Wr1YqrZ5Z3ZxKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_zVbDUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xeCvGq2dHd6sAAA3T

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL,
but ad5755_probe() stores and later dereferences the result.

Validate the match data before it is used.

Fixes: 62d3fb9dcc09 ("iio: dac: ad5755: make use of of_device_id table")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/dac/ad5755.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 0828b9909099..730289dd8ef6 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -819,6 +819,9 @@ static int ad5755_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODATA;
+
 	st->spi = spi;
 	st->pwr_down = 0xf;
 
-- 
2.34.1

