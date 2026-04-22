Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E8397E89
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880760; cv=none; b=aPbfwPqfoMI+ZPX9ZX42Cp51vDhrGeajnX5G7PCvpVIzzKr16NxGwU17e4pmlKCIkwD0C+G2ONN+6iBp9iODR59ZPUUeWMVm9NfmRmt3irNFU4BQyG4EjtJCrAW9gA2I+3HfZHEOacOvffrYnnyPeZIYWItSIzCCJ4sxmUHnfjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880760; c=relaxed/simple;
	bh=oSwSjRcqFgmUDNciLfbR3xEQk2X154orQ4R79xVy2bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VvVU3PQ+3/P4QocWchNzMcz/vsWfU5S/ZQlaZs0wemKjsJc9c1G3CQBwUfgRO5O2RkbNWX6RiBM6ggTHn0D3xVzkXJlw0UKOUDCwzL2E7nI/jyOTkAV7Kux/vfKV0/zn22R1HyhZdZ4d9riNJSeFY70odWlRqqHq2Jm1AT8tgws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWo4IRsy; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWo4IRsy"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so2013933a12.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776880758; x=1777485558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hzVO1meE1c/JGoIEI9CESvSlvQaIMvGuuQhtTpxCv40=;
        b=lWo4IRsyCJKInuqAxJxGrDUOZ3h9AS6V8NnuG/98YaJ6uSciaDLhkfjINcP/4avGiu
         18NX4HY9MDrCoVWz79HpaIV3pWJeOVdB6LRcUNaRBf6f74muZsvNCr70PioXITHA8mzC
         q2Bjh95BhXSp3UCxQeIqb1W+COoj8OrKUuKCVkqFYpqmepZ/g5CicpY3P9CNZ9naAGn9
         QnXGbBqs8vha0RTCMjr9u1HyvXSDTBzamona2U70Lz22Qm691UzA7bSTPBqvGf+nnzCJ
         gjTlJS973NBiNMaz+3+KTxW1VrHCWAncQeyVGQ9FKji2kSYDSqMXAtSztuzwTuUnCtDv
         NirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776880758; x=1777485558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzVO1meE1c/JGoIEI9CESvSlvQaIMvGuuQhtTpxCv40=;
        b=Y4KqVzHTEVhShASY+BeujK/Bk1EqzTzI5BZi+ji/0UpdBjcg2dYjCQOeU7mKNty23m
         J8CFwVes6LqJiXQfggWb1YYi1ZKr191slnQThYPU1F8AH3P9jLiA7APGtqCR2LkcajZs
         pM5ZLqzmAeM/f4p8SuIIpXLq7DiFG0OTP5J5WztKi1UoB/f/6ou3GKgQDZYyRLZBqdXj
         Vt7wV5XHDGcEDyblEsqXW8z4trLHdVmnF3DxbCgS8OZhrMyNGxlKeb5FV+LiyjMOy9q/
         EzAUTvIDeJe8rLiEYs6O9baP7oixlWvYiaHRnV5WEB6/+hdol0tr7JYy6JXmB17gD3lq
         Yajg==
X-Forwarded-Encrypted: i=1; AFNElJ/m+fhwbVR/OwTROStMDKoGVc+3q3/1JtIUMSK+zuG2rUthISS66GrWmXC/SlNi+mVja4F1E/GTlWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7a04UgmWj7NWP+C0ecjZHvRQr45hGvEXWbMDFAUAH+x2nC3M4
	MdZVB/+3OWxraoaQ3OFGqsLxUrFwfi4PFo9Nin28oiU+nztCB4WPG1r1
