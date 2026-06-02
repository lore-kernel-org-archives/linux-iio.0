Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E3C36309B
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431279; cv=none; b=Ox/hDZSW25RjDZM3VhP7D6U5433paXFFbmodGEK2joimhEwTaE505800QpjJjCT4rZjenu0IogOMPQvdMvbM3JR8GMwULl4F65AtiAt1uH1hOta0GarBP9QHK4s1NM37JNr+Z1bPIxv29mthh09zktNmeBWmXkd4iUjS+jivkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431279; c=relaxed/simple;
	bh=TKcUV19ReBkomlOIaTwg1EwLtfYv/SXP8hjqtC98/NE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BjKspzSt6mR/UhnP6Owec83MXNWSgSH3WNovKH+mpR6+99bQsTNKaixmImUOOBqP76BibzOWZQijCn6Om7Rn9+FYpPq5VQajmQ2lqvFhkguFnMNCWFR6gNWHhuM3z+FpfcQvMN/Kqmz0pD0gAtTiAQrmdbSlHH0UNFDU9QnQToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/k2BlJj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/k2BlJj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490ac357c55so25232145e9.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780431276; x=1781036076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ULUwZVNwHMVsY07U5LlxchyI/5Ac8i6SfhG87PTbrus=;
        b=m/k2BlJj+2R7dpYL+k/UF284MwG942TBBqjCzpY9RVz0gcdToVo7x/xlHr9yasZfor
         fL2EtSkIGP8GVowWIjIYNzaJr5KvR9zpgrGz2TqdEXkKsyTI0fawHVgniwJJ9f4cRar6
         QCoOyqieWIR015vjGxMy4Y9Yh4/DITIPRz5VQKIEe0SgoxAzy/xDHeR3EsBKJRY7lXGE
         IZPIt7z8vKCFXVzmWE0bB4eVr/hNCiOP4U79Ow284Hmuf9VJfvYdFcPkujIddAGpCFRP
         y40G6HW8TjFpsiwduNdknrYwOtNF+b/UH08u53ocQGKGAYZI2B/gHQa71QLwQi7SMEh2
         iUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431276; x=1781036076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULUwZVNwHMVsY07U5LlxchyI/5Ac8i6SfhG87PTbrus=;
        b=V6yRb20DgjCduEsvCVahYX1jy/G+vEEkLa+dqKx3q20/mNUunh5k3UrcInDAHGB7k2
         jeIU0IMyUMfCO2/G/Z5L1Sfa907l7alnOPmYrMVUND7Ne3HC+PaK9BFzBG+jVV3xCH2I
         dH21aQ6MqSsl/U4duX+KJ7vTqzlY+sHHLI6LFINE/nDHK/7EQHFkFjY4XuwTMqG43Maq
         nyLpmdbt6m1IYeU3Bs0qA/ci1ELN1LBgakDXGGF0nKoOfAJOVQkisCoJBRDPu/re4qyv
         Ct6rWGznQaa5g8x5nMONQ4HMZtgWitbRi0pXTTRDQRJXdiYXANrldf+9aLrChTN5pasz
         YrEQ==
X-Gm-Message-State: AOJu0Yz975yGg2woFy7FXpdfdLJq49cn0VQ3EDUmBfJjw/g7wWjB9/vf
	idokuQmJWeiQT/LxAa9rQ7rxN/Fx14tQHhyAFXSEf8jRoBvTtIWa9SdW
X-Gm-Gg: Acq92OGdnwxQZiHHHcFcNQkxXueuCXEpFo9pY4A4WBG5CQfFid7TD1A07EIoi3p4Kyj
	o3g7oA3QekPBMyQPdiBtr8Z8GdXVBo1aAaahhhpf4yKuwIrz52co0WZEYp/0nYox4wlFoVrZoS1
	tRJZdOZnrrFGP1D7Si9TMizlFj5cF2F6zs7rje0Z7C06Jk5sEd4gnIiJzQC7SQp9y8FhedUHb3h
	7kvEIgjFU6JGym15jw/ZjsVyhjLxNYZFRhoh597PhSFVxq0C/O/gHHH/aX1IqsTsK9dbXlWAMJc
	ECIFGwMpBcL8/kxd+J+DIH+URsZpOGEmyiTHvl/4jXNcREetg5j6x1sxvagWB+0N/jWXiUe+L0X
	jKyGBZEnoLYpa5XGWKOpL3OAxHiEosfpJCkKQ+laa9bhn2/A41Iag0JFvMtR+DTfGAxtTUtmWs/
	sQhqtnm3DKRvOPEJys2D2LzD124AR8TRp4Qn7OpEq/ZG0uBgtu2sjw582SPwk+k54sOXDlJFSUs
	UDShjft0aEqolg=
