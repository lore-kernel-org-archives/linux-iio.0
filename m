Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851AC54280D;
	Wed,  9 Sep 2026 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956627; cv=none; b=InBLyFktGtRJq7MDI49YvyS3j9GI6tGqQVVDEb2WWoCkX9XJgS23EDfwDtC57vx/rwgK9KeWwfp6P8zRqyavPWRORf9826pQlw0VOrTACC3ywk5trEKO4C/5Io42rovd+ULgcrYL8jCj3pzSKJpXD74P+sUcW5thbidKJE0dlaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956627; c=relaxed/simple;
	bh=wMFKsWN/dcTfZ69KG8lWADaHWCwXAHzH9FtY49sEzOE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=inFtLg4nlWypegfFmEGcFgYz/7e9nSK1Frsww19jP8CLoculMbJ6BguoJXUp2mDh/n2xT7i/4knrgsWwBuQxdqSn1bdmnd6pB7dFWI4houhTnTtxRrrQOPwFUtFeJFNwvGiMMgb8TJYgzdMEagwO9Bc0quX7IdsYou7XzQA1nE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lSgJAr3q; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lSgJAr3q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788956630; x=1820492630;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=wMFKsWN/dcTfZ69KG8lWADaHWCwXAHzH9FtY49sEzOE=;
  b=lSgJAr3qjFQeX3mwqHfL0GOKi+3RtkwAdgQgozlS1drTKjrF9EYPWFad
   fndGcfS0qhtV6EB2y+lCjsQHI5lh15G1/RIVIpA5nXRkp4ICN0JVT703i
   3irLraMqczMr6B9xy93fExE3DieLayjxbutkS4joHFvzyJmxT2Q1+CUYO
   zPKwVwtPNboOQmWVHIH3LX9lxQXJcEEvCVdLh82rLUcWGHstRjY+POHkN
   d76iP1KtZCzVeazHma4aTDmi4e2Nf6F4iIgfw/0o7xtRLl8D/m1l7iT0i
   pDkUoBZTnO885lutZqpKrYSEdALam7+6opf87FnrYtmRMZBJB9hZZOrJp
   g==;
X-CSE-ConnectionGUID: CNLrItBCSd+aeqMej9o1Mg==
X-CSE-MsgGUID: zGJP/6IRT1uq3nAGZUigaQ==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="294758080"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 05:23:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 9 Sep 2026 05:23:38 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 05:23:35 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH v3 0/2] Add support for Microchip PAC1711 Power Monitor
Date: Wed, 9 Sep 2026 15:23:33 +0300
Message-ID: <20260909-pac1711-v3-0-dff81003b82f@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMVPoWoC/12MQQ7CIBBFr9KwFjNAC+LKexgXdErtLFoaMETT9
 O7SJmri8s389xaWfCSf2LlaWPSZEoWpgDpUDAc33T2nrjCTIBuwIPjsUBgheKdah52rAfqOlfU
 cfU/PvXS9FR4oPUJ87eEstuveECCabyMLDtwabWvrlVbaXEbCGHCg+YhhZFsny4+rwcjTz5XF1
 WBb3D5W4b+7rusbKTE4k94AAAA=
X-Change-ID: 20250901-pac1711-d3bacda400fd
To: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Ariana Lazar
	<ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788956615; l=6496;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=wMFKsWN/dcTfZ69KG8lWADaHWCwXAHzH9FtY49sEzOE=;
 b=L04a2ZhhfvHbfTclyVsntJ7ON1wmW8c07BEe5GvKX6og/GOB9ZaQkJ7wJCCu8PyVSsiN/NR0c
 2Tnq991N06pA/MkwucBR4YUNJIvpO1uRjAMvgaiGvaqOynHrTrvDgf7
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

The PAC1711, PAC1721, PAC1811 and PAC1821 products are single-channel power
monitors with accumulator. The PAC1711 and PAC1721 devices use 12-bit
resolution for voltage and current measurements and 24 bits for power
calculations, while PAC1811 and PAC1821 have 16-bit resolution and use 32
bits for power calculations. The 56-bit accumulator register accumulates
power (energy) or current (Coulomb counter).

PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
PAC1721 and PAC1821.

Reasons why these devices are more suitable for the IIO subsystem:

1. Hardware capabilities and sampling rates:
   The device is fundamentally a high-speed ADC with advanced hardware
   features (e.g., measuring low voltage over a current shunt, calculate
   power and/or acumulate power/current). When
   configured to sample a single channel (e.g. current exclusively),
   the PAC1711 can achieve sampling rates of up to 16,384 samples/second.
   High-rate sampling is specifically required to enable accurate
   power/current profiling.

