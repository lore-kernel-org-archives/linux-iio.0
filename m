Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FECE40DB56;
	Thu, 13 Aug 2026 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629478; cv=none; b=UtzTQRgwi6qsTG+FDPfZSQlpEo/dbONOIphYugOAajGxeuzH/CGfbD1WW3/c30RIJoZnwgCRtuYGEytwthqtArNBmfmbeBZQomhQKicajcZJPzkaBC9Qy5pqxgdJshj2uum1e5BBkBfm9UbIWkFhT4Vq63mIyWVRDVBsYrziOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629478; c=relaxed/simple;
	bh=ltr7iWScldlgEM0z6egOeH9sP9IbA/8hjF1OIhFFvmA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=C0dv6SqVP0K6+PNsUBxYmQ6mdBNvHCXyNb3j7wzBZDvbML4l2vhFjiTANxDKM485vCb+26psr5Wmwy8VAHFoTsYNAIuAdoe6dFuIehysqm/IqReyMVpiLoLceh53+kzLMFCb59woq45na40Z3kuYLEf+oWtBoomiSltpyIJKBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mn4IFbFg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mn4IFbFg"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCL8oP2350817;
	Thu, 13 Aug 2026 09:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=AxUDxtGN279BtOfcY3Pv9nKDRyT
	MpxgNb52SL0pJvKo=; b=mn4IFbFg1dRHBi+YNQNeNH0R0JCfNOYBomNBtjpnPPW
	Z7y64gJVGLjnCG1g9EHBmmSX44HR9v7ZgTmbAd0qdPIow5W9nObqC2YFDebWqdkn
	HaSyAG+g8mjk+sZ0ezXdAiQrxhcSV0Ap3zexDTTdJxZtpaP3D7gYo5hkrw27c83a
	aK6rTirST/MOvT9Y8mXmhjkV6WiCB7k4oqv8WTHdkwIiFGw0Q/k+fHJFhzrzsULx
	7o8eZtH2CLO8xfXhXbaSPO1PGRfF/wL9idZ/8xlhnl7s/eEf52EcLEIOAUI2b93J
	L0mo8/EgpuyQ7OXOYuypEt6JcJphqaCXRNqz9STeZmw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g19w9hwbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:57:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDvhxS024600
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:57:43 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 09:57:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:57:43 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwS006802;
	Thu, 13 Aug 2026 09:57:27 -0400
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v3 00/14] iio: adc: Add AD7768/AD7768-4 ADC driver support
Date: Thu, 13 Aug 2026 15:56:53 +0200
Message-ID: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACbNfWoC/13M0QrCIBTG8VcZXmccT05nV71HdCF6tgk1Q0OKs
 XfPDSLq8vvg/5tZphQos2Mzs0Ql5BCnOg67hrnRTgPx4OtmCKhAQ8et11p13KdQKHEBzosWjXI
 IrDb3RH14bt75UvcY8iOm18YXsb4fyfxJRXDgUpIQRvbeKHuyk73GYe/ija1UwW/egfrPseaA2
 rqW0CopfvJlWd4W1Jw26gAAAA==
X-Change-ID: 20260708-ad7768-driver-10cd15296c20
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=8799;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=ltr7iWScldlgEM0z6egOeH9sP9IbA/8hjF1OIhFFvmA=;
 b=nqyt8DX6FrNSPp+hDQQHPYKOGM0RDRrt/lRrqAsdAb3JtuZHfHPt4TPDAllbyai6Iz6wftGgG
 yvQXNuLeM8FAQU67taG6VQQ34WtecllejzRdk+rCfaIWpUOXiLlOZ7X
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX2+dSQGStuqMI
 CRUYREqPTW1332sh74iTkkFGNebBR0PfAKaTKh5M/dBhb09YpT2a0B4FKt8zO/Yoc4GhwMh68Hb
 VNcn4D4zTGp/Z/fUdhpws7YzIt1OXVYlA+FU+XH7SK7J4kOyY1HRWTsq8hHMDZXxLavH4ywwTNF
 yqtqyMGhEqYjvrB238dDYTJDUifm7nynWcqE8awqLTK0uYwHaBM8/T4lOmkJ8l1YSiPv2M7YY3Y
 yV2kK6S6ceFHc8szhPWVT7RA0LgfvEqHh3afb/ryoOv5MIvZCV/qJCd14XKLDX/VeKX18vxTupR
 n5YoyfL6/7ef8Q3dvvxAjLDrZPFEHRdBWCqpqxF9JaxDmj0s6VP719YQDOrpEHyG+/e1G4jyRRt
 k2Ogz1ukO2Fd4Mlh1/pSywQO1PvMCm9e9QD538xFtAhXpk/VjCPQTVOTAviTsAhyAjprwRTCHl3
 qCt8O6NJwLsAV3dCXZA==
X-Proofpoint-GUID: QaKxn3Y0S5BVChAgcADl2e6h_FLemSi9
X-Proofpoint-ORIG-GUID: QaKxn3Y0S5BVChAgcADl2e6h_FLemSi9
X-Authority-Analysis: v=2.4 cv=f/R4wuyM c=1 sm=1 tr=0 ts=6a7dcd58 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=HCFDkiZIB1MI3FGiDVwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX8weLKBc35j1Q
 hgH/ICpieedslAJqEgcU/cQPKiEyQI/VEFMXrAsTvbFCp1HrnLjORPDW4vyJfJR5sh9QkbpaKwu
 BTBJdodv8rzPTLTmAUD+SICezAGUz2N0WvEqbzlLsi4fE+0o4h6/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

Add support for Analog Devices AD7768 and AD7768-4, 24-bit simultaneous
sampling Sigma-Delta ADCs with automatic power mode selection.

Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768.pdf

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
1. Add the AD7768 and AD7768-4 devicetree binding.
2. Add the IIO backend CRC operation.
3. Initialize the AXI ADC state mutex.
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
      dt-bindings: iio: adc: Add AD7768
      iio: backend: Add support for CRC
      iio: adc: adi-axi-adc: Initialize state mutex
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

 .../devicetree/bindings/iio/adc/adi,ad7768.yaml    |  338 ++++
 Documentation/iio/ad7768.rst                       |  240 +++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   10 +
 drivers/gpio/Kconfig                               |   12 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-ad7768.c                         |  106 ++
 drivers/gpio/gpio-regmap.c                         |  115 +-
 drivers/iio/adc/Kconfig                            |   15 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7768.c                           | 1682 ++++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                      |   25 +
 drivers/iio/industrialio-backend.c                 |   33 +
 include/linux/gpio/regmap.h                        |    2 +
 include/linux/iio/backend.h                        |    6 +
 15 files changed, 2564 insertions(+), 23 deletions(-)
---
base-commit: b75697ef53e435d894833dad2a8c2fa882cb9b19
change-id: 20260708-ad7768-driver-10cd15296c20

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>

