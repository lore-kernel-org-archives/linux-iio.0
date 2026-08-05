Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E44A0C
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785908128; cv=none; b=sh+DjIKdPlPKIQQPFTkLMIbfHXx6dfoW9StVi97qpE6FK0CCyzPDbA/oT5OJXwfPDU5yihC4C7C9kngc6twtVeb/i6We+eXYIiQCH1lIUTjKaGCdqfiODS60iN5Bm0XngMnfJ9oNp1b6tDNWG0WCS5uVUEsK+tHF1vn/dkZkXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785908128; c=relaxed/simple;
	bh=tpKX4/6jtyZxGgtiLI/SI+QmTqy1qaVqpcPo2dKFY7A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fxUso/5TBmc293EHxXqqSr54XSXDbQvDJjL0TnAITph01rpbNi6fd8/048ZtFaVMeCBvGFq+UWfxNzPZ1jDv70oL7jmWtwAQXI6XB6acOTz5JRzbbsTmKCFVK99Ufxso5tyoyGEfzld11saA8+XWZfgFNU7H/30E3Ez4IfkgytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpcA1oR2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpcA1oR2"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d01663d816so5469765ad.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 22:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785908126; x=1786512926; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wHjVLD0AcaQ6WvBpKZJ61p7P1mggpiUP9AhMb5W7tOo=;
        b=YpcA1oR2BGeFZE5fmks8+5BsZobKysk6Z4+hd9LLzX67sW2CHmvVsSBTLbwB+6fLo6
         skVCp+LC3QdRBUoivSnIejvadR8k2tBGZTXNiQ0BSS6Mc284e7pDIbKuysgvFSxEB5hF
         2jfM7U100FXzHruDd4hB+RrOHSdRJb5TwtBx+VSCslESa1rSb8eID6a+/I5S0Umm2VhQ
         yDhgnO/iAAoBHPYzzF+UU6omotQILWQXmXnYbJi+cjfipSIlRsz1oonXKohFSEjDYMFk
         x247nymPOYBdh+dGa6J5czcEoYdT680PMvWWfg124OsnINLKljzF+p+by0zS529gxMZ2
         Hy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785908126; x=1786512926;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wHjVLD0AcaQ6WvBpKZJ61p7P1mggpiUP9AhMb5W7tOo=;
        b=U1ZkT7yfX4TCXakfiXlB6scLKPW09Z0slBeseEYM0vn7qGTrV+AnCJOA+Vhq0QgkaK
         fZE0WyiVRYprPVEBNwx4ZuONZQLzXMsNz+pC3aoZhvAwmbPOFzaKeB0df6GRs2cVqn7Q
         CCjUsD8c6un4O+ZsxKtpHF7YrLGCHeU/3IQRGuhIVlcL5zRcuFnGoLsoqJXbjWxIo+7N
         yJE8yZbxureQ/daAbByLS5hixZ7NG8I7SqKWmGSLCnligcHwzkgLBB2ZWlLY32Axjxwf
         eMisywpw9gL+YA6gyhjvita7gsBLydQCJfuskm368NKGuRZmoLrjH+SP6M2CBMQMFbOZ
         Hc3g==
X-Gm-Message-State: AOJu0YxOu7BEgpsF5dmA4vL9E5ZNiz9Ks82zJPvuY65ayCtsHptFCFVI
	rSkVre3WHJuPLuB07NUubCcOMhfi9iH+QWw++4DEtmyAlMDMMrtnvaCv
X-Gm-Gg: AR+sD10vAA82T+TmS+/dhuNx8z4m2a3LReR7biviFGD+hrIdZu0K+e0E8VYFRoi71qN
	PRWEM/Lyd9JEbHfmSHBrWIUKiqeDSQigpCItWsQFkYw1aecyXF2U3XnLcOhdfn5hjQ0ryx7Yg2z
	kISXIA20hZfPG13HvLP89JMnUZQeBkzCCK+aMW6WQcgezgOQBt8LXPeck/B/Hv9iS8jEH3eBXkB
	MPmzhZ3AtcqPwVR9YdX+XZz6whtXdgtzPXayONfLQz+fRSEkJ28+nwMtbO8yMoEQ25Gb7EbAm4L
	0Q0UrZBjxkQpztpVaY5iLgLFoEwcDmqF0fMLw6Uky/ShjWgxUTd/Wy6l5Zkednk3aNRfAtVjyus
	wLyleQCip3s1dgY7iz0yVOaFYMgUEt3Lkl9GtIMTn/cGHczJnbH980OqyFGsGQx7ryQbgerCti+
	Px7TL+mZmpNai3SuY0RHEBS+F3tzNvSbljngcvLBigPvIEP0Y+dEEQ2UNqaqSHtTOMJvbhVBq1L
	naMpKdJ2QGKgWQ6iGyoUdS7nHtbZijAn2akMA0=
X-Received: by 2002:a17:903:2310:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2d0ca757773mr39862825ad.10.1785908126141;
        Tue, 04 Aug 2026 22:35:26 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4c0b1fsm14307245ad.64.2026.08.04.22.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:35:25 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v3 0/2] iio: adc: Add support for Texas Instruments
 ADS112C04
