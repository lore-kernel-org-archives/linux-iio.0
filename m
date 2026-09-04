Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA884AE101;
	Fri,  4 Sep 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531372; cv=none; b=qGlGueC/tDoLPqiX0rEz+whC3CoXDT0tERXRWi/qrbDy+6alV+bcuG0yuQP7FILY2pkYCV4aVMzUvjmJbaToqDitQs6xpHn3K8xFerJvfPP5s4VzH92aglsnAl6ijJRXhiJGFXDgjQFdYQi+k3rreBo3+SNkCpCPfRbxjv73+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531372; c=relaxed/simple;
	bh=GlyffMYERUYgrSfXPTbPCH1bmQzgGla05SIPEuixtz0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=BeprlIn/2XgIP6clzAczmBHlgbPFH6K5VDsZuJLTHsDf2IXygPWj8XDHgh0GZx/GxCmKDlwq03zCijE/me7Y4/p+W6fQv/rSbWCKs/KRuB0w6sJRYl2VBk6eXnwbrrXorwGGNtABo636N2iq6/CYpOr++o/QUjJB7VMYKMQ/jaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UQKJa3Ox; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UQKJa3Ox"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Dgbpe332992;
	Fri, 4 Sep 2026 10:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=M0QAMAH8BhGDVwArQpkFSHDpBJg
	t7H208xQaXco2cSw=; b=UQKJa3OxsT8TiZHr4qq23kvyseepan1of+3Par0S0/D
	t3sw2WA4DFIF5xoPni3/ihsZ1jW+cv1xBHg7zlhWxZ98Q+g1Zb2R0phUuC4OYXqW
	sYOE6SiFKUCmNkJJI/nzhVl4KPcWtiiCfneqrX2lBo1NWDHhlsnT3BzL9W0WRzPo
	zqX95gR9ALKOm8kkRtr/pOlmoYPXVJzcqe4+ttHCsXjBEm2WJ8zM5fQi9qlvdYyS
	Zq5TfXLM07USAGzoQQhoqo1h9AR7zz2ighCZ9eNA9JeswsMtScU1DJnm4IPmmbch
	aN+XCOmCFbLHXG6l8Qc00GnrUk3AuduEP6FVxiz847Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gffkkmf7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:15:24 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 684EFNxs036031
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:15:23 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:15:23 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:15:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 10:15:22 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 684EF2d4026210;
	Fri, 4 Sep 2026 10:15:04 -0400
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v6 00/17] iio: adc: Add AD7768/AD7768-4 ADC driver support
Date: Fri, 4 Sep 2026 16:14:52 +0200
Message-ID: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFzSmmoC/2XQz0rEMBDH8VdZcjaSmSTTxJPvIR4mf7ob0FZSC
 crSdze7INb2+Bv4fA9zFUuuJS/i6XQVNbeylHnqgx5OIl54OmdZUt8CFZIalJOchoGcTLW0XCW
 omMCip4hKdPNR81i+7r2X174vZfmc6/c93+B2/S35XamBVNKYDODNmDzxM0/8Np8f4/wubqmGf
 9wp2nPsXOHA0WZkMnDgesNB77nuPAZrjfaeE9KBmw1H2HPTeQhuDElRMjkcuN3y/Reb7TxrHZl
 GZ4DxH1/X9QdwwTLIpwEAAA==
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
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788531302; l=13420;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=GlyffMYERUYgrSfXPTbPCH1bmQzgGla05SIPEuixtz0=;
 b=Ma4bKCuuimEnzx+hjG92INuQgMNK7Dmgq/cUOY1rcXnc+ANkUN7ZSUtbj+JVJfbN956r9ijgd
 s7pGW15ZB3bDisVqSCHNuqTDY+fJLVBCcydLzkFtxvtdh5PBCP6od/6
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: oGkNopk67cLiEmXyLviDMUkl9RnPR5Pu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX83sxiLaxYnEJ
 ci5lgtx4TnZGO+ifH6Ip6vapGSWIiGcf3AmS38ClaffF5TYZAV/1ImbhP849hpZ4sAzKz711UYU
 Sbvmr4qLDH3chnmg8VCuizTVUKr3aKvdb30IReM+ganeLOCaT2qtldens8gODDiGQcoFKuZ5BHZ
 uM4z3HCwtSY+xugpLjPW0CA9iW2KRQNOCX+dER2/3hj5OLYV1xfCyoWGmfDL80tIXsUwix+7+V0
 zNB6qjKmNLUk5OxtIcduL3HsnDBQvlZBHrbuiVV5NUTzIVG/U5jKCP/6/8j40UqShHgwLfAfFwk
 RwvOYcsYfknjeQPbjj4FC6EKL4d/8Qpmb2Pa6tbHlRUVDzemFylHt2mIp4x1xp7isNunPc263w9
 Cs4wKVtXkqDsUvjgbSwAFlpr2z5yW1nhcGKD0rp3yzS5d6Zh+FLMPiRztNsmTO+XFDts1cNqz2f
 iDTNUbYQGhcSkIdteLQ==
X-Proofpoint-ORIG-GUID: oGkNopk67cLiEmXyLviDMUkl9RnPR5Pu
X-Authority-Analysis: v=2.4 cv=F6NnsKhN c=1 sm=1 tr=0 ts=6a9ad27c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=ilnOTeOmgiGuhMgLUcYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX2N1QkxZJha4N
 xQQ31kHYL1kFBxZ2R5OpZAhhdwcHRv4VQZdiSCioLvFK21bC1TClY8T+HFT8mewQP3+2ke/0zfC
 ju6h4p+KkjeNWtGWE2LZThwTqCBBMpBnraWeEk2C1czGSo3c6fKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040130

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
- Register a GPIO auxiliary device for the separately submitted AD7768
  GPIO driver.
