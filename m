Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5243B349AF6
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833821; cv=none; b=ElAFX8+5E586pG9krl/iTEGSZbV+2UOZOdl5zuCnHVgtJlAilIzdHvAxEgLcQdxBiUSHq6BF0N4ChAffoLS1wx3WwkHe2Qg7tQsHv+7sF9komAMnbZVU7JiHUWC9HQzkGmmyJROu6lj8fZavaWUD9aAfqQ5OOL3nvKgwTuNR8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833821; c=relaxed/simple;
	bh=JQRBVo2ep5z8a2QhtECu2GO87aKrVztQ/+OOGVjVxIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E8rthYtayv8nR3y54b83+4FlzKza7b25ae5PkjkFodpiRpn/oB2V5akpf9m4G8mC9Dd4LJQGczswiU/taFOTPhzCYiCfymm515e1Uc/sYFAtz96dEz6KHyTi8zlg/wHWJ2B5tTqKgj3kDCtk6P4wvqIMMoXMksokyZhYVUB65aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyZuWyrZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyZuWyrZ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a7bced39cfso42564365ad.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 00:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771833820; x=1772438620; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=208yj0wO16cY+IBYbY4vtJGd8DAsVL59TpfoOHdonDQ=;
        b=UyZuWyrZQeqObJ7Q43hVNLG0LpDzTFAL3K3Bs4xmu8SjFH3FAHjfaHsugUikaInCTi
         gvZ3g0C8pkJ+BaFBXlVBPUrGR68EEJad0YgnP9Xeluw2+kyP3mIxc1LrOYTSFSxnUmHL
         deaqX0FNHej1QW6Lnlqp4IsHjE5FA4ysXDe657tQ5DsVFTWlGpnVoRhf3lseM6MOE5d9
         eC1RhJkmc2HLH2RWYFE78wyQbGjF1ot5W0BZhEzmSKJEQJOoyo/O4IBY3RAaSF92PTPJ
         6GL7sKXqUT/klMFzCg0ghX6SnbQaFKmXtW5FSz6Vi6eUu9Yxqck8o8aAht4STV1juq1n
         H0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771833820; x=1772438620;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=208yj0wO16cY+IBYbY4vtJGd8DAsVL59TpfoOHdonDQ=;
        b=AgrOzvb5Irbhd7dA994nNbQK9312MDlsI7f4LckZgnrCaaokZJgzMgtD1SRRVWyrNy
         5hXnPL+95UzxOz9UbDK9y6TwpdC3tsSfo5TwPahNnBISUL+6N1thQdvVl2Xryi4im8N1
         oVGm3ToJ4EpZZDO6Hbae44HKjnFManZqqqpwBq1YIiC2DisVNyp/b1FKs3B8+aWuI+7/
         YMqAzwLqIznSWRM9PLTFsHwIl7WR3OCbbENa8gPpSCM/iBpBYGZTcSvNCHmBKGDuXsq3
         WEHaezkhIC/1CuG6n51opYer4AVmPlwdydaMolWChLqD9lh38ExCrpqJ+WvKcNWTRg5I
         EbUw==
X-Forwarded-Encrypted: i=1; AJvYcCXNWkT/bUxmHDQ7cpL3M2exVknm/iYDEIA2Hrg4eEoxGmcdpEzqUsVufmQz7jjfgJ0dfXVZxLGHAtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+IoB0IXwuVaydFw6BFaqsI5swNZ0MxoUXY6de5wc0jcyPz+3
	gYXIkMa8cJj8/gCVLDnPxUYZ9FabfiYS54rH1ADGmiPAAO91RLJ4pY90vf0eWTks
X-Gm-Gg: ATEYQzyxH/OYVWnKAzgonkVrxuX/20K8hniYZ8SZJbPBl5W1nuHACsxnAuFiftOOMe3
	aUxyHV0Yaz6NaUSYtFUW05kXnX+vOrrlqbTrYR2TOOKqchIOxxMOzn3f2iQxBM0nOCjcpxGTB8k
	8mEba4z00ajaIEf6OLdjzTlWD5uirU3tRNDUeTHvnctW9hx1Zmpq3dM3fTJKdzWogNYmBRRWZrq
	QpycyxqHF7wbDjGp9BOiDJLCpDOjKSDVN+yxPf38kwpuuJ9JI+8UBTgjEy/yNtk78bL5lE0K3Ka
	hjG5PnhUy3OERq2IBrbKCXvVgWx8mnfdd31lXIJas+MFeg++xbI05ycwbWuUSnwZgd5eBkoakr5
	NRwVhhKKZkl4G0HJvOxZhdeCbwzptzdACJX33ydTp0CjVly/chdqcNPm0Dq/H0ClOz1366SMs+1
	b4urGk0IJLq/fnPlqrQBXsfM98JxkRq0IxIl5pwA==
X-Received: by 2002:a17:903:41cc:b0:2aa:dad4:d351 with SMTP id d9443c01a7336-2ad74562664mr78015875ad.53.1771833819671;
        Mon, 23 Feb 2026 00:03:39 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52:1cfe:ae34:fdd6:6b97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e189sm65710615ad.57.2026.02.23.00.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:03:39 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 23 Feb 2026 16:03:34 +0800
Subject: [PATCH] iio: dac: mcp47feb02: Fix mutex used before initialization
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-mcp47feb02-v1-1-41f80bdbbb45@gmail.com>
X-B4-Tracking: v=1; b=H4sIANUJnGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyNj3dzkAhPztNQkAyPdVIOk1BRD81RDS4skJaCGgqLUtMwKsGHRsbW
 1AKYHn69cAAAA
X-Change-ID: 20260223-mcp47feb02-e0bed17e198b
To: Ariana Lazar <ariana.lazar@microchip.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771833816; l=1334;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=JQRBVo2ep5z8a2QhtECu2GO87aKrVztQ/+OOGVjVxIU=;
 b=m5lrOfYwiYeYjvaMRjjK/ewwnurijle+QUAnsoVxXzRG+Z7jNd5GvEJWGRDYKgWtyuuO+PWYc
 L/L8EqIrcN2DyDL3rw4MSCyxifaBw3E6064i1/o1/DyPeU09BXugn17
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The mcp47feb02_parse_fw() function uses data->lock, but the mutex was
initialized after this function in probe path.

Fix this by moving devm_mutex_init() before mcp47feb02_parse_fw().

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/dac/mcp47feb02.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index b218f0c3a0bd..4ff5abcfecea 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -1131,14 +1131,14 @@ static int mcp47feb02_probe(struct i2c_client *client)
 
 	indio_dev->name = chip_features->name;
 
-	ret = mcp47feb02_parse_fw(indio_dev, chip_features);
-	if (ret)
-		return dev_err_probe(dev, ret, "Error parsing firmware data\n");
-
 	ret = devm_mutex_init(dev, &data->lock);
 	if (ret)
 		return ret;
 
+	ret = mcp47feb02_parse_fw(indio_dev, chip_features);
+	if (ret)
+		return dev_err_probe(dev, ret, "Error parsing firmware data\n");
+
 	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
 	if (ret < 0)
 		return ret;

---
base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
change-id: 20260223-mcp47feb02-e0bed17e198b

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

