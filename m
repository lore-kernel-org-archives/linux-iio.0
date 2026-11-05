Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882574;
	b=FktxVSdyQAgPCHbDplrbWVAfMp1eo25szY6Jarh/5OH/wl+IUHvUFDNPNs/gbrDFB+Z9
	 GBpabeu/HZO23DYw3ZuS1YnVmngEXddqpLJWb2iveDUxzCAaeUM99XTvdSmakjB/QPLKT
	 tTq+YDekYEgR060HYrH3ptx4tR9+8SpIi4/tQ3WfXlE7Ibol+4c3kY7g05WhvFiQtNL7s
	 99TQGC+CTTFSj2FR7HZ8xWO8y4yY3eqWo6rJOkBI3+K+7F4ihjDB1uFaRzl0qopftnA0O
	 c/VBznzjnmBlRUef/QY7bgRxtXfiPoUG9tUqqXQDwShgeHQ6dYJmSC8rz4ORNB56BDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1Ne75eyG2UyJXHCI/3L+TP/oCHE9qyAF9KYGixpkjUI=;
	b=fPZvzSO2E2f4BlMiJ5Ha67TmE7ho3MQ7yTfdubPtJLWjZjs/wUxe00T2yiuhK48k3+4m
	 JZ8PZ+RndPRDya2iXxBrv3qrxkGCjpzJXnB4cLFNbFkBdAwH/1V7AwAd+O7eGniQT7K/z
	 KFJzTHJ2OwVFY6pZQkYOKFgpCDP9sGuwab4jSpbJoGVVhgxY3F8Nvw5ZFTA+hi010hXaG
	 1/1Vy1s9RcQrsWmjJFbZJkZ6mlnv3PEdBmr6nYxaKg6tqT0FrntsDJ8S5SecbozWaq1MB
	 SM6klQGmxdAOWR6EtJkufodjJ6cf1w26c/hwNkHrUrEuuLpWIvZJine+wcePYYBz0ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="Iq/RsRJ4";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79832606EE8E
	for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2026 12:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79832606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Iq/RsRJ4
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so11487045e9.2
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 04:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793882573; x=1794487373; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1Ne75eyG2UyJXHCI/3L+TP/oCHE9qyAF9KYGixpkjUI=;
        b=Iq/RsRJ4FsBgNrS+n61bnnkncfY3sB1utDJz4yKMa8JmxtntKvltA7XUnIUJlt0kpA
         QMFuu+8SAgTWPRaT7UvfwS5VivCUqcB/2qfMqThFc4z3B1I6eERj7as7Ylf1yWfyTzNI
         S1ZKyvYz1AZhQFycQHFAtuireiThe7zLVuv/N51Csjb9LggQWMvcxAt8KnICGFYTQnfz
         pDzUixOyPM9CSnPzxdbbvnG06wwxondl8WwHBFBrhyKgaIa7qyRxyOEG5J6MXx7548jK
         uXuijpg/ZS0Y+yQPXD5R5cgaoyvTnkBblpitcCRcBrJ0GcZVY4tWysEYijBtCxFVcXok
         h36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793882573; x=1794487373;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1Ne75eyG2UyJXHCI/3L+TP/oCHE9qyAF9KYGixpkjUI=;
        b=uVkN07V1zBuh2fPZjt1FlFCsTEdjfKYWls7YaOGeVe4ppTmck1SGv2KZtO7KLAsdha
         za7zNTs6Jljx0c0cYBeprk4wVIqseID+Bk9HS7+1CKOZIgaFmStw3wdXFuE4HlJbZMib
         WIKr90LjiY3v5R4sWCVoFgaWTbr2e2i5/vTRPRkMiDKRg04xUs9Ic8Ax8eSdKcZU55c/
         iBmx5XNTv0W98wP00X2mJrHmw8bVmep4tamhSnRNIlTa0Rr0uHLpbd3EFULhtnqBu0ez
         QMHlf5ZItHFBJSgWqK+cII4a4H3fXJOrLEKLBpjZIDtuIYS4gH21kWAeSDeG95YSNFxj
         O2pg==
X-Gm-Message-State: APuU4Z/hiwlNhxj1CUANubzFjJJqjkG+YuQ1fqLKgq5ifXCVeNmbr/N9
	PMtLM9DHLt3+Gzi4MoaDKEbWQZoWgUVE7AWBL8PDm23DjnLZFFVtSOLrnj5SUyC41qI=
X-Gm-Gg: AYBFou21q9/6dCp/yF8xxULsvtnpQiCM1lWwBy983EJx/aoCczSFpnMVR4B0Ks9nQK/
	j+a137XEOm3hDY2k6TnS3APgt7+YIDE6u7iFugZVGhoyoBQjvhEMyBQRbw1h2bt4IfdlWw++UQm
	EFk1Vq2cMIm36OJF0tp1clvlqfGe4VpDi1nQvwamVeI2Dg6YyvAxpWi5tKod/6Lhd9d6x6PpWOy
	EP00+AEDdaUXNucVSfh4qyvbEBAJ2qBMuGJFeIf0GQySiuLLUPMa9BwKZfcuh09EURasmR8o7no
	zwj3zEtoa7Wbkzlh5XyTB3VUD7eV6KcjdprqTxSyVa0GzFK69gmWy/HIpzNC++rqguVbSs6i0hf
	5i3cOS6E6gbSSca7kIH1VMuYeBpVpSq9Jr4klLGRhz/LCzIOHfoLYRKYanq3FPF1Y+SUgnfzKPS
	fX+NKqKN3AfabeTJQjSxPmUrNTylPnUc/oLj4deqbTU7x08k1wJtuPjqU6v2bThT6k4k+NfcFW8
	SyhHMLJbrlxQhZaD9So/nmbziU1yth7eAqexcRa+9z/YEP99+Rs6DSoW4L8FKdphS8/howtNPRA
	+e4GVeTEoGthCMBYpfR7WE9nbFZgezvx+rHGx+2oyEwM
