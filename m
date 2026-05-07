Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D9A283FDC
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187047; cv=none; b=BdgxMOrbay4kbk09ibwzeHmsQoeevXtC/MjSyR7cINe4BvC0LUH1b3DrdZfBdgF8gDgT+5FabzNf7MlAhR5uKyDDXNXWdjyFVPCN1Hsj9mf7ICztUln2hcQRiw3yM/Ped+4yC6uqYtr8HdK+ZpY/dxZOnKZyWish4yl/CwanUMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187047; c=relaxed/simple;
	bh=laYspjwNdik0wTpw0SMM5VASlnIv1utg5JkDc2Xvo4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YAItWDmO9aomTDrZw4P6+4svjwCmlzxLRZdu3hm63VPY9l6scYiGoQ3SSabfIFHYXvYIAWJAWMZqLEgVx2qmg2SGlVtpE/vC7ZjhNN8lMprYdqTwBfyUSluhb2sJxGolC7fdROXxrQ6uUduiTX8NF/j2t5Qj57FAwkpp4lo3238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pw7tvB3l; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw7tvB3l"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-444826c16ffso1190744f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778187044; x=1778791844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OnuO/zosxDfRrEJIngyG6XeRQW3GT6C0GQiewkPFchM=;
        b=Pw7tvB3l/xg1b6lA/T+RK3OIpwuYLoabXxuw7eTzPIJ4wTSmKEzz2cCaBNRDOcGESn
         gJl4NdwmbxicSQRKLbZzrmaRPVXW7CxswU15uB8wjtFMTmZnzBewPO0UCvwaLjc46UwQ
         4Zfj5kUOF9+0fZ+WI+dXSIWC0v57vke/ugUzEggG8QoUw3oOyl/y7gAVN0aCenTQu/ws
         Stz31u4owSXw7Fx0EE+f2B6gdFn90HOmu6Rqb2dNU9g1Wh3Pb9HCvzm6qfh/gcN3xtIX
         /nuW3GtUCayJ/8OCAZRi1LH8AuS8YeIrImo2jLSENL78WS0mm9wkXS5vvff2kvLjKdkx
         zlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778187044; x=1778791844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnuO/zosxDfRrEJIngyG6XeRQW3GT6C0GQiewkPFchM=;
        b=E3G4D79RsEwgcyBsHIqW7UjbFQA4b0kkk0w+QOJCChmcSoC6rnUstTWtOmOvLixwWo
         R1QR9u4oYUbvHTq+7AiESZepjLQ8FxI8tBqcRHXvkpC5UmYtW9d+xtaSRPJA5nHjpmB1
         Snu/VIDKHItri4TtBtL5mNut91dQA3rmkFpU56DhxwGpV+tKjbf5t9Yfc0BWli8FJm69
         9N0RJ+yTuobsLlMO3DaWd1T8pSAQMcQKcrg8iU/ii3TaugOD+w4EkbJYJGAjnzJkzcZr
         bXMVxOHmeCU+oloANwQ41QRsVA2hcA2D7tYfxk480IpiXyPGdVioyUuwFVWvNzMT23vj
         NQQg==
X-Gm-Message-State: AOJu0YyDvXHBRXPPxKaA+sDuZdM9itZq+EQ1jjMeUNRguW51n4TkPKj8
	iBwX6taqblxtUVTf9vfewy77tB0FGTk57SP3xVrOn9oUt/kZQQGPPedB