Date: Wed, 05 Aug 2026 13:38:19 +0800
Message-Id: <20260805-ti-ads112c04-driver-v3-0-49f436829e01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEvMcmoC/23NTQqDMBCG4atI1p2Sv5q0q96jdBHjqANVSyKhR
 bx7o1Bw4fL9YJ6ZWcRAGNmtmFnARJHGIYc6Fcx3bmgRqM7NJJclN1LDRODqKIT0XEMdKGGACg3
 aK9fGKs3y5TtgQ59NfTxzdxSnMXy3J0ms69+zh14SwEGbCzaoUVbG3tve0evsx56tXpI7Q4ljQ
 2bDuYqL0nrludgby7L8AGmTjrj6AAAA
X-Change-ID: 20260724-ti-ads112c04-driver-be7e89047834
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3838;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=tpKX4/6jtyZxGgtiLI/SI+QmTqy1qaVqpcPo2dKFY7A=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqcsxNlOomGP7A7aQxwZja9nIdrgBMQAww57c9j
 1D/SROaijaJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCanLMTQAKCRClg0K3CVbE
 gcNOB/9NRKMYHlH8Org+p1hFY1H1nKruaQfdtfZBGifVsNt7aFH3C1GSKftxzb9lL9lLjhKmr7E
 y1VZhBSnVxn9ib+Z6y5im+isEhlF0B3FgANgCsI6v68wi1OnnPD1AYauvee9O5J5/EiYE6M6TkP
 25DHIfgWWKXcElcCt4+fJaSJIvAUF2bwePj0dq4bMb6+J7aLPzmOv9STL0meLGCch5SJAizMKXq
 M03saOvdzUqolK+p7xIVPJH/2Tucrx69Nls4bkbRa2YmZ4fi+357vf91z9Gu8vfH2DdXhrCmBOa
 IVlq/eGMt4xjUt42CNT8gJUX1waT9yIQaN5bOoLjjQ+8Ry06
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

This patch series introduces support for the Texas Instruments ADS112C04
Analog-to-Digital Converters.

The ADS112C04 (16-bit) is precision, low-power, delta-sigma ADCs with
an I2C interface. They feature a flexible input multiplexer supporting
single-ended and differential measurements, a programmable gain amplifier,
and an internal voltage reference.

Note: While this chip shares similarities with the ADS112C14 (currently 
being upstreamed by David Lechner), the register maps and feature sets 
are sufficiently different to warrant a separate driver. However, the
DT bindings and channel parsing logic have been aligned with the
ADS112C14 conventions.

This initial submission provides a minimal feature set (single-shot 
conversions and basic DRDY interrupt) covering current use cases.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v3:
- dt-bindings: iio: adc: ti,ads112c04:
  - Resolved dt_binding_check errors by removing redundant $ref for
    standard unit suffixes and fixing YAML array syntax.
  - Added full hardware capability descriptions (excitation-channels,
    excitation-current-nanoamp, burn-out-current-nanoamp,
    reference-sources) as suggested by David Lechner.
  - Restricted the reg maximum to 11 and updated the regex to
    ^channel@[0-9a-b]$ to accurately reflect the 12 possible MUX
    combinations.

- iio: adc: ti-ads112c04:
  - Transitioned all I2C read/write wrappers to use SMBus APIs
    (i2c_smbus_read_byte_data, i2c_smbus_read_word_data, etc.) to
    gracefully handle I2C errors, NACKs, and Repeated Starts, addressing
    feedback from Joshua Crofts and Jonathan Cameron.
  - Added forward compatibility checks in probe() and parse_channels()
    using dev_err_probe() to return -EOPNOTSUPP for unimplemented DT
    properties.
  - Reverted devm_request_irq() flags to 0 to let the driver inherit the
    trigger type strictly from the DT, per Jonathan Cameron's advice.
  - Reduced the data wait timeout to 100ms, reflecting the chip's slowest
    data rate of 20 SPS.
  - Fixed #include alphabetical sorting, grouped <linux/iio/*> headers,
    and added missing headers.
  - Fixed variable declaration ordering (reverse xmas tree) and updated
    variable naming to vref_mV (SI unit exception).
  - Optimized GPIO reset logic using GPIOD_OUT_HIGH.
- Link to v2: https://lore.kernel.org/r/20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com

Changes in v2:
- Replaced `vref-supply` with `refp-supply` and `refn-supply` to accurately reflect hardware.
- Refactored the driver to dynamically parse channel configurations and routing from DT child nodes.
- Modernized the driver using kernel macros.
- Handled endianness elegantly.
- Added hardware reset fallback logic.
- Inherited IRQ trigger type from device tree instead of hardcoding.
- Fixed a bug where the MUX software cache could desync from hardware if the I2C write failed.
- Added strict return value checking for all I2C writes during probe.
- Updated the `i2c_device_id` array to use C99 named initializers.
- Link to v1: https://lore.kernel.org/r/20260728-ti-ads112c04-driver-v1-0-475efe4e2b78@gmail.com

---
Kyle Hsieh (2):
      dt-bindings: iio: adc: ti,ads112c04: Add binding for ADS112C04
      iio: adc: ti-ads112c04: Add support for TI ADS112C04

 .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 146 +++++++
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads112c04.c                     | 423 +++++++++++++++++++++
 4 files changed, 580 insertions(+)
---
base-commit: 4539944e515183668109bdf4d0c3d7d228383d88
change-id: 20260724-ti-ads112c04-driver-be7e89047834

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>

