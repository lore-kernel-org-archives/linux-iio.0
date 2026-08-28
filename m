Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31523909C;
	Fri, 28 Aug 2026 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787905953; cv=none; b=nS+uZyKfhEJQw5iwS41nnaBZLsv/EeivDa48TvKTtJHnUxdI3Jczyvs16t0+S590Zj9/HEezQ2BBYXslb9VWmXyref7dCoVIZInaB0CSinD5U68Jv66OwP+4BxlyO86B75qiN6Eh3ZfnG2qGzMvss1bxthQtWWyaD5WSeo/WESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787905953; c=relaxed/simple;
	bh=thP9TZsJWIMh/hZRkf9oMTKfsus0rZhwFR2Yxngjago=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ozX61qfAqs/7DV0F/Lf1nGYjiJj/9PFiRNG7sj1zgsQ7Ai3McC70wezbn49ER1MKLHrRWpxxhTi1Hs6UhkOHdPg+6FLUc90uG+1BkTzjpXceFlLbEXdP95TtnhmRMwT6sovuLFmAY4iguK3pNIaxLhGG+n6ObK1FxCbytpwKzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FAlCgqk/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FAlCgqk/"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S678bN687737;
	Fri, 28 Aug 2026 04:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=w9bEEZX1y4yBzshQK7ZLuu6k2Dc
	gyXz13tGCYVu0H6E=; b=FAlCgqk/vBMotLsSi67QULGP5ldpJXcFqO5PYBDsmLY
	IXvCCMd48MjtF4quQWlaB+e8YCgC5eWNFVBHoUJTrGf8/ufIshRJhkN9qA0UjuyW
	IQV0cRhqf0kjd/5ebh8jPPooJ2zcPl4ocm+3tD0ZfiviFhAW40yvKI0y9tGqF5Dr
	88RBKrWEm+4jjdbGV83+utdDU/EGyxXi26IlkdTaWRiAUcB2/u6/DNZel5XVlhbV
	DrLcHZvm7uQcS/iW8XMVJjsj6v7FN2a2pDmVCOyvZvMFOtIvhx6IuvzekM3hFTrA
	kbRhMEx1KhX3m+70gykJtxVOnAqzmJAHRV5i+bf/SJg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gad896rxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 04:31:44 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67S8Vh3V060944
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 04:31:43 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 04:31:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 04:31:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 04:31:43 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67S8VQ5b029508;
	Fri, 28 Aug 2026 04:31:29 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andy@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <siratul.islam@linux.dev>, <u.kleine-koenig@baylibre.com>,
        <linux@roeck-us.net>, <joshua.crofts1@gmail.com>,
        <ciprian.hegbeli@analog.com>, <krzysztof.kozlowski@oss.qualcomm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stefan Popa
	<stefan.popa@analog.com>
Subject: [PATCH v8 0/2] iio: adc: add MAX40080 current-sense amplifier driver
Date: Fri, 28 Aug 2026 11:31:16 +0300
Message-ID: <20260828083119.54495-1-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=I4hVgtgg c=1 sm=1 tr=0 ts=6a914770 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=MpOJK7KPi5LqZtta67AA:9
X-Proofpoint-GUID: aYQ2BydGKSj1YM6EQn8l7R5B6d3YT2Gh
X-Proofpoint-ORIG-GUID: aYQ2BydGKSj1YM6EQn8l7R5B6d3YT2Gh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA3MiBTYWx0ZWRfX/uxk6ESwJmL1
 WCeaet1uFqf69xE2VRvruaWCOa9itOk6xjO5wadLP/z4m3RT00Hr4QpF6vYh67vkEOEuo8pse5S
 Vey/RXJFv7cwwTb1bbyfFBiwAipQOypuw3zZsLCu6JjM7ycE3NsB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA3MiBTYWx0ZWRfX8v83EoyuCmHC
 NRimMRBT3Y7qydoBcYMbjxEeABRl5cRGa4U4moKq5uUtbTqCchidkL8pp0k8MkPTaBgqCeVGNtG
 BbkQTK6dLCbwbBmP+3Gjkmr3qufdY78/guQw24Y5dJ3953S9Bfx6RHIp4LRh08vVy4s9gF8B+sk
 56n7VYLJssv407xHo3f96pygywypOpAPNWFl4+0ea1VYwdUuiIcdx+txCi4CXp6R7WT08ak/Jl7
 icztv7P0K0TlJlKwVc7BrYNhOXx0afJ8Ow7DL92/85IeAb/AcwknKaLpezK2ZvDRPtV0VCLBiUo
 aZgB6jtFWzOLk14/ucET5Yc7yY2vOE8Rioqx8lxUBfMqWN+qcpsoHatB45mndtDeR7OJt4Cqocc
 MDd8aOtiYc6jrJPiGtZGoco2giyBfKeMpazS/3CrLQ+qW31vnEVOQHTZ+1eOx9TslA2eb+hLnrb
 hJfI6wQ+d6jlFS1CRsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280072

This series adds support for the MAX40080, a bidirectional current-sense
amplifier with an integrated 12-bit ADC.

