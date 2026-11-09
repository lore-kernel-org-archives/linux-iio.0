Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243137;
	b=LCL+Osu6iwFFlxVS6jUzvSkcmTq7FrHpZyvOErFfdz98Dr/qmMI3Q5Toajv+8z5P6dWP
	 UnRJTziagM2yx+2TJzFvxBLZEhlpwLXSteTBqaJGcneve+v8rbEghI1hS0Fv+Bk9wvOFg
	 f51HyQY6hlCoQDE8wuebyqjPIl3SukiOrPWF3pSbCOQF8vV0l4pEn5ENVws1F4h5hXUMt
	 fyU72uAJAPDy/LzgvL9IclEFgrZC8RkbyPrhUKG0VUL5VknmL4v2vBUPXFw2zhgBf5BCp
	 nhMHshihrR9Rm38LWpTktfHTxSya6k7Oo64002nkB3atQIK2vOJ1oPaA9vLuHFPN31A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pd5Wjo4IJ/GK6HgEtpBX9p1EqEJyWK+lBQtVn6hbD7g=;
	b=BoX8M4mm5vbGj814CHaPcJfqQJuvyRSea3UFoqBqKyASlj3tmX1+FdpEggHhsMYZsE4c
	 /Fi6M8mX/KW7/hFW8bBgLMU5Sq1OJF/b1wcPFWsPSxkmbgZ1IYShdsZipAOP04glZXGWw
	 zTc8LF148kh0+72xZHAe2/9FfzBs4nv+aIJOJSXL0BdFrQHp1IQGHWEBezN6DRhqhoDQX
	 Zkosp+EuFrgNgm8VuzqaejhfK+RCfIwmihsQk8lZTj0X0RKJ9AJg0IG4XfyfT4vzurmK4
	 /8H3Bt31obrcu8Ov3RkM3B36DY17CH61cwIN8vXGd3CAjLC/1cH0KhjEp9vhfbvV6nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KhroH+wz;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251B606EE87
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3251B606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KhroH+wz
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15ea896ddc8so1920692c88.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243136; x=1794847936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pd5Wjo4IJ/GK6HgEtpBX9p1EqEJyWK+lBQtVn6hbD7g=;
        b=KhroH+wzyyb+/rtmaqKeQ2eGtpKy82zqqH0rUO6mQ1Bze1z2wlYHHR0KQKd6h5qaXu
         j6agKJKh7qMRp4sb7TN84N/IJI1mZqsWzrdmGlQ7p+/VByfv2BLEZYsJKe9cLS4H+tCb
         lQcObnPSeaGJ/LImud5VeFYYoeOBYn6vOnPz/A1CnNmnas9fhD7mgNKH7ba25I5s9RZZ
         FtzQ4BWsP3o8+LP9ElTmipqafoF0L5hHLSYw8muI5T+EFAo4rGL0gtQiWhmZRnf7uULt
         XTJJn8QrMz9ZnnAWOJtLVIE6jACRyHubOSBf372MnoZntPUNs2IJzJGVaAjOLmcxnVMR
         sTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243136; x=1794847936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pd5Wjo4IJ/GK6HgEtpBX9p1EqEJyWK+lBQtVn6hbD7g=;
        b=PGq9YDU+dIZcR0ZhZaKbcL9xr0b9/OycfpJvI7gBWPjnvGN25qqXCI0aDjQeMBIKrx
         CNHpXjZvlvC5LKY70Ho4WMJZiW6zsZGU4vUuo1PtrbwWz3wfLn/I1gytx4/Ed9maNsMh
         LZ/vVBmVsvQd9xF9cRTzf66HVRif+NS9dUojc4m52pQVbd4PuQiAqq/7nkXFoAqW5xlp
         aAcFArjPcTjzz8qhIwoLvXN7QP4r5r3cwS5ziMofsNE9FJeN3+OIM4x0ghQ/U/OztPn8
         g2O9YMCiWzl3mmzNVWDf9QYVKybYPY8dLQoJdvscq7qW3Bxk8o+/tjDb5Vr+Iwfhubo9
         VLTA==
X-Forwarded-Encrypted: i=1; AL+hErEEAbVpLoR/qETciWOctJ2wPhJBBjqsU4LeeuYsmBVvIyZBOL9G1YwVhJ2GgZP5CjusBQHaYOf1K60=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HYD3/5CBxoPC9d5XWNummKbJ/1eO6aOP5RbVtVnkTDq+4B/qk
	XVUvXwo6GX2+W4JIfztfGItVA22rNDOmwivNAPMP3cIFYtDSydu09Njq
