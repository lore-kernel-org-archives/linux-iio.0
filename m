Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0237A374A1B;
	Wed,  5 Aug 2026 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914326; cv=none; b=AJnyHy6Cf7TEnRvw/FEW4O3RBombX5tRXNeRBwGhoqQp3H2/zq6yjhkRchFr4kc4v6cd0CB1abZr5uhOAZ1G/Qf1ObckuUmUWgficekm1ilwnD2cI9ExSNH4V/IMZ3PD/WyCgrnYP0nf85poxpGsfygR36YXaBFBeSFMPyQEqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914326; c=relaxed/simple;
	bh=1Vy4XQA0KdUtMIBTJC5PqWjtX/O8kiYcVRqMVlcWXPY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=fPh8aukrMKV1QDF6OV7fP61XaAC1IEkicPhtn5MqlhyMoTdnxSzNeKWGmlqM/YHzZLvZf+pfDXQWDnZ66w92SLKufmwZuzpndP4ih6Vi0e8HhcNoTNRcYtaaJx1KNwAdvoV6JOlF2CnzX/o5pze+WNqPeKGz4x1Aw6rN7eRGG+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=a0KGhxOA; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="a0KGhxOA"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755iU40065264;
	Wed, 5 Aug 2026 03:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=bwS2sRxKhD0VwySTPgY8hah2zBN
	g02uRh/ykLfAEaCs=; b=a0KGhxOAI0klD8SfHcw5Okq6ITqaFVcQ9uMbQb66E8e
	AK3Z62qUQZVtY35GslCT2X6AAUPI3ILP6WO/reTmoUpgnQx+7tX/0JQ4Y2KuQh7F
	MQqVOkFrWnqcUEd7q26pqYpzaeTZ91nDQGdm4p0Zh6/DFNK3K3b/DPZ/fhIwdWo2
	oZZN2mymjFcoRmUAICyElh6jJluJ9G6fCT0RaQpip9xsWHepu3OVpYMGNpYvG5Gb
	sS2APSkBOTlvYTRS9OMRzvpXEupR1NflIWRhSXqRpg03csDwLPg2DYE+7ETXvo5N
	nj+AZaMgpflIBsJURz/83e17XHp0lQxY6YE+GBAcFIA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fue6wmv8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 03:18:09 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6757I89Q052715
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Aug 2026 03:18:08 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 5 Aug 2026 03:18:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 5 Aug 2026 03:18:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 5 Aug 2026 03:18:07 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6757Hgx4021587;
	Wed, 5 Aug 2026 03:17:44 -0400
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v8 0/3] iio: dac: Add support for AD5529R DAC
Date: Wed, 5 Aug 2026 09:17:40 +0200
Message-ID: <20260805-ad5529r-driver-v8-0-b41781f5632a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJTjcmoC/3XOTWrDMBCG4asErasy+puRu+o9SheyNEoErR3kY
 lqC7145m7iIrsQ38LzoJhauhRfxcrqJymtZyjy14Z9OIl7CdGZZUttCg0ZwQDIk5/RQZapl5So
 94jim5NEmFg1dK+fyfQ++vbd9KcvXXH/u/VXt139Tq5IgR2sRsontza9hCh/z+TnOn2Jvrfrof
 ed182yUs1ahd4k6bw5eDZ03zWukCGRUCOg7bx8eofd292wjaG1sUKHz7uEJVOfd/v8EngYARqs
 7jwevXOex+ZhT9uOQHbPpPB281p2n5om8iolsSOT++G3bfgFaUdVULQIAAA==
X-Change-ID: 20260507-ad5529r-driver-866bbdd864de
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Marius Cristea <marius.cristea@microchip.com>,
        "Marcus
 Folkesson" <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara
	<daire.mcnamara@microchip.com>,
        Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>, <linux-riscv@lists.infradead.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785914262; l=8886;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=1Vy4XQA0KdUtMIBTJC5PqWjtX/O8kiYcVRqMVlcWXPY=;
 b=ZLIcggrIzqy3URLbwJQtD/97PL9HivRsovwlEXJRE5np7Q/O9h0vA4eK+/w5tdmh8B2qoCn0x
 vDSDM74lHliAItXz3dNs75DQMaZUtrrf//fzd69mtPb76XcBYRCWxsZ
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=SdzHsPRu c=1 sm=1 tr=0 ts=6a72e3b1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=4XpirmV3TBTceRdBKbIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: llrDJW1LyvpO5K1RlWKDFDpfavsIo3e9
X-Proofpoint-GUID: llrDJW1LyvpO5K1RlWKDFDpfavsIo3e9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA1NSBTYWx0ZWRfX/kzJfQOBrDtc
 SXs6MXw6FVW/bUOJ1ko94eqsEfVHHuh38NJxMSi8uXjXspQfQvNjeDHP04oLdc9EC+byrlCcfrF
 bLOfnhHJ1GbF3CUf9bX/3RMsqf0VbNf42yHvkEB8qx8OHOwKuXo/jqAp4tZ9uYpPd9nwZidrJgM
 Frfh++oKbXhsRlvsPO7GN8Lz6HaHh4T0YU+s/LxjxgL+ss77lRcWIz/X4zwjtJooswTp8QoSOCi
 AL1WnRZTqcFeRnrM1ifHFL6VLEWoVttZSTtnBjXHqqoFoxHemhdALrOvajQtVI1hhA6IWOiEoQS
 sTTe65of8LBHlCv/2ipXNfT63b/+b4+iERpEFKzb55U/ckSrrdJMShSmq0EFwFFs5SqnTQ5bAB6
 QysdoQ4VwSKpQf3R2+pjS500zBfaqCFVeh5IzAAFvXCGjU8UvR0SXCwHDhiM1MVMHnnXk2/LraM
 9P5FJUzwWsyh+hr18KA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA1NSBTYWx0ZWRfX7FljMASf/5aQ
 awwgFf5xCa8ZcggVdJcrhjNThKAfLtqVNeWiQtzNjs/iXqA+mvOUTaUCGFU7egn2lWmd3uJl+1w
 MGvVMbbRf92gA9claCjuOv5dLQyTyMOXm5GW04kfUkKV309K2pU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050055

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
 drivers/iio/dac/Kconfig                            |  17 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5529r.c                          | 530 +++++++++++++++++++++
 6 files changed, 817 insertions(+)
---
base-commit: 93df88612859e8e19dec93c69d563b4b73e9bd4b
change-id: 20260507-ad5529r-driver-866bbdd864de

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>

