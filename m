Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D737882B;
	Tue,  9 Jun 2026 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017286; cv=none; b=NT4c9RiVSyZJN3ZA+2wdP0TC05JDZAO/DgLYR0j5bWIK9MqUH8CgJgJ1sHdG9XslRS/3kkO1yVFuEaKLFBNKqNKQAl6LrlnVICiixqL5fRqwMjf9Ib5cXxCaycuKzRzoGWI+cesb3xEkw/p/c27XQWmuwpuivjW/9JFNG3Rw44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017286; c=relaxed/simple;
	bh=osuIgOhwLk4A6x1vMgUY4WOqFjQ6Lj1LwO6l4YH496I=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=A/Ua2TET4qbYiHxxVW7oAJGwc2CFbRzrgjnBYETdp25UcEBe5uiyIWP2S/x5ZNiFkWTyZzqcyR53XC4tVdI1GwQbMPdxOS/oz+wgpg/c3Y9FcH7Y1Aup1r3MxgkVzB3q5n93qNQPJ0Aisux5K/AbUlsMZO/oF74bUdbFFleHJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TlprrHzY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TlprrHzY"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659CpMh81070513;
	Tue, 9 Jun 2026 11:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=XtUbU8sJECamcrz2bW2ccJZ9/Tm
	AZpnRb32KkDPytdk=; b=TlprrHzY2v7teGY9xXED5DI7i1HXFsDaJSXv8623cqr
	Wepvj1qTxWNr6q+fNvTwUKjFixR/pb+J0L3X03vGdik9qH8FHW/n9rAf9Q/IJpW3
	3BaFC1NQKUcV2DLwWQDkat/d619kZhBaqVYse6fF/L4dZl21DCF6FLJaWBKVJ/Jp
	MmY8mN/DdyqdmO+XVGZg2xFPutXGHa7BGkfZ3yimyUeTdobCvuopLubfhmWvNbT0
	VtEr+4oA/ASA7upACzUnww1Rn9xbNTJsFxyGyB2lTMdTLpk6oYR/kPjrOAVY14En
	tU4avQUX2eAta7VemRKETqBmeldUaaVr2fDSavxdZvg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4epaa2jd50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 11:00:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 659F0qZa007380
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jun 2026 11:00:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 9 Jun 2026 11:00:52 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 9 Jun 2026 11:00:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 9 Jun 2026 11:00:52 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 659F0au1031316;
	Tue, 9 Jun 2026 11:00:38 -0400
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v4 0/2] iio: dac: Add support for AD5529R DAC
Date: Tue, 9 Jun 2026 17:00:19 +0200
Message-ID: <20260609-ad5529r-driver-v4-0-2e4c02234a1a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIMqKGoC/3XMTQrCMBCG4auUrI3kP9GV9xAXaTJtA9pIIkEpv
 btpV5XiavgGnndCGVKAjM7NhBKUkEMc6xCHBrnBjj3g4OtGjDBFJNHYeinZKWGfQoGEjVJt671
 RwgOq6JmgC+81eL3VPYT8iumz9gtdvn9ThWKCWyEU6birt7vY0d5jf3TxgZZWYVtvdp5VD5xKI
 agy0uud5xtPTzvPq2dKO6I5tVaZHz/P8xfziwwXLQEAAA==
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
        Shuah Khan <skhan@linuxfoundation.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781017235; l=4679;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=osuIgOhwLk4A6x1vMgUY4WOqFjQ6Lj1LwO6l4YH496I=;
 b=7DoXAT98tTnUIbVckMTXHxq9Ge6pV9mv8pwM1krmXpAXhSB01mv5d0ucHM5BhxB+fTZlxa5x5
 JloPFbjDJFiBFOwMen3ZqLY6zzGR57w6wBnUAoYuHfYrrFnAStuEKu2
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=O6gJeh9W c=1 sm=1 tr=0 ts=6a282aa5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=TO-HZfrkYtFgNpTHoC0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0MiBTYWx0ZWRfX7wBUHzqQD/pd
 RSxjVHp9DvIO4NZv0hF2xpI2ZRDTETao4yG/udQ5+82/2pK3CFLFN2pPrtt+kpy8NiDahFVcqx8
 wW4wuj0LbObSFJFs5IUXbJMKvqb1G5DxuVTKCw7w3PDrqW1PE/zOrJczjoVBfFIylTXiov3TByJ
 fFOe7RheFDQmVi7onObtRbfZu13I53Dq3HBYz6W4+vO8GvPIoXE7F1GIRaNytEZnj0L9PtE2h67
 QToYaH+9AKCEKZAuuTdVku75NfaTFfZLRaFbJX1fOjOZ4QF22TG6VJgEDN6oIW1PxRSHen9qRI8
 3g1jBA1XhpyCX5DmH5woWkbTHBR1LYwHb7+XGHu61C+PCImTjAEaK7M5Xn9S+bMXWco3tW0YIPi
 HAcL9iHPSn+bXwq7bIK/LD282pIwqEaLYmSt6E4shEe0QLL0euP+6fA/CzO7I4ndQ/eIx22NMBP
 qXG/4e+KFjPP+9Wgedg==
X-Proofpoint-ORIG-GUID: tUJ8aP-tZ1MoD6AdWx2ae_PdeaP4HhfE
X-Proofpoint-GUID: tUJ8aP-tZ1MoD6AdWx2ae_PdeaP4HhfE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090142

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

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
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
Janani Sunil (2):
      dt-bindings: iio: dac: Add AD5529R
      iio: dac: Add AD5529R DAC driver support

 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 208 +++++++++
 MAINTAINERS                                        |   8 +
 drivers/iio/dac/Kconfig                            |  17 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5529r.c                          | 517 +++++++++++++++++++++
 5 files changed, 751 insertions(+)
---
base-commit: 93df88612859e8e19dec93c69d563b4b73e9bd4b
change-id: 20260507-ad5529r-driver-866bbdd864de

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>