X-Received: by 2002:a05:600c:4fc6:b0:490:53b0:9e53 with SMTP id 5b1f17b1804b1-490b5e94e48mr4943035e9.1.1780431275963;
        Tue, 02 Jun 2026 13:14:35 -0700 (PDT)
Received: from fedora ([105.190.243.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e76153sm92599075e9.11.2026.06.02.13.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:14:35 -0700 (PDT)
From: Jad Keskes <inasj268@gmail.com>
To: linux-staging@lists.linux.dev
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Jad Keskes <inasj268@gmail.com>
Subject: [PATCH] staging: iio: impedance-analyzer: fix CamelCase in ad5933
Date: Tue,  2 Jun 2026 21:14:28 +0100
Message-ID: <20260602201428.213890-1-inasj268@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch flagged mixed-case suffixes in #define names: _mVpp and _Hz.
Rename to _MV_PP and _HZ to follow kernel UPPER_SNAKE_CASE convention.

Signed-off-by: Jad Keskes <inasj268@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 85a422329..62ed5e40e 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -43,10 +43,10 @@
 #define AD5933_CTRL_POWER_DOWN		(0xA << 4)
 #define AD5933_CTRL_STANDBY		(0xB << 4)
 
-#define AD5933_CTRL_RANGE_2000mVpp	(0x0 << 1)
-#define AD5933_CTRL_RANGE_200mVpp	(0x1 << 1)
-#define AD5933_CTRL_RANGE_400mVpp	(0x2 << 1)
-#define AD5933_CTRL_RANGE_1000mVpp	(0x3 << 1)
+#define AD5933_CTRL_RANGE_2000_MV_PP	(0x0 << 1)
+#define AD5933_CTRL_RANGE_200_MV_PP	(0x1 << 1)
+#define AD5933_CTRL_RANGE_400_MV_PP	(0x2 << 1)
+#define AD5933_CTRL_RANGE_1000_MV_PP	(0x3 << 1)
 #define AD5933_CTRL_RANGE(x)		((x) << 1)
 
 #define AD5933_CTRL_PGA_GAIN_1		(0x1 << 0)
@@ -68,8 +68,8 @@
 #define AD5933_I2C_ADDR_POINTER		0xB0
 
 /* Device Specs */
-#define AD5933_INT_OSC_FREQ_Hz		16776000
-#define AD5933_MAX_OUTPUT_FREQ_Hz	100000
+#define AD5933_INT_OSC_FREQ_HZ		16776000
+#define AD5933_MAX_OUTPUT_FREQ_HZ	100000
 #define AD5933_MAX_RETRIES		100
 
 #define AD5933_OUT_RANGE		1
@@ -303,7 +303,7 @@ static ssize_t ad5933_store_frequency(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (val > AD5933_MAX_OUTPUT_FREQ_Hz)
+	if (val > AD5933_MAX_OUTPUT_FREQ_HZ)
 		return -EINVAL;
 
 	if (!iio_device_claim_direct(indio_dev))
@@ -699,7 +699,7 @@ static int ad5933_probe(struct i2c_client *client)
 		st->mclk_hz = ext_clk_hz;
 		st->ctrl_lb = AD5933_CTRL_EXT_SYSCLK;
 	} else {
-		st->mclk_hz = AD5933_INT_OSC_FREQ_Hz;
+		st->mclk_hz = AD5933_INT_OSC_FREQ_HZ;
 		st->ctrl_lb = AD5933_CTRL_INT_SYSCLK;
 	}
 
-- 
2.54.0

