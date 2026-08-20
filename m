Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224423B892B;
	Thu, 20 Aug 2026 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787209770; cv=none; b=ZZlC903HDBEKM9jrN9mrG+jQklcyroNTDJnIuh+QN74Sq6wnyOhAqSJjFQkBD0UmYflWP+SeXet6qFPk4byN9+Xwl6mRlzyJAjU92rV87Gas9hB+n68sRp9SzeOUNUmTP5IUwJjVbUBRb9TjCZtSbDOUq/yWssiARylYj+bmYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787209770; c=relaxed/simple;
	bh=WaUtVJD8k6I3qdP4jNXvqALImjfFJsSApnruVjO+nxE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=e1TiCL6mPZIFf54I05S42GhejhZ9PmVHy3+GRScejcBjNR2tbN0rsqwCUodgfrSwX/ca9ATgoxrJC6ATlTR/xuC7WquilS/JrrpPUAFz/ACfjrtFz4JW+Xkfqx7lez/mxHiFExC3DCfq2WhoVf8pTUL+uK57AZ3cvef8SAhxHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RWNDbEVO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RWNDbEVO"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K3sEf82445561;
	Thu, 20 Aug 2026 03:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=InXWJt9pbU4F3hOMoeL9BfWgRMr
	lBsmI1c7bAaF69tY=; b=RWNDbEVOIZP+b0DXTLaNPbrw/TLll8JHKcQcRdvpZcp
	JPQwr6KCqpMn3/HRFdv3nGDYyN7MGEMc/sdjJtYxyLFNCFXc6g6enARbdWAWDgRV
	19vCubU1cq3tL29S/qW8IFCQ/E4iiWwjF0YyN+WJqtSwbWjksYM+uFgzxaNNp2+Z
	+fVvI698o5/hmTyURkcri8WIsh9Le1R5jI4TdpQBKSVPJ789ac9bLLV0N7F9pTxF
	8+Pvigy1MsDELxuhD1WtSBxKobOwV8o95jWQ7sQ8YCPfiUp/D6A/wZxORpMi0+hk
	l3AX7sivG9MT38QDEntQatawVT2Y8JI3Pjjdm+v40wA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g4yeps9xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 03:08:48 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67K78lGw018789
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 03:08:47 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 20 Aug
 2026 03:08:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 20 Aug 2026 03:08:47 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.68])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67K78OkY003019;
	Thu, 20 Aug 2026 03:08:26 -0400
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v9 0/3] iio: dac: Add support for AD5529R DAC
Date: Thu, 20 Aug 2026 09:08:20 +0200
Message-ID: <20260820-ad5529r-driver-v9-0-ba62e0b2a816@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOSnhmoC/3XRz2rEIBAG8FdZPDdlHHU0PfU9Sg/GP7tCmyymh
 JYl716TS1KGnuQTft+M+BBzqiXN4uXyEDUtZS7T2EL/dBHh5sdr6kpsWSAggQHb+WgM9rWLtSy
 pdo5oGGJ0pGMSDd1ryuV7L3x7b/lW5q+p/uz9i9xu/61aZAfdoDVBVqGd+dWP/mO6PofpU2xdC
 569Yx6bT0oarSU5Ey3z6uRlz7xqHskGsEp6T455fXgC7vXmkw6AqLSXnnlzeAuSebPtH8HZHiC
 RRubp5KVhnpoPOWY39NmkpJi3J4/IvG3eWidDtNpHa5h3h3fA57v9/2RryIYU/n3/uq6/0tDnw
 m0CAAA=
X-Change-ID: 20260507-ad5529r-driver-866bbdd864de
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Marius Cristea <marius.cristea@microchip.com>,
        Marcus
 Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara
	<daire.mcnamara@microchip.com>,
        Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>, <linux-riscv@lists.infradead.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787209704; l=9197;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=WaUtVJD8k6I3qdP4jNXvqALImjfFJsSApnruVjO+nxE=;
 b=eiWkHTT0szEJN87qQsEGoYQE8f4Mb5ou5owZoFm/bpW6wQQEp+Xws4F3LIHOUHjBwjt26Pkmm
 n0WXEGb+355BqAteju4Vkr/PI/2WpWh0cShjZedcCp6I9hDw3DnIn0x
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: C7AuVAen3rJ0frDy5jtEmZrZ92NCFL8k
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1MCBTYWx0ZWRfX4a9Tsqvj8lPw
 G6lV4ZAcaql/ryXLYULIyP1pahBDPK6J7r+I6TKoAJZ56GRWcs/7bIgMHTjbIBeabqqFA7QDlUJ
 cMxr5WM1YUGRa3nyJLuxRFW62XhQQa6cqJWbsM4x/wUDhXXNWB5Y
