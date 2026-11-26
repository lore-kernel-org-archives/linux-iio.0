Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729089;
	b=EFUbSJBRVI9w5UGF6D2BxCpt/G50I4TMtoWYyS+Mvooox+jHIPF0BUCKguYlhBUJXvCN
	 V7BsWAqyTFa0ap29FgZO0QscTN/cdubdHO9ps6CsRQDkNeFZVyefRhzK/8g4Cu/EGbmzq
	 PFrUuzSLHJl+oyWyUXohDOEc2ObDO3hDb0yJI6pdmszaMddeP5nC/2FigtfPsikYP14HY
	 tOLXns/HiMknr2K81x5vGP/ubWClre9AyQqx72Ds6pI2ADYdQ70BRvuBjfVADagGhq1Pw
	 6SxgrIP6AcfzTZu7DCmS+JXVFUbLMnsZCfV6rgG4bLxXVyVrPJ0IJFDMmu7IolJM9Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YRpXQrHWpFwrOpMV8MW5AI9XJefGuUFCrzL+sHdF41M=;
	b=vGDxJxaTw/SwlG5ekbItfmt/63glEh6NrBh8Gn0zLiN8RZ+CrYc7ihimv5Bq43wj/9P4
	 MI6tU/j2/6B+uhIFwm54qSqPX7OCBdDsGOmgdcd+jBXUSnoBLNSN20tI6vUZmR02rFL4J
	 0X5GY8L2/qwHrhY8lwBWTTnh6CVPvIeV0f7vxHC0HkzAGla+FDiJqYj9AsaukI9EbTWVp
	 Lx2eNFCNNr+wTGrBu6bQU5Ff/L66kBwtu1z0O8mUNlKuzk56TQv5vTT5sO0kL9Avo+M6h
	 c7fZyViY3qSv3r21W+hhrUIe1kZMuwDhytpFMMahUZB2n1haxiQ7ZyzgciRixVbqVRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UPH5WV37;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DEE606A323
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 21:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4DEE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UPH5WV37
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a9f9473029so5585802b3a.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 13:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729088; x=1796333888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRpXQrHWpFwrOpMV8MW5AI9XJefGuUFCrzL+sHdF41M=;
        b=UPH5WV37lSVsSIP0gw1HSz46gqWtdd/gaSgcGVnsHCi3yvyHJtcogiKy2W0NuBJMs5
         SQxZMgtibaVfb4HWJlXQiljw2JSaMLbW+jDjBGzm53iv6T8IOccUu3BnJqenbD+IGta4
         jJVdanFXAoupcK3qYYKXaNo+K0TIq4ANUycAcMw+gZkdcSoU9GmkC6bgodODUEiKuS1n
         +vn1O2feaiUeZTUZ1YZgsp2NLvULXMbyIV0VhMeKHvZMV6eT6DYqAOimcucWSXy1JzNp
         aJ7aYks1C02eyM4aBbFX8R5xInvKSZN+LXN8owREq+nPgXprhn1xgsjzauYIQetvq55n
         ah/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729088; x=1796333888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YRpXQrHWpFwrOpMV8MW5AI9XJefGuUFCrzL+sHdF41M=;
        b=WYRzYIqAND/iGDTVzFh9O2VdxBdWUF4TqdUwlzsexFgKFGQYGlDYyzhJbAZxmw9Jfc
         3C6ZB90i66zM8Sr+9DANo4r0LfGsz8KNuU14jTdqBbYJV/GoMvYX5f3k4N3l501WYJVN
         TuS5J2MBtGd77+Ubw7OPpMIshGaDGSw4aKYP9QzEzaxYs5Nu6QUJxtaBAncvOxhCOoDB
         oEYaiOkeo1lXs+4swvli2HrURJi/rGlt37+rovrkR0MxVMTfktJnirZMeqkdrdGKYba2
         qj/1ay5nDu/t6JlW4eBEE5awvikpnDyepTkz8VTcgguym3/Bdn9XjtUPm8PseyZsv2q+
         YMeg==
X-Forwarded-Encrypted: i=1; AL+hErGrbDMr4JRDP43iC3tYmmV62kd5v0XzStu7xwfTyA8nLMHlM1+T1UmGHDidVnNfwvQPDSwA+U0yWUY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GkxBuYzZMli51wigF7eF1/jeJWusFEjxUIk0R93QF30ZBiA4y
	vfKyAXX3YdszCqNQ6TmF3xn5gEa1hzZixoFf1Bk5J5ilztuBW2gUAu3+