X-Gm-Gg: AeBDievYUv+mGshsTgz5QQ1Ss43CCmrDYOaKETuD5B4lzTm461IVxHg78wYhn3pnSKE
	42Drx/deoP75YO+IJ/XBozRJVVBCmfl/QXzZo8zu5CC5+vAMo6oiSvUI1JX/elkRmflDKt4dmJm
	H1JU9XwN3iIFGkOMbPvF57Je08Ak7nFZSCHjVhFMS8c4ZM7kkGBVfUxSu2QFmZ3QbAESjUjbx8f
	B2nqB1XLFgO4hwM7R/MgHV7yUPeRZUUH1UFSNg3Y6VUjYjSxrqPTvWgz7rHUOPRtE9OMnId+hX0
	Au3OOyjrpy1RoIeZ4+lTDl8BFTGjyn6ZrmNvaO6GK0odSepH33AdXQJ/mnxqXVt8jm1pAGeyq2l
	zVYepm7KQkmqFb1Eapv9dGKAwzU5Ua44GRpwmM2O2+tvO/neKF0y9NUF8epySCDgRKkzkFpGwMS
	DL2WJisbzAM0u6Mjbmv+KXcrjAf5yQ9h6OGvxHY2qRZ/Df+DnXJwVgpL4k3k+Ck9K7271Mvm8Yc
	PBy+Dq5sipBlHndWqvpIFkSiAZhXBTFnfh3ay0TLltN2cwmk/g=
X-Received: by 2002:a05:6a20:7350:b0:3a2:bd1d:d68c with SMTP id adf61e73a8af0-3a2bd1dd849mr15278903637.50.1776880758180;
        Wed, 22 Apr 2026 10:59:18 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:48f3:f940:b423:53fc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f9cacasm15174361a12.8.2026.04.22.10.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:59:17 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] iio: adc: hx711: add HX710B support
Date: Wed, 22 Apr 2026 23:29:07 +0530
Message-ID: <20260422175910.1258579-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the HX710B ADC, a variant of the HX711 with the same
GPIO interface but a different channel and gain model.

The first patch updates the devicetree binding to add the
`avia,hx710b` compatible, document the variant-specific behavior, and
add chip-specific properties for supplies, the RATE pin, and an allOf
constraint for HX710B nodes.
The second patch refactors the driver with per-chip configuration and
keeps the existing HX711 behavior unchanged.
The third patch adds HX710B support using that infrastructure, with
pulse counts stored in chan->address, a dedicated fixed_gain flag, and
the differential channel descriptor for the HX710B input.

Tested on PocketBeagle2 with an HX710B breakout module. The device
probed successfully, both channels returned stable raw readings, and
alternating reads confirmed channel switching between the differential
input and the DVDD-AVDD supply monitor path.

Build-tested with:
- make -s W=1 drivers/iio/adc/hx711.o
- pahole -C hx711_chip_info drivers/iio/adc/hx711.o

pahole reports hx711_chip_info as 40 bytes with no internal holes. The
remaining 7 bytes are tail padding from 8-byte alignment.

Changes in v3:
- See individual patch changelogs for full details.
- dt-bindings: remove vref-supply wording; drop repeated
  clock-frequency default text; restore example node name; remove the
  extra HX710B example
- driver: split the hx711_chip_info refactor from the HX710B support
  patch; fix signedness; update channel_set only after successful
  channel switching; keep HX710B scale based on the documented fixed
  gain of 128; add direct ARRAY_SIZE/types includes; use pahole to
  verify and improve hx711_chip_info field ordering
- Reworked Kconfig text to use "HX711 and compatible ADCs" and list
  supported AVIA ADCs one per line.
- Restored/updated driver header and module description wording while
  keeping the bitbanging context.

Changes in v2:
- See individual patch changelogs for full details.
- dt-bindings: add dvdd-supply, vsup-supply, rate-gpios; allOf if/then
  for HX710B; fix clock-frequency description; remove dead vendor URL;
  clarify AVDD as voltage reference on both chips
- driver: fix pulse count bug ({25,26}->{1,2}); move counts to
  chan->address; add fixed_gain flag; add .differential/.channel2;
  remove NULL check; drop reset_channel; pass iio_chan_spec * directly

Piyush Patle (3):
  dt-bindings: iio: adc: avia-hx711: add avia,hx710b compatible
  iio: adc: hx711: refactor to per-chip hx711_chip_info structure
  iio: adc: hx711: add support for HX710B

 .../bindings/iio/adc/avia-hx711.yaml          |  50 +++-
 drivers/iio/adc/Kconfig                       |   8 +-
 drivers/iio/adc/hx711.c                       | 216 ++++++++++++++----
 3 files changed, 221 insertions(+), 53 deletions(-)

-- 
2.43.0
