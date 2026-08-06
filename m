Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD447ECF2;
	Thu,  6 Aug 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030946; cv=none; b=YVdFdYrV1Ct5YJxAx2dek/JVvkQ6+G2oZN5OGo/3K+5phqWbwDX/1tiLNA19S5sCRR0aGW1amTSqMZNztBTft6RaDsmc2/36Bge5YDk61MbBEsFjvAQ6F49JVa2rbpkb5wF2hrwXzGx3DRPGmY8l5QfQd+bCLkn0RW3E7Iy0hyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030946; c=relaxed/simple;
	bh=cdis5cPip72Bds+HVE118777rlAoUkFOaTG3iCIbBnY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=P8oq9jBbUr9qImCiEDwG8w/tBQEprhD5OA3CYvqxQHlQ0H0QLaamWv+Z+c/anoW7lDEce05WOIkGSWRebih5ksm9SuHTHraHDdcvSuWQ/a4OeKOcmbHpYkj0qRmj+cEdgypLeC1DyE/UstSxwBE5jzzV6El8DwkjTkeTe/MqbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=07MKdXX4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="07MKdXX4"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EqlHl3342773;
	Thu, 6 Aug 2026 11:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=PHHPtgJlL1psJV48pid+ZAo3ndp
	+Bi1ajAMRXQ92tuc=; b=07MKdXX4GmEX0gbe0uXFS9JLkDshyeNZ3uzS3YRkEty
	tGkBI+BUzEpA40mpHJ4iHo5Vm8M1wOrfQCN7iC5MQ2P8aK9YyKXS92ur7Blo53/N
	Akya3j4iyWCdYF++Tb9C7Maxp/RXkNuIL9g7Jc10xv5HM5/0LPugTLVcP5fOCjBu
	RT9iFdemClRbbKxjBQj0uALFwCUztIHRiAOJF8kiWRHbh6X5mDOtwqKg+//9gEbL
	acF+VHWAF/6wi2H6+hWoYP0ChNEtOV5+h+eF2YhiCrvEbD7y71W4b6VeeGV2YE15
	j5GPDH7zG+IVyqH+pu9F/pKWF2zngtODKwuqD2V1i9A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fvuvyrd51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 11:42:03 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 676Fg16R007015
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Aug 2026 11:42:01 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 6 Aug
 2026 11:42:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 6 Aug 2026 11:42:01 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 676FfcgX008127;
	Thu, 6 Aug 2026 11:41:40 -0400
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v2 0/7] iio: adc: Add AD7768/AD7768-4 ADC driver support
Date: Thu, 6 Aug 2026 17:41:19 +0200
Message-ID: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB+rdGoC/13MwQoCIRSF4VcZ7jpDxXRs1XvELETvzFwoDQ0pB
 t89G2jT8j9wvg0KZsIC52GDjJUKpdhDHgbwq4sLMgq9QXKpueEjc8EYPbKQqWJmgvsgTtJqLzn
 0zyPjTK/du069VyrPlN87X8V3/Un2T6qCcaYUCmHVHKx2FxfdLS1Hn+4wtdY+MHlOH6sAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786030898; l=6922;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=cdis5cPip72Bds+HVE118777rlAoUkFOaTG3iCIbBnY=;
 b=LznloeH1J5LTevl8JZYhVdtDskT86PLWeOXsu4oO7+usmLGUhykSMZrP/M4wIegLd6OMTzBIP
 Pk7X+Zjnc9PBEIqecotmwMwhIlzGUPczosFiL7Hy0cGRwqtwJkp0zJP
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX8YcqCCFEQzKW
 4PNxq6oEFgIzIiy2582VIJHvzutuMYiVqabGSYMmIDYVR/yqm52B3146pKPZCzrtAtVpfSKgUJv
 Et+4Yw3i4IRmBoa9AULNvxGmFCZvZk4jRHG9S6vbu07TxQ5GP05S2dQ1+DV+iNyppFOF0/l9eN5
 Kcm0Y3pd+n4hYX6ie368ZBvslNLND2Y/xQyMC/HD9v0IyOk60GRTrTdza6OcDwYnPpa5SmNn5yY
 e/rw5Ln4zx7y2QDwrGo7TPNWpx9wxq8H8lHDlYiOIzluUrSfEgJBpY+3loPde7Bsn8T/p5PanLb
 eKO84WIVUIFWDFQ8AVhpEXUeM2SYfi4jgw9iQO/n0mhXe3G5L9UWDKn1+NCDTrlCH8lj3arJ/qo
 UrF7UntCK/r5LhCRRJtSFFvS9GFVE4KJYfLO7DaXrLFqMn8RN5/gfs2ZL3oZJJVQ5JtXFfvWXAJ
 p3XfssLHmS7k0OS79tA==
X-Proofpoint-GUID: 09nL_w-frpfHQLcqfDgi9AwZ8vqRzCIu
X-Proofpoint-ORIG-GUID: 09nL_w-frpfHQLcqfDgi9AwZ8vqRzCIu
X-Authority-Analysis: v=2.4 cv=JsjBas4C c=1 sm=1 tr=0 ts=6a74ab4b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=j9EIZ_jAAyhqBOZAihwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX5irjicTMh44U
 aCNxnnp0RcvaCxGk6r07Zd426ilDfamuhXqvzlW5fzzk1/jTg8VzQhV/VKrX1N9tVtT5bs/Pdti
 8cRm0MzC9FyXBubaeiB7gzRXWLjcJftA+PHzSUVLRH2iq13mN/gW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060121

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
1. **dt-bindings**: Binding documentation for AD7768 and AD7768-4,
   covering SPI interface, clock, power supplies, reference voltage,
   reset GPIO, serial data lane count, and on-chip GPIO controller.
2. **iio: backend**: Add CRC enable/disable backend operation for data
   integrity verification over the high-speed serial interface.
3. **iio: adi-axi-adc**: Implement the new CRC backend operation.
4. **driver**: Core IIO driver for AD7768/AD7768-4 with regmap, power
   mode, calibration, and IIO backend support. Registers an auxiliary
   device to expose the GPIO functionality.
5. **gpio: regmap**: Add optional runtime PM integration and support for
   reading output values from a separate register.
6. **gpio**: Auxiliary bus GPIO driver for the AD7768's 5 general-purpose
   I/O pins, reusing the parent's regmap and runtime PM.
7. **docs**: Driver documentation.

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
Janani Sunil (7):
      dt-bindings: iio: adc: Add AD7768
      iio: backend: Add support for CRC
      iio: adc: adi-axi-adc: Add support for CRC
      iio: adc: Add AD7768 IIO Driver support
      gpio: regmap: Add runtime PM and read_output_reg_set support
      gpio: ad7768: Add AD7768 GPIO auxiliary driver
      Documentation: iio: Add AD7768 Documentation

 .../devicetree/bindings/iio/adc/adi,ad7768.yaml    |  343 ++++
 Documentation/iio/ad7768.rst                       |  240 +++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   10 +
 drivers/gpio/Kconfig                               |   12 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-ad7768.c                         |   78 +
 drivers/gpio/gpio-regmap.c                         |  113 +-
 drivers/iio/adc/Kconfig                            |   16 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7768.c                           | 1720 ++++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                      |   26 +
 drivers/iio/industrialio-backend.c                 |   33 +
 include/linux/gpio/regmap.h                        |    8 +
 include/linux/iio/backend.h                        |    6 +
 15 files changed, 2592 insertions(+), 16 deletions(-)
---
base-commit: b75697ef53e435d894833dad2a8c2fa882cb9b19
change-id: 20260708-ad7768-driver-10cd15296c20

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>

