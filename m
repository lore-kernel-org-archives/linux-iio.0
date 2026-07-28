Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2C42DA53;
	Tue, 28 Jul 2026 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240239; cv=none; b=YfFd2DkGCdGLVd15XSzX5EC+MWnhyqAbFLjddLcDonMQIo6o1Depsc/RUTXwOz/f8LEk687xEodJciUEnUlhc51tEf1/5V1hHYcpk/o6EJEsikwskf6SrQL9g6/zN9zxGV/Oren2RcXJNE1LqRSbqkHo4kTVu2UV5TfIsSTMHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240239; c=relaxed/simple;
	bh=J6/vi0BO6AwiRBLuYh6atEief8RHfl/MgzFgI62Gk9o=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=taEQYQVu5wTsCpRCoJGomHxxzWrz/9S70gnQsbdzKRYgG/6IKPkVayDL12FKBkf6yN6hlgfUKX02L3/JXD3LWrnCydw8SSpWUt3zswAUDrzI1h4KJLzwlfxW1Ex/jsX7o5nphXi8jrvWSl/U6eXpDHrV3EwDyORD9iTe0Toy0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TrFYn1Zm; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TrFYn1Zm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785240238; x=1816776238;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=J6/vi0BO6AwiRBLuYh6atEief8RHfl/MgzFgI62Gk9o=;
  b=TrFYn1Zmgp0h+xw2g43tDKkfKP2H+uKbwAwzxMbMsFFdPz3qVSEXhxAg
   0k2VXxiyTLEhDtBu6PJ2NXaHH4GaGBoPD7c2y4QcF1ANs76FAhDZaguB4
   0zcnZyREhnq6NkO5eBqUP6LcnnDAxGZJQ/tg7TKwLNzGxuq/UV6QLvQKV
   UIE8oRqX+5bKhtRzJjDLgy/E1kBJ45AQO7PvT5ZHAUDKeQqf8rvml5kaK
   pYa3GrW1GvLzCbs7MbdHGh5uTSq+DzbAXchaZDz0coIxqp0O1JZ2m+zxJ
   HBttvHh7HMiVG8y0RA6lW5RLfMvJyCt1K0cLxHUqvj9QDJvN4jh4KwZOz
   Q==;
X-CSE-ConnectionGUID: DAKaVPZmQq6CpIhWxNTncQ==
X-CSE-MsgGUID: vxvfIJf1SsqPQIZ41z5noA==
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="292649048"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 05:03:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 28 Jul 2026 05:03:56 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 28 Jul 2026 05:03:53 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH v2 0/2] add support for Microchip PAC1711 Power Monitor
Date: Tue, 28 Jul 2026 15:03:47 +0300
Message-ID: <20260728-pac1711-v2-0-609bc026093c@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKOaaGoC/z3Myw7CIBCF4VdpZi1mpjeCq76H6QKB2lm0EDBE0
 /TdRRYu/5OT74DkIrsEt+aA6DIn9nuJ9tKAWfX+dIJtaWixHVAhiaANSSJhu4c2VveIi4XyDtE
 t/K7SfS69cnr5+Klwpt9aDUIa/kYmgULJUfXKdWM3ymljE71ZOVyN32A+z/MLEH6MU6IAAAA=
X-Change-ID: 20250901-pac1711-d3bacda400fd
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785240233; l=3452;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=J6/vi0BO6AwiRBLuYh6atEief8RHfl/MgzFgI62Gk9o=;
 b=fuU4UnNtlrtsckczJuz/cadAv5FgOTx34KsDYRWDZPGSQ6D4ojXTE1zpYEUicescyU1GsBmlp
 N+H21NNWpYZC3+5WF/H0QUYXvXvdhrdnIPFtStyiv5FF3HK8vf8aTHU
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

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
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
 .../bindings/iio/adc/microchip,pac1711.yaml        |  209 ++++
 MAINTAINERS                                        |    8 +
 drivers/iio/adc/Kconfig                            |   11 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/pac1711.c                          | 1274 ++++++++++++++++++++
 6 files changed, 1527 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250901-pac1711-d3bacda400fd

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

