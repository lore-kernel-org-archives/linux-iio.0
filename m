Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BF260580
	for <linux-iio@vger.kernel.org>; Sat,  5 Sep 2026 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788587612; cv=none; b=gmJqun8uJ9LNB3krceJEMVMLlj/HQvVvigaPWK6tZJIIL4Dl2eRmfyJRw91pmR3newItsKWG41qhfBDxRLnnxWi7fbSgj7DvRro7xfdyCrUB90O4370MyYRoHvSBc+nj1nFCIqOeM3PzJmqyo/FCEA9keIS+APdeJLjXxKhhiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788587612; c=relaxed/simple;
	bh=GlvBmDe9HBgmOBC+ac7r0fb426/2Lt7xm9O3A4283o0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQ0CsX1SwgFW92TPk/PWAEiAcfMLQPJXKQGXv/TD4bqfoUg5HnjOo5fa8nOk7obIhTEO3IHzkFFsmcCNGiXzMkjhMBL0qIm0HGTcx9NSjjC0IoMG+EcNob0E/kPcbBv42oD6y7tbhssrR4j98F3VhQez07kyJ6kF0kaDIrpaMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkVmpa2m; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkVmpa2m"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ecf499af9so25413387b3.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 22:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788587610; x=1789192410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VWxHomrMj47FEZcQbKS6VuVqMA7sj5V/Mt3JaM2UCHs=;
        b=SkVmpa2mWw3yFAcmjKmKgU43/OsjiolsgG9u1Mk9XSZlBcxHP5h1bcckNLmFwmgzcY
         NaEub8a6vRso+0voqjt5llUo6oQh8Oe8aIGOwDRrdkUCT/80HhAEK75nmy1Ux2cDeJsx
         hq9p3iV0lR3ye+2p9MVKwc3Bae18ZDQ9Wo2klNcF5dyCtWEoc7aVcWiClkWWW9+7Oqeq
         WxjECqQ6cEYvILA09/Z9tAlvbO7fUI34UWc9DecBITapl44Ak2sbFdvyJWPKq7c9eROq
         9Jc0IAw7yeX+IKSTINQqCAg0v9XHnH+AD6BrQruzUbjepzg9kP6ywA5v0kyvwtv5/jvr
         SmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788587610; x=1789192410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VWxHomrMj47FEZcQbKS6VuVqMA7sj5V/Mt3JaM2UCHs=;
        b=pCjznBC+MjlFRVMD0kcuiDQ4IpllrYV704k8efR3FIZLOWWnALfFeC5sUhvjLqI+5A
         DXyINdouaH2Yx5o9sVn9E5LCEDt8l5NB4gtUz2By10KWFygJrb6W38ISbwLuuKyRo3Y1
         ehvfRwvxlgpZGuh958SFY6WdZdQ9qGmqWMqYFoGLgxZVCls9pPQ1K1vRZPV2bJBSaU6U
         LryRJsA2eUXNXcLE+mc9AI2me/dPdZKttttuyaWRRRNshvfK2YrrUJFHPmAhI5y0LLr4
         ITmSr/gTkAvBx33kddDw6MuEbyS8CajIwJ94BTsTQVtnpBYn1+a74T4sVhIJwh8GBecq
         xBgw==
X-Forwarded-Encrypted: i=1; AKwUvBz89KzVeYw3AHtDH+2OveuHuMc7D/8T8cKRgYCxn3xSU/koVXmR9vlZRjSigyBoV6aFDX6jw/WxcOE=@vger.kernel.org
X-Gm-Message-State: AFuF++maAUpZc9k8wYQEjMSFISz7TmXZ1nEtxr2JU+eGwsCVNZCf7L5j
	S8DwevBRLqQi7f0oZnA/TrcpjAp+0irOn/CABBgaZwGJLklz/SS4xnRm
X-Gm-Gg: AYBFou05dISv9nTYVFMdp3Yh09YS39gjOIhoMZ/cDc8hgpR+Kj/RgqdbNO9WuGfGW87
	ezdl/UJzkAP/wc0ZE69/6amG/ui+oPgOuKhz2maf96Swey5Xamzx1M2ubp3EA5uoO16vweAwjYO
	1q4+0i4JtxmaFwwKvf8WPsejJsx5oWuUgz9VT5WWkUsG/xIpXQwo/r7riyaVEtpHmz8AA3Bn15q
	cDNiy/tRkCpSlMaAwnXGZxSTDbc+fnTlp0XftFR1+yuHfISTVtFxAn10fvwHY+2i769kj9Ilg/H
	UoOrg+7lI0ce3V2hxKL8eW60747bWddgtrfBZc+ZpNPgrpP/IGkpTa0vGgsfE4BeadFig+3V2ms
	H0NvIhA5OXmJLLhQGDUYbHU3FkJ8bdWxY5peLuJi7BNpGxwkFiXWr2lbG7RrBa7U5ovg1knyZrO
	XvKZVra9LzLd75CJk9stRJU8QvcFav9aYo+ceeDkLyfLH1
X-Received: by 2002:a05:690c:660a:b0:7ff:87e1:34d1 with SMTP id 00721157ae682-87123717b32mr52875547b3.11.1788587610127;
        Fri, 04 Sep 2026 22:53:30 -0700 (PDT)
Received: from localhost ([2600:1700:5431:250::1e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87143ca6ddesm33717067b3.2.2026.09.04.22.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 22:53:29 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for AS7343 multi-spectral sensor
Date: Fri,  4 Sep 2026 22:53:24 -0700
Message-ID: <cover.1788586814.git.marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds initial support for the AMS AS7343 14-channel
multi-spectral sensor.

The sensor has 14 optical channels (11 visible + NIR + clear +
flicker) in total. This initial driver supports reading raw counts
from all 12 spectral channels (11 visible + NIR) via sysfs and basic
power management.

Not yet supported:
- Configurable integration time and gain
- Interrupt support
- Clear (VIS) channel and flicker detection

The driver uses `extend_name` to differentiate channels, exposing
files like in_intensity_F1_raw for channel F1, etc. via sysfs.

Patch 1 adds device tree bindings.
Patch 2 adds the driver.

Testing was performed on a Raspberry Pi 4.

Datasheet: [1]

Link: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf [1]

Chang Yu (2):
  dt-bindings: iio: light: add as7343
  iio: light: add AS7343 multi-spectral sensor driver

 .../bindings/iio/light/ams,as7343.yaml        |  46 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/light/Kconfig                     |  11 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/as7343.c                    | 309 ++++++++++++++++++
 5 files changed, 374 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
 create mode 100644 drivers/iio/light/as7343.c

-- 
2.55.0