X-Authority-Analysis: v=2.4 cv=NLHlPU6g c=1 sm=1 tr=0 ts=6a86a800 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=IWTvGB1dTFcGZpCuenYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1MCBTYWx0ZWRfX5kEMunN+l3jQ
 3i6fF1FeLS4qzeaMd4GWvW8hhBir4QVNb4w27u6IOyGcYFcqO5mKvcVFvTAMdV0f9cg89J8sYif
 v5DRV/Y3eGxEPQgewd9+qX1uvidhvKfG45AyyRYQfPL262xlpPEVhdNOVjVveaiqFzjD4HIm9Qx
 1IyHVPPgZqMI2lXx/7xksY0DXV1UfAyxu5Mw5w8S2jGAkUoG0mPjjO03pzOr7pwzrA5NiE6C2a9
 HjihOolthdNlFxZ8XxdBcrPufWkP1zGzFqJ2LIAJKx8/1DyPR5mBo6Snro7VUheCaAvhURxAQLw
 z9LbqedPF/oxG8gi2Apauka7DGXGDZBbzOLYNb3kA1AmlZ+OLY2RXOUj11lB3uiPRLYQRXPYUHb
 y3fSeGIJAxANoJirZy8GfNgjt1sOwa3S7mx4MY5BOB1TOpRzNTrpUshik/FPPxVgxpXc/e5z4+n
 1HLb+kw1XvYm5n/V7RA==
X-Proofpoint-GUID: C7AuVAen3rJ0frDy5jtEmZrZ92NCFL8k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200050

This patch series adds support for Analog Devices AD5529R, a 16 channel
16 and 12 bit voltage Digital-to-Analog Converter (DAC) with integrated
precision reference. The AD5529R operates from both unipolar and
bipolar supplies. The device communicates via SPI interface.

**Device Overview:**
The AD5529R features 16 independent DAC channels, with 16 or 12 bit
resolution, allowing independently programmable output ranges. The
internal 4.096V precision reference sets the accuracy of the output
voltage.

The device can encode a hardware address in its SPI command frame,
allowing up to 4 devices to share a single chip select. This series
introduces a generic spi-device-addr property for describing this type
of addressing.

**Features Implemented:**
- Support for AD5529R 12-bit and 16-bit variants via device match data.
- Support for a single DAC device using any hardware address between 0
  and 3.
- Reset support via reset controller framework.
- Dual regmap configuration to handle 8 and 16 bit registers.
- Per-channel output range configuration from devicetree.
- Optional external reference and bipolar supply handling.

**Patch Summary:**
1. Add the generic spi-device-addr SPI peripheral property.
2. AD5529R binding documentation with channel configuration.
3. Implement AD5529R IIO DAC Driver with regmap support.

**Testing:**
The driver was compiled and tested on the EVAL-AD5529R-ARDZ using a
coraZ7 with a mainline v7.0 kernel.

**Driver Rationale:**
AD5529R introduces:
1. A unique register layout
2. Mixed 8-bit and 16-bit register accesses
3. Hardware specific features like function generators, multi-die
hotpath registers etc.

The device warrants its own driver due to these fundamental
architectural differences, that would require substantial changes to
existing drivers without providing reusable benefits. The standalone
driver also allows future extensions for related devices in the same
family.

**Not Implemented in this Series:**
The binding includes generic, peripheral level device addressing needed for
multi-device support using a shared CS, but the driver presently
supports only a single device.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
Changes in v9:
- Add a 10 ms delay after power-up before the first SPI transaction.
- Document why the fixed scale applies when using an external reference.
- Reflow the AD5529R Kconfig help text to 80 columns.
- Link to v8: https://lore.kernel.org/r/20260805-ad5529r-driver-v8-0-b41781f5632a@analog.com

Changes in v8:
- Rename the AD5529R supply properties to match the datasheet supply
  names.
- Describe and enable all four positive and four negative high-voltage
  supplies.
- Reject duplicate channel nodes and configurations with too many
  channels.
- Add the required 20 ns delay between reset assertion and deassertion.
- Add a macro to represent the number of channels.
- Return -ENODATA when device cannot be identified.
- Clarify that spi-device-addr contains one address per physical device.
- Drop the Microchip binding and driver changes from the series.
- Drop brackets around scalar spi-device-addr defaults.
- Simplify the regmap_assign_bits() reference selection value.
- Link to v7: https://lore.kernel.org/r/20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com

Changes in v7:
- Drop #include <linux/mod_devicetable.h>
- Add comment on minimum HW reset low width.
- Flip the vref regulator error check.
- Clarify why spi-device-addr is an array, with one address per physical
  device sharing a chip select.
- Add default addresses for mcp3564 and mcp3911 bindings.
- Initialize AD5529R regmap configurations locally using designated
  initializers.
- Update "Patch Summary" section in the cover letter.
- Link to v6: https://lore.kernel.org/r/20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com

Changes in v6:
- Rename spi,device-addr to spi-device-addr and define it as an array at
  peripheral node level.