X-Gm-Gg: Acq92OHTQWJluowcEU72YXE9IkmW28uMI6JdJNiu/Uj8NQEnH+slffxjK/XEi7pj1Dx
	jE63fSBiaSmT5pFCRkpbR36S3mOP8kAbFnDHzcQh5i9PYb3BWoXQkayTttLLEnW6WLcYVDwG+zm
	QP3HDBFkUXCyxurNSWg41vn1h5u7gwuE1D1t/H+aiHaakQb9u3qnengs6OUmNjJCaS+gwSRtNqz
	tTv0f1Gxu19j20SxJ/iohGFBpA1qf1K6hRbhD5/mn5ilKa9BEbT6fBeeU5LgkAOmABU5zI5kqhQ
	20SIrc+hBz7xxt7Tzc7ji3hiDfp52CD8zbCygqNV7nOFwh1NK+ZdEJhVNTVpCVm5XwnDnPE6ZNP
	cfL1dqF6HrPR1nkWR4M1kUGTJhutEe/PDhkmhyR7kcWqFqVI85Ajm6uJ03nxhIsJB1dKodiDP86
	aMqjJgiRZjl6AdUsnlMT9eyV8/ukrrfVaBs2dGA+jgv9LvhrqWxb+Z8HBp89NYA0eGEYVIfkVND
	AKT5n2LWFYi5S1e00k=
X-Received: by 2002:a5d:64c5:0:b0:43d:70de:1c70 with SMTP id ffacd0b85a97d-4515d5c54cbmr14522135f8f.32.1778187043449;
        Thu, 07 May 2026 13:50:43 -0700 (PDT)
Received: from ai-node.taila4f726.ts.net (89-139-15-25.bb.netvision.net.il. [89.139.15.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454175f59a5sm1401635f8f.32.2026.05.07.13.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:50:42 -0700 (PDT)
From: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Subject: [PATCH v2 0/2] iio: magnetometer: add MEMSIC MMC5983MA driver
Date: Thu,  7 May 2026 20:50:30 +0000
Message-ID: <20260507205033.951990-1-vlad.kulikov.c@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an IIO driver for the MEMSIC MMC5983MA 3-axis magnetometer over
I2C. The driver provides raw magnetic field readings with
per-measurement SET/RESET offset cancellation, giving 18-bit output
with a full-scale range of +/-8 Gauss.

Tested on a Raspberry Pi 2B with the sensor on I2C-1 at 0x30.

The initial driver implements the validated I2C single-measurement path.
Other chip features are left for future work:

- SPI transport: the binding describes SPI wiring, but driver support is
  left for follow-up validation of the SPI command and SET/RESET
  sequencing.
- Temperature channel: left until the temperature output behavior is
  better validated.
- Continuous measurement mode and Auto SET/RESET: left until the
  interaction between CMM, TM_M, Meas_M_Done, and SET/RESET sequencing
  is better understood.
- Saturation/self-test bits and BW/decimation tuning: not exposed until
  their behavior can be described reliably through stable IIO ABI.

The driver uses a conservative 500 us post-SET/RESET delay before
starting the following measurement. The datasheet describes a 500 ns
SET/RESET coil pulse, but testing showed that a longer software delay is
needed before taking the next measurement.

Changes since v1:
- DT binding:
  - added SPI bus support, interrupts, and vddio-supply
  - made vdd-supply required
  - switched to unevaluatedProperties with spi-peripheral-props ref
- Driver:
  - replaced scoped_guard() with guard(mutex) in a case block
  - added datasheet page references for timing values
  - changed product ID mismatch from probe failure to dev_info()
  - hardcoded the IIO device name
  - added trailing commas
  - added local struct device and regmap pointers in mmc5983_init()
- MAINTAINERS:
  - split binding and driver F: entries across the relevant patches

Thank you Jonathan for the review and quick response.

Vladislav Kulikov (2):
  dt-bindings: iio: magnetometer: add MEMSIC MMC5983MA
  iio: magnetometer: add driver for MEMSIC MMC5983MA

 .../iio/magnetometer/memsic,mmc5983.yaml      |  65 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  11 +
 drivers/iio/magnetometer/Makefile             |   1 +
 drivers/iio/magnetometer/mmc5983.c            | 351 ++++++++++++++++++
 5 files changed, 435 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
 create mode 100644 drivers/iio/magnetometer/mmc5983.c


base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
-- 
2.43.0

