Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D15344036;
	Tue, 18 Aug 2026 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063435; cv=none; b=FVUGfBxzaRCutp9ywi84hP/oKJgoZFZTWSUImYDiSo7w7LS0M1EVOb2g+g57hFBDrhHqE3LXM8+R+lrG3ugRoeC2Bv7A7QRyxEtMu0JJVbIuwHwe7ML4rKRWfWDWEnRXo79mp+24VzRQVvOtUCkd62G/RIvEoSzDwvWUrHvMfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063435; c=relaxed/simple;
	bh=fO/MiFbu4zSk/lgoEdvFya3ZQKWOZs1K++KiLGbjg1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ex9/Fm38Dxd0fqNw2dqd6q7rGjl2yLD5W0bEOa0k6IvPjXNcT4J9lBzzu1E2vwISlpC/An3nmvgbe//B2OMRBY2oo7hndnAaneeSaHwXNypPIr4kshgBS75AfQ5EMriw7XQXJdZT7wzf1DYtH99ucsTqF4tV5RVadbW6W2Gro8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dgmIKbP/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dgmIKbP/"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IDuGAn3121330;
	Tue, 18 Aug 2026 10:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=/rmFhWS8vQ5cZ3A4X9ZGRZ6Cxsp
	5+ds/tmqDScuEvaY=; b=dgmIKbP/CS56fAFEoZx3mYxRveafED2slc6MhDQkIzE
	A1W9KJEPkG11U10UNWpJG+x9tmuK/pNndTrYsPlYQ29ZbTy54oCcYFl1E+7xo+C2
	i7gzj6k145fojTD+s9n3In2rHtJbNM/yWRf6E4uOqEMjvbzpW5l84ITQcWbhGHb7
	viz3zzjb8ESI/OrPe0x3xZPIRsg95Trbv9OY9f8yDhjUBzEChhA87qWoccdCKUED
	PsXxAhUIlVutzefvMas2ZKZ2vK14U5yGzUm/VhR1WaA2o90rvL4ONRMrgCdh9CAO
	SDrEWHaUC3AMZVeBIqPOB9I0fZohV6v/Ft/8/1gHBtQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g4nr21aj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 10:29:53 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67IETqnu035908
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Aug 2026 10:29:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 18 Aug 2026 10:29:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 18 Aug 2026 10:29:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 18 Aug 2026 10:29:51 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67IETZOu015349;
	Tue, 18 Aug 2026 10:29:37 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andy@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <siratul.islam@linux.dev>, <u.kleine-koenig@baylibre.com>,
        <linux@roeck-us.net>, <joshua.crofts1@gmail.com>,
        <ciprian.hegbeli@analog.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v7 0/2] iio: adc: add MAX40080 current-sense amplifier driver
Date: Tue, 18 Aug 2026 17:29:26 +0300
Message-ID: <20260818142928.8244-1-stefan.popa@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX4A9FudJF9LIo
 78kOJjidl/wNDTVo7Pj11IowVraWQJRzpFYiKRWbXlXFWHrDnrHexpbfFQWPC7WSfU26GIttaGB
 TCpu5rFvd32OKoSbHY8CVoBh1M/3C0jbNUHBIaE+TtS//8VljZIiHeA4Trujm1TJ3CJIbYBaPhg
 IFflg9Kds/6E1q4Ijas12RtJJsqcYO1DH4EDfwhIa1U2ED/uf/S3UxI4Whn1zVp8JfhH8y8dvzz
 Kjnb+sb4cuR50QQusu8CW663FN/0E/h0b4DZCw/qebw0KNkvO+cujyeXF+qBB31pdLwdqXoIpIS
 NtVq11T7wDUto8ZmM9lac+2GF7b0IHBpHkRedC2lZSMs8Xj+8ykli+3xzsxt1Dh5OwM+CJOP+hO
 Q24WVdN+kDuWv7RNJzgtJoninqKW/h3o5QmOQfBH6IhamS5ad+eDseJBXHo3Rcun5pFlKPlwa7v
 Vl5Lw3Yy5RSFf9IE0pg==
X-Proofpoint-GUID: eV-QQRg7uSx_ikoHf4eFJYdP6R0USGdR
X-Authority-Analysis: v=2.4 cv=B7CJFutM c=1 sm=1 tr=0 ts=6a846c61 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=YosFZmRKdi6gkAz3PX0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXxodcGJcwkrnM
 oXkacXlIE5BZvloKfBa6aRHY1rjxEoT5CbOPAs7lmEs+xaJno82Wc2BbFMtSN5fHM8ruGT86hfp
 CMq4R3wYJf4rA1uM7ILS9PHYsQ5Xc+yVyiSV9ZhOWcg9z557tcoJ
X-Proofpoint-ORIG-GUID: eV-QQRg7uSx_ikoHf4eFJYdP6R0USGdR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

This series adds support for the MAX40080, a bidirectional current-sense
amplifier with an integrated 12-bit ADC.

The driver is placed in IIO rather than hwmon because:
  - IIO's scale/raw model naturally exposes the selectable gain ranges and
    lets userspace apply the correct scale per range.
  - Buffered capture support is planned for a follow-up series -- each
    conversion returns a matched current+voltage pair, which maps cleanly
    to IIO's buffered/triggered model.

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

