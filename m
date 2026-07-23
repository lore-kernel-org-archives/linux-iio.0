Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6561A346E74;
	Thu, 23 Jul 2026 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789486; cv=none; b=cXA6fjEu8FRAsEpbCZ29m9HoCnSLcBe3IUqu4zUzWH8znFoT5rkU53RON4PD5+Zh0N7SO++MAgtH1jkuZUDD232/2aQWt7wMO+1AxFWz4SbN4+uZBBsLd7fgZSjlxqd3aYEAbLunm6SMsQjs+dzmV0+UYMUe9USVusn/Nuty/3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789486; c=relaxed/simple;
	bh=IldCBTIVQ/20IH2of9ojT4K6QWDUBkC9r8K95rwpswo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nZFBGPxLEBKkZ/wSYOPc4VFRmrgFcMkOciFihR7rkoQRGOgdOGWvnV72e7k7wkITcBrchnb6MPU/+ftxyIMt7H9079wVccHNrn8jPX+KN4sIMB/8r7v53YNpvXWGhyyhiDCJFTOPZ2gqfQQApGibyPoc/FNpgO2Xv31OJQDEQ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dIm4Phku; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dIm4Phku"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N4xbQP1191979;
	Thu, 23 Jul 2026 02:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=C+06+t5Vnmb0imB+GgslTdHyKCz
	tk1vLc1A4qLZgHBg=; b=dIm4PhkuXNIimHfAqh0H5aYOOl906KZBZcHxrU2vkiF
	MczEFjW0mcVBp53+3APM1rFsulzN5ClWh4w5P/0em1d152Q10vTtccqX7LoJJTJR
	C8jzqFDwyvmZ7s3TDY6+A1TNYtB6GM8/nrywu5jNDk993e7/2geEKsgg0pyU2xEQ
	tJiVx0GpcqRkTF+aomddf9/XpDZ14gO7SCC2vHfDdicWGY3qmx1D7Fk/6F5QgVuI
	vBAif7VZKPVE4UPkaAYCVQBOm54D7BrNRP7hXNuw5ku8q6GFpteP+l+I89e/Topq
	L1fZvoik9Dc/AS5vNcNWwJmJUIyTfFo5F6MGR7aOz/g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fjnd9p0ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 02:51:02 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66N6p1rP039195
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 02:51:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 23 Jul
 2026 02:51:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 23 Jul 2026 02:51:01 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66N6olKw030342;
	Thu, 23 Jul 2026 02:50:50 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <linux@roeck-us.net>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dlechner@baylibre.com>,
        <ciprian.hegbeli@analog.com>, <siratul.islam@linux.dev>,
        <u.kleine-koenig@baylibre.com>, Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v5 0/2] iio: adc: add MAX40080 current-sense amplifier driver
Date: Thu, 23 Jul 2026 09:50:34 +0300
Message-ID: <20260723065036.2683075-1-stefan.popa@analog.com>
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
X-Proofpoint-ORIG-GUID: VLC4CTfIRrv15bGBb3kwcOfAr2C104el
X-Proofpoint-GUID: VLC4CTfIRrv15bGBb3kwcOfAr2C104el
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA2NyBTYWx0ZWRfX6pnssPUupqFs
 qKZIRLMPTbjeRSw6Qe5JjQ8ONy6JvhB5M0ZLVpcGarqtinjbtZ6TMyVkHmSx660f6X9UieDwokV
 LIEnvx/y5PSU+OsqsFHTZMgQHKoOL087clvta1kVzndxmo7Mn12ywLXSIQc5CQbPw/oBCZJaDeE
 j+S6frawxaADARr11WWK3Cw05JBZZcjpp8P1tfIRLcf/aLYJn2I1ilZ8zpNp+6j20eDeuEg1OVF
 oT0CN7AZLTBwPuCTwEPQs97Vt7yfqEbFxqoHRtbz0s/ch7h4MpouZRC2I3oDvs8ltcLEck91B8U
 4/M0bHhDKs33g8PfgFvvDHvhp/PgDJFE24ymN/ni+Z/lx0nzdXCrNg45WDq/EF2jEbTglFUUeS7
 iSPXDfn0HNLYvh/EovLf0tajpxnoEBO4sMbx3AzcQn/2YENq4ZnN+/QhvN9VhnSDyJloPvwCA4S
 RtIUt2A6JV4ZqViFZqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA2NyBTYWx0ZWRfXwNaj2o7WPlnx
 ykL11wKLom+dsE+DReaZrNQ3gnlfvGZ3W9v4FHKjZXBe+uxNjgcZ0Fk2nwKLHDCvdZPrteSv41z
 /x1N1LmT0je/a/uPdn/pRZ8tzRXhxO/FeJ6Pk8ajob70aPbqYZVY
X-Authority-Analysis: v=2.4 cv=BYHoFLt2 c=1 sm=1 tr=0 ts=6a61b9d7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=UunNvpd7KEJHXI4jChAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230067

This series adds support for the MAX40080, a bidirectional current-sense
amplifier with an integrated 12-bit ADC.

The driver is placed in IIO rather than hwmon because:
  - IIO's scale/raw model naturally exposes the selectable gain ranges and
    lets userspace apply the correct scale per range.
  - Buffered capture support is planned for a follow-up series -- each
    conversion returns a matched current+voltage pair, which maps cleanly
    to IIO's buffered/triggered model.

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

Link: https://lore.kernel.org/linux-iio/20260717123852.1140893-1-stefan.popa@analog.com/ [v4]
Link: https://lore.kernel.org/linux-iio/20260715063652.368501-1-stefan.popa@analog.com/ [v3]
Link: https://lore.kernel.org/linux-iio/20260713120226.90303-1-stefan.popa@analog.com/ [v2]
Link: https://lore.kernel.org/linux-iio/20260703102941.1141341-1-stefan.popa@analog.com/ [v1]

Stefan Popa (2):
  dt-bindings: iio: adc: add maxim,max40080
  iio: adc: add MAX40080 current-sense amplifier driver

 .../bindings/iio/adc/maxim,max40080.yaml      |  56 ++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max40080.c                    | 586 ++++++++++++++++++
 5 files changed, 663 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
 create mode 100644 drivers/iio/adc/max40080.c

--
2.53.0

