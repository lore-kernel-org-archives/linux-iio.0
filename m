Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26A3A1684
	for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2026 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783166009; cv=none; b=Hnip9m+dxT+Dp2xbdUtEA1+7oTdu3afFUeaya/yrkIHDeCxUaRvgp7IUaVsBfBNHXJGX/Kk2rrnbkksSW6zirIOXE0+HZSeTVMC/A0MklDmHZsIv13KQKhvWwnArQBq4/jrYzIFp12gfRSOgMkMN58WwZfzzBWDomCRhyMK7Uoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783166009; c=relaxed/simple;
	bh=ai4jZCdbrJPe7EUiAYRqiOCk3jA6QZQXOwe8vdOoInE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLlDY3RYH22I3bFLuBd6uWQApyob08D/2kiKFzn6kNgHUVtelKB0iUoSyEtjCfzDfV3mCTqDoe0W4r1z+DLkNzikfY84bbYDFtgyEsxg5lcXqpfjh07JBztpWLms3ZSkSzdl/MpR0hvZrcBYe1TT7AepzpGHSO9X2Rh0gbaDc8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LelzI2l7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LelzI2l7"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso672714a12.2
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2026 04:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783166008; x=1783770808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsxMTdTxaGyKiRcEKAGvLn+sq4FSJrsqhtc2CDzMcoo=;
        b=LelzI2l7mZDui9oETlWsSJ9zfQHg6c3S3FIhmIWg71HO58PJK1g7cyL6Xs32/SC/Vy
         yI1EBqWn41YTDrCXmPLZr33Xhwmg29x2pqG9BMSuIJsXOT8sO8M8hTsTBFEdPO8ZzRoS
         AGUw9yZ9t70ne0k8BCLC9nFdoggkt3qa3gXucAi0SIEZ9h5g+/Y/siFBDOPfs81OE5Nt
         6it2EC9lgpg8z3rlynYDhULEwIfYvqFf/1PuiG/OOBm6lBqzXLa5P/XEERTy5B8UPqc5
         B/nppy4rUXLCRyvCA6JyVGOaSsUu1OhRYPIbjYc9L1GnE/UlpSgm7DU/4bYcfpqyWasd
         7jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783166008; x=1783770808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UsxMTdTxaGyKiRcEKAGvLn+sq4FSJrsqhtc2CDzMcoo=;
        b=SzOZO/NDkPXgtSFwrP3ThkN1XvKP+vz0yXHvGOFs5v3OU+ZZghlZ1FbB4wCvZ7AGDW
         u1HJCIRqSdEfgFX51Z6nKElzsOf1dAIs0VY8mL0P6fCrrDM1L/9n0nNkyS9gMxRgOM5a
         fMi7m/b9CgQfPKQt+KME6sr3vaawq2y1nsqLbshRCHRUirsVfb/TSca/tNyqKKyH/nws
         erYamXE+J8VuehAWhZWAZQssHBL4Jx3jCvxbcqAa9NGNDBMDIfY6AYWPYPyrcp8BYVio
         HKhFlKvm9xzIJk48cwgB9vReevy6ObEKHRIzG2ECL/2JwwuIp1cIIJumqZRyP+9NfjMJ
         2jjw==
X-Forwarded-Encrypted: i=1; AFNElJ9NXtpPIOrDx0fOMSCFvQVKxdcYd8xUbE2a2w2MTJCsMWDo02vE1EdTgysk5qzy0OkL8KQvEfSZPd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywimwhQOl18g9ldAFVhFTKrT9k+c3O2iDF2NU622DupYR1gPBH
	Cxb3ldwwpslGoMcCbRCZPr37tI+mwntxmMbvaD1J+rTQfOQcCkdr3uAu
X-Gm-Gg: AfdE7ckY+mXx11s7GSg+kqNi7TccoXdDedifmCaxeAoiDgqcDyAozC1Ap3LqgSOCdxR
	rce7O6fF6NUPRQpuDYLGMV36UGZ1gCyVzmzL2+CI0KOYWLP+K9h4P7aN/vps3Axz2vUM55weY8i
	Ur1kkhXStNNfLxnEaMDk38pD1OEc3KAgS5itdctyGIjcxkI3XIds+Xg4tkuvVB8iZvLr6q1hKtp
	/Zj7XsSQGHw8I+p5Qj2WrPFaaBjx9W4UCP3l3qCWjEooSu2XfRpDmhoWwVFLritRcdsuRWW5DME
	GtOIThyM1i9AYsh5XlSi9EdjOn3qHBMPF9MinmQefNKN4tHkIgYN6P5MQGEDxltgAznQips6H24
	sdZEsIzjfyussauFZvHuB1abfxWjWJlNlHJOHiTAQxctuH1DIZlJhE2yIycfrmonZVi27hPsNw8
	oE1TOzO3UfYe5QI08lfy0AVrfzP5jKzbL/bLng6KtMAg==
X-Received: by 2002:a05:6a21:6e48:b0:3bf:6c04:a816 with SMTP id adf61e73a8af0-3c03e4da45cmr3219460637.55.1783166007775;
        Sat, 04 Jul 2026 04:53:27 -0700 (PDT)
Received: from primary ([223.181.23.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85bde6sm49580285c88.9.2026.07.04.04.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 04:53:27 -0700 (PDT)
From: Vidhu Sarwal <vidhu.linux@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Vidhu Sarwal <vidhu.linux@gmail.com>
Subject: [PATCH v2] iio: light: al3010: fix incorrect scale for the highest gain range
Date: Sat,  4 Jul 2026 17:22:45 +0530
Message-ID: <20260704115245.11167-1-vidhu.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702052913.114130-1-vidhu.linux@gmail.com>
References: <20260702052913.114130-1-vidhu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

al3010_scales[] encodes the highest gain range as {0, 1187200}.
For IIO_VAL_INT_PLUS_MICRO, the fractional part must be less than
1000000, so the scale 1.1872 should instead be represented as
{ 1, 187200 }.

Since write_raw() compares the value from userspace against this
table, writing the advertised 1.1872 scale never matches the malformed
entry and returns -EINVAL. As a result, the highest gain range cannot
be selected. Reading the scale in that state also reports the malformed
value.

Fixes: c36b5195ab70 ("iio: light: add Dyna-Image AL3010 driver")
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
v2:
- Remove trailing whitespace in commit message and Add trailing comma after last array element (Andy)
- Use IIO preferred brace spacing (Jonathan)

 drivers/iio/light/al3010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index d603b4a6b8e8..ca1d7fd6defb 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -42,7 +42,7 @@ enum al3xxxx_range {
 };
 
 static const int al3010_scales[][2] = {
-	{0, 1187200}, {0, 296800}, {0, 74200}, {0, 18600}
+	{ 1, 187200 }, { 0, 296800 }, { 0, 74200 }, { 0, 18600 },
 };
 
 static const struct regmap_config al3010_regmap_config = {
-- 
2.53.0