X-Gm-Gg: AYBFou0KnIsN0Q7v3xpmd50HXFblX6V4ZyizIVUDddGxDFqFxwNF8vRY6Dx2pdqrolG
	UuuaW85Y/LqUu65yapP9GrGY50AVp3sfhMkTe/Cg3M1a+OusTvYgAN1gqj8p1u5wvtincfOKSkC
	6j1EaFZJtTyVx98Rq3UM9A6nNWzBcs1+xGhSH+9AvH79f17XFKkgCWDiRxBXUXMbcCXC+8rrbOg
	vpkq3cNfolC6Wm9hVxF5XaV9zKGPqgv6TOI72hP5lscjn6bf7yGqsFNyfcXVfm3bMFiWJ+pU+A7
	qT/wHEBoFLVYLBGqXIejbOj8hF0+xj8DdeeEFmLzmJFsb7WxuXKclGGBTVTyxm/1BbRUVQUuBXl
	JrwL/nJlO3c3gCATXXlthu22Go1k+u9bnVoKTv3CqKZNGUjREj3gHKpWgRLgeYh48YxudWBgXBb
	Xb+qNUQ60e4IblrX/iDz9/t7NW9rkTnyV2fj6kFsAWM1jrjqwaBzh1QPo9J9Csihuy9AFZNIt2v
	BpCp3q6ZCGvOXjiF5LdoO7G17oQl0UmvNYZ+M+MGGdAi70zL/hh7YiTsD6ayCSjktSXevz3/mVD
	dV4dgo6+kEPT7UpvmN/4UqqIHiHkex3sy8FIfKXiT8wzGW+mijbVdtQrb6SZuNHFv2g2xIr6vU+
	jfufzkyGh3nZT0Tu0OG1cpfb6yB3vp69EB2cnPe55N/gtdwJSJjz9Os2DLAGTj8hqarsny/oL4m
	FcplvHSlKmLFxBIbyESqBhWejZ5YpY1QDfgFxKtIr5Lg==
X-Received: by 2002:a05:7022:28a:b0:1a3:87c8:7efc with SMTP id a92af1059eb24-1b3b605185emr5274c88.39.1794243136209;
        Mon, 09 Nov 2026 08:52:16 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890584sm307041c88.3.2026.11.09.08.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:52:15 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 1/2] iio: proximity: sx9310: reject out-of-range hardware gain values
Date: Mon,  9 Nov 2026 22:21:52 +0530
Message-ID: <20261109165200.305266-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109165200.305266-1-kapoorarnav43@gmail.com>
References: <20261109165200.305266-1-kapoorarnav43@gmail.com>
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

sx9310_write_gain() passes the value from userspace to ilog2() and then
FIELD_PREP() into a 2-bit gain field without checking it, so some
values silently program a gain unrelated to the one requested, and the
write still reports success:

  - 16 and larger wrap around in the 2-bit field, e.g. 16 sets a gain
    of 1 and 32 a gain of 2;
  - 0 and negative values set the maximum gain of 8, because ilog2(0)
    is -1 and a negative int becomes a large unsigned value.

Return -EINVAL for values <= 0 and for values whose ilog2() does not
fit in the gain field. Values between the supported gains of 1, 2, 4
and 8 are still rounded down, as before, and the gain read back
reflects what was applied.

Fixes: 227c83faa2f8 ("iio: sx9310: Support hardware gain factor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9310.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 2585b9c6fb69..9177d6d4a0a1 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -665,16 +665,23 @@ static int sx9310_write_gain(struct sx_common_data *data,
 {
 	unsigned int gain, mask;
 
+	if (val <= 0)
+		return -EINVAL;
+
 	gain = ilog2(val);
 
 	switch (chan->channel) {
 	case 0:
 	case 3:
+		if (!FIELD_FIT(SX9310_REG_PROX_CTRL3_GAIN0_MASK, gain))
+			return -EINVAL;
 		mask = SX9310_REG_PROX_CTRL3_GAIN0_MASK;
 		gain = FIELD_PREP(SX9310_REG_PROX_CTRL3_GAIN0_MASK, gain);
 		break;
 	case 1:
 	case 2:
+		if (!FIELD_FIT(SX9310_REG_PROX_CTRL3_GAIN12_MASK, gain))
+			return -EINVAL;
 		mask = SX9310_REG_PROX_CTRL3_GAIN12_MASK;
 		gain = FIELD_PREP(SX9310_REG_PROX_CTRL3_GAIN12_MASK, gain);
 		break;
-- 
2.53.0