2. Future Features:
   The currently submitted version of the driver provides the basic
   hardware interface that could be suitable for HWMON, but later on it is
   needed to introduce features such as IIO buffer support. High-frequency
   buffered data capture is essential for profiling high-resolution current
   consumption on processors, peripherals, battery systems, and industrial
   low-voltage automation.

3. Consistency:
   It maintains a unified API across the entire Microchip power and current
   monitor device family with similar hardware capabilities.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Changes in v3:
- fix review comments device tree binding:
    remove interrupts and GPIO properties
    change VSENSEP to VSENSE+, VSENSEN to VSENSE-
    explain why we need the accumulation mode as a devicetree property

- fix review comments driver:
    use NANO macro in defines
    use anonymous enums
    rename is_pac18x1_family to has_16bit_resolution
    use more meaningful names for local variables instead of tmp
    use guard instead of scoped_guard where possible
    replace 'Increasing precision' comment from
     pac1711_in_coulomb_counter_scale_show()
    rename pac1711_work_periodic_rfsh() to pac1711_work_periodic_refresh()
    remove ret initialization from pac1711_chip_configure()
    add explanation for background worker instead of polling data in a
     comment
    remove dynamic allocation of the always available channels
    return 0 in the end of pac1711_retrieve_data()
    remove comma after NULL entries
    use FIELD_MODIFY() instead of FIELD_PREP()
    use consistent one line style
    verify length instead of return code for I2C reads
    remove return error code when accumulator overflows
    correct refresh logic and jiffies timestamp calculation
    add mutex in pac1711_in_power_acc_raw_show()
    add mutex when reading power raw values
    correct wait_time calculation
    initialize all struct fields when identifying the chip fails
    handle return code correctly for i2c_smbus_read_i2c_block_data()
    correct power scale calculation to avoid overflow
    change vals type from s32 to u32 in pac1711_init_vbus_vsense_ranges()
    use IIO_ENERGY instead of custom attribute for vpower accumulation
    add more comments to explain accumulation functionality
    validate I2C transfer lengths and return -EIO for short transfers

- Link to v2: https://lore.kernel.org/r/20260728-pac1711-v2-0-609bc026093c@microchip.com

Changes in v2:
- fix review comments device tree binding:
    add PAC1721, PAC1811 and PAC1821 part numbers
    add Vbus/Vsense input ranges in attribute definition
    change accumulation-mode from int to string type
    remove size and address cells
    correct interrupts definition and add attributes for the two
      alerts, microchip,gpio0-mode and microchip,gpio1-mode
    remove microchip,gpio attribute
    remove "vbus" accumulation mode

- fix review comments driver:
    add PAC1721, PAC1811 and PAC1821 part numbers
    run pahole on reg_data and pac1711_chip_info structs
    remove average registers - VBUS_AVG and VSENSE_AVG
    add PAC1721, PAC1811, PAC1821 to features/compatible
    add missing headers
    remove rarely used defines like PAC1711_POWER_24B_RES and use the
      numerical value inline instead
    use ARRAY_SIZE() instead of define for the number of accumulator
      related attributes
    add explanation for bytes length defines
    use spacing convention space after { and before }
    remove pac1711_shift_map_tbl in order to use just
      pac1711_samp_rate_map_tbl and an index saved in struct
    use read_avail() for sampling_rate
    change mutex comment in reg_data
    use fsleep instead of usleep
    use a local __be16 variable in endianess transformations
    add missing error returns after dev_err
    add info_mask_shared_by_all for sampling_frequency
    use dev_info instead of dev_err_probe in chip_identify
    generalize input setup functions into one
    remove device_property_present
    rename pac1711_single_channel into pac1711_chan_spec
    rename pac1711_of_parse_channel_config into pac1711_parse_fw
    remove unneccessary comments in probe
    define in_shunt_resistor as ext_info instead of custom attribute
    use calculations only with 16-bit resolution instead of multiple
     shifting (12-bit registers are left shifted)
    add scale computations based on new voltage of 9V for PAC1721/PAC1821

v1:
- first version committed to review
- Link to v1: https://lore.kernel.org/r/20251015-pac1711-v1-0-976949e36367@microchip.com

---
Ariana Lazar (2):
      dt-bindings: iio: adc: add support for PAC1711
      iio: adc: add support for PAC1711

 .../ABI/testing/sysfs-bus-iio-adc-pac1711          |   24 +
 .../bindings/iio/adc/microchip,pac1711.yaml        |  183 +++
 MAINTAINERS                                        |    8 +
 drivers/iio/adc/Kconfig                            |   11 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/pac1711.c                          | 1304 ++++++++++++++++++++
 6 files changed, 1531 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250901-pac1711-d3bacda400fd

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

