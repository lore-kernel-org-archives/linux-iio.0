Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8E31D367
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178143; cv=none; b=AhBV/3CZITjvfebicbzdBOvQO1NP5WjGtz6tWl0bKhR2tUsM6k/qOqXJhlznf+slKeQ3PlKvdkp/5AJ/tKcUZBQqX2A2hTZ7km8ZvVB7w3xa4Ei7DUrD4DPvKXTXg3x5TW6kDAz/U2RdkZWvLjTlLTdyXRkW4LzFecdh3v7FzYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178143; c=relaxed/simple;
	bh=mEMioOeArUOwcyQK+i4sJyvWP61cn0vi1h5orQSnP4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHDPFsFAUl2tFnoXQbciBpFoMSycb4AXn30LijEDgLh5rvPrl5LutwDdiIYCMQqgcf3dprl9eGS7X/1/QGnrnU2ULHckSI9boJ/uS9upQkOoxYnSILR3gOUFV/KJ14dmnuHBi6JWcA6pHxo13vcwHTMlHXnmWZjxnCo4TXrjKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/40ZXe+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/40ZXe+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceed7018c8so19967385ad.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785178141; x=1785782941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EfiZ6IJDTy0yxZ7QXla7+zVZ2XbqWwJrwRsgjOcldtw=;
        b=A/40ZXe+eFcIqvswvH2BrKgoy3Hhl8aqfxUzq1nU5uOduD3HfwCGgKWjNsyls5IXw7
         06nJ5MOyqUzEHomeiAFQYr7VdkZcYNYPLftu1LwwsmBckAMUd/AKudPPqsBtioOYNmSl
         pYBagWABzVzBbQP0K6CIZnuAXSfb1R6W4Kyl/fjoour6ZuxC6SPZXe8QZ+I6Nz73tadW
         Mpxh1a0CHRDDYvh86Uv8D4fyEf7Jd3yYKWn9oHPx/zn0WPAnvlRnFl/tqpNEKQp+HVKZ
         aBU/xgvopk7ho6VEFdkDcDR0BSovJ4XzbZMKLAfjZ9jCKYXGd0YFBjMMZWsu1KsfZsYA
         MWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178141; x=1785782941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfiZ6IJDTy0yxZ7QXla7+zVZ2XbqWwJrwRsgjOcldtw=;
        b=VWQV3eXb7RfAcXklZnrnkUS3miYtCqtK9MlrE/MhOWY/mXhIeLiqjd1PABe+gDu7sl
         o6ho/Pg6Rc9lR57rqPCqPKAB7UJeGC3PGmHEgt57dgmthR6QoM5xhfEo//hLaX+3o2Pq
         LseLaWH7BocM2E391g6zeZKPlOLa9fxK+Y0ZXtgpIKVgFd4uosBmQ1FTfaW0A+V8MyAm
         qQCPUqskETQP6Z1RnGXbuXdGyADWZqECw4vLZMkvOHB8zWzTkA1FWJX8yyA7zYhaQpq5
         hraHDi8LtWC0Qyet0S2kbG8ENkdIh5M4hGrCJaN32QB5xqniK9SxSnHhRjDYpbSoiamX
         222Q==
X-Forwarded-Encrypted: i=1; AHgh+RoSDqDhFy03OtCEWZ7NrKau2dYD5+lrvhlVn71vmcGM/Ed0URxHZvXMn+ABYmcLMgWdwvSHN2/qXFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQUx6Tg79a+kmW1zbsUR4SgPQYezM2jJft9YIy4CQBppN3JoVh
	BzgiVJcoT2J9lActhlJ53iIwGgflBs2p5jDiT3CG3QZF2j5HLKikA1ps
X-Gm-Gg: AR+sD13597cdz9DUcaD1UyUUagZfu72JUOsDZ1ltpaAjlEV+TAWHAh6RpF3sH67vQ0P
	5Q2qwHiwn4alWez8XeqMbMymq9KUXZewJbtx4cSzKPsfh/WiF2nohBO4C26YSjo/3HLndKCe0bI
	99sgFLE2361+FH6xVpL0DffxDilEJrQA1mAaP/M6cS8jo37eV3kBgYbD8GJkqxhkeQw04cMuTYW
	PI8dnlA6rw1Wssp378L5EKyUaNjlNwaH3PKMkYTZtl4H9KdKZaZaU4K4EaV41Uw9UyXtStQ5oBw
	kfVk/x8otE4Dk/KMMzUr1LT9ETqmHDxg+K6xEOzScxjPeRRdKTRoP4SW2zKplgeiRUMUwOWMuQh
	uAoCfdS6F8ql9eBFegoeC811/RH7k6gLIJpqLl8BjY9HfGnzsEyzYv0MeX+aJDfgj6cDePr/kKN
	KCR7LKiu8=
X-Received: by 2002:a17:903:26cf:b0:2ca:4cfd:a6df with SMTP id d9443c01a7336-2cfde8887dbmr93495685ad.43.1785178140809;
        Mon, 27 Jul 2026 11:49:00 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7d7b87sm40186245ad.57.2026.07.27.11.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:49:00 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <jic23@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Brian Masney <masneyb@onstation.org>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 0/9] iio: fix write_raw() return values and remove pm helpers
Date: Tue, 28 Jul 2026 03:47:37 +0900
Message-ID: <20260727184755.2055414-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series fixes write_raw() return values and removes pm runtime
helpers in iio drivers, as Jonathan suggested when reviewing the
original iio patch [1].

Patches 1-2 fix write_raw() in isl29028 and tsl2583 to always return
zero on success. write_raw() returns the value of
pm_runtime_put_autosuspend(), which is 1 if the device is already
runtime suspended. In that case write() on the sysfs attribute returns
1 instead of the number of bytes written.

Patches 3-7 remove the pm runtime helpers in isl29028, tsl2583,
vcnl4035, vcnl4000 and rcar-gyroadc. Each helper just calls
pm_runtime_resume_and_get() or pm_runtime_put_autosuspend() depending
on its bool argument and adds no value.

Patches 8-9 are the remaining conditional return cleanups from the
original patch, generated by the Coccinelle script.

[1] https://lore.kernel.org/all/20260723184538.3888637-16-ekffu200098@gmail.com/

---

Sang-Heon Jeon (9):
  iio: light: isl29028: return zero in write_raw() on success
  iio: light: tsl2583: return zero in write_raw() on success
  iio: light: isl29028: remove isl29028_set_pm_runtime_busy() helper
  iio: light: tsl2583: remove tsl2583_set_pm_runtime_busy() helper
  iio: light: vcnl4035: remove vcnl4035_set_pm_runtime_state() helper
  iio: light: vcnl4000: remove vcnl4000_set_pm_runtime_state() helper
  iio: adc: rcar-gyroadc: remove rcar_gyroadc_set_power() helper
  iio: light: tsl2583: remove conditional return with no effect
  iio: magnetometer: ak8974: remove conditional return with no effect

 drivers/iio/adc/rcar-gyroadc.c    | 14 ++------------
 drivers/iio/light/isl29028.c      | 22 ++++++---------------
 drivers/iio/light/tsl2583.c       | 32 ++++++++++---------------------
 drivers/iio/light/vcnl4000.c      | 14 ++------------
 drivers/iio/light/vcnl4035.c      | 18 ++++-------------
 drivers/iio/magnetometer/ak8974.c |  6 +-----
 6 files changed, 25 insertions(+), 81 deletions(-)

-- 
2.43.0

