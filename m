Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131814;
	b=Jxwgh0p3tL3GRivILYdsLpDk8LEHv87hM5swwMyOKM4XEk+JbOzdRkekIQYGawF1Nvej
	 VSiiv0KdKqgAVb+0esoKvvwJkZrQieUUArfWQiRpKlSXzVsZB3koIsE4YQCqpHBAl3OWP
	 ihrtEhoSlvKouZJ/08WwQIy1gX8sv1gDnEPyYz1/bUbPMWXU9TgTnIL6AVtYyXfXCD1kI
	 5ivr5suV49vHl0tNCaH62T5mzGjgr+JoUjBdCgKha8zLm4zyZ+cOPD3YnLhBQ9bfRv3zy
	 KUVnqIQd3PAoaW0kTInsyGCTU8XMrf9DLIEC3AQ8klhPX8ZvDY/AkIvBA727HUkYNvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ugACOXCHmbMQ59e6XOW7QryfqNYQQNBqkuOYV89Woug=;
	b=rlA+bK/o+f4qTklAqxgpfZXlO9Z1C2kdv1hQw3ScBOXrpuwnPKncBWF3GclWmFEERKia
	 cv3CzhUqhfLCczsOnfL7atNwu7OQ2RMOLv0DDQ4YJgDoE5mlRJwdlkTC5irRZc30I1M7f
	 3dkVtj8cMtZnqxz7kXGsozfmphmhtGh4owdpy5NuPxmi0Tk18CI3gkhiJ+yo9OCatXD0q
	 zidlZEm3X3keT6HsBDYC28ZVNJKtp7WUZj27hcPuWDGCQ7EfleIEKBqoOsYW/n2z6JK+2
	 kHGwkWopzIRg/awkbjzNuevkog8m4wBMXOMrE84OwEFUrfFJpQ39W2mhbKTQyghFWwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYkyBMq+;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D32606D81C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 09:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10D32606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYkyBMq+
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c45551fa84eso1668366b.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 01:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794131812; x=1794736612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ugACOXCHmbMQ59e6XOW7QryfqNYQQNBqkuOYV89Woug=;
        b=GYkyBMq+6hTJRlLurayvRtFWq7BfTfJF1QfRO3MxS2NamxdMZ/inCuUjbY2WId5SFi
         xJk8YxMKzUk/2a6NpGDpAOB1lJ3cWsZNtXkDiLN2ciBgFXZxUlGcfBwIdjyX0xuJRbE9
         tDqTxXp0xJ1kOb2LT51BtjB4fQKs7QiAXIzAAYHLzIbIxLV6w2EPAaeyecmNXUQ+7ajM
         xaOb0h8qy6OKl4hVp1A2z2zFjrjoXtO6R3Z7l0MPC7K1uTAWSnnaPHM5isVd4wRU4ABq
         ZSwQBY4/NxAWtGVF/a3mt569V8rXGz3kOqkRmhlnW4HK8pLKNpUEn6NxrJACfHGddNlU
         BXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794131812; x=1794736612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ugACOXCHmbMQ59e6XOW7QryfqNYQQNBqkuOYV89Woug=;
        b=ANob/QXE3gsVr3gZULd2dMlos+lcctE8kYcZsVMGQz336ruZoLxElofFVjv38c0JP2
         pl8rAZGyMLrupIclOGuj5scFzkR73bAYG/GRuGvW12wfk79XgS8AX0EecQZRS768Z827
         BY/jreeHABDU3baiO2HP8MoIeBFcKAqU/vaLadg01NzyjZGiztQFisI3PGieyPBSczS5
         AfDiM1Phk5aOfN9Hujh9kzXjYPMO2I/miJ4jTikrIDnUXPuWroeGUhn+OdA/oLuZFgpm
         Z/W8Xp5kcbpkHg1b36+0sz6U8elclO2orgw+McwyHH7fCkKdpcjsh54AYv5kHhLxRsHo
         ji8A==
X-Forwarded-Encrypted: i=1; AKwUvBzSew6mu18HQrVgY+rYLYGT9SVOLgY6I8dPvaSTXoKo4o7/xDSw+DX+ys+yMfL8W+XhEKt2ICEDku0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cPmgy0JpsbPX4+VeNUda14JwM0QJIv0GVBMp7QOFtV4HKxM+r
	yXtjmj4kbOF8/S5Kb1LVIlfmiQThMJtcEdZ2Eq1uaufWefMjeA4GYVHl
X-Gm-Gg: AYBFou3Ojdx8LHUcn5PaPqhFx/wV7GV/VEPw3iI8JssR9XOwQKhJ6zy2kwu95xRSxYk
	2OOpcrYp1l7wm0rfDdmgVU2AGbdCrF66GDJoKz6Iu0/CH9uDQvsSOWXVtav21OHVqgliONJ7nWp
	9XZovncH7Y2xh3jEM3+ITZX+fZVcr6h8cve8P6+C5hlXWen2kq07f0o7dFO8TW53JNjacHUIjW3
	XCr9xGko17IYt/X3J0eT9ePo/6O1XCxfirTFwLv7do0qVJnyZVi9kfr+XSvGPNCgvrUPgE7agox
	FCMPF39WBck5sR5M99Nk0NAj5jEv2uY9l3LnF1zEOQsw8OPCrzCgiuMabG9Kee/PE1HtoKdjA9D
	u6hkTn4fxV1xqBKL26lgeXINBWKr2iPzVwX2F7pedhuS7YPHA2MUUKxoPvyVmrghIpxXDK33m7b
	7i5FNmxuW12WM/6BhTP3wWnH6Gcx0Qf+ejn/mL7Z/xRYd3iM8YxZRVruADuV34oy97fnEiGZmkb
	6WVZaMpicBZWStbltZAiOWM9IrtAh87TW2yCxe5HAGPuGsWA1jx8Yum13O3H62B6riSR3HaFj6B
	uDjJsWqR0NrFcWAOOUK7qP5mkx8e13jN+yLBWq27NYhAZdXtOovD6Yj+tTsxoCvkAZvZ/j5mhyJ
	deprk4amvMQ==
X-Received: by 2002:a17:907:2d0e:b0:c29:d31f:7d6a with SMTP id a640c23a62f3a-c4d6d7d7a0amr75803866b.35.1794131812255;
        Sun, 08 Nov 2026 01:56:52 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a9bc2e2sm48920866b.83.2026.11.08.01.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 01:56:51 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH v1 4/4] mfd: max8907: Add ADC cell
Date: Sun,  8 Nov 2026 11:56:34 +0200
Message-ID: <20261108095634.100517-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108095634.100517-1-clamor95@gmail.com>
References: <20261108095634.100517-1-clamor95@gmail.com>
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

Add the ADC cell name to the list of MAX8907 cells.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/max8907.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 86579729111ee..f6b584b002e02 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 
 static const struct mfd_cell max8907_cells[] = {
+	{ .name = "max8907-adc", },
 	{ .name = "max8907-leds", },
 	{ .name = "max8907-regulator", },
 	{ .name = "max8907-rtc", },
-- 
2.53.0

