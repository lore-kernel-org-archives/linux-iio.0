Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF82DE709
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738518; cv=none; b=qHEtNhXawQdq6z03f8RRlZqr1GG8t2QY2TbOvdRVJj01sdv96D5ZAfvwDQuBPSKCwT2ZmPWa8UTMQv+hMBw4eH6whvg1GGXDdCPJqyJio2oKjuHnL6v6/bFYvukVjhGfMpUuFKftIrq4/wJLY4bd4C08ZebcLrAgwnHI6HY5KsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738518; c=relaxed/simple;
	bh=MvllY5ZtAepd2o9C5tkQ/ey/kovbVY5Gr4Z0ciR/tdo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jbupejl+KwdNOiMui6MU6Qn8Nwkx/vZQH32nUsHr59yJMFqgxlpH/TffpJBHKIBZVJKgV9c6bMxgjl+KtmGaMiYz8i7MXwhMiktHhqtaDIGAibEF4crT1K0UHvDQBfjTdXvMWdArHO5ATq4O2m8fx9f0fTGL3akYlqCzgUAm4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz+LoX0V; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz+LoX0V"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b4520f6b32so9693673eec.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772738516; x=1773343316; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yVQsp4yjVr1S8WVqzluv3UyIwYDdzrxzgvj6D1S97jo=;
        b=Iz+LoX0VYM6E5d95hNPiMLn7cDxlwTMZjIKUR/BVo+dxjR3SuZaEgwKlcebIF79qZn
         r89QAdGdv1pMlmWYEpzELpCs24Ed0WzwHXQSR4x5gArNE91UF/6h4DMhztVbgG7Tpub0
         haGMGJ4JkK9caW4Pp2+mE3vXGvTAw9lXPF/ParSj6LPjdPLRrZzWGza2SLFinzfmstwf
         AAu2BGTNVAFt29mzIC/g/0HtvBnY6ewqK7v8nuI92rkDTrhEroMnB1mN3fwP2E1RDM2k
         zh1xLDbJ0Uc1+VLsw77SFelLk8BZM/rPGDaXOnorMtB31nbD/Dzd5C0533WwBukzc84m
         yhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772738516; x=1773343316;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVQsp4yjVr1S8WVqzluv3UyIwYDdzrxzgvj6D1S97jo=;
        b=WaLxAwtPyP90Bmsal08ee1nmSwn6fv5KtnPQIhJlNZG19F1kCB4+16Pxjjwaws5hYQ
         rXWqV3AVOgJmhGhiQKUTTxMvH7+GZi2Wmu26n0PbCphLDPqpWEYzERM7aay5o8uWQv7X
         UmMqNV/uxfOTWTbST4Rvwa9piLcteqMZfcAny9XfZjNhNbmF0+g/ylWNGw5lJ9tjOKqT
         8Qbmsi17kASTba8UiRw48EjRzXAAmedTF/ihn5EH6Vmb9C3NWdMKmbwsL/Jw4iIBNn78
         403qNGtiw9zMfrq7VZJt6AVw844YFwRhY+uCZz/iJP5epvFcHiNTrc5Uzh5idlAVRwJ5
         LL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZ3yf859dUjPZOS2DDF3+mim2o876UQ7raU4wEkQbm8yo+HRZovP2c3Zrwu3fZ5r/PMQgwa2ief0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9FXQBO4dXl5EU1dlPC4gTMFiRMXBL0IrzcY17HAm4iPPYN05y
	2DkGS2SRDwSNU/sbOnirBttSSB87DRM2JExLkME/w7eSngxyD1LWnUGQ
X-Gm-Gg: ATEYQzzFQszKsHe/qIWmv/k2WD60Jj+PtU7QIzcTC4lBtJ3IlS71x7X+p4gXX4PbXKx
	k/1BMBW3WcZl4sRcEGbr9LYJh2H08zvSJ4Hc4Dr8ue5A+DXBc5eLkTCpykJ5l+PaziAK3kjDbb/
	pmESaD6Af1DSAcQF9BDzRScSC5c8OPT3j8lnCz3TOlICuphdTm+djG6y4tQTKIjbRhuuWWkrMfk
	mCfEaJrh+xNQ2rNLHyPvPQlyowiZIEzBOIQ2xhRNPZYWnkZBQn0XYbBzPe9XdzZ0I6dwbVsNbW9
	zsjFoyEVH1MT5qVcs58LoKP7UOeNlwlmYXkBk1Ro5oD1UoUJ7vwznha4/m9sU8wULu1bD/jh69T
	625JScxShkVHGCcuUFBlHHbzma0KdgQjK7Dp+F0oUruiI78rfp03KVnIpu6h52iJm42L/8YSi9t
	NT7bp4diTVrvbcnM0vDYD9NAmz+0scfeLyUf94V/xW3Yzhmz2nV+oUUjLuQcCESg7oN34fRgq3Q
	ji5ADtSx06siIw=
X-Received: by 2002:a05:7300:dc8a:b0:2bd:fe33:dd8c with SMTP id 5a478bee46e88-2be4ab38704mr388100eec.19.1772738515706;
        Thu, 05 Mar 2026 11:21:55 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7788:d145:a740:ca06])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1281ff70sm10800980eec.14.2026.03.05.11.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:21:55 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 0/6] ti-ads7950: fix gpio handling and facelift
Date: Thu, 05 Mar 2026 11:21:51 -0800
Message-Id: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM/XqWkC/03MQQ6CMBCF4auYWTukFIvUlfcwLipMYSKlZtoQD
 eHuNq5c/i953waJhCnB5bCB0MqJ41KiOR6gn9wyEvJQGrTSrdJaYWZ0Qzpbo9C7nmb2uQzdwzR
 WudacoDxfQp7fP/V2L+0lBsyTkPuzals8q23VGNOprsYah8BZPlWOEp9TXK9jcDxXfQyw719ey
 7ciqgAAAA==
X-Change-ID: 20260220-ti-ads7950-facelift-ad8b5390a654
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-94184

The original reason for this series is to make sure ti_ads7950_get()
returns result in range [0, 1] or a negative error code to comply with
gpiolib requirement.

During review David noticed the fact that the function also clobbers
gpio state. Fixing that lead to adding cleanups using guard() and devm.

v3:

- Added "Fixes" tags
- Picked up reviewed-by tags for #1 and #2
- Dropped the conversion to "error" variables
- Avoid using scoped_guard (per David)
- directly return results of function calls at the end of function (David)
- Split spi_sync() error handling into a new patxch (Andy)
- Switch to using devm_regulator_get_enable_read_voltage() (David)

v2:

- style fixes in #1 (per David)
- fix to not clobber state (#2, new)
- #3 and #4 (new)

---
Dmitry Torokhov (6):
      iio: adc: ti-ads7950: normalize return value of gpio_get
      iio: adc: ti-ads7950: do not clobber gpio state in ti_ads7950_get()
      iio: adc: ti-ads7950: switch to using guard() notation
      iio: adc: ti-ads7950: simplify check for spi_setup() failures
      iio: adc: ti-ads7950: switch to using devm_regulator_get_enable_read_voltage()
      iio: adc: ti-ads7950: complete conversion to using managed resources

 drivers/iio/adc/ti-ads7950.c | 188 ++++++++++++++-----------------------------
 1 file changed, 59 insertions(+), 129 deletions(-)
---
base-commit: c025f6cf4209e1542ec2afebe49f42bbaf1a5c7b
change-id: 20260220-ti-ads7950-facelift-ad8b5390a654

Thanks.

-- 
Dmitry

