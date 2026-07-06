Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52639412282
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336981; cv=none; b=o4Og3zMnzr2mVaZbowdAt/4QdKmoE6Usds2Hna/1a2I6nLcbcTgsOvjX5Xsje6YH55m/ogl6+MgnVd8WU/Q4onfJS0PybGG/t82mIEDpd4FxQdOKzj28Kxfe8zT/qdzaDILC/KIIbICjSfefwG5llimYTS76JE83P1kceUJxrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336981; c=relaxed/simple;
	bh=87hbVnXcE3DZaZ6AbsxViVySopHn5hjdVRGnKNx+RIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcX4c6DKZzMBvt6caCpfB++vSGp6wKj5Gzfnj6LCyArJPdTh+DJec7UjgOkZTRz/JdsMul3yI1EgdyReEgxJdPGph1PcK3cedS4fUcESpn+woSS4ACQgQIDM2QRHpPDW8ShtxVyXeoj1VfgYbVtKXQdbcfoW2par2I3y3fjCgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWmEIUqd; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWmEIUqd"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb17c2564so2693409e87.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 04:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783336976; x=1783941776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QWnEVjCCSAv4bGwbGyMt/3GycHgQiVf+iVKz8UzBssE=;
        b=cWmEIUqdlUjsFhf54RHjlrdnfHhNyj57EcGPioX0PkL6M0ovkUijMojoewagGCYFLc
         RVLrGDQTg4oJBJDjOADL1hG9AZMilKu7ZKZj4SmTby8LqgsWYY8TX3CxfBvPsILSHria
         dJTMetnkgtNnnutYy/V0X6mMMU8Xqg3Tovq+N25kR2yaH6dZphAw2KxXK7b+pjmNBpW4
         x9VK7ftRR6D9+Pjv8QBJEgS/F5Y5M0cYLqXMpyrGw9yik/DBVwotI82GZiKFNX18G6/8
         cVGFb7kIQr2SPsR3R+PABMA0q/OonSZ23GPRFCUaKY8uSXAPqhOom/+L/AXPTkY134l+
         rgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336976; x=1783941776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QWnEVjCCSAv4bGwbGyMt/3GycHgQiVf+iVKz8UzBssE=;
        b=gtyzECWFpopdqLQobW466KgOXDMfO+5CEiIAwLq+bb23qyirZVkQQBNmhoRPXBAIux
         IYKyAeBgOLl03UcTX2BVxuGwsA44N8tcjfSAYSsPt+EnaA070EaJMWqUlNlCsLseAQsf
         81S6rOUaMdo9n/yy0q5tnG7/CpR5OFYHv6WMJnr94Fbny3d9rStgxukvK5hT7D4QyJxG
         2iS/jh6ZpeNHHLwZiZIjJU1ti+ykrygRNJBnbH6Ugv0I4Ny7WslQBFg0x6thRs2npcKK
         FCJ3aCWShgkNkwPmPrZYwyp04AyEl/L4rwR53i8UtrShHl5DA5yVfLQ1/kHM3vnDQvEp
         NtVQ==
X-Gm-Message-State: AOJu0YzzkB3VCCZcwOrNDp2UVHaYWtSadq+Ttj8/fnqiDQxtTX3wNcQF
	hBF1nREL33+j1lv/feyjfvAz5zfM1wVB21N8vu+LfOd4wjm2at0IuRxutJDWCqEIyqFLoQ==
X-Gm-Gg: AfdE7clfWAE//6wPfpNAci7Nwiz4GcYYfqJYZQ5REqhQ+BA1oeT5OxNZZidw9W74yL+
	e8WXfmM9JkBjyfjHGBZDrDujE7okETgc45qNO+Vi+qUl5JA4Ehs8M8WAkq4EJdQTUoLGxcBeH2O
	kGMTChftRjZmnBP+dsCBd+Txd1DTWpnv74f2eER26G82i7YRZ0tvNftm2bVDaX+03IlDOBFxmV+
	BueFC0AHhvMoY1mdiJvvD3ALI8ED1+tlzk7bNi7cjZnxfwF0q3nny4IUegxyiwNZSocT6FM6uJx
	ZvZh+gnIjeQfbKzwpR3lfxb88W+oLUoEB3aLJOJXF5C1Wa+op2C716oAfGN27uMsIxkrHBZAii/
	ffINFaowInTet4XHmo1vDudKB70ByhxixHY6T5+rThWVO60/448OCY2k1v1/mLDOpcqPKHc04Cz
	ooDg+x63oZVb2GrmRXIGqtzUDl61+htiHoRqEcwVItdxveLQ==
X-Received: by 2002:a05:6512:1085:b0:5aa:123d:b755 with SMTP id 2adb3069b0e04-5aed5090a73mr1983472e87.28.1783336975912;
        Mon, 06 Jul 2026 04:22:55 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c3a22sm2739145e87.72.2026.07.06.04.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:22:55 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v6 0/3] iio: health: add MAX86150 ECG and PPG biosensor driver
Date: Mon,  6 Jul 2026 14:22:51 +0300
Message-ID: <20260706112254.1262002-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623140730.12574-1-shofiqtest@gmail.com>
References: <20260623140730.12574-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX86150 (Analog Devices / Maxim) is an integrated biosensor
combining two photoplethysmography (PPG) channels (Red LED and IR LED)
and one electrocardiogram (ECG) channel. Samples are buffered in a
32-entry hardware FIFO with a configurable almost-full interrupt.

This series adds a DT binding schema, an IIO triggered-buffer driver,
and a MAINTAINERS entry.

Changes in v6:
- dt-bindings: remove "SoC" from description (Jonathan Cameron)
- dt-bindings: spell out PPG and ECG acronyms in full before
  abbreviating them (Jonathan Cameron)
- dt-bindings: remove the I2C 400 kHz sentence from description;
  keep FIFO/interrupt mention (Jonathan Cameron)
- dt-bindings: simplify interrupt description to FIFO almost-full only

Changes in v5:
- dt-bindings: remove avdd-supply from required[] (Krzysztof Kozlowski)
- dt-bindings: rename leds-supply to vled-supply (Krzysztof Kozlowski)
- dt-bindings: remove literal block scalar from interrupts description
  (Krzysztof Kozlowski)
- dt-bindings: use IRQ_TYPE_LEVEL_LOW in example (Sashiko AI review)

Changes in v4:
- driver: fix buffer overflow: buf[4] -> buf[6] for full sample
- driver: use iio_device_claim_direct() for raw reads
- driver: add OVF_COUNTER FIFO-full detection
- driver: fix active_scan_mask channel packing
- driver: remove IRQF_ONESHOT (threaded IRQ already implies it)
- driver: add set_trigger_state callback
- driver: use IIO_CPU endianness for timestamp
- driver: use devm for powerdown on remove
- driver: enable regulator before first access
- driver: use devm action for iio_trigger_put

Md Shofiqul Islam (3):
  dt-bindings: iio: health: add adi,max86150
  iio: health: add MAX86150 ECG and PPG biosensor driver
  MAINTAINERS: add entry for MAX86150 IIO health driver

 .../bindings/iio/health/adi,max86150.yaml     |  70 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/health/Kconfig                    |  23 +
 drivers/iio/health/Makefile                   |   1 +
 drivers/iio/health/max86150.c                 | 725 ++++++++++++++++++
 5 files changed, 826 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
 create mode 100644 drivers/iio/health/max86150.c

-- 
2.51.1

