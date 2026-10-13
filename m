Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB43C3F48
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900439; cv=none; b=of7okZ7NrdCUxgFb4pAZGl80I/u84jwwUH9Dn0KQCRDJ6FOJEBTiWYazKBdwti2I7o/aYgdJ+VK2CMR1eo9aNMI6jz0qh5wuTj2KMDHpxsEacgjxJvKCrQjieegoTDGRCpTEwO0BRpqs3Flz2ghdNo6z9Ct5qJ2ixuvVBCkK7ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900439; c=relaxed/simple;
	bh=/sq0nuwqB/pm3NU5zjPxVPeaJJlmDWE80dJE3nYd4g0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=INVrP2ZbphQXuqmomg9fFMKytWFDmtH9HxYae7SVzlLD/vdaTryVvi49flxD4dYQB9v/BfHcZSeWMO7ph8AHhlRg1xJMd4puSP7vo+qhNCDzKi1vFUkQHETh9IdiS4IYw3I4Mk6x/nHfhAZ3eaYgWMsLwmoTKpd3ccmGD8YdTkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w2KzdW2o; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2KzdW2o"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a16bc2278aso21472025e9.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791900436; x=1792505236; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=afbvFWPWi+JdvKTsjhtgFkolxmG5xvEkrb8KG7OzSYg=;
        b=w2KzdW2orTYOzkOCKGSavBT3L2DOhs4t3zV9WF41KySi4SaufExKui/BdRVkDoXzN6
         Xawf6u9iOnwixRFaVSLqSy8V/db1p7b9WV1th0Z2aR6NSMfsWtbIH4r+UPMVzDnv11a2
         eC9DA98DOkPGgDRg4sXruU27hCZHBASFfkwCf7P9iVnOryLCKgM46qiszeeqR6ODbG/P
         eETeAtV3pFufCjG9YqGDdAzntRYA3M8PYokmhp23WuqwX9u+U8h/yGRq5G/WUv8zvlOo
         XtgptM6oqp+AU/rCXk7TTu6nGXLrfmJDw0EMOeGmaFO2UmeMN/eddb80TnchQpuHioBd
         tOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900436; x=1792505236;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=afbvFWPWi+JdvKTsjhtgFkolxmG5xvEkrb8KG7OzSYg=;
        b=tdPp7MS1cuQ5vLHd2ME1qirMvu/Pr+X0Db+UU/RQxbHHduGiW1sOyd9xDSfSrlSfIh
         bdNJgbHjv4IeB3ZcDOHUQzqJry4YXA7m7DrXkl2JoxeeElRgX0uFeMTZp/Bg6VeiAgWC
         jR7uTFEUgHfqINY01mDmWlHmWvjkiVT2HOwFPzUVcUkagppJ16LbmR5QgDWlaVODwgk4
         swdOXwC/kPuUW8E0kwYHN/FisypVb5MP/fcbmxVcIPHS+F72KeftRJdj9QQIgUhcNp+t
         0ZI/b6BoeKuNjT/fPlo9nlZUICzvHoz6Hkia00b/3ZsLbMhTJt6FkYjHVB4VfhwQYyei
         G4KQ==
X-Gm-Message-State: AFq9FYK+VwDDQxWJnv3N0QOZASED6aP1nPMS2xgRTAtb85/DiWSlp6bH
	CMWjEF6KLECi3RfYo855MjwBsYyoqnRRTrL8A9MGi1DZS1T4fXGu0ulG0FyhAWUxqMw=
X-Gm-Gg: AYBFou0Ft1zs2/ZtUNN4RygNBOuj2QDDCxZT6GOPvHM1DyMpYcT+qGiLR7PJEmL9C28
	dwIfTWl+DXIiGTRxLl7D0g3QCou2/8SVkgbUjw6zmhBkmS1HOwzoRPZJqz2jEhOtc/0SGNgbkEh
	VmHe7iABFU1PkXq8qW9hWHKSxe5/rGtG3N2druwoKYo3cK8MFI4f+vqq2cFIYc3FX78bEhFxP8+
	y/FweOxUblvmuZflPdVafG/6ANHzRSImQJCD33671AKgjj2zryy4RsBv4HAmcwsLznwlsTDFhw4
	jE0+mPjeORcSk2PoEX73r8qNTJV/OfHUTw1II47VRFndaofK7AQqCXCHjJTRnfDPi/AyuNIho8a
	AeL6TjsRv9jEPnJTPlWl9H8ZOc0DI2TskCDk8yIg1lIijq3Ln1IiknGN1wBT4mGFbFpX3t1c4Dp
	c98uRmhvLrkUiBJOaSEtWDj8YQh1Y1EINOF31CbTuw+AmLQT4CWc3O66SR+ejUjnx66TbO0zx3K
	3vvjZmoTGip4lf5sFaW582MrF7dvA==
X-Received: by 2002:a05:600d:8499:20b0:4a1:9687:bbd9 with SMTP id 5b1f17b1804b1-4a19687be3dmr135971285e9.35.1791900435476;
        Tue, 13 Oct 2026 07:07:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bead84esm364625305e9.13.2026.10.13.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:07:15 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/3] iio: adc: add support for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
Date: Tue, 13 Oct 2026 16:07:10 +0200
Message-Id: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA87zmoC/43OTQ6CMBQE4KuQrn2mfwi48h7GRVtaeUYoaZFgC
 He34EZXupxk8s3MJNqANpJjNpNgR4zouxTELiOmUd3VAtYpE075gVZcwOB7NBDbcsopIHpo1SS
 kZAWo2gCnlS1LmgvhNElGH6zDafPPl3eOD32zZljRtdFgHHx4bgdGtvb+3RoZUJCsllox7Yxkp
 zt2Kvi9D1eyjo38k5O/OJ64StHUtQV3ufnilmV5AfrDGwAsAQAA
