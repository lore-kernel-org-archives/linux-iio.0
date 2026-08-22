Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C063AD513
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385843; cv=none; b=sWAaizj+413k+CVjrxn38XwJH74GqA+I4dfdrsKBY3uGmG+Rp2f3f/mwM1fCOfQHMey56UKLDBJfc9iGNXxtqqH1NRST3bc1ZPtn0oPkWi5kjOczPVTlSdCe1g+5r0QxqpEzCi9Be5uYd2mEBrIqJejaW5Aw4+7pnqd5tu935Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385843; c=relaxed/simple;
	bh=HXABlvbovapo8X5ULjVoUp05rLGCvcH7Hwv2idfGruc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/aRQmHt58xrnVGsfzBvw1fRSqbcYBGE7rOL7MJY7TA2Mvq5HfWWe5m3oOF0HiEmMohKFwIIAfEjKnxigVi8I60j6CAw4W/DezsnMsjOsEHIFwzo1Fn+Guovh4a804sU0hPtsJj73J41Kfc78DNZwf4ZZP8lGv9SpB7f3QgbS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swppKRxE; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swppKRxE"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso3315120a12.0
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385834; x=1787990634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkSPzkNePAAObmivPyMjVU/afPEpN4pzFimu9a853YI=;
        b=swppKRxEEqp+CIRg3mpnphlJaXC/GA7R90pStQX09Sb3/roOxWtVAMhB74Lzxx5MpO
         ZROQnrFQS8rlLc58iRM1igOCnXEpLjSpII5fJrUVW2alB+GaNhpIyENgE1T9bj/I7mHw
         ZzQ2IosyJ/TfoMYR90jYHEjlB/06940y+hVeEGod8YSP7G78nx5xUtVpSIWywmZvi248
         1A/c+OCppNF3Qm/7qrpJ0PTqEf9XGYrI7EJ+yXdPII7CnCb4K7KW8mUQ5VzpWp/l60Pm
         oDWlCnnueMY+TL1poaF1ANjBNVoG7T5fU0SbKsQvUTxEMC/0TMkv4M4Ro6eUyWVidspq
         CDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385834; x=1787990634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QkSPzkNePAAObmivPyMjVU/afPEpN4pzFimu9a853YI=;
        b=TZ4i0BjflU+HRm9FBEUmknbODLpge4Pv9xc4WBOwPHA5bxF/UDandB0OTAqCj+7W8g
         N8dx7ms9wZiRYQui1LpALKCg1jAtaS8XYWhED8BV0gH6qHYn4/48ClukeAkU19zOH5u0
         rtqMi65aNDODE8mzrKyngkS6U/x+g8I5ALRqUbWktqSyN6TT3gcUhDbd2ncINeKhFTsW
         HjkSnHxazmuvQ5RtaY7hgjygledqF9FbhKCEufnFRjFh2U022pVahdaEuDY3mVJWn+2h
         YP7QHZdCsoNuk2AXKTXhccam3MbFUsVswZqaJvuaAfy77zEp+a4x2q59TFJcJgm4TYVY
         38ww==
X-Gm-Message-State: AFuF++kTVgO5UMebU0NEZjDLzEA211oHN19/ZQfYkf4w11sC3p8FoJvE
	N2nYNQVMHh1RjxPyTEmoqLhu3V7KL3Vsa4Lfl6qeZu3DVoD+HN/yESZqF5NDwRL2rpM=
X-Gm-Gg: AR+sD112BSe7VGwO/mJ4MMsxXSqmaKAqZxv6FLZSn+9ZTwMO4X1m/YmQlmA6tNSs0iI
	dmrpDp2PDXKaMY/EL1UH5orxw4zUUHnxMbxoZyOVeX90fU7r0UFmlnN+5LVR7WiI5T3fb+uP5j7
	YRPUdW69rGqKUVuF0oauIXKvwJdh1md+1muNek0VhDCBjV+LrbtbzpeABCLU8dJAz4dH4+X+FOf
	GQN8mYpOzKW5P64CTe10mbJ/SgnYyT0Cxdpgia0DJQ98n7GjDt5+nhvTHY+KnZh4j7w6DoFU+BH
	gezlD3vAAEKyQIMq//hh/QP6MvXS9m1l4ypeWEhsD3YfrveJryOs4BIjdhfejByrH5odmZQiV39
	PxSN1MFWYeLNdt5z4CaFf0HKX46vo5yMrD+truqPLVzNjl9P7Dpiu53gcnAK8fm4Ac72ASCVGQq
	54W/mNiom+Elgj0TDP0Eyzhg72GcIuHG+HBOvXTlSolNLjmawwbyu4bz1vrG9sYeGQs/GgpN/lw
	nDo5OdBUlnJA1az5iKVeCrI9jrJu8eYrUO/iJYHiy15Xyb/frVfa0KTDGNh6qCWPe5C4q3Ldg/n
	9t4zl2h0gwaLgXAQ3DFAVqJfgKIaiXFoVU1hcuFRD6TKlKxz2YIvW64VjNb+UCKf9bMp5Da9cfQ
	GePZA4Vp9RuXnzWIxJar+SnkH
X-Received: by 2002:a05:6402:274a:b0:6a1:f95b:8cef with SMTP id 4fb4d7f45d1cf-6a582b1476emr5003208a12.4.1787385834158;
        Sat, 22 Aug 2026 01:03:54 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:53 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:38 +0200
Subject: [PATCH 11/14] iio: temperature: tsys01: reorder headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-11-ee31b124be11@gmail.com>
References: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
In-Reply-To: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=1038;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=HXABlvbovapo8X5ULjVoUp05rLGCvcH7Hwv2idfGruc=;
 b=04+UHeRQpRlr8H9Ky1SDzlcXvYbOXoKXYev/VIETYOpZ46UsrrYLzZppUa7ucduFwnGw1LcWJ
 Fc12uxnHKBJBTRFg2MZyxBl+rq2TIDmWLucfGWjafUUGy/V2dCm3lay
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Sort the headers alphabetically and group the IIO headers and vendor
specific header separately.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/tsys01.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 28b3ce022ce7..14de67ee8be7 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -8,14 +8,16 @@
  *  http://www.meas-spec.com/downloads/TSYS01_Digital_Temperature_Sensor.pdf
  */
 
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/device.h>
-#include <linux/mutex.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/stat.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
 #include "../common/ms_sensors/ms_sensors_i2c.h"
 
 /* TSYS01 Commands */

-- 
2.55.0

