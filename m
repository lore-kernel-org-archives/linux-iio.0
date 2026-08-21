Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A54499F30;
	Fri, 21 Aug 2026 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321288; cv=none; b=mkw4ZclvLEJAADr12QXk8N6xdO3czaBCtpF2c44i+0uCmbZCQr0/EjLQd0cdl/IgJD6yogSnGijhh+PpJepgCTR6OCwBKqsSUgzkxBiVZQVgGdNewwxqLVZq/Gt357okEAhbMLGHROqSUMbD/32kFGZcD34PwVZCO59z6Iy8fVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321288; c=relaxed/simple;
	bh=1plWyF4ua6ywltHExbXRv0kEs0tdG1IHiJlzIJ59sOY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=V6B9VSQLmhVvu1XzQNG/A0iFBcjFEBcsfjabe0Eztc9MkzsUQJlrlC0pEZsqZgx7+zJkO29d0mV0kb9b0mfawQw5+lHkPMYzCjF69ZbNVZfydEoCB4VLpOCBdD6euP1hGARq+CH/rJJpPDWLu4zkBq+SsqP/Fi7ugztVzV8jbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XjgiQID0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XjgiQID0"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCpYAh3076411;
	Fri, 21 Aug 2026 10:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Frgz1EEA0Z2A712/Q8MWffmvysF
	5On1EzL4WlAnAqU4=; b=XjgiQID0EtVOA9iqUGX3c2Cq6Q5XQgTSqLlHMnTvUC8
	NCVFNuSmSY4y6Tt8TnJq7VVzuDMTBmERrYUiZdJ5EFNRPv1VC06Qi2hf67dcGu3Y
	9pop+o6r50ljfEHIzsIpdg+ySZzbzXmtRwiXDPI4A9Kh/qmz5fU9mcFDMS/kgOzR
	zDywA8jiQSdIc8EEQLmApa7PS2qaxJ7xadO51SISXD+Z3/Z62lbFn5yaAvqOGPq/
	iZoWT/DO8v4LEsLhu85eDYiVB8kRb8G2pPug6Fv5Tj0Z69CZ8YP/B3lajhNoJ2Ar
	ggHCWXxMRWWAQ37x6JajyrvmTr5e/iLOzJRSXpZA1Ig==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g5rk8yk9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:07:43 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LE7geA032845
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 10:07:42 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 10:07:42 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 10:07:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 10:07:42 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LE7Kkj024319;
	Fri, 21 Aug 2026 10:07:23 -0400
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v4 00/14] iio: adc: Add AD7768/AD7768-4 ADC driver support
Date: Fri, 21 Aug 2026 16:06:53 +0200
Message-ID: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH1biGoC/2XM3wrCIByG4VsJjzP057/ZUfcRHZi6TagZGlKM3
 XtuENU6/D543hFln4LPaL8ZUfIl5BCHOvh2g2xvhs7j4OpGQEASRRpsnFKywS6F4hOmxDoqQEs
 LBFVzS74Nj6V3PNXdh3yP6bnkC53fd0mvSoVigjn3lGreOi3NwQzmErudjVc0pwp8eEPkmkPlB
 JSxwoORnP5x9sUpW3NWuT0LwZnWxoH84dM0vQB3vAdFKQEAAA==
X-Change-ID: 20260708-ad7768-driver-10cd15296c20
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787321240; l=10574;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=1plWyF4ua6ywltHExbXRv0kEs0tdG1IHiJlzIJ59sOY=;
 b=GeTE2Zsyt+E3JMQCeX7PwwYlIrZcxk0YzeYRUAxG8d2K8Lm+D2QqGSkgiqndGuIhiMZwc80lx
 fWfOPzN59g/AtG66+uzHYzpV5BXNPgoqiVYgPRe7he4uCE2c9Hbq7E4
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX2kNarpM5P93S
 gOY66OgU8sNXZcevHDSLRL/4klCxc4UmmBKq7o8WnN0QQk7xtT0y0w5V8KKu9BY/Q5ySR5Ikzjm
 ISVCv7Xbbt9ri623vSP/vY9VCiO91+Nva2QjiuskmvR3UX1M5Pjn
X-Proofpoint-GUID: kjUnnuqzAj332PyQtkbbGZjfm7NSq3cy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX7IaShc7xzVGQ
 Qlhaw93u5aHPBpA0Y88iS9ucLV1X7CIUEN4hRmHU8wNosA1QEOCV7o6NCFNgERJqbCGLOTQpNwp
 1kXt++efZlKWUpuqC1ywLBbM5u0tB0CQTjdeaS4Ip7pMYC+/kVJsd4TYdmn496cESXg+AtQf0Bi
 BbJjH3x6tm/kPLczKKZWUI99M0WicRxTI8Tolr7jxdh8hNMbiB9Pf+H926RAHzMD8LK7ffU7WN0
 HiSw893Nl7Qyc39KG6k7dXgdar6zary7faDGxmWWhJyjzeJzGkVvd6+1mmLUMJNnfwRdaLuTIXd
 NHfyfrx9AkCHLXuwGfkLfoRDABYYAJVjK+/OybS79te4tG77kW6K0vC1LKoEE6kU2M6FwEKMRjF
 S558iFgNKMuMg+iv/U5sIHkDORkaWDc6LANg4EilxrQQwLPvzdSF9qPtW0gJJe+nsIYxSwN+qYJ
 ZxJ8lSSMwA4G4HTengA==
