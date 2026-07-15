Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA343303A;
	Wed, 15 Jul 2026 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115719; cv=none; b=TrYyCs/RW9OJJKGgS4yya7NdUoIPngR6dlvh7Jt8xZf8vWM8ncxY7+bwuvp/ajHeTItfNRXgWTReh6k0lT/wSsLjkV940o9E32pNcK4rzPJBzRa1EB4zx1f7fH5wMRLmhsTf564gHPninAKT0grJeLsyUa9e463bHrPIVpcy7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115719; c=relaxed/simple;
	bh=x/06NXfngGPfKxOqf7Frx/U9q1s+MvbB2YeN1YMl5CU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=rm2u9jiyEBLnfecjhsKexrD/cP6dzAZKnvBh/5EGS20EUsImgd40V2BE9N4SuIg9oS+6tIwDaBnzOXF/A1IXUGYQsGL2zKxi2ra7XNS/0W3KTt3BTl57a7Zjo+Cnu75pbVsWIXXShbf3QrnoXvUyASHkxfrlxf/dgZ4otmvK5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=inY6PaNT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="inY6PaNT"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBZhAx874851;
	Wed, 15 Jul 2026 07:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=m9XC9G5ycEwWxxTOFgDma//aSSG
	aG9F02NvBtac+wVo=; b=inY6PaNTk+F5sK9GsUXR2mFw6CL99ZfY4RrBfgW+/uE
	TR3w4Nfvmp7SqjMwtnCBycDZtT3u2W7q6/dJNq1CyQ0JFa2MG6dmtmpO4LFA7DVA
	Wz7qcPkiCHdFF37jxzOyP3xO/GLytgPcDOxnKviyRnFIhsQYYZWDjTpcYPjuSS0K
	Wx/sDKnwID/tWC/d6PO2+eGMdPJSBEbjpm0gQwGSEnXYbe0yrCmjhrs+vtgNI7Tk
	iAMQ/aRRYHLRvwbvV9B0Vy1UDib+NvVkzsuP/2rJH2KLmvOfLrgjledldjr5AYuL
	HnROPfHvBmHVG1BkknRhVcZ1DjNBxNX21gdAtwpvYcg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fe8a8883r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 07:41:34 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66FBfWxv004879
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jul 2026 07:41:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 15 Jul
 2026 07:41:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 15 Jul 2026 07:41:32 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66FBfASp024964;
	Wed, 15 Jul 2026 07:41:12 -0400
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v6 0/5] iio: dac: Add support for AD5529R DAC
Date: Wed, 15 Jul 2026 13:41:03 +0200
Message-ID: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM9xV2oC/3XOwWoDIRDG8VcJnmsZdRzdnvoepQdXZxOh3Q1uk
 YSw7143l6RIT/IN/P54EyuXzKt4O9xE4ZrXvMxt0MtBxFOYjyxzalto0AQWnAzJWj0UmUquXKQ
 nGseUPGFi0dC58JQv9+DHZ9unvP4s5XrvV7Vf/01VJUGOiASTie2d3sMcvpbja1y+xd6q+tn7z
 uvm2SiLqMjb5DpvnrwaOm+a1+QiOKNCIN95fHiC3uPuGSNobTCo0Hn78A5U5+3+/wTeDQBMqP/
 4bdt+AR8L3PCtAQAA
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
        Kent Gustavsson <kent@minoris.se>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784115670; l=8140;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=x/06NXfngGPfKxOqf7Frx/U9q1s+MvbB2YeN1YMl5CU=;
 b=m/wDRlUZw7w6zyDSRltMooW7+37MjGHCbqKK5qN93PVRH+L3LrXm+ruge/Ex540+tRtMHacza
 XwH+73WSi/ODBDbHTVCD5MgxsmbBHf8GZsRMzUDfWX3yEG9RFI2Uxjx
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDExNSBTYWx0ZWRfXydb2v1jNefA1
 Orppz9rSalZ8rgBxNL9Kw9h6cdpqFmwSUalgN9mWEFaZptwOx4O+y9xSVJ++t/ZCAM1g2ueS4iX
 dOgZ+4UUSGwbcjqWz0HbOuvn2izHNMPMzK7Yx4y/Ei8yuOZrXi6/Kz3rzDRjHejd5zMXmMZF2bW
 MIFbbMz49ZTzMlKNe9Dhvl6QEsk+lAedTPMhZBz1vIPWihvIm3dqMG5V2htFKOOa3t8LM/F6FUS
 w4YgojC9MqTe0BAy1aAXcE2Np+HRZY2tiAJ25DB/uxgMIRfk75MaOVMb4g8aCrO/BfCufc1UXwK
 Ciom454rOgN1oGuuv3h1ao/DAxC5JG3SeA99FnpgmhCWYGOuRKk4m8pgpMX1bwg2mmKoJGp3ZQS
 5mCmWpiLi1chUUgmZUL2lM/OQg+tYqQSFoaNzcTE8wzVvAktKRscL56C5DMwOVc++/JgY2f9J+C
 ZTRcX3tfNlVbjyrIGLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDExNSBTYWx0ZWRfX8j9ZHN9B2n9e
 Dp7ymvJndbcRrC8T5nlZkFnz4Ia6iFVSXwglzTG5hPj7NqEctFjQEMfQGWBFKYWomVOMn7HLfb/
 5ZFmjS1QnpWzQ7X41CCU3yDScnMbkj7vdWhOLNZDIBAwqfY9bA6d
X-Authority-Analysis: v=2.4 cv=R4sz39RX c=1 sm=1 tr=0 ts=6a5771ee cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=WJSN6tYCzPgVlJIUX1oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tyLGRXFIos61iGesuqPpFvI9ZVndqiVj
X-Proofpoint-GUID: tyLGRXFIos61iGesuqPpFvI9ZVndqiVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150115

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
of addressing. Existing equivalent properties in the Microchip MCP3564
and MCP3911 bindings are retained but marked as deprecated.

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
2. Add spi-device-addr to the MCP3564 binding and deprecate its legacy
   vendor specific property.
3. Add spi-device-addr to the MCP3911 binding and deprecate its legacy
   vendor specific property.
4. AD5529R binding documentation with channel configuration.
5. Implement AD5529R IIO DAC Driver with regmap support.

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
Janani Sunil (5):
      spi: dt-bindings: Add spi-device-addr peripheral property
      dt-bindings: iio: adc: microchip,mcp3564: Add spi-device-addr
      dt-bindings: iio: adc: microchip,mcp3911: Add spi-device-addr
      dt-bindings: iio: dac: Add AD5529R
      iio: dac: Add AD5529R DAC driver support

 .../bindings/iio/adc/microchip,mcp3564.yaml        |   9 +-
 .../bindings/iio/adc/microchip,mcp3911.yaml        |   8 +-
 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 224 +++++++++
 .../bindings/spi/spi-peripheral-props.yaml         |   5 +
 MAINTAINERS                                        |   8 +
 drivers/iio/dac/Kconfig                            |  17 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5529r.c                          | 502 +++++++++++++++++++++
 8 files changed, 771 insertions(+), 3 deletions(-)
---
base-commit: 93df88612859e8e19dec93c69d563b4b73e9bd4b
change-id: 20260507-ad5529r-driver-866bbdd864de

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>

