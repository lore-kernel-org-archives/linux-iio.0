Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446457;
	b=yYOpLhzpyRkZKpMl4OVbKmjPXTQtjQi+VaqAE7adKjMFEap/UpeeaK5K0iqy+q7Bna8n
	 lDgQm3G5DvxfRfIn+EGfS8qUrovHDn2oT5NdX1neiGltTcbaQqQmW6iLjJCkimyetmgpS
	 xikPcqm9NpzQ7B3+M5OwXn0+Ia4WDsY+SYA+4wOf2fFP024jyOWxK/8zhfG2uCCvUlFQd
	 W8ydygnX+5PJbls5Hp2nNdDRC9pWS39NyN42BC6euUCukJ8Wj4oJQJjfvAoNe1rHElu/s
	 zjwrR4yNI8wkGaqXgswQ17Z1MdTbg+xCumE6KCQEmcMWlrY+RgqptsTO7xr0XFmsRWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LrQqNvxu/j1cHnx9Lcyw23sony0Jj3XqLz3lYlPUdFQ=;
	b=mf4VqK9ZpBRPmd2AUab7AMSTyalZ7xA98R84mVgqZHg3J9uTFgQzVh8Ffxh9YQLLOWAF
	 uMOz16yUzyL4I0F0MZLAToUP+b7+dJTfizWo+aajbYxtvpdwYu/Kt/qHfQ3moycvHiWxf
	 H80HElx6k/bB6udWu4nFrc9Vi+H/pdUhssho+msgMebDxl4v+ZeFURCccnIP/6mY3C5WL
	 mQCyhJkIbPMFi66XFArS8uOmDQpYvFLEPMcrvwRJDxJiJCDp4HIILETb8/LoR1fHxUxqf
	 d/ITGuA6eeQwF1vwIc3CXRL2N4FAHvFem0HmTUVa9T6v6eCheUa4hPqaGP6dRRFG/Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EPqUHYLo;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F414606A327
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 15:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F414606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EPqUHYLo
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6ba1e22ff4dso3806592a12.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446456; x=1796051256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LrQqNvxu/j1cHnx9Lcyw23sony0Jj3XqLz3lYlPUdFQ=;
        b=EPqUHYLo+3zB60AG4ZmvSvS4PSvmm+KHS9uXrJd0s6uPr9B2Hpk1VdCgVuvcXvxzAd
         DoXVOKzvYRXVHugk7MDe2ZoWCKuV+M3+rahOrLMtDuOmYKebrCh9UReTGHxXdTWdRDUz
         828iB4GDtT2Krpgh+0D8R/N7wpVooHNmXDgX6ujKscBDiYqa6vbywVj12qLWIHGOjXSP
         R3elBqY2PN+Hk78FRgH4g1Irmra90YL+CdzF5OOb9Zi1Myn5msN2gcghX8Ls4mPZL+XM
         RsiQpFUFnEliQhpw+CI8x0exFeoMT+OZU27N07TgIBkQbtzbSqgPLK8AGX0zCt6U+JCR
         JUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446456; x=1796051256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrQqNvxu/j1cHnx9Lcyw23sony0Jj3XqLz3lYlPUdFQ=;
        b=K8+7MYL8pOsgJ9LV58n8raPxW4sH8TdcY4uuu6jd/NLs9Ez2fPOEWCpT23pYds10Zg
         cwXCcqEkE5ykr2XACRam/++yGWSo2clYRS0NbT9zm28aYFMII3vlLeD1gOng13WVL0PE
         2YGEh6/YN4ezBgEHF2i7kdA/BKauiiq8pBFyiPMVXmj0qNYEcK+kDIkE+GuLJC6MyAFK
         uVr5larEKiSFXWXUuqMO8Zc1wLcraSgXDhSLCpx/4N1ylocHGAK/a6NbMBt+tBswoZKZ
         Uvgkm6w0oa3EOb7jM/Oh3OXDNhTr/q2UJYw55YnMo1t/eg4tQeSKohg8Accg4DXB4zCV
         cfMg==
X-Forwarded-Encrypted: i=1; AL+hErEDlai/TD7i+XLHK9jpghzn7wFTfxli32+Ay7xQwhl8d8mOcHEPglj72FoNYpY9lOn2Wvy6Z5Yzj54=@vger.kernel.org
X-Gm-Message-State: APuU4Z86fxQpd9fPt55nxadB+8LfS3XOy3LIMuJ87fW6eFfXjP3JPq9X
	rIg/MDhBo54SfQN8C+9WmuvA1lMfZwGJR+pTtY9taQkprV4tF9u24UJs
