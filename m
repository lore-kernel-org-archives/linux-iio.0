Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139947F3DF;
	Wed,  7 Oct 2026 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384126; cv=none; b=W7ODs3Zt6dN0wSbYm25yTc9mj8P5mT6rEmdWBsO6ezHkgT8A13BSlQI95ziOdVkcly8yPSh4o0mgdneWUvtZqJywBr/VCbjZBDalPByN5dReuXNDRFpDX6LTfQVEzgVadHpKrpDLWxSo0pQerZsaI9JfOPf2D7tUQqKXO94HtMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384126; c=relaxed/simple;
	bh=o2C1MfHvjU8jefvslCjpuyRjZBgzB9VT2q3uY4ayfVA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=EFqSDL2e4ZWFeGP2394muwefAApemmoyNFUlaNl3nG2A+lmE/bCngX4MD3g+pRlAc4KV9kkPSdqMJmZGyHnKcxMu11DEUfMCIn1gt61ns3U01f991ipishOkWUILp6XpZw1BUBqMPd5s76x/QICk4EsdF5A1uQSaoQtI4LAyr2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0XRbBdQa; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0XRbBdQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791384124; x=1822920124;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=o2C1MfHvjU8jefvslCjpuyRjZBgzB9VT2q3uY4ayfVA=;
  b=0XRbBdQa46gjHWW3Z3hp/dXDl8e9IzmOW2JLb0eiL5qmsPpN3pxy9Kr4
   peETcxTso7Va5klDs0qWK9FWbQfRlN9HujPzDUoYpz+9IxhRuqt+AGVte
   2Y5z5VnAMB2VZIO4Hhke0IttJe1mv+Qh2L1fOhJ3GTl7Kz9/Mgu20irH9
   jEJf7f5uStxYkl5AKD8dGfauyu7pcnw2ejuM5QxweHCkjNoP+W0/CEgUf
   X8GIdG2kkpaEabbrilqd+7u+tBuzNLbBmYplIfo+4gOaYn3xXPKJh5peO
   07CmEJDzsxAYJdgy5ROm0+Pc1cMVaME+OVy3wXSSlLxTS389lNMp8oh1J
   w==;
X-CSE-ConnectionGUID: u1H6dKEBQKe9Q/7PgV6y4A==
X-CSE-MsgGUID: jtSEf13KQMGMul6vy7d4RQ==
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="231797349"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2026 07:42:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 7 Oct 2026 07:41:57 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 7 Oct 2026 07:41:54 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH v4 0/3] Add support for Microchip PAC1711 Power Monitor
Date: Wed, 7 Oct 2026 17:41:52 +0300
Message-ID: <20261007-pac1711-v4-0-6ef34d7a7947@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADBaxmoC/23MTQ7CIBCG4as0rMXMQAvFlfcwLig/lkVtA4Zom
 t5d2kSbGJcfzPPOJLkYXCKnaibR5ZDCeC+jPlTE9Pp+czTYsgkD1oACpJM2KBGp5Z02VtcA3pJ
 yPUXnw3MrXa5l9yE9xvjawhnX162BgM23kZECVVKoWjkuuJDnIZg4mj5MRzMOZO1k9rECJGt3y
 4oVoDqz/ihu/lm+WwVqt7xY632LALxrmf+1y7K8AUUCevcaAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791384113; l=7925;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=o2C1MfHvjU8jefvslCjpuyRjZBgzB9VT2q3uY4ayfVA=;
 b=71kQ4gouhp6UW8m6KMcqoVV8Lpwp3TpDCkwSon3XZ/C44K1eWenQD3gaOxg87htSw/Kmsou8L
 xthn4iTHeUCD3YFNW5moLV8SxkeKLjY3slt1Qn2uM23fxdRYA+ikTpg
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
Changes in v4:
- fix review comments device tree binding:
    move the reasoning for defining accumulation-source as a DT property
     from the binding description to the commit message

- fix review comments driver:
    add a new patch in the series to add IIO_CHARGE as a standard channel
     type (instead of using custom attributes for Coulomb Counter)
    remove chip_variant from pac1711_chip_info struct
    remove TO_PAC1711_CHIP_INFO define
    use reverse xmas and correct other coding style issues flagged
    use dev_err_probe() instead of dev_err() in pac1711_chip_identify()
    correct sample rate update
    restructure pac1711_features struct to reflect hardware
     differencies
    rewrite defines using unit defines such as  MILLI, MICRO
    add comment to explain sample rate update wait time
    add device_property_present() check where needed
    add porposed function pac1711_get_features_from_id() to be used as a
     helper in pac1711_chip_identify()
    remove early return in pac1711_set_acc_enable()
    protected 64-bit read operations with guards
- Link to v3: https://lore.kernel.org/r/20260909-pac1711-v3-0-dff81003b82f@microchip.com

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
Ariana Lazar (3):
      iio: core: add IIO_CHARGE channel type
      dt-bindings: iio: adc: add support for PAC1711
      iio: adc: add support for PAC1711

 Documentation/ABI/testing/sysfs-bus-iio            |   13 +
 .../bindings/iio/adc/microchip,pac1711.yaml        |  169 +++
 MAINTAINERS                                        |    7 +
 drivers/iio/adc/Kconfig                            |   11 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/pac1711.c                          | 1231 ++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |    1 +
 include/uapi/linux/iio/types.h                     |    1 +
 tools/iio/iio_event_monitor.c                      |    2 +
 9 files changed, 1436 insertions(+)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20250901-pac1711-d3bacda400fd

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

