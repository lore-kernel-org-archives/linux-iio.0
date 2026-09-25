Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28883C9ED0;
	Fri, 25 Sep 2026 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342293; cv=none; b=VgB/v1Rm2AX08XLXGORQRY7OnjhhwMXVmIAcpfXQgHr6OiWPKvU9sCm5/cmd7bGS0hCvva2l8DCccSROcc4xQRW//4e3Q/mWrAPRgUTuBX9esLXzgkDjhXvF5kyE6b8Pzp41BevAuwasxCfqzaF85p9WzYiS3XQ+eSmLSdEaJPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342293; c=relaxed/simple;
	bh=11A7xLBCs5rNEIv5AHJFPXFRptu17BOjRex/Ja6Qfv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QHqslUy3Wypqmf+aRluq6SGyLa/ia5vU9gafeUO0OrylIk4WKiCJItknOJMvFcXmO25nHtFvzEZvkYr5UwNoHxHtGq7cyw46XTfMVs/odZ8Gxl5WQmzxr/utwqZ8ozwpEs5N2uTqRm8vEqXKW3WvtkbNas2DmHCI830QRDTFacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=okZu40tr; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="okZu40tr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KV
	vTWvC2kkH0m00+G/2IkeekWvZNi6D2tfD5y+9wsOw=; b=okZu40trohZHTimwPX
	VEuMwj1tXtADXVIW3V8VLOE8tD6BaAnmAerIGBgDsFq5qn/lsbnPaYScSvfrzBwb
	uBD4iTnIVrfmUg9kZxMokBJph94TiNAKYRCM3BJ2xstyCskapoaft+g3wEeW1Vk5
	whrG1CpwS0vRNcsQuGdnPgPBQ=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3fy9zdLZq8jiZBA--.52716S6;
	Fri, 25 Sep 2026 21:17:45 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 4/7] iio: frequency: adf4377: reject devices without match data
Date: Fri, 25 Sep 2026 21:17:33 +0800
Message-Id: <20260925131738.2200612-5-yaojiale02@163.com>
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
X-CM-TRANSID:PCgvCgC3fy9zdLZq8jiZBA--.52716S6
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWDGFykuF1UGw15ur45Wrg_yoWDWFb_Cw
	18uryxWrn0v3WkKF1DKrn0vr93KF9YqFWF9rsayrWfW347uryfAFnY9FWxJwsrCFWIyFn8
	J3WkAF4F934fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZBMKDUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhmDvWq2dHkNfQAA3I

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL,
but the result is later dereferenced by the property parsing and
initialization paths.

Reject devices without match data before continuing probe.

Fixes: 6140a92cd086 ("iio: frequency: adf4377: add adf4378 support")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/frequency/adf4377.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 4dd19a9aa994..d1e5bb062474 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -1060,6 +1060,9 @@ static int adf4377_probe(struct spi_device *spi)
 	st->regmap = regmap;
 	st->spi = spi;
 	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODATA;
+
 	mutex_init(&st->lock);
 
 	ret = adf4377_properties_parse(st);
-- 
2.34.1

