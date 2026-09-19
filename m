Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486AC35C693
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847750; cv=none; b=OSUbY+Blp6k9BlAlK0qERWt3vGMESSTDs1BVnOguCYuY/NsSsNueoaxDUGnz5QLHi9Qpx+sd0xl/jRMVDon6kljhR9ajIoIWNFd1dxO1+T+cL0jRf0APXveQgG+nULxZXN5+viuMY8j2yEH+pk4lqiNHH9J6Aq2YA5xws3m/nZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847750; c=relaxed/simple;
	bh=g3SPnvN4YEARiFmdW5Ux83YJ3rzRN9/F/Tr8VpCksLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IieMuAuB/OqTDWRJzHnKkbihfi6ZnmlmixiGTjzi5pA2u9bQl30M3WnKi5D1XobbhygwNR6YTxnVEE/oqJmt4j/K/q+TUd298Tleld+l7kdlLgHHXZMzxr1rPRaaQfgxu7EoSfMu//AKJxDmHMBBnRbb7ejxDkWtrP8V2Dxe7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BC65/TAa; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC65/TAa"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874fso622142f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 12:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789847747; x=1790452547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TcN+YUzHfzeC0XYeUrNzJxeHFOGLorYxlXTCMVHIaKo=;
        b=BC65/TAatxPTE+45OYIh9GGRJJ2kUV1P+MaSqxjS929w0bqDlppSRIOfAwq2FiOpTL
         pAoE2ChiJm6rC+sxtFWl01WAnwvGu+6d4HSi7p+k7gY44y0wNeb4cb7gV55MV4Nm6DMQ
         dpCQtkE39GnXaaJdEn655FKXoJE5mSHJS1hQOOgDJDOfWCA1H6L5qyf0gICWYo5hN9FS
         XK+KJ9DehgBilqR26api4VC3puJ5KjDX5RIzn00PmjfVBGW3uLSrqGNbAwoA1DQGThZ2
         37KbUHGj50ucpffn6Kj65V1zQtyMT1oEIZVv5dno/WtZICKS2aSdAw6Tg1708xSwE8c6
         k39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789847747; x=1790452547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TcN+YUzHfzeC0XYeUrNzJxeHFOGLorYxlXTCMVHIaKo=;
        b=BoGxfE0RQtVDFhx9tiVLPY1q8dxIBkGmGmQW/k0PwzA2evZ0uERilNxAytf+7UxC8g
         nFkcayjyYqNVkzo02zxanqOV8NHx0jR0RUgdvnIG2Symd019pci1vpDzmaDnaIVL2qd7
         GBfG2L7Ij70CclEZHh2XHLnN9SCWhnUGxaS1DNcu5jwMEh1cYozu8DDC48CUxcFlcn6u
         YL0MF5MR87/r4rR/JrIF9Pjx469U0nWiDqZu/jKVja66w4NVwIU+Sbbr4GIU4RoIxEN2
         /MVREIIiz/L/2MX+O5/KlHKvt3AHGsJgnmq+FydfBK72FS7EO+aupbX5xOiYCGBQtGwj
         8eDg==
X-Gm-Message-State: AFuF++mSEwlis/Z/exTWovcsxGA/YBS6H7QhlmP/Wd8IcGR/htHC99b7
	tEBBalyKd0TYDu2zBa5tShf/tULvk6ZHVUui6qk1lNhYdSzVMjmZiSdNcgVUOQUT
X-Gm-Gg: AYBFou36uHT5HH/2c9JoaL8zUW7VYT1/raH0OY3dgVGsuMzxVH0ewt+YcQ05ZmnYSgt
	CAhz4sP6m0mbmFN4AQSZFDtbdfu3OEYlzJJmslhlicfeJRerr8I9O8ow+G16Pm5hlTRJVWzT998
	vq0fgFbM1g3X3QAjetpHkmZdoEONS1vgP7Rr4zFVKWQBCpSkqeAqmJY1XVSkKNnVCBJ6ZnP3BH9
	fQzD5ccda0nAV9kNVQwGg3nZW/LBTzFUAlAMs+zDexdqzST2wK6EWp9TREllOGvVNniRBsK0q9a
	RUcizykQbTQUw7Kd7eYVWqw57DxiItuty9PtTGp5OMKWNFl8i4CUPAIuH06Vl2GJBJy7A+LzeUP
	CtJ+m4TlEf4sRsz9InXe+o7rJGMWyRxkgTjI/IERMc0XWKZL6cGRtXueF3GDMh3UfoDg7Gr/0Iu
	jZ7xThgd55mzpp7/bnpKoMAwB14zT53xWdhbMnNqjZG9+Z5QJT4hHp8egby/U1ZX40o+2jpYsBV
	/B2FD30plucFOE0ZaPigzE1vmpt0c4drlbOjqvbiK02S8iigfUFNMd7Kx5qWj+y3XUm9AkkDype
	GUSBdDE=
X-Received: by 2002:a05:600c:3510:b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49fc4eef2dfmr95041315e9.0.1789847747394;
        Sat, 19 Sep 2026 12:55:47 -0700 (PDT)
Received: from SegFaultinator.localdomain ([37.142.157.121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07bba7sm93823795e9.9.2026.09.19.12.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:55:46 -0700 (PDT)
From: Angel2Eyes <thefireking@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Angel2Eyes <thefireking@gmail.com>
Subject: [PATCH] iio: adc: mcp3422: use sysfs_emit() in show functions
Date: Sat, 19 Sep 2026 22:55:07 +0300
Message-ID: <20260919195507.94130-1-thefireking@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs_emit() is preferred over sprintf() for sysfs show() callbacks
since it is aware of the PAGE_SIZE buffer and has built-in size and
alignment checks.

Convert the remaining sprintf() calls in mcp3422_show_samp_freqs() and
mcp3422_show_scales(). The formatted output is unchanged.

Assisted-by: LLM
Signed-off-by: Angel2Eyes <thefireking@gmail.com>
---
 drivers/iio/adc/mcp3422.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 36ba00edf..fd9e72265 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -262,9 +262,9 @@ static ssize_t mcp3422_show_samp_freqs(struct device *dev,
 	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
 
 	if (adc->id > 4)
-		return sprintf(buf, "240 60 15\n");
+		return sysfs_emit(buf, "240 60 15\n");
 
-	return sprintf(buf, "240 60 15 3\n");
+	return sysfs_emit(buf, "240 60 15 3\n");
 }
 
 static ssize_t mcp3422_show_scales(struct device *dev,
@@ -273,7 +273,7 @@ static ssize_t mcp3422_show_scales(struct device *dev,
 	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
 	u8 sample_rate = FIELD_GET(MCP3422_SRATE_MASK, adc->config);
 
-	return sprintf(buf, "0.%09u 0.%09u 0.%09u 0.%09u\n",
+	return sysfs_emit(buf, "0.%09u 0.%09u 0.%09u 0.%09u\n",
 		mcp3422_scales[sample_rate][0],
 		mcp3422_scales[sample_rate][1],
 		mcp3422_scales[sample_rate][2],

base-commit: 69fa76f0af3414cc189c3b0b807cb59e327ecc00
-- 
2.43.0

