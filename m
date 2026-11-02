Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630955;
	b=T84ujWE3u70krUSoGGWm1OstLthYCCDOdNNJjDj/C1vEFAqryml+YbMYAsIR7+zhTMb/
	 kc40DBlxzozavm3Nktc0TIBtpfHwQOI0quQH1TDncfXN/LM/pFSQFNLj7hu6DoA8VvzlI
	 A/X3HG0D3I1n2KlnGeHPZU7+Wwc8sGb56Yaw+K8qMn+657iQdNQm6PtO1ilhiP23pdUom
	 53vHh0rCSHXGY4v6z0YNjQE1Pr8mdHCbcgV0dH1cRkJfkmIAeIyup3aAzL6wOi59YHMh2
	 sp5jjUp7DUqB73AqUuEnq/kyq2x8nuEvYyiR+CfcSoSpyyI98Z01BGfZOCyb/xRJ37A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=0qUp81D/2Ci0HUHkZPw66TOq85Lgn8fgQoyIUETqHdI=;
	b=1/U/pj7atLxzSib1l+8Xmm2Gglj4mRB3vbSCVm7YqeakiG8FLa1vlrX/CNZvGccWU3Ge
	 3KB18pfg7ye9hBja5l78OGzIig5ukW/cIXlA0rdxrETa1hKoZneTN/RXZRv0eGp/wzqEk
	 Cc5i7NBXLD+rHAJtF2pwItrpOoXmTh4j/aBLLWgpUk40bZGN0ZdGvzalGIZbRlQUdQLTm
	 2/2ByUyRYhRXWePAZrpmreD41m7+zGjM/SjnbjLHKQaXTwGpUwICZQ/Lsd4LgK8l8SnSJ
	 TEMnqgi4wgwk5kalFBaxgJmPCXPcIF3HCheHDPBUqcsYR/AVIDcEnqBipC6Zfdp+8kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hyXgvT9R;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE2606A91E
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 14:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53EE2606A91E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hyXgvT9R
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so14170675e9.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 06:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793630954; x=1794235754; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0qUp81D/2Ci0HUHkZPw66TOq85Lgn8fgQoyIUETqHdI=;
        b=hyXgvT9Ra57UmHv1LWPVx6d11ZdCUUrZGkiHQEtM+lNQNR+3jew2yiCqK3QH8JpLWN
         SBYBxK/QCcdXR/qWV7k5W6i8bXaF4oH30hq+xv2wKjCQ8moRJJCPCuCOdLqkAp83saOU
         ctdKQ95u/D4LodRDbK7qBJ7ZmUL7a4BrDbEyOf4wn5roPO7CuAiKbdYhkGFj+R/kZvd9
         puliQdCzx+iErkpdKK6aNxGEXHrllYVH/jsPAqkvc9ZlLDGCPXr5Aw3vaNpHKy4WQbZa
         nXUwKiXGge2PqQMFeAJVqyX/5j5YrGMzxVg1t2xCVJBKMh49T/IDg5e/G5dRrGamIwPk
         22yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630954; x=1794235754;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0qUp81D/2Ci0HUHkZPw66TOq85Lgn8fgQoyIUETqHdI=;
        b=cgX+1fZHIVGnSEZ3na21PECA+6Z3rWp0y3oC0P1ZOPmYoL2kmxqNU5RRQ4IsfAdRGV
         2O2pw/MueC+h2GJT2eFU0FIlPqEV4Dx/0F5fYaZZqDBfh0K0xRYSHo7VA5Hdwi2HZ7Fp
         P1CaUYrxx77OVXb758l2NTo65nxNLP0xV5H7/Jvo2lNBnfewe2+gGqW3HeH6iNR3UW6X
         rosVJNpWXhUS8cG45zDfofEQRD/uAq+uNWUeWizTkZHgAbk1Du4KgBhs1exwVt+/pB5w
         9bfMNRHaw6mZS1whLhJv/gvhtFP3dQrlGrBHQ6+TNH3F2aVQgy4Zq9OVeICwz0eVxRuc
         dcyw==