X-Gm-Gg: AZFdTZe2QNPFHZIvWBvBu/Lkz7vWWRAPAJHUzida05IeZsl4v3kYJQgEcxq1ftctZ/J
	ojkIadCzOzLZi0SmUpEAuNF4YpO8z+TMLGyE/B4uInJSy/FloTsXO4aKnf/Bg0FBzQ+zCbJ2Pih
	QO76LWwT/wCFc4n23IzXlLQkVwuKe6zVBr3B1wI0muOghMbxkpTQso6YRHdq9F+YgXXv4NNf8f1
	Uf8aNEnepVFQJtLfvVcLpkuW8I63jIKBnLwu400I8XVAW8Fkwk0TRWZqZXw9mk07yLuCpMqR7tR
	dOknBSz7jHVuwR0ik0Hqq6W6V8qBExmNkIrOVQBjfNqHwQOTaO1FSZ5Do8THwPDZXmh9fVxWQ1W
	bmHppELux6cibLG+qNmSBvwyQwnHiLlq44aXKngGtGzP8nRMYITSx0+7uKgSkYV7ajlXSpiiBfH
	VrOaBbzKTbVxCO3CIWOBdtvkzwjdkdREGQb4tnVOPebLVoiLAWemhEayc3Qdhd/kC4MCThb3oe5
	7WeIz/hY8Z9/iXI8b1PUeSTyiNtqwzVFllKDI8t910RixY8O+MYgjwzZZ/IAzEC9olcx9wkcjXa
	WExb6YW2Qz31i/cOIkFK6ncepIKWaievAyG19WNK694+XcG+wWptCNx2URMsAPNgLzASIvTp/N/
	6T04u9jlQtg==
X-Received: by 2002:a05:6402:4416:b0:6ba:b24b:a25 with SMTP id 4fb4d7f45d1cf-6bab24b0fc3mr2248751a12.7.1795446455855;
        Mon, 23 Nov 2026 07:07:35 -0800 (PST)
Received: from xeon ([188.163.112.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fc020sm5446279a12.25.2026.11.23.07.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:07:35 -0800 (PST)
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
Subject: [PATCH v3 0/4] iio: adc: Add support for MAX8907 ADC cell
Date: Mon, 23 Nov 2026 17:07:21 +0200
Message-ID: <20261123150725.212836-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The MAX8907 PMIC has a dedicated ADC cell, which provides 8 ADC channels
with information about different parts of the power system, including the
battery, charger/plug, jack and thermal readings.

This patchset has 2 dependencies:

- patch 1 of the series requires this patch
  ("regulator: dt-bindings: maxim,max8907: Convert to DT schema")
  https://lore.kernel.org/lkml/20261027114634.79706-2-clamor95@gmail.com/

- patch 4 of the series requires this patch
  ("leds: Add driver for MAX8907 LED cell")
  https://lore.kernel.org/lkml/20261027115006.86032-1-clamor95@gmail.com/
  Or to be sspecific, part that adds max8907-leds to max8907_cells

---
Changes in v2:
- remove unused register fields
- add prefixes to used register bits and macros
- default reference values indexed off the enum
- swap data array to __be16
- set bulk read size with sizeof
- return directly last regmap_update_bits in the max8907_adc_init()
- added comment for iio_device_set_parent()
- MAX8907_MASK_RST_CFG_INT_REF_EN > MAX8907_MASK_INT_REF_EN
- dropped kernel.h

Changes in v3:
- explicitly assign values to channel naming enum
- add missing headers
- loosen regmap_read_poll_timeout() loop
- rename module description
---

Svyatoslav Ryhel (4):
  regulator: dt-bindings: maxim,max8907: Document io-channel-cells
    property
  mfd: max8907: Add ADC client support
  iio: adc: Add support for MAX8907 ADC cell
  mfd: max8907: Add ADC cell

 .../bindings/regulator/maxim,max8907.yaml     |   3 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max8907-adc.c                 | 181 ++++++++++++++++++
 drivers/mfd/max8907.c                         |  75 ++++++++
 include/linux/mfd/max8907.h                   |  53 +++++
 6 files changed, 323 insertions(+)
 create mode 100644 drivers/iio/adc/max8907-adc.c

-- 
2.53.0