The driver is placed in IIO rather than hwmon because:
  - IIO's scale/raw model naturally exposes the selectable gain ranges and
    lets userspace apply the correct scale per range.
  - Buffered capture support is planned for a follow-up series -- each
    conversion returns a matched current+voltage pair, which maps cleanly
    to IIO's buffered/triggered model.

Changes since v7:
  - Add array_size.h include (Andy).
  - Add asm/byteorder.h include, use __le32 buf with le32_to_cpu()
    instead of u8 buf[4] with get_unaligned_le32() (Andy).
  - Use BIT_ULL() instead of 1ULL * BIT() (Andy).
  - Use READ_ONCE/WRITE_ONCE for st->range access (Jonathan).
  - Move propname declaration to function top, assignment near use (Andy).
  - Remove unnecessary blank lines between variable assignments and
    their use (Andy).
  - Place dev_err_probe on single line (Andy).
  - Fix Kconfig/Makefile alphabetical ordering -- MAX40080 between
    MAX34408 and MAX77541 (Andy).

Changes since v6:
  - Add types.h include (Andy).
  - Remove dead code: i2c_smbus_read_i2c_block_data can't return partial
    reads, so remove the ret != sizeof(buf) check (David).
  - Remove dead code: iv variable initialization not needed as
    max40080_read_iv always writes to *iv before returning (David).

Changes since v5:
  - Fix datasheet URL format in binding -- use stable link without /en/
    path component (Jonathan, Siratul).
  - Use 'adi' compatible prefix instead of 'maxim' -- MAX40080 is an ADI
    product (Conor).
  - Split MAINTAINERS into binding and driver patches (Siratul).
  - Add datasheet link in driver header comment (Siratul).
  - Fix comment style: capital first letter + period (Siratul).
  - Fix register defines: add register name prefix (CFG_, FIFO_CFG_, IV_)
    and use designated initializers for csa_gain array (Jonathan).
  - Define MAX40080_ADC_RES_BITS and use BIT() for shift (Jonathan).
  - Use lowercase 'mV' in defines (Siratul).
  - Use C99 loop variable declarations (Siratul).
  - Remove braces from single-statement if blocks (Siratul).
  - Declaration and initialization in same statement (Siratul).
  - Use IIO_VAL_FRACTIONAL_LOG2 for voltage scale (Jonathan).
  - Remove unused i2c_set_clientdata call (Jonathan).
  - Use defines instead of magic numbers for range default (Jonathan).

Changes since v4:
  - Initialize tmp = 0 in max40080_read_iv() before read_poll_timeout to
    avoid using potentially uninitialized value in the condition check
    (Sashiko, Jonathan).
  - Simplify max40080_get_oversampling_ratio() to use cached value instead
    of reading from the device (Jonathan).
  - Remove DMA-safe buffer from struct -- I2C layer already bounces data
    internally for i2c_smbus_* calls (Jonathan).
  - Make shunt-resistor-micro-ohms required in DT binding. The default
    1 Ohm was arbitrary and rarely correct for real hardware (Jonathan).
  - Remove PM ops entirely. Having only resume without suspend was flagged
    as "papering over" possible power loss issues (Jonathan).
  - Remove the {} scope around propname, declare it at function top (Andy).
  - Remove mod_devicetable.h include -- i2c.h provides necessary types
    (Jonathan).

Changes since v3:
  - Removed all regmap usage -- regmap doesn't support SMBus PEC or Quick
    Command, both required by this device (Nuno).
  - Fixed locking: max40080_update_bits() now takes the lock internally,
    and callers update cached state after the call returns (Nuno).
  - Consistent comment style: capital first letter + period (Andy).
  - Use propname variable to deduplicate "shunt-resistor-micro-ohms" (Andy).
  - Return IIO_VAL_* inline instead of break + return pattern (Nuno).

Changes since v2:
  - Added shunt-resistor-micro-ohms DT property with default value.
  - Use single-shot mode with SMBus Quick Command trigger for correlated
    current/voltage reads.
  - Precompute current scale per range at probe time.

Link: https://lore.kernel.org/linux-iio/20260818142928.8244-1-stefan.popa@analog.com/ [v7]
Link: https://lore.kernel.org/linux-iio/20260730131738.822405-1-stefan.popa@analog.com/ [v6]
Link: https://lore.kernel.org/linux-iio/20260723065036.2683075-1-stefan.popa@analog.com/ [v5]
Link: https://lore.kernel.org/linux-iio/20260717123852.1140893-1-stefan.popa@analog.com/ [v4]
Link: https://lore.kernel.org/linux-iio/20260715063652.368501-1-stefan.popa@analog.com/ [v3]
Link: https://lore.kernel.org/linux-iio/20260713120226.90303-1-stefan.popa@analog.com/ [v2]
Link: https://lore.kernel.org/linux-iio/20260703102941.1141341-1-stefan.popa@analog.com/ [v1]

Stefan Popa (2):
  dt-bindings: iio: adc: add adi,max40080
  iio: adc: add MAX40080 current-sense amplifier driver

 .../bindings/iio/adc/adi,max40080.yaml        |  65 ++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max40080.c                    | 572 ++++++++++++++++++
 5 files changed, 658 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml
 create mode 100644 drivers/iio/adc/max40080.c

--
2.53.0