- VCM common-mode output exposed through the regulator framework, with
  runtime PM management while the output is enabled.

**Patch Summary:**
1. Initialize the AXI ADC state mutex.
2. Add the AD7768 and AD7768-4 devicetree binding.
3. Add the IIO backend CRC operation.
4. Implement CRC control in the AXI ADC backend.
5. Add core AD7768 and AD7768-4 capture support.
6. Validate the master clock rate.
7. Add the power-mode configuration helper.
8. Derive output data rates and the data-clock divider.
9. Configure enabled channels across two sampling profiles.
10. Expose per-channel sampling-frequency controls.
11. Expose per-channel filter controls.
12. Wait for active digital filters to settle.
13. Add per-channel offset and gain calibration controls.
14. Add per-channel conversion delay.
15. Expose the VCM output through the regulator framework.
16. Register the GPIO auxiliary device from the parent driver.
17. Add driver documentation.

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

5. On-chip GPIO: the parent registers an auxiliary device that shares its
   regmap and runtime PM state. The GPIO driver and supporting gpio-regmap
   changes are handled separately through the GPIO tree.

**Base:**
This series is based on Linux v7.3-rc1, commit
cee9395acd8043be0644b25c34bfa86623f2b935 ("Linux 7.3-rc1").

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
Changes in v6:
- Rebase onto Linux v7.3-rc1 cee9395acd8043be0644b25c34bfa86623f2b935.
- Document why the custom SPI protocol requires regmap bulk transfers to
  be split into individual register accesses.
- Simplify register definitions, channel parsing, data-line property
  handling, clock-source selection, error reporting, and fixed capture
  configuration.
- Use standard unit and bit helpers and keep the scale implementation
  stable as sampling-frequency controls are introduced.
- Simplify output-rate derivation, DCLK divider selection, power-mode
  selection, filter settling, and conversion-delay arithmetic.
- Add the mutex only when first used and optimize the driver state layout
  based on pahole results.
- Split the GPIO support patches into a separate series based on
  gpio/for-next:
  https://lore.kernel.org/r/20260903-ad7768-gpio-v6-0-4254ef6c9b38@analog.com
- Link to v5: https://lore.kernel.org/r/20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com

Changes in v5:
- Split configurable sampling support into focused patches for clock
  validation, power-mode setup, output-rate derivation, channel profiles,
  sampling-frequency controls, filter controls, and filter settling.
- Read the positive and negative reference supply voltages and report the
  resulting differential IIO scale for each channel group.
- Allow grounded REF1- and REF2- inputs to omit their regulator supplies,
  treating absent negative reference supplies as 0 V.
- Document the per-channel IIO scale attribute.
- Require a named master clock, remove the default clock source, and
  clarify why the LVDS clock is enabled only after device configuration.
- Clarify the clock-source, supply, and VCM descriptions in the
  Devicetree binding, and drop the unused sync-out-gpios property.
- Simplify scan-mask handling, register-range checks, channel parsing,
  reset timing, probe initialization, and error reporting.
- Use the exact 1.66 ms reset start-up delay and standard time-unit
  constants for fixed delays.
- Avoid runtime-PM references for cached IIO attributes and acquire them
  locally for calibration register accesses.
- Use regmap_assign_bits() for single-bit assignments and sizeof() for
  calibration byte-array transfers.
- Rework gpio-regmap runtime-PM guards and synchronize the pm_dev member
  and kernel-doc ordering.
- Simplify the AD7768 GPIO auxiliary driver's includes and probe setup,
  and drop its cross-tree MAINTAINERS update.
- Note that the AXI ADC mutex fix is already queued in the IIO fixes tree.
- Link to v4: https://lore.kernel.org/r/20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com

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
Janani Sunil (17):
      iio: adc: adi-axi-adc: Initialize state mutex
      dt-bindings: iio: adc: Add AD7768
      iio: backend: Add support for CRC
      iio: adc: adi-axi-adc: Add support for CRC
      iio: adc: Add AD7768 and AD7768-4 core support
      iio: adc: ad7768: Validate master clock rate
      iio: adc: ad7768: Add power mode helper
      iio: adc: ad7768: Derive output data rates
      iio: adc: ad7768: Configure channel sampling profiles
      iio: adc: ad7768: Add sampling frequency controls
      iio: adc: ad7768: Add per-channel filter controls
      iio: adc: ad7768: Wait for digital filters to settle
      iio: adc: ad7768: Add calibration controls
      iio: adc: ad7768: Add per-channel conversion delay
      iio: adc: ad7768: Add VCM regulator support
      iio: adc: ad7768: Register GPIO auxiliary device
      Documentation: iio: Add AD7768 Documentation

 .../devicetree/bindings/iio/adc/adi,ad7768.yaml    |  270 +++
 Documentation/iio/ad7768.rst                       |  273 +++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |    9 +
 drivers/iio/adc/Kconfig                            |   15 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7768.c                           | 1888 ++++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                      |   25 +
 drivers/iio/industrialio-backend.c                 |   33 +
 include/linux/iio/backend.h                        |    6 +
 10 files changed, 2521 insertions(+)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260708-ad7768-driver-10cd15296c20

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>

