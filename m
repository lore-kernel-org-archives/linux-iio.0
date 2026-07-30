Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C58433BA9;
	Thu, 30 Jul 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417522; cv=none; b=KC35Lq0z8gnqo5ntHe540Ldlvk2H05s2sy2lKHMPv6m7LvBf/VTIPX8/s5COMIaTL0ZOXHdXlaDfc2Tmyy4iiB8ZpTxt4a1fz9HBndTjYoYEizYVlFOtceFef8uVXYfKDf3Fr/V1OjNqSXUeCgDb6G41neBBqOMG+Iw57FY6uVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417522; c=relaxed/simple;
	bh=RwbrVvFP5ACD68QG4+ESkwUpauO2BteO6XvW6k51aNg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LOxSZTFXkpbjbfSS+G8DpA/Sp3c268z1NqJyMAjXW7guFvqZJIdw3SKO50e2JRbNxdRamdr5n31XlKCmbnu0TQZHHResjXIfC6sIAdTG2ITTR6MxnUuRmDvRWzKJ1AT5OLr0SDvXdOcsR6uXVABkbd4UY69GbnbQPIy9r9FeWd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=roGi+4Un; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="roGi+4Un"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDEtgR845127;
	Thu, 30 Jul 2026 09:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=YMQwYUQ7OXYANWycqdKRgaCpcRu
	DZiPHnlXYPEIlS5g=; b=roGi+4Unc3krHX5Mh2uQv5jKL/wrwYqWmZHjBPCTHzN
	m7Jl4qUceNWL/ThNkDGwKDoetmcTUIWGLPAiwImnRXgc8xzh+edYHg6BVjyHJazE
	rvwHLAUCUuIUz2Hxah/11ZStcDxRN2C8OsRcNYYSD+9ZNnL5Jc7vfJ1kMjun5z36
	7eWVMm77GdELQtYakHETYN733eJus8Mjrw1W5lQN9jURGfLT5aN2V9PySCkqH4Km
	yaFZvMmbF6QvAD140G+Wg2Yl9n3PBTkCIftxcROfcyGn/uy7WZEhCLeiICSxZDyv
	Fc04F6ddFvDg5jBgn0hAz10S3Y3f80iK3NUBthNErGQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fqj4f5b5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 09:18:15 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66UDIE8C022487
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Jul 2026 09:18:14 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 30 Jul
 2026 09:18:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 30 Jul 2026 09:18:14 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66UDHtPu008508;
	Thu, 30 Jul 2026 09:17:58 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <linux@roeck-us.net>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dlechner@baylibre.com>,
        <ciprian.hegbeli@analog.com>, <siratul.islam@linux.dev>,
        <u.kleine-koenig@baylibre.com>, <joshua.crofts1@gmail.com>,
        Stefan Popa
	<stefan.popa@analog.com>
Subject: [PATCH v6 0/2] iio: adc: add MAX40080 current-sense amplifier driver
Date: Thu, 30 Jul 2026 16:17:36 +0300
Message-ID: <20260730131738.822405-1-stefan.popa@analog.com>
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
X-Proofpoint-ORIG-GUID: 6UYUd8sbsY-wPWYTSxS_O9iMLyNflOX6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMCBTYWx0ZWRfX2V6rTSuMKIBT
 27WjT15JGJFUlG7q3EOIo9957JGm/dhE4GIL1hxFyOdSirvrnFqM/HBDljBxry3Kw3DhlUUeWK5
 xEK7dHyUm8XHY6Mr8pjYOv37v299AQLmi6P0KLBW/3TJTmCTjAfwRXWJBQCLRR2zI2k2bpCF6rW
 5FZgfFLiKTaTQvRaMGmzT01u15nTAmHEpb+KR+9DQD83IWXP/KeKQAjYsetW1GDpm6OBMC78fya
 Q5mgQoiV2qDqHzDXTwWCbCSrjicyBcf7BlcgG1jK695J5+QhXOGIgRdZQlDUm9ibwl+tAw+50yY
 7Og3nb3qZUawQIqw+WRw8lrQBaxBFsB2uCYjtC1fGkEKXXzmUb5u64UDWHgJEl1rJZf2E1/SNPd
 oHqaPernTuBWK0YUGi6ZwMXHPbr3mzJVYvH/Hl63wmkTA/RcXhzTexKSbYsC1Ab894sI+U54/1C
 NFTGL/S501gC5Cc9MRw==
X-Authority-Analysis: v=2.4 cv=EMk2FVZC c=1 sm=1 tr=0 ts=6a6b4f17 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=UunNvpd7KEJHXI4jChAA:9
X-Proofpoint-GUID: 6UYUd8sbsY-wPWYTSxS_O9iMLyNflOX6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMCBTYWx0ZWRfXxgUgESEzbHHu
 kn8l51pfeocM8mB1h89VT26xBa4x6yfIgldaNj1m3qWu6B39XvagKXA5Y+yukYGAyD+g1WyU1GG
 vT9tDp/ojR25E8i50R3QeTfPIVIGd78KidxoMUZ1qC/EVP8sXMzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300100

This series adds support for the MAX40080, a bidirectional current-sense
amplifier with an integrated 12-bit ADC.

The driver is placed in IIO rather than hwmon because:
  - IIO's scale/raw model naturally exposes the selectable gain ranges and
    lets userspace apply the correct scale per range.
  - Buffered capture support is planned for a follow-up series -- each
    conversion returns a matched current+voltage pair, which maps cleanly
    to IIO's buffered/triggered model.

Changes since v5:
  - Add register prefixes (MAX40080_CFG_MODE_MSK, etc.) for clarity
    (Jonathan).
  - Define MAX40080_CFG_RANGE_50MV/10MV with designated initializers
    (Jonathan, Guenter).
  - Use MAX40080_ADC_RES_BITS (12) instead of 4096 (Jonathan).
  - Use IIO_VAL_FRACTIONAL_LOG2 for voltage scale (Jonathan).
  - Return i2c_smbus_write_word_data() directly at end of max40080_init()
    (Jonathan).
  - Hold lock in write_raw for proper cache protection; local range copy
    in read_raw prevents torn reads (Jonathan, Nuno, Sashiko).
  - Add comment explaining intentional *iv = tmp before error check
    (Siratul).
  - Blank line consistency fixes in read_raw switch cases and
    max40080_init() (Siratul).
  - Use adi,max40080 compatible prefix (David).
  - Add vdd-supply and interrupts properties to binding (David).

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

Link: https://lore.kernel.org/linux-iio/20260723065036.2683075-1-stefan.popa@analog.com/ [v5]
Link: https://lore.kernel.org/linux-iio/20260717123852.1140893-1-stefan.popa@analog.com/ [v4]
Link: https://lore.kernel.org/linux-iio/20260715063652.368501-1-stefan.popa@analog.com/ [v3]
Link: https://lore.kernel.org/linux-iio/20260713120226.90303-1-stefan.popa@analog.com/ [v2]
Link: https://lore.kernel.org/linux-iio/20260703102941.1141341-1-stefan.popa@analog.com/ [v1]

Stefan Popa (2):
  dt-bindings: iio: adc: add adi,max40080
  iio: adc: add MAX40080 current-sense amplifier driver

 .../bindings/iio/adc/adi,max40080.yaml        |  63 ++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max40080.c                    | 574 ++++++++++++++++++
 5 files changed, 658 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml
 create mode 100644 drivers/iio/adc/max40080.c

--
2.53.0

