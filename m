Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C823939C2;
	Wed,  1 Jul 2026 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888097; cv=none; b=jpmWLZIxDTPFX9vlnapl2NF/uGSlL9GYGheMszsY7A0/yWkOXVio7BuVZtikqckik8r3BnZfIni1zA4zcJAEVnSmYZZ9NOUzcuJfcMn2rgqYaugz78yRTGj/b8yx1oigkq1tQkyMy5mdCzN7fXRD1jJpUkej4TVG1Ww/oiS28b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888097; c=relaxed/simple;
	bh=Dfq57po5r9m5Jjzu3Nnky6cW7ciigIazOtfol1C5sZE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=khqaqzFeaR2jHEwNjZPMV3F33/vVwlx4aX+43IzaAaeagfKAsGF2ccSRuv2slEvAK5h0cRFe6vX5GSoDy1nXtPHtyNI3mQfWlFqb6KiYO4Sv/HWQSU/xvxkj0ArKiBhwVeP5G3qQeyjUsej67IsRXqP4oENAqaBcpACQ11Z0GLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mvhv7zXl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mvhv7zXl"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6612wVKe2535986;
	Wed, 1 Jul 2026 02:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=qUglXI7CW4uvKCtK/SNFE+NCDmg
	BovA/shKP9ModlF8=; b=mvhv7zXlDWLSbJa36OnUb3uKFKy0XMM7TXTllQVtoJp
	pgs3dRPljn+Q9c+A3te2I9i00It56gwJgVKnTPzYEkInxqZvv5tLF6CjmECDVICl
	Is76Enlrew8a5/0u96pLH9Dg05XOIzfclOLaaXc6myWtnYcmCJkkrsRJhSWD0MNx
	7yZSJCkPgYhhRtLbu3/tVYItRMR4OziYTyVUoidPXbvF36tBIb2KyTcUdO2KVSWf
	rQQ49nvxrSkCKCseNsaOG9cbhFl7kdcawiN8aFALuvwFOY66K1bpBy0zzpc3Hzlr
	2P5jFUSHIoQvrA2dbfTX39f1ojoVklbD1zcNFUXUCDA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f4604xp9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 02:41:14 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6616fCBs061163
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Jul 2026 02:41:12 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 1 Jul 2026 02:41:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 1 Jul 2026 02:41:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 1 Jul 2026 02:41:12 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.62] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6616etN8002283;
	Wed, 1 Jul 2026 02:40:57 -0400
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v5 0/3] iio: dac: Add support for AD5529R DAC
Date: Wed, 1 Jul 2026 08:40:38 +0200
Message-ID: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGa2RGoC/3XMTQrCMBCG4atI1kbyM5lGV95DXKTJVAPaSipBK
 b27qRuV4Gr4Bp53YiOlSCPbrSaWKMcxDn0ZZr1i/uz6E/EYymZKKBRGNNwFY9Q28ZBipsQtYtu
 GYBECsYJuibr4eAcPx7LPcbwP6fnuZ7l8/6ay5IK3ACg67cvt9q53l+G08cOVLa2svr2tvCqet
 DQAEq0JTeX1l5fbyuviFTZeNFo6h7by8PEoag+LJ/BCKQ1Ouh8/z/MLtmnGwG0BAAA=
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
	<broonie@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782888055; l=6064;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=Dfq57po5r9m5Jjzu3Nnky6cW7ciigIazOtfol1C5sZE=;
 b=16F5p5ocXhNDqOBfK1qxuWYjW6Y1Jq/Nt/2s0KDttL6hkMLVEPdcseshtfhoZzYz77tp1XpvI
 gLpheYxA2KmBR/pU+a1jyewenp0BoMEnGyRZEIfTfThbey3g7ZVzXEn
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2NiBTYWx0ZWRfXwIlP3UEp/eYX
 IpdiobVcblJIUAah97w48ExcXUzfghseiAC7quhmLKVkkYBXJMXCTOEReixt8R2BAYKPT1y0ei1
 n7T8T5R89QtasyQqA+FRC3vMOgX/uizWN6Ro8IZEQl6Fb9mq3NSW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2NiBTYWx0ZWRfX86LQ5DsifUkh
 Gg3amKolj/rtmODfPtx8LeVdFLfRXrVYTXPumosI/QwHx7lXLwjWyPGQzNVhdizFGUu3oc1dYqd
 7Mg68IsP7olecZHdIwO8odY+Egav+7Mtwo8BYa0KIH8phQyE4OIpUPy01wyZf1/1wtBnlzVKeFk
 GWJnSG+9x5KJh1oWXzlYXCoTBK6TFpCYcEv+GXc5OAs3H85G/jFan8PJUJuxXC9N43juoZlAVtv
 E4hIKltqKEH0+zvTV1ZrxMvyWhWz2PB56FlvzoyQen1n3kxnvSKB2iUHridRqbTqHLFDx4FAQe4
 UHp+DPTpz/8toF67+Psb2qhm3p/BSGn22vebFBVkB+gijuFZZhnDnQnUyaTvaIyy7tGnuxPXY8Y
 DrnPZhIxx5XaWO4NKiTOrv5PiZcuhmnWL1eN210537GAnLDyBMS82TOC9IzNkhEU7UJRjaSKQkV
 RPB2TZe4JhzqadrcETQ==