X-Change-ID: 20260923-topic-sm8x50-iio-max34417-adc-209e880533fb
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marius Cristea <marius.cristea@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4451;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/sq0nuwqB/pm3NU5zjPxVPeaJJlmDWE80dJE3nYd4g0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqzjsQwjxwlTUV84lG3p5q68886D0CfxeTzoFhipJQ
 a7bamPeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCas47EAAKCRB33NvayMhJ0TyYD/
 9053lDFl/t8V3EWswcKgvdeSOgpJ1BDSBQSzU76eSOQ7KIGxZAiXfL65KpGFy4eTchCEpS2Bcy6fs7
 xXsx9FmPBWOrvkqcWjDCZV6bW8FKf4uzfG8yti53gwRAZfgKGIvw4KDvMyoXBypP+T/rQFsY3tT7Zs
 I811d+MveJgkf2X4MAlzkGk0kQTvPkNHgIxkIFV4M9ep5UHB2c4fMv0LZXNWvTSlcnx2Tw/SheOU77
 5vbw+6KMhr9di0X3pHfw8ethUs0BU/W55uZp5z1asSjhfw2d01Dcb9gaXtqRGucho7m1UOX2I/zEal
 MjgOYRdOQo+dYm83BLvOIfnTDoRb1gKKjE8FnV79asZKauh9qMseJFgVtHNlOGU1Nz0PgqMGNG+lmj
 6GJ8n4FncUeJ61CVyP+vw8IKCHbqAqgmP8bVebcZkqsWz2yDzR77tyWqHaKGcPpS8nTA7DAz5o11Cv
 hpqQQQg2ae/2yIlRgA5nLASGlF9iWyYpFX7csLCpOnE7qEE140IPmAKzWM3tOsP+eHx7KomfG4rtpJ
 2AYwqe/ka2PnftaXPAc1O9rZa622BiPY+NKKaeL0plSde/TclgDAv8ewlqk5AIteBJJogTUK2YwZGM
 C08Tf7LboSBW5sdDasgTVfMGDAWZYUSLXa83EVqETvDzaobELBc8su/7j70A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The MAX34417 is a specialized current and voltage monitor used to
determine power consumption of portable systems. The driver supports
getting the channels voltage, average power and accumulated average
power and energy over an I2C/SMBUS serial interface.

The MAX34417 datasheet only specified on how to calculate the
accumulated average power, but with the Sample Per Second rate
we can easily get accumulated Energy in mJ.

By default the IIO driver only supports single-shot Voltage
and Power sensing, but the accumulation can be enabled by
enabling the Energy IIO channel which then enables the
Continuous Accumulation Mode.

The counter is common to all channels, so when reading a single
channel we will copy all accumulators to registers, so in order
to permit reading individual channels we must accumulate the
other channels in the driver when Continuous Accumulation Mode
is enabled.

The get_unaligned_be56() helper is added since we effectly
get an unaligned 56bit value from the HW.

While Maxim originally provided an HWMON driver for this
IC, using IIO makes much more sense because it provides
much more flexibility to support getting the power values
and will make it easier to support trigger to dump all
channels in a single shot and then support the Bulk Update
feature to update all MAX34417 on the same bus via the
trigger mechanism.

The v3 implementation has been completely revised since
v1/v2 to better match the capabilities of the MAX34417 and
allow getting accumulated Energy plus provide single
channel read without loosing other channels accumulations.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Implement Continuous Accumulate Mode and default to single-shot mode
- Fix includes
- Better define Rsense and default rsensd in driver & bindings
- Define all read length and offsets
- Define the SPS bits
- Fix comments first letters
- Fix max register
- Add ENERGY channel with shared enable for Continuous Accumulate Mode
- By default reset the MAX34417 counters for each readout to do a single-shot measure
- Handle zero counter
- Add get_unaligned_be56
- Use get_unaligned_* macros
- Better handle the DT properties and report errors
- Reset the MAX34417 at the end of probe
- Link to v2: https://patch.msgid.link/20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org

Changes in v2:
- switch to shunt-resistor-micro-ohms no more required
- removed gpio.h from example
- Fixed max34417->MAX34417 in Kconfig and comments
- Added missing includes and remove unneeded
- Fixed typos in comments
- Switched to fsleep()
- Better aligned max34417_read_power declararation
- Handled 0 acc_count
- Switched to GENMASK_ULL() for 32bits systems
- Added missing empty lines
- Moved the input correction into a helper
- Set default input correction for all channels
- Switched to dev_err_probe() to return from probe
- Switched to device_for_each_child_node_scoped()
- Handled invalid shunt-resistor-micro-ohms value
- Link to v1: https://patch.msgid.link/20260923-topic-sm8x50-iio-max34417-adc-v1-0-41d4ba1bfc41@linaro.org

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Marius Cristea (1):
      unaligned: introduce be56 unaligned accessors

Neil Armstrong (2):
      dt-bindings: iio: add: document the MAX34417 Four-Channel High Dynamic Range Power Accumulator
      iio: adc: add driver for the MAX34417 Four-Channel High Dynamic Range Power Accumulator

 .../bindings/iio/adc/maxim,max34417.yaml           | 100 +++
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/max34417.c                         | 777 +++++++++++++++++++++
 include/linux/unaligned.h                          |  27 +
 5 files changed, 916 insertions(+)
---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20260923-topic-sm8x50-iio-max34417-adc-209e880533fb

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

