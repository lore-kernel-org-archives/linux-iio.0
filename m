Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847200;
	b=GoLQw99olQ9/DW3g+tXmkbZdlvtvStL74CsLyxs191YKtDdlPIavN8Ut69VJKJGpckFX
	 kQxOx3t1T6lqLOtDSolKbECAhaUCLRdDUbhu1BbUDJjj89luwM1DPuaIUG38w+4mlOBRx
	 otaJc/YrwrYHQ3e0DwDAVExCVTOcqgU6QHsdrpSGLiYP3zEabk5a7FGEQb7WD+bfNq7k3
	 +mkmZtAMJqYL2fctY+o04QTfG8OZ0ozjB2uifvfcjYfjC2LLLEBf5XGtP5I/eeA8T1F4h
	 HsS0IAeoZ6AwTjTKD0ua14KdRyhDFItUzTkLUPkzDqbgdn9yl0A6Xct+HevJ+C7eWDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847200;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MPTcW4Z9vo4Z7/XoesrWIOcgvVRF9TyWF+1Cfqk7Xng=;
	b=LDzx9AVZP8s/+ASmAZhhuVe63lT6IpvaG0lmIOP58IE9UMW/qAqZuvgm1g7n0OoCoMAP
	 6ycsLGx6rwwZA4iABIc1UeDFnII4eNGdWivYVXgjERSysnVPCzAgv/Qp2FwKSrGurXTdb
	 6OkeG7iPmIk7xfO89hzVvR/1+RjqJpT9r8mNQxVzDA8UL40AO8lj9m9+4+gAGJLcnx92h
	 2aWokO1J5u5VH7TqrDw5YMj8aHeGUSpkAKXS0SxzAv+uXayHEOMiF1ntWcR076TaVxZnr
	 N5ReNGc3xf8Dd+QY8M/0XJBw8pbtjkaGdmxsmyZFpVkAzpLYka/Gppr93FgZCrwyusw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gd1WoPMC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BE606A31C;
	Mon, 16 Nov 2026 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gd1WoPMC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794847199;
	b=Ko0blIUgbpIDckIuyKWlxrSy4hn1FKadJD0pFFV9KPZMQGZrmpddUyqbLsQ6BIyXyKVx
	 wusoJsxDo7QG3q3b/z1OuCUcxVoYKbGN6gwiRu9GucftIATZk7SBNRC0FAvEMXxVd/7SB
	 nJsb/qo7rEtdThyqbBRQhijnv+/yLmkJk47dxI2UKx3AeQWYtUVKjZJmdD8iEHKXw1AXt
	 WHFnlV8iDq6lzTIvfY8ZxhYuTZt4FFTgZyOaXDPzhh5j351I3PKrjqWKPr4EXG3wuUEPa
	 AOUvgmGW+sy7rwoRqqIhJBo9msCXJV4JOtCcrioS6WTLs3ZYm6Tcu0IGJNa3gc2EqEQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847199;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MPTcW4Z9vo4Z7/XoesrWIOcgvVRF9TyWF+1Cfqk7Xng=;
	b=kEYIitbjpXUc1iu2VJeYoxpIVoWrqFl+g/fE/cm0y45r28oO/+d0CPtGu/7/jWURhckf
	 l2hwCbHV514v41IOZ31jD5a00TY6uVBC9PO77leFBQTSfof+YSKundq7Qdz6LH8lOw+RV
	 XaybEvV0WKqkurDKP+4/7JXg+dHGpkpY3Twv/y00onLhgIoFKW/sb4/OzJBVXoWofjunk
	 HtPwyAX2hAwn5MwsHXN2XRhKmVgw36Kkg6Ww8ZEGNMVcKhMPyQVxTYfUlthcMngfGDwHJ
	 9+Fbvr6TF6T7aWJyuZ++/mEiMvJSOPo/VoUAKYtt/P/qPEU/NCiTUHPu2fGzJyAYXsw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5A45D1F000CA;
	Mon, 16 Nov 2026 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794847199;
	bh=MPTcW4Z9vo4Z7/XoesrWIOcgvVRF9TyWF+1Cfqk7Xng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gd1WoPMCWPLLTy6axzCbTiUrp8gf5uDKwUO7mWfZOy52LMpwwG+o57zdqFfbbGPRa
	 6sOwZN/huzrWfqJ1FU4ppfLEc+I+mpZuV4oyrColy0KZtckdIeFN7+3h2osVaSG5so
	 aag0TUBbMUVX2G3FXa0TZ14FC1gl9EjckLQtwtyYxLUjMPI1KjvE0gk+yUnbdVkCuK
	 weHdfERPkimq6D3wK6mYNsNxuJ8Zu+HghLAmGCvshqATpjB3x3mth+OdS8pZ56Qu/r
	 2M1c120cMhezOH1QGAka3pjALUxwkPpJkIJTNtXHFYfZmBDiSkX7eCgJVciIQQ3yuH
	 oVWJngVZjLuCw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DB7954A51E;
	Mon, 16 Nov 2026 16:39:58 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Nov 2026 16:39:54 +0000
Subject: [PATCH v4 02/12] iio: frequency: ad9910: round up FM gain scale
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-ad9910-backend-support-v4-2-fcf1ad364ed5@analog.com>
References: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
In-Reply-To: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794847197; l=1744;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=G3vGlTj0BTKaDzZ4Lm3Cx3xNScaDzjERpmIMz76p3fM=;
 b=GSaqdVOSuAVl7j4TvPugi/LuIchKI1Dl5DPs2/303nhlWA1MJL5JtxmLCAqK8n92XLHkfvbMH
 VLafIbN1bMaAqsOBepY3wRZ2UV2O3cbLi1KItETCO/wG/Fu//V7CthN
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

The parallel port frequency scale is set through the CFR2 FM gain field,
which selects a power of two multiplier. The requested scale is converted
into a ratio against the frequency tuning word LSB and then rounded up to
a power of two, so that the resulting scale is the smallest one that is
not below the requested value.

However, the ratio itself was computed with closest rounding, so when its
fractional part is below one half, it gets rounded down before
roundup_pow_of_two() is applied. For instance, a ratio of 1.3 becomes 1,
selecting a gain of 0 instead of 1, and the applied scale ends up smaller
than the requested one.

Use mul_u64_u64_div_u64_roundup() so that the ratio is rounded up as well.

Fixes: 3647f9fe3488 ("iio: frequency: ad9910: add basic parallel port support")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/ad9910.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index 8bc24d0b7442..680415b37b0d 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -1626,8 +1626,8 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 			if (val < 0 || val2 < 0)
 				return -EINVAL;
 
-			tmp64 = ad9910_rational_scale((u64)val * NANO + val2, BIT_ULL(32),
-						      (u64)st->data.sysclk_freq_hz * NANO);
+			tmp64 = mul_u64_u64_div_u64_roundup((u64)val * NANO + val2, BIT_ULL(32),
+							    (u64)st->data.sysclk_freq_hz * NANO);
 			tmp64 = roundup_pow_of_two(clamp(tmp64, 1ULL, BIT_ULL(15)));
 			tmp32 = FIELD_PREP(AD9910_CFR2_FM_GAIN_MSK, ilog2(tmp64));
 			return ad9910_reg32_update(st, AD9910_REG_CFR2,

-- 
2.43.0


