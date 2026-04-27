Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FBD3B7B9D
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289276; cv=none; b=qKctWG4HdKHUHI+NYOSCjkiP1UMMtau/BHGgfCd2FrM9oEz7P7g2dcN0A4h7GIjlGhW1zqBsLMVUUuQekeFsK3wE4VMBQ+6xi6xOlIae3QMCk19UDo4bDm5p7GY9Fym3ZRZeSEEefGujKJkk8QwQGhrpDZZ8Zs+hub+Dgzr/EvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289276; c=relaxed/simple;
	bh=RBabLqD+tGh8IYvzJyarXxDfNs7n/EFI2FJh1Goq9zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1nInemefSoiRenGvKmstqG1DkqsiR1ZVFKtlra6oDFmo9qBDO6qBCjrkj++z9kuBF9NFKRStQatnbFWesvOFlBYog6Q4EX9fwEwuRgwtmqusPGzguEYtWFb8f4VN4YVSPyCgdIpJObxwnyATnIr9BF9IkUyO6yNxIZk+TAhNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUNG8VHT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUNG8VHT"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43fe7c6f61fso1040044f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 04:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777289273; x=1777894073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WMwv0fkBxFJwWQsLP7Ii5ugXzxTh1cB00PWr4huj+AQ=;
        b=iUNG8VHT5Y6XfozrKbnAHMFrRxs9m3lDZ55YyAfpdmZGNmByLL2A1Q+Cil3ir8m2Bg
         4xlV9je93kxjFCnLQfqdnIyuQthcVmmNsHnAaIxUj3ANhef0MXBC/SctU7+4uEmzG4rt
         XMKCxYgr0A+odL5iTdkTKbfq1q9pSBd5j0rW7gDIPUBzzVkYuYdl7IgDuggb04mulp5O
         VAmICfBZIaweuAqxvmah2UEUKc3Aj/Lpg4pUM+o1KcU2ZYjYO+RscogvkrJ8itFm03fi
         gcmqstfFn1J2Rrvg+hL2i4+/xBBJr5WKsaA9pc1XkGDsx/eSLB1TvO/Ec3i4K52VLAg4
         6jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777289273; x=1777894073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMwv0fkBxFJwWQsLP7Ii5ugXzxTh1cB00PWr4huj+AQ=;
        b=Hhd/ejabUxCptlaEH0YcPYXJXi3z+C6wSQY4yWyZIrPpzuptJWwHtfgBjO8LTO+3XD
         fJ1noBwf3nC8x5OiTy+qsapVZfY6zehKYwrB51mNwvRF7ynlqk37wfzilbfU+S/PY7Cu
         Zox+LX97P7uzbHMWdJXsa1c3t3tndEmgHzzIQ0GoOZA7fJk6X+XetHYoqXCAqp40KW1i
         DhIMDXCQdtqNqTGQ4RjmAazqbr9O8PWHjCbhlor36+jbLFLdj/RjXzx3ES8Cg/SQg5GS
         vGHBsDxnecYHOH080wEWjxGYSEHaM9rRORsMIMKvvbWX72DjFErh+eGKiqf6mVKNwHdc
         on6w==
X-Forwarded-Encrypted: i=1; AFNElJ/EiohRuScsJ9NYesDixCphwgzOUGcM66F4HL776MGC7j3eNqgmv4dT38XwUxrQ4B0Hu12EfAlnd4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLVRsvGuLI6kG/eEbOKsonVKRJFFepv7066ay+5WK3hviyj6S
	+YDL5lrM3+D5PJ/UQht5oKy9Z5WzU7yGZUMNAMqfoI687Bte9IQTV/C9
X-Gm-Gg: AeBDiesBRX0nufdWtIcEaWlcH/HIIZH6uIs7txE6TAfmI9ucEPwSgYKPEwXccCeneRO
	w5Z7W5yo9IwIUm3+WaN2AetegCNThDFjTd8P3/9TwXRuHnnOcVTMKv5F05EWKYlfNpspSx+XNCp
	d04x3n0AjQn8XxcZybAhgtgsrhgn/OVuBmBxbCykA7Gu/jZq02agE7mqkSzfMT+NAOQzAjDHKbN
	qb+jh5OBNN5Hozd2ZiNQ+ShgX0lXDF9FpLWagPrWwR4fmmvP0Fg9f0VAbrcnAJd/GSgcGKJYI35
	Z5gsfhEu8rUq50CuL/4/mYvvSaq07jdMfy1AdtC+b31fOqMt2FuiyMPKALIqdh8E7mbtOf9b/DJ
	oFgMLp5YLC35rn6bN1vt0BPKCRWnFIKMzPVkvCm1S80kpxszuFSYvMgLTfJJ0g2UgfgToFYXUWP
	yq5EJ2vXUQ2sA2n1QtFIOuHoob1DAKMlLC/Q33l2L8NXquGF6TzkHbEMxEfgtCZfAHkgfKqhF0R
	xyAVzU04gL0d9V+OdTqsHNdXX4AlrlvxYaI+so5Xcb5fcuW40hEQYBMGmRuvy4=
X-Received: by 2002:a05:600c:154c:b0:48a:5758:7999 with SMTP id 5b1f17b1804b1-48a57587e4bmr202154105e9.4.1777289272811;
        Mon, 27 Apr 2026 04:27:52 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm1342961895e9.3.2026.04.27.04.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 04:27:52 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2] iio: adc: ti-ads7138: replace kmalloc() with stack allocation in i2c_write_block
Date: Mon, 27 Apr 2026 15:27:07 +0400
Message-ID: <20260427112705.71138-3-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ads7138_i2c_write_block() function currently utilizes kmalloc()
to allocate a buffer for I2C transfers. However, the length
parameter passed to this function is strictly 2 bytes across all
driver invocations, making the total payload buffer size exactly 4 bytes.
Invoking the heap allocator for a 4-byte buffer introduces
unnecessary SLUB overhead. 

Replace the kmalloc() call with a statically sized 4-byte stack array.
Add a boundary check returning -EINVAL to ensure future driver
modifications do not overflow the stack buffer if a length
greater than 2 is requested.
Furthermore, dropping the dynamic allocation entirely removes the need to
include <linux/slab.h> (which was the original motivation for this patch)
and streamlines the PIO transfer path.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ti-ads7138.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
index ee5c1b8e3a8e..172893cbc17d 100644
--- a/drivers/iio/adc/ti-ads7138.c
+++ b/drivers/iio/adc/ti-ads7138.c
@@ -102,21 +102,20 @@ static const int ads7138_oversampling_ratios[] = {
 static int ads7138_i2c_write_block(const struct i2c_client *client, u8 reg,
 				   u8 *values, u8 length)
 {
+	u8 buf[4];
 	int ret;
-	int len = length + 2; /* "+ 2" for OPCODE and reg */
 
-	u8 *buf __free(kfree) = kmalloc(len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	if (length != 2)
+		return -EINVAL;
 
 	buf[0] = ADS7138_OPCODE_BLOCK_WRITE;
 	buf[1] = reg;
 	memcpy(&buf[2], values, length);
 
-	ret = i2c_master_send(client, buf, len);
+	ret = i2c_master_send(client, buf, ARRAY_SIZE(buf));
 	if (ret < 0)
 		return ret;
-	if (ret != len)
+	if (ret != ARRAY_SIZE(buf))
 		return -EIO;
 
 	return 0;
-- 
2.52.0