X-Gm-Gg: AZFdTZfcPpQC/SivhMKRTkchaJ804sRCtKXeU6vje6C7F8zOrys6DQX/f4u1jyMRZE/
	0i4QumI4v0UM5EbWRdzdP3zzg9GdB20bBOtliHQjZVH4mxdBmrjqcC7HLN0tHxjAMJ8fvXCKd4M
	ejJ1LoEH4FRk0s5p4UaZffBwuXwxJDHpA6wZPlTm+II3909ODVOZRTjZ4QG7sczv/Pw13WXkw+l
	B6E5v+K+H7Ns/rznTzEA4FogX02Apnx2uzQnIaK1uKAQs1hX8p9/GK67qXrv2ggpZb7xFcx6g4c
	/zFMxoKS/7djcMYZXhzbKnUPnas7f9dN8tVzNBKMHbrG9l2o+cYDCTK+UBaGVHGnOgfuh/i3hWJ
	ClXcZpy/MuHOBE8wUIS3WPK2IPcX9dfZH8d1/IFeagM9HrbX57Ttl9HpKRwZW5DwHH0Sgmzsu+b
	Ix9DxBeu8redL5UoWSlvoSeJFyN8+Gikb22xFSwagK6AtKAjaojrf81OKnQPhxSGXlnSxDV7Amh
	9TeEio6hkXnoADLCwrh4ilV1M5N4Da8C8rylBJsjppo2eB/H0ywIt6Jrc1oqv9ihLxh+dAyc8qE
	MhjsSxkxMA2GwTm5T93nS+2NdkvkvAoL7h13jLBaUC8wOzb/gazSubYy4yiTxyj7kralb2snZEd
	tEYJGA1DEZpIiipR/h+Kt9TROHza179rM5keRma46v2NECwU2/vZlxtTzm3GpNAPVuOrH8KwZyX
	Bljavjcik6SfBPeRgNXg9RLA==
X-Received: by 2002:a05:6300:8095:b0:3de:8ee8:8323 with SMTP id adf61e73a8af0-4014c946a9emr20399641637.29.1795729088320;
        Thu, 26 Nov 2026 13:38:08 -0800 (PST)
Received: from kapoor ([149.40.62.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm11703905a12.2.2026.11.26.13.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:38:07 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 5/6] iio: proximity: hx9023s: reject out-of-range debounce values
Date: Fri, 27 Nov 2026 03:06:50 +0530
Message-ID: <20261126213710.1047676-6-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
References: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The near and far debounce counts are 4-bit fields.
hx9023s_write_far_debounce() and hx9023s_write_near_debounce() pass the
value through FIELD_GET(), which only masks it here because the field
starts at bit 0, so an out-of-range value is silently written as a
different one: 16 becomes 0 (no debounce) and -1 becomes 15.

Return -EINVAL for values outside 0..15, and use FIELD_PREP(), which is
the right helper for building a register value.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 2d2774398259..c2718723db27 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -359,18 +359,24 @@ static int hx9023s_ch_cfg(struct hx9023s_data *data)
 
 static int hx9023s_write_far_debounce(struct hx9023s_data *data, int val)
 {
+	if (val < 0 || val > FIELD_MAX(HX9023S_PROX_DEBOUNCE_MASK))
+		return -EINVAL;
+
 	guard(mutex)(&data->mutex);
 	return regmap_update_bits(data->regmap, HX9023S_PROX_INT_LOW_CFG,
 				HX9023S_PROX_DEBOUNCE_MASK,
-				FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, val));
+				FIELD_PREP(HX9023S_PROX_DEBOUNCE_MASK, val));
 }
 
 static int hx9023s_write_near_debounce(struct hx9023s_data *data, int val)
 {
+	if (val < 0 || val > FIELD_MAX(HX9023S_PROX_DEBOUNCE_MASK))
+		return -EINVAL;
+
 	guard(mutex)(&data->mutex);
 	return regmap_update_bits(data->regmap, HX9023S_PROX_INT_HIGH_CFG,
 				HX9023S_PROX_DEBOUNCE_MASK,
-				FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, val));
+				FIELD_PREP(HX9023S_PROX_DEBOUNCE_MASK, val));
 }
 
 static int hx9023s_read_far_debounce(struct hx9023s_data *data, int *val)
-- 
2.53.0

