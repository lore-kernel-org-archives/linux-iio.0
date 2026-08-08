Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA73B47C1
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179671; cv=none; b=N/IX7tump1iyNvET9lSkN+JSFEFEfnK/WJSMHF5ErVs/qwJosSaJCQBXAjDf/AwBJdIoI8K9H9S3AGzL5Vx0v/+iy/FfbLHBJFShDPFg8EmzwGWWo07lLKmjWw2pTlpzkSk/68u77MDZlMTuDsmnU7ThEx3Cx+RkqCPO3qm2/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179671; c=relaxed/simple;
	bh=EHfaoi/H5aVDlNxnEr2yGng8APrb8ROD3VYBvv0JVis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tth4y+Q9RT6wWmr653DfKl1ZRszTHzGdzMBiqVpHBXAi/yzYlkwsOEdSDyWwckGNnH0Gl0o3oEKDnYYbzn9qt8GpP3CpP+wbqVlZxJnWvjjBkFZq6K55P/MrAxo5DlVpUjPzW0UOXB9s9hJdzZo51PCq3uKSavDYDKdPnIPumpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POfxsR+o; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POfxsR+o"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-848743155bcso80240b3a.0
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 02:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786179668; x=1786784468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y0kd4BZdCcR2jnnA1HcZjBK3ddxINoAkrrsu0qcIwIE=;
        b=POfxsR+ocwgVUhaYW72DlLRGNjGsxhYuTbpfZ36s/t1LCGv5DY/cIkS+fiGipnvn38
         7xYG4ztHYi5/4K+cIVGpWOq7Hzqxxbqb+s8tINUhwK3cdBiM4FfhR9+0TNf2/BQ4sG/U
         xy/cwQqGzz+scH/RvTRNVxoJu06nCHB72e6DUXW1WwBTuNshUi4KxY1sgvfe2Rv9d5Te
         kycK3yNzYU5czCLY/brqkVEiSzC5okNatT4EzH8rTee+uHV0C7zxcmoDDJvgLcmeVjXp
         aOJdV+LcqivtfZ004TmZ/ENoEUldDoeuevck1ehW6hRA1xVVqOISAvIeC9CGFJXEjBjm
         pvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786179668; x=1786784468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y0kd4BZdCcR2jnnA1HcZjBK3ddxINoAkrrsu0qcIwIE=;
        b=PAcJ+ywc1VSbzRrNIn5Y9AoNEBCUCPDQ/wFBqTVUDfcsJav00ldD4zVqBCP0KvixNP
         h+S8kBXHjdQ+TrR02j7LV0yLOgFrUGgL8Mct3jwb8h505AW8u+2PiFYYvvnbsV0JSYSb
         CSfQ4vIsA06GoIxbgmTpqJVGWTLl8aY5IimBV8E1zPSox1Yra5t0GIbv3PLURv7aWeGt
         gnV7xI02qEJfJLuPSe2p6PpgIS4eVIA6U60HCALQBDIlkloTlsdFk+EK4S9LzgM9oRoa
         Fs1ZaVRlrADf7Cu3Gku8rwyQmb5WF0P+c1nq4qyO8yP22aYPIOf107bHnzz06amv/xZt
         7cCQ==
X-Forwarded-Encrypted: i=1; AHgh+RoaBDMPMi6uoj+r0WdPy+0bYiC8+6Dqju8OMJG6XNFCDluPBd9BcO5subYymKti1ydwyoEAEa+5QHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaAyiF1hVESvnKlmb6oldtN8+YKG2qFcJprztGF4a+R2Z08V5G
	y5+vvIeDx/a2r9TpLqsgIgoqmAB5MzLRuLHm/oMkPY1yFnZ8aLwdvKhE
X-Gm-Gg: AR+sD13NKADkPW3d+KbAAq4cMGky5d2Rrj3mrSXnQ5GASEo8Kmi47un3a7YbDOW+lfR
	U5yHoD0OtXl4CBAUiaV+x3zyCvCRxY8DMCIKAO67Kg+vK1GjW1w2v9BFjlMJs7xakmwb45SN46V
	c+oj5SKbzD9tySN8Z5rDE7rWvEDgRyXp9DESZmSNf252fmPqNv98IUsL1PmTZJLX6StGgU6UeSn
	O2A83aIpbWM+2Eg1WboQs0cfKqbJh2ONaaOLFCcWmXl3Sovqrf61l5kGc7a21ManUcfKzZHfafN
	f3sVK057bDWnJj6a4oI94sR3F30Mz4PP1NWNMZNjVhWvVWVk8gjXi6W31oioRFNQtHwLeDpGIH0
	xCQhm7V7Td3yyFHIZ0dAV1HVlh1D9MKwwCVzcUmPu3EaaSmu360VSVSHU9Me7sbPJNwOhUBgnOq
	SQ891fExfL1ZJK/VXP+QQQtfYJ0klc6BQpMBI3jGMnQQLb6eI/c+Xhz08O5DbdgBSIvcfJezfDp
	QA1vlsAWGeHbu14Vh1BfMhg1IRxlBPms89FwIUjUf/0SDHmqxyLcPbJUrPEQw==
X-Received: by 2002:a05:6a00:8d1:b0:845:ba94:a56 with SMTP id d2e1a72fcca58-84f4fd9f82amr15992649b3a.5.1786179668348;
        Sat, 08 Aug 2026 02:01:08 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51e9f0sm1973871b3a.28.2026.08.08.02.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:01:07 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: lorenzo@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	Adi Nata <adinata.softwareengineer@gmail.com>
Subject: [PATCH 3/5] iio: humidity: hts221: Allow unknown whoami for DT fallback
Date: Sat,  8 Aug 2026 17:00:24 +0800
Message-ID: <20260808090026.34187-4-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
References: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WHOAMI check currently returns -ENODEV when the chip ID is not
0xbc. That rejects Device Tree fallback compatibles.

Keep failing if the WHOAMI register cannot be read. On an unexpected
ID, log it and continue so OF fallback matching can work.

Use dev_err_probe() for the read-failure path.

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/hts221_core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 76a391f421f5..da773d2edc80 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -139,16 +139,13 @@ static int hts221_check_whoami(struct hts221_hw *hw)
 	int err, data;
 
 	err = regmap_read(hw->regmap, HTS221_REG_WHOAMI_ADDR, &data);
-	if (err < 0) {
-		dev_err(hw->dev, "failed to read whoami register\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(hw->dev, err,
+				     "failed to read whoami register\n");
 
-	if (data != HTS221_REG_WHOAMI_VAL) {
-		dev_err(hw->dev, "wrong whoami {%02x vs %02x}\n",
-			data, HTS221_REG_WHOAMI_VAL);
-		return -ENODEV;
-	}
+	if (data != HTS221_REG_WHOAMI_VAL)
+		dev_info(hw->dev,
+			 "unexpected whoami 0x%02x, continuing\n", data);
 
 	return 0;
 }
-- 
2.47.3