X-Received: by 2002:a05:600c:3b88:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4ac187a6ffcmr448518465e9.29.1793882572597;
        Thu, 05 Nov 2026 04:42:52 -0800 (PST)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57373f7f1sm73487895e9.15.2026.11.05.04.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:42:52 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v6 0/3] iio: adc: add support for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
Date: Thu, 05 Nov 2026 13:42:45 +0100
Message-Id: <20261105-topic-sm8x50-iio-max34417-adc-v6-0-63b4e8279633@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIAMZ57GoC/43PQW7DIBAF0KtErEs1DODYXfUeVRYYhoSqMRG4l
 qPIdy+kUhvVC3f5pa/3Z24sUwqU2cvuxhJNIYc4lNA87Zg9meFIPLiSGQI20KHkY7wEy/O5nTX
 wECI/m1kqJfbcOMsROmpb0FL6nhXjksiH+e6/Hb5z/uzfyY4VrY1TyGNM1/sBk6i9/25NggNXw
 qneiN5bJV4/wmBSfI7pyOrYhI+c2uKwcJ2B0qU9em1XnPzhBIjN62ThnGxAGVIGsVtx6oHDdot
 TlSuvGi+JOpArTv9yxdvidOHAe6NJe3R/nl2W5QvEWufUGQIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7272;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=LlEAGHxTmhCT5Msd7aVO4EmAR3EMf33/+99ZdmDLrbY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBq7HnKlfP9xl0hE98PNnbXKlRlkcWKbuLo0lWcBbXi
 NLXyT22JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaux5ygAKCRB33NvayMhJ0RtpD/
 46dOeyJve/cyfLReO5da4Z4mHdX6/zl6GdHvnxYLnKOcMe8bDYcgwakiF5wrc0hqPVLBCM3dnRv11U
 VaMlrBuFauKiq7JKfSKTrtPQWmITBDLvLr7MH7Gb/tWGH4NxvSUIFU2dmDXDOP218CXkso3aYjJYvO
 MFrT0b5a0dks2qZp1yOrp+N68D2YwOF044pdGf8c1VHzBq8gu7Q659gIeO3r7rGWVyDOMvn52J9KWh
 p+JQ8INYVj4vMGSXH8MPo2ZBgeTq5CbLmUrATwilnXe7O3ru5aycdqHMwn6U7dGhFuzQxxRgKg1k2Z
 ghpr8rUxugKlwtaJaPdDl3QDvDnFJxhFPVT2qhmrIyfbszTDLeWfV7M2pP2Twic3pit4Y3UylM71YF
 q7mUZDyuGNXOZ4JGewO59J39B2y//73x3RmsTmtW1gCZtMcx6s37htMrW5SJEuZLTN0w7FHBikeS8k
 MnTdvaP2VA2Yquo9AXaJZ4hapSu5T6O3aBnY0c2T/mSyse5jl7AAusQ/XoGlYxySAcLrv4D9odlWQi
 dMsFCqYXFYSAW0XP92VxTKm69oYxIUj7lEKbBCtdQKqAHeCZ/oHz2p9X8aQsus08gA2SWZgR+nIY2l
 EX+Ju+kvvmLbOtCV157do2r3KiuduqxkxJ7DZz5bWalf1OKncIwBW6od3JpQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The MAX34417 is a specialized current and voltage monitor used to
determine power consumption of portable systems. The driver supports
getting the channels voltage, average power and accumulated average
power and energy over an I2C/SMBUS serial interface.

The MAX34417 datasheet only specified on how to calculate the
accumulated average power, but with the Sample Per Second rate
we can easily get accumulated Energy in Joules.

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
Changes in v6:
- Fixed sashiko comments
  - Fixed the binding example indentation
  - Added a timestamp to make sure we don't call UPDATE in less than 1ms
  - Switched ENERGY to return Joules instead of mJ, simplifying the scale formlula and use IIO_VAL_FRACTIONAL_LOG2
- Dropped using SMM and using the default mode, simplifies the process for same result
- Added software overflow check
- Switch to s64/s32 everywhere to make sure we don't mess the sign since we return signed int values
- Added readable_noinc_reg to mark the data regs as noinc
- Added explicit comments on the OVF check, UPDATE sequencing and byte0 content
- Dropped the channel type in the channel label
- Moved the DT channel probe into a separate function
- Link to v5: https://patch.msgid.link/20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org

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
 drivers/iio/adc/max34417.c                         | 845 +++++++++++++++++++++
 include/linux/unaligned.h                          |  27 +
 5 files changed, 987 insertions(+)
---
base-commit: 54729cd85a044e8e2ee3f73ddda2d7c2fb39e199
change-id: 20260923-topic-sm8x50-iio-max34417-adc-209e880533fb

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