- Fix the SPI binding patch subject prefix to use "spi: dt-bindings:".
- Add spi-device-addr to the MCP3564 and MCP3911 bindings.
- Deprecate the existing Microchip-specific device-address properties.
- Replace adi,output-range-microvolt with output-range-microvolt.
- Move AD5529R device addressing from channel nodes to the peripheral
  node.
- Include linux/types.h
- Honour non-zero hardware address in the AD5529R driver.
- Dynamically expose only the channels described by devicetree and
  remove unused scan type definitions.
- Use explicit reset assertion and deassertion as the GPIO reset
  controller does not implement reset_control_reset().
- Use the MICRO and MILLI unit constants when matching output ranges.
-  Simplify optional reference regulator handling and remove the
   external reference comment.
- Simplify error messages and stick to 80 col.
- Link to v5: https://lore.kernel.org/r/20260701-ad5529r-driver-v5-0-ed087900e642@analog.com

Changes in v5:
- Move register bitfield definitions next to their parent register
  addresses.
- Remove spurious extra indent.
- Rename ad5529r_output_ranges_mv[] to ad5529r_output_ranges_mV[].
- Remove extra parentheses in regmap_reg_range() for the readback range.
- Use reset_control_reset() instead of reset_control_deassert().
- Use 10 * USEC_PER_MSEC instead of a bare 10000 in fsleep().
- Use fwnode_property_present() to explicitly guard the optional property.
- Rewrite external_vref detection using explicit if/else.
- Follow reverse christmas tree variable declaration order.
- Improve invalid channel error message to include the maximum.
- Add a new spi property to include the SPI device address.
- Update ad5529r devicetree binding to allow more than 16 channels to include multiple DACs.
- Update cover letter to add a mention about the multi device support.
- Update driver commit message to describe the device further.
- Link to v4: https://lore.kernel.org/r/20260609-ad5529r-driver-v4-0-2e4c02234a1a@analog.com

Changes in v4:
- Fix DT child-node regex for hexadecimal channel addresses.
- Wrap long DT binding description lines.
- Simplify optional `vref-supply` and `hvss-supply` handling.
- Update REF_SEL programming for optional external reference use.
- Clean up range parsing and error messages.
- Simplify debugfs register access by calling regmap helpers directly.
- Add clarifying comments for reset settling time and RAW reads from `DAC_INPUT_A`.
- Remove an unused vref regulator pointer and an include.
- Rename the REF_SEL bit define and clean up small driver details.
- Toggle pins defined as PWM pins, instead of GPIOs
- Update cover letter to sync up latest changes.
- Link to v3: https://lore.kernel.org/r/20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com

Changes in v3:
- Split into adi,ad5529r-16 and adi,ad5529r-12 device tree compatibles
- Add DT-based output range configuration via adi,output-range-microvolt
- Expand DT binding: vref-supply, clear/tg GPIOs, interrupts, muxout
- Correct power supply voltage specifications as per datasheet
- Reduce SPI frequency limit to 25MHz as per datasheet specs
- Switch to autoincrement addressing mode, remove +1 register offsets
- Use DT match data instead of device ID detection for fallback support
- Implement dynamic scale/offset calculation per configured channel range
- Added explicit val_format_endian and reg_stride for 16-bit regmap bus
- Code cleanup: alphabetical includes, ARRAY_SIZE(), unused defines
- Minor: .sign→.format field, simplify read/write order, optional hvss-supply
- Remove redundant driver documentation ad5529r.rst
- Link to v2: https://lore.kernel.org/r/20260508-ad5529r-driver-v2-0-e315441685d7@analog.com

Changes in v2:
- Fix IIO scale to use millivolts per ABI requirement
- Fix documentation voltage calculations (2.5V not 2.048V)
- Fix bipolar ranges in documentation (±5V, ±10V, ±15V, ±20V)
- Fix alphabetical ordering in documentation index
- Add missing newline to documentation file
- Fix scale units description (millivolts not microvolts)
- Include a section for driver rationale in the cover letter
- Reword contents in cover letter 12/16 bit generic->variant
- Add dependency array for spi-cpha and spi-cpol properties
- Link to v1: https://lore.kernel.org/r/20260507-ad5529r-driver-v1-0-b4460f3cb44f@analog.com

---
Janani Sunil (3):
      spi: dt-bindings: Add spi-device-addr peripheral property
      dt-bindings: iio: dac: Add AD5529R
      iio: dac: Add AD5529R DAC driver support

 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 254 ++++++++++
 .../bindings/spi/spi-peripheral-props.yaml         |   7 +
 MAINTAINERS                                        |   8 +
 drivers/iio/dac/Kconfig                            |  16 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5529r.c                          | 538 +++++++++++++++++++++
 6 files changed, 824 insertions(+)
---
base-commit: 93df88612859e8e19dec93c69d563b4b73e9bd4b
change-id: 20260507-ad5529r-driver-866bbdd864de

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>