X-Gm-Message-State: AFq9FYLDVKhyQEcGXEpFaC/PKb+PslhDvBxvMLGzAyngXGmQNS7JKI75
	03thrQfY4Ck/y2b4SUEJ99EYW7ZMScpZ5bqzBUishtRIDow3E6S8dcdGcZ0Nw5uixSw=
X-Gm-Gg: AYBFou2EMiNwat/Lralj8A5Eqm8NO3RbqGVRU3wMEKjbdzHUfMXS58u+vOEimiPhHgt
	Jhh/i2p59pnYv7g77KZS2OGlMp9qiyScg9LQvLi55I9+f8j5aJ+s7sNCzuhp0TXJHGpvvsCT+av
	T0x+4Va8lpSOX9NU5B9GOu5+p3nW/sa3QFoIR11XJFqz2AF7hj42M9EXI3Qvt4IwrNkGnHCkA9h
	I5gtCDdWx57BBEKwOlfYEdUYqQXeFc/nWodzR7ZgGb6E2IRk+6V1E/dDAv+UCbvfDF3EeV60IZQ
	agsgWTGYSTZBYF923HvsLFiRLT+TcieIVnTSA7T7rhsVZMrX/SOVCGBHNKCB8kEvJP9i/u+7im7
	5jM8wZsOsr3o6QOuUAeXnn2Ch6mYWmZLoutwGuDhYOyT0Rd7epgmcBnq0Exa/HRLbqfl3NurtcO
	jdpfBXUZUPMucKxQC56uy77YEGunj+5zjdfQDZ1Qi5RrCz4GJwr0Zi7s0Kc2bKZIBN6E0ofu3/2
	tXfDssVVJBZrWpufCJQu7nlvyEEE8FKrvMOkgdGw11c13q2ingg4iWRSUC/m03L8ZO7nkl4YEQm
	CbAwBdTSFxhdb9VXsMnIHna3dhnJ33g/j86NnJWxw8ANRXS9Po8=
X-Received: by 2002:a05:600c:e547:10b0:4ad:5e09:ae43 with SMTP id 5b1f17b1804b1-4ad5e09ae61mr100166455e9.29.1793630953516;
        Mon, 02 Nov 2026 06:49:13 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm447287005e9.3.2026.11.02.06.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:49:13 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 0/3] iio: adc: add support for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
Date: Mon, 02 Nov 2026 15:49:03 +0100
Message-Id: <20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN+i6GoC/43PQWrDMBAF0KsErasijcaJlVXvUbKQ5VEypbGC5
 BiX4LtXSqGkZOEuP3zen7mJTIkpi/3mJhJNnDkOJTQvG+FPbjiS5L5kAQq2yoKRY7ywl/nczo2
 SzFGe3WwQ9U663ktQltpWNcaEThTjkijwfPffDz85X7sP8mNFa+PEeYzp637ApGvvv1uTlkqi7
 rFzugse9dsnDy7F15iOoo5N8MjhGgeFs06VLu0gNP6JM7+cVnr1OlO43mwVOkIHYJ84fOCgXeO
 wcuVVFwyRVeYPtyzLNzfepX3KAQAA