X-Authority-Analysis: v=2.4 cv=BMCDalQG c=1 sm=1 tr=0 ts=6a44b68a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=RFyswZHjbAIkJhqxi8oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _gw89hjhpOuGvgTuEmRthpiRa67A21wV
X-Proofpoint-GUID: _gw89hjhpOuGvgTuEmRthpiRa67A21wV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010066

This patch series adds support for Analog Devices AD5529R, a 16 channel
16 and 12 bit voltage Digital-to-Analog Converter (DAC) with integrated
precision reference. The AD5529R operates from both unipolar and
bipolar supplies. The device communicates via SPI interface.

**Device Overview:**
The AD5529R features 16 independent DAC channels, with 16 or 12 bit
resolution, allowing independently programmable output ranges. The
internal 4.096V precision reference sets the accuracy of the output
voltage.

**Features Implemented:**
- Support for AD5529R 12-bit and 16-bit variants via device match data.
- Reset support via GPIO.
- Dual regmap configuration to handle 8 and 16 bit registers.
- Per-channel output range configuration from devicetree.
- Optional external reference and bipolar supply handling.

**Patch Summary:**
1. **dt-bindings**: Binding documentation with channel configuration.
2. **driver**: Implement IIO DAC Driver with regmap support.

**Testing:**
The driver was compiled and tested on the EVAL-AD5529R-ARDZ using a
coraZ7 with a mainline v7.0 kernel.

**Driver Rationale:**
AD5529R introduces:
1. A unique register layout
2. Mixed 8-bit and 16-bit register accesses
3. Hardware specific features like function generators, multi-die
hotpath registers etc.

The device warrants its own drivers due to these fundamental
architectural differences, that would require substantial changes to
existing drivers without providing reusable benefits. The standalone
driver also allows future extensions for related devices in the same
family.

**Not Implemented in this Series:**
The binding includes generic, per-channel device addressing needed for
multi-device support using a shared CS, but the driver presently
supports only a single device.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
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
      dt-bindings: spi: Add spi,device-addr peripheral property
      dt-bindings: iio: dac: Add AD5529R
      iio: dac: Add AD5529R DAC driver support

 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 216 +++++++++
 .../bindings/spi/spi-peripheral-props.yaml         |   5 +
 MAINTAINERS                                        |   8 +
 drivers/iio/dac/Kconfig                            |  17 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5529r.c                          | 531 +++++++++++++++++++++
 6 files changed, 778 insertions(+)
---
base-commit: 93df88612859e8e19dec93c69d563b4b73e9bd4b
change-id: 20260507-ad5529r-driver-866bbdd864de

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>