X-Proofpoint-ORIG-GUID: kjUnnuqzAj332PyQtkbbGZjfm7NSq3cy
X-Authority-Analysis: v=2.4 cv=P+YKQCAu c=1 sm=1 tr=0 ts=6a885baf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=aH_XzyrSaOxLzF7If6EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210109

Add support for Analog Devices AD7768 and AD7768-4, 24-bit simultaneous
sampling Sigma-Delta ADCs with automatic power mode selection.

Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-ad7768-4.pdf

**Device Overview:**
The AD7768 is an 8-channel, 24-bit simultaneous sampling ADC. The
AD7768-4 is a 4-channel variant. Both support configurable power modes,
programmable decimation filters, and a high-speed serial interface with
1, 2, 4, or 8 data output lines. Per-channel offset, gain, and phase
calibration registers are available.

**Features Implemented:**
- Support for AD7768 (8-channel) and AD7768-4 (4-channel) via device
  match data.
- Automatic low-noise power mode selection (fast, median, low power)
  with associated decimation rate and output data rate tables.
- Per-channel offset, gain, and conversion delay via IIO attributes.
- SPI communication with custom regmap bus for the device's protocol.
- IIO backend integration with adi-axi-adc for high-speed data capture.
- CRC data integrity verification over the serial interface.
- GPIO auxiliary driver to expose the 5 on-chip GPIO pins.
- VCM common-mode output exposed through the regulator framework, with
  runtime PM management while the output is enabled.

**Patch Summary:**
1. Initialize the AXI ADC state mutex.
2. Add the AD7768 and AD7768-4 devicetree binding.
3. Add the IIO backend CRC operation.
4. Implement CRC control in the AXI ADC backend.
5. Add core AD7768 and AD7768-4 capture support.
6. Add configurable sampling rates, power modes, and filters.
7. Add per-channel offset and gain calibration controls.
8. Add per-channel conversion delay.
9. Expose the VCM output through the regulator framework.
10. Register the GPIO auxiliary device from the parent driver.
11. Use regmap_test_bits() for single-bit gpio-regmap reads.
12. Add optional runtime PM support to gpio-regmap.
13. Add the AD7768 GPIO auxiliary driver.
14. Add driver documentation.

**Testing:**
The driver was compiled and tested on the EVAL-AD7768FMCZ using a
Zedboard with a mainline kernel.

**Driver Rationale:**
The AD7768/AD7768-4 warrants its own driver due to several
device-specific characteristics:

1. A custom SPI framing protocol: register reads and writes use 16-bit
   frames with embedded read/write bits and register address fields,
   requiring a custom regmap bus implementation rather than the standard
   SPI regmap backend.

2. A coupled power mode / sample rate model: available output data rates
   are not a flat list but depend on the active power mode (fast, median,
   low power), each with its own set of valid decimation rates. This
   relationship must be managed in the driver.

3. Simultaneous sampling across all channels with per-channel calibration
   registers (24-bit offset, gain, and phase) that are laid out
   differently between the 8-channel AD7768 and the 4-channel AD7768-4,
   requiring device-specific register mapping.

4. IIO backend integration for high-speed data capture via adi-axi-adc,
   including CRC data integrity verification over the serial interface.

5. On-chip GPIO: 5 general-purpose I/O pins exposed via an auxiliary bus
   driver, sharing the parent's regmap and runtime PM.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
Changes in v4:
- Move the AXI ADC mutex initialization fix to the start of the series.
- Clarify the IIO backend CRC documentation for input and output paths.
- Add explicit MCLK, crystal, and LVDS clock-source handling and
  sequencing.
- Keep the required channel active for crystal excitation.
- Configure FILTER/GPIO4 for crystal and LVDS clock sources and reserve
  it from GPIO consumers while it is used for clock selection.
- Make AVSS optional.
- Validate MCLK, crystal, and LVDS clock rates against datasheet limits.
- Split each differential reference into positive and negative supplies.
- Correct AD7768-4 standby and channel-mode bit handling.
- Program the AD7768-4 channel mode-enable bits correctly.
- Use unshifted register values and FIELD_PREP() consistently.
- Use regmap single-bit helpers where appropriate.
- Use scoped runtime-PM guards and scoped loop variables.
- Use for_each_set_bit() and named channel-child iteration.
- Remove the redundant initial autosuspend request.
- Document the validated 20 ms wake-up delay.
- Make REGULATOR mandatory when VCM regulator support is introduced.
- Add feature dependencies and includes in their respective patches.
- Convert gpio-regmap runtime-PM handling to cleanup guards.
- Use active-only PM references for gpio-regmap operations.
- Mark GPIO chips using runtime PM as sleep-capable.
- Simplify the AD7768 GPIO auxiliary driver.
- Clean up IIO and kernel coding-style issues across the series.
- Drop the redundant Devicetree example.
- Update the link to the latest Rev. D datasheet, update table
  references.
