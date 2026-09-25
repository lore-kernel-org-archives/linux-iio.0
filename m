Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258483B19AA;
	Fri, 25 Sep 2026 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342295; cv=none; b=ptEBQC0fVwu6oPiuGD6e9AE5o+zgHmU34UIQ3/9IqwKI1cJW/+JxlOTpt6gUvD3jpUGIXQl1i5s7rngmK7dgg0kIh6CQjHHUvBQORQ7aV8NZonXNgDHBwHAER0fQU7lhdIhk2RPNhwBE4YEvDiiMQO7SNRGrqxfwtY5BF92xOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342295; c=relaxed/simple;
	bh=D6im4coNoyTgbaG0CmdRB0XtJTIKC81vi1+3JyoMwxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWzIy6aX8oeg3bL+aFgGEzaif4T8gZJY/TWowTr+H3R4g9SPQhBa/z/hjBGj9gfXEK0Lb8/HwMGseqfHYqh48DBr9gB/JjdhvP/K2VtDQw3/TSPELAhD1XCFVqIBTtdWrBxyEFPJbmY31Vl9dIFmPGxQa2+A5Dm0xWgiGcbloEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UHVu2CWx; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UHVu2CWx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=b1
	KixFmdQhPDKLFdtrCAMUdsyle7ELFK80DK6HEp8Gk=; b=UHVu2CWxS/Y8fPnezn
	eLkr+9DEzhlOf2QEcRiCt50Yx+XG0v8sRhcWcgYXIoHNN32nmDOObtneBeISSB0v
	cJ6t9G3mJFDHFpxv+hvif0g2copk5YsQWqoOrZHSwHRDs+wlq5FMih7eYzCxNvWR
	Z6HEnpVFib9pRLnPenheY+QV0=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3fy9zdLZq8jiZBA--.52716S7;
	Fri, 25 Sep 2026 21:17:46 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 5/7] iio: imu: adis16400: validate SPI match data
Date: Fri, 25 Sep 2026 21:17:34 +0800
Message-Id: <20260925131738.2200612-6-yaojiale02@163.com>
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
X-CM-TRANSID:PCgvCgC3fy9zdLZq8jiZBA--.52716S7
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWDGFykuF1UGw15ZFy8Grg_yoWkJrg_Zw
	1kZrn7XFnrZ3W2kr10qwn3Zry5KrWUKrnYvwsYyFyS9ry3Z3WxAF1vyrWDGwsrurWSyr1k
	WFyUKr40vws3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiwID5UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhuDvWq2dHsNmgAA3v

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL,
but adis16400_probe() immediately dereferences the result.

Validate the match data before it is used.

Fixes: 2ef920e0e5c0 ("iio: imu: adis16400: Use separate structures rather than an array for chip info")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/imu/adis16400.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 4842346f9f0c..28ad2d62d984 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -1150,6 +1150,9 @@ static int adis16400_probe(struct spi_device *spi)
 
 	/* setup the industrialio driver allocated elements */
 	st->variant = spi_get_device_match_data(spi);
+	if (!st->variant)
+		return -ENODATA;
+
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->channels = st->variant->channels;
 	indio_dev->num_channels = st->variant->num_channels;
-- 
2.34.1