X-Change-ID: 20260923-topic-sm8x50-iio-max34417-adc-209e880533fb
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux@analog.com, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6416;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6jaJPoTGUqrFyROlTBDlWU3tE0Y8ZPvq2MUTpZFqPk4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBq6KLmjwwnX/WWUJfNGu8V5y/j2BDi/bEowI2Puoqv
 0kyKipyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCauii5gAKCRB33NvayMhJ0QnED/
 4xBlLDicDGu2mvg4XKvsrgwqPhS54tZTnleRQKXLkvZoNN5iRyYq9YkfPnr2Zoo6diRW1SZE8cABby
 GO7fgHiXzU/IFLnlYD6qatrjFQKBM2srs9NWIHdzqmGiV/MTcIYkHeRzvLg9JurZeOgOF/aFl4Mho4
 Ai/zmVmCbogObPri/o25/HHT6m57ugte5DreusGZeWASA8c6H72hRsoo+4GQcddExo0cP3c8JwCynt
 ZsGW4DIUtXu9m5zAWlXdRtcHyM4cK+9N9Qr55cIST/vOGSNPMNuXi1qSs5QRTEtq3adLxyaoYsG27A
 k88A4Dde+Lcq7bWBZ24v+wDQx1wtSTdbPKE4w9SJ9C/6IO2m3GNx8It2JxgZTOF7wjnegofW0uT8QS
 PZmHj0kZJCp1jnJhA2VNZM+rzog5NtXeR/XaYZxweM6B07v34abQNTKteE4b8AC5o5kcX721a9Dgyq
 FojBvE0bOGyYvbKqrl1Gg9e1MpP0KVN1Ox/PlRo5mBrnPV6+vNJ4V4Q+i0Yfwt8g1vZzssx3roQAFp
 FJbLc/wfu9gux5hMCF93PE+XQh2ALK66mCjTcHzDxSl8pWNsyOIIb/Uv+vNCSWrusrylp1nBT6bU4r
 pwuLlrm4mLVfroT7PK08GYqq3cY+3yIJEEywOQYvfCQpSEtFB0cH+vN8sTKg==
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

While Analog Devices originally provided an HWMON driver for this
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
Changes in v5:
- Collected review tags
- Fixed patch 2 commit message
- Added sysfs.h include
- Finished all struct max34417_data with .
- Added explicit MAX34417_CONTROL_REG: to is_volatile callback
- Added local *map to all functions, shortening regmap calls
- Explicited the 1ms UPDATE delay for manual mode
- Simplified max34417_check_ovf logic
- Simplified acc_count == 0 logic
- Used iio_val_s64_decompose
- Used regmap_update_bits to compine regmap clear and set
- Added switch instead of if/else for IIO_CHAN_INFO_SCALE
- Changed max34417_calc_input_correction comment and return type
- Switch to rsense_uOhm
- Return -ECHRNG for invalide channel count
- Link to v4: https://patch.msgid.link/20261028-topic-sm8x50-iio-max34417-adc-v4-0-d4baaf3ee903@linaro.org

Changes in v4:
- Fix bindings with Conor review on v2
 - Rename to Analog Devices and "adi" prefix
 - Move reg before #*-cells
 - Remove "label: true"
 - Make supplies required
 - Update DT example
- Rebase on linux-next
- Fix RSENSE defines
- Drop dev from max34417_data struct
- Move acc_count to u64
- Add regmap writeable/readable/volatile callbacks
- Use regmap_set/clear_bits() when needed
- Fix MAX34417_CHANNEL layout
- Drop useless comments
- Move i in the "for (int i...") and use i++ instead of ++i
- Move mutex guard into iio callbacks
- Use lower_32_bits/upper_32_bits instead of FIELD_GET()
- Use div_u64() when returning the Power scale to make sure it runs on 32bit systems
- Reorganize the get_label() callback
- Use devm_mutex_init
- Drop fwnode_property_present(node, "reg") before getting reg
- Rename rsense variable to rsense_microOhm
- Drop !rsense test
- Register iio device after device init
- Add comment about supporting MAX34407
- Link to v3: https://patch.msgid.link/20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org

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
To: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux@analog.com

---
Marius Cristea (1):
      unaligned: introduce be56 unaligned accessors

Neil Armstrong (2):
      dt-bindings: iio: add: document the MAX34417 Four-Channel High Dynamic Range Power Accumulator
      iio: adc: add driver for the MAX34417 Four-Channel High Dynamic Range Power Accumulator

 .../devicetree/bindings/iio/adc/adi,max34417.yaml  | 103 +++
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/max34417.c                         | 787 +++++++++++++++++++++
 include/linux/unaligned.h                          |  27 +
 5 files changed, 929 insertions(+)
---
base-commit: 54729cd85a044e8e2ee3f73ddda2d7c2fb39e199
change-id: 20260923-topic-sm8x50-iio-max34417-adc-209e880533fb

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