- Address the remaining binding description comments.
- Link to v3: https://lore.kernel.org/r/20260813-ad7768-driver-v3-0-cb554399ad26@analog.com

Changes in v3:
- Split the IIO driver into core support and focused patches for sampling
  modes, calibration, conversion delay, VCM, and GPIO registration.
- Split AXI ADC mutex initialization into a separate preparatory patch.
- Use PSEC_PER_SEC, explicit frequency units, unsigned frequency storage,
  32-bit divider arithmetic, and rounddown_pow_of_two().
- Use endian helpers and bulk regmap operations for calibration transfers,
  while retaining single-register writes for the custom SPI protocol.
- Validate the MCLK rate during probe and reject a zero computed DCLK rate.
- Remove redundant SPI and channel-template state, regmap_attach_dev(),
  unused includes, and a forward declaration, unused chn_mode assignment.
- Move regulators additionalProperties and drop redundant GPIO
  dependencies from the Devicetree binding.
- Split the gpio-regmap changes and add the regmap_test_bits() conversion
  as a separate cleanup.
- Limit the generic gpio-regmap extension to optional runtime PM support.
- Use an AD7768 reg_mask_xlate() callback to select the output latch for
  output GPIOs and document why it is required.
- Use regmap_test_bits() when reading the VCM enable state.
- Use descriptive runtime PM cleanup labels and verify structure layout
  with pahole.
- Set the VCM regulator's regulators_node so constraints from the nested
  vcm-output node are parsed.
- Mark gpio-regmap GPIO chips as sleep-capable when a runtime PM device is
  configured.
- Reword the conversion-delay and buffered-capture documentation to
  clarify their operation.
- Link to v2: https://lore.kernel.org/r/20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com

Changes in v2:
- Renamed and expanded supply descriptions, split reference to
  ref1-supply and ref2-supply.
- Added START and synchronization signal descriptions.
- Added variant-specific channel and data-line validation.
- Made adi,data-lines-number optional, defaulting to the maximum.
- Renamed the precharge and reference-buffer properties, removed channel
  mode and power mode properties.
- Exposed the VCM output through the regulator framework and updated
  documentation accordingly.
- Improved runtime PM initialization and requested initial autosuspend
  after probe.
- Automatically assigned channels to two hardware mode profiles.
- Selected the lowest noise compatible power mode when ODR ranges overlap.
- Replaced the raw phase attribute with the standard conversion-delay
  attribute.
- Added filter-settling delays based on the selected filter and ODR.
- Fixed AD7768-4 register and channel-bit mapping, including standby,
  calibration, phase, precharge and reference-buffer handling.
- Added direct-mode protection around runtime channel configuration.
- Added calibration register range validation and documented
  calibration values as raw unsigned 24-bit values.
- Added the required reset pulse delay derived from MCLK.
- Added a generic GPIO-regmap patch providing runtime-PM integration
  and separate output-register readback.
- Converted the AD7768 GPIO auxiliary driver to use gpio-regmap.
- Documented that AXI ADC CRC control bit 8 is common to the AXI ADC
  cores.
- Added the missing AXI ADC mutex initialization.
- Expanded the driver documentation to describe dynamic channel
  grouping, power-mode selection, VCM regulation and conversion delay.
- Link to v1: https://lore.kernel.org/r/20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com

---
Janani Sunil (14):
      iio: adc: adi-axi-adc: Initialize state mutex
      dt-bindings: iio: adc: Add AD7768
      iio: backend: Add support for CRC
      iio: adc: adi-axi-adc: Add support for CRC
      iio: adc: Add AD7768 and AD7768-4 core support
      iio: adc: ad7768: Add configurable sampling modes
      iio: adc: ad7768: Add calibration controls
      iio: adc: ad7768: Add per-channel conversion delay
      iio: adc: ad7768: Add VCM regulator support
      iio: adc: ad7768: Register GPIO auxiliary device
      gpio: regmap: Use regmap_test_bits() for single bit reads
      gpio: regmap: Add optional runtime PM support
      gpio: ad7768: Add AD7768 GPIO auxiliary driver
      Documentation: iio: Add AD7768 Documentation

 .../devicetree/bindings/iio/adc/adi,ad7768.yaml    |  314 ++++
 Documentation/iio/ad7768.rst                       |  259 +++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   10 +
 drivers/gpio/Kconfig                               |   12 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-ad7768.c                         |  118 ++
 drivers/gpio/gpio-regmap.c                         |   82 +-
 drivers/iio/adc/Kconfig                            |   15 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7768.c                           | 1855 ++++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                      |   25 +
 drivers/iio/industrialio-backend.c                 |   33 +
 include/linux/gpio/regmap.h                        |    2 +
 include/linux/iio/backend.h                        |    6 +
 15 files changed, 2722 insertions(+), 12 deletions(-)
---
base-commit: b75697ef53e435d894833dad2a8c2fa882cb9b19
change-id: 20260708-ad7768-driver-10cd15296c20

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>

