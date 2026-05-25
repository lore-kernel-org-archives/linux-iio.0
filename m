Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFA3F4135;
	Mon, 25 May 2026 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727283; cv=none; b=uN8NS7j8wzz9hsfKagcLEnKhhIz8MCSP6pBYaTINuaxTLQbyP/ST06XETglqmu1Sbi6WhXdyk1a1oicY5fqqe2EWQjAVKosc1T+IkucgE4G6Y4basOcBjesZU8zvybVJffhBx5tjrTgyW1CgAtDCK9q1p8cM2pLz5s+56UPoXOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727283; c=relaxed/simple;
	bh=+YGVxc0rpsonJHPTa6UOETIlDRrA21DSYW3qB9qF7G0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a4qPstOuf7o6rWLPbyb7psV3GVUnf4LthuUOxE0I2wgQQsy5JMq5okgqhFd2qbPxw8LOzvSgz1o9/5y2K7a3Bmqqm1fgewJFah8+MU0x6Ig9e56fKuc1kxRr6OnxAlRc681nYDd1CZzTNPwAdKqLXSaafF0dkODMXQPPfLJL+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MGDgWl5w; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MGDgWl5w"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PD2YLc3928508;
	Mon, 25 May 2026 12:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=HjZndMQ6/Lw4Bqx+YQN6tihLrNp
	sUe9oVYfTONLrbAo=; b=MGDgWl5weq+WVhCwAJ4LmMOq0Af5KRgToU5olO+O63J
	nUimdr6ZFUt3KUPoP6nAQLPyrai0UBpqq1csNUKh4Q+0PThXDJyJ7ZH0j/grI4IP
	1Sj82F4LUq05wNI16Av21gZEg7wL4ct66Y+akOTF1oI9UrwA8BWrAKteBuWU/M+T
	E/ST62poOxQXaiTLkV3TlQgfjUys5OHR6XKC2JCqFKYT2zU4+dwT2tZsWebEAJG4
	N1mYrHmi9DRVoCxFEmc2o5c29CWZlIy27A70IWoxdZn3RIFlUJfSoZd0c5amDc3J
	/7ZFoUmxjuCYhhaVR9OYM2RFaBLXxfffnmdP6XAgXSA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4eb950f9fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 12:41:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64PGfIdf022271
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 May 2026 12:41:18 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 25 May 2026 12:41:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 25 May 2026 12:41:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 25 May 2026 12:41:09 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com ([10.32.226.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64PGevGx028845;
	Mon, 25 May 2026 12:40:59 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Antoniu
 Miclaus" <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>,
        Liviu Stan <liviu.stan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 0/9] iio: temperature: ltc2983: Add support for ADT7604
Date: Mon, 25 May 2026 19:39:27 +0300
Message-ID: <20260525164013.118614-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: hD7D0iDi9LhErwLxoEbU7MlSTF0HjBb-
X-Proofpoint-GUID: hD7D0iDi9LhErwLxoEbU7MlSTF0HjBb-
X-Authority-Analysis: v=2.4 cv=TOh1jVla c=1 sm=1 tr=0 ts=6a147baf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=pGLkceISAAAA:8 a=drhNbCVVPJFLfvZI_aUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE2OCBTYWx0ZWRfX+qzDv0qZLQb2
 tGMBtejlDaz8bH+fPZotXGT+jeH72pGQxHzz5q4usd9bKDcEqazOcQu9aoWWaSkSaaFS6zsV92I
 OO9vS7CZoK1ACYIdedRHA9hdnh4XyRyVL4IhS9HpO0J98IuTxlNjcUQHhma4FCTLgyBPMTCZR6F
 dXWeBIZbarzuCy/e7qQdCu9S2HKdhU7rHibY/diCc4m4EytQxqNPa0sK1bd68ndvY+BCUtbsKeY
 yXIdwsydIC+Mk4VDci2yS0iGKQ4+EVaeYqUTo911k8Qx6gHRV+9X3xhie5wVcOtFYk/3UBvP0JY
 CAVtiUDmFN6hwWK4B04ZBZGCe1OCi23Onw/587bnw5wxTEbmwN7QOKasHhcszDhbpXwcDA6Uo9M
 fhPpmmGbv/Tg9aTEakx0obfv4c/Y2QccV9Xs1KLEmYuB3XTh5OxoUeBQNq2R3FlB2IBQhLyByVu
 Zj7mkXDc3i3FSGUFg3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250168

This series adds support for the ADT7604 multi-sensor temperature
measurement and leak detection system to the existing ltc2983 driver.

The ADT7604 shares the same die as the LTC2984, reusing its register
map and SPI interface. It repurposes the custom RTD sensor type (18)
as a copper trace resistance sensor and the custom thermistor type (27)
as a leak detector, removing thermocouple, diode and direct ADC support.

Patches 1-6 fix pre-existing bugs in the ltc2983 driver: an n_wires
default that silently bypassed the current-rotate validation, a
reinit_completion() call after the hardware conversion was started,
macro parenthesization and renaming, inconsistent use of the local
device pointer, inconsistent channel wording in log messages, and
missing fwnode_property_present() guards for optional properties.

Patch 7 adds IIO_COVERAGE, a new channel type for sensors reporting
fractional surface coverage as a percentage.

Patch 8 updates the device tree bindings: adds adi,adt7604 compatible,
copper-trace@ and leak-detector@ sensor node types with their respective
properties, and an ADT7604 example.

Patch 9 updates the driver: introduces two new software sensor type
values (LTC2983_SENSOR_COPPER_TRACE = 32, LTC2983_SENSOR_LEAK_DETECTOR
= 33) with dedicated structs and parser functions rather than extending
the existing RTD and thermistor paths. The hardware configuration bits
are fully hardcoded for both sensor types, and several RTD/thermistor
DT properties have no meaning for them. A u64 supported_sensors bitmask
in ltc2983_chip_info gates sensor type validation per chip, replacing
the has_temp bool pattern. BIT_ULL() is used for the new type values
at bits 32 and 33 to avoid shifting beyond 32 bits on 32-bit builds.

Tested on EVAL-ADT7604-AZ connected to Raspberry Pi 5 via SPI.

Changes in v4:

The n_wires fix was moved to position 1 and a new reinit_completion()
fix was inserted at position 2.

Patch 1 - Fix n_wires default bypassing rotation check:
- Moved to the front of the series

Patch 2 - Fix reinit_completion() called after conversion start:
- New patch

Patch 3 - macro parenthesization and rename:
- Added Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Patch 4 - use local device pointer consistently:
- Collapsed some wrapped lines that now fit within 80 characters
- Decided to leave lines that would slightly pass 80 characters
  wrapped since they looked more readable
- Updated commit message to reflect the line consolidation
- Added Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Patch 5 - fix inconsistent channel wording in messages:
- Added Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Patch 7 - IIO_COVERAGE channel type:
- Renamed the sysfs attribute from in_coverageX_raw to in_coverageY_raw
  and in_coverageX_scale to in_coverageY_scale to follow ABI convention
- Updated commit message to reflect the rename

Patch 8 - DT bindings:
- Added restrictions for adi,sensor-type = <18> in ^rtd@ nodes and
  adi,sensor-type = <27> in ^thermistor@ nodes for adi,adt7604

Patch 9 - driver:
- Removed trailing comma from LTC2983_SENSOR_NUM enum sentinel
- Sorted id_table, of_match, and chip_info_data structs alphabetically

Liviu Stan (9):
  iio: temperature: ltc2983: Fix n_wires default bypassing rotation
    check
  iio: temperature: ltc2983: Fix reinit_completion() called after
    conversion start
  iio: temperature: ltc2983: Fix macro parenthesization and rename
  iio: temperature: ltc2983: Use local device pointer consistently
  iio: temperature: ltc2983: Fix inconsistent channel wording in
    messages
  iio: temperature: ltc2983: Use fwnode_property_present() for optional
    properties
  iio: core: Add IIO_COVERAGE channel type
  dt-bindings: iio: temperature: Add ADT7604 support to adi,ltc2983
  iio: temperature: ltc2983: Add support for ADT7604

 Documentation/ABI/testing/sysfs-bus-iio       |  17 +
 .../bindings/iio/temperature/adi,ltc2983.yaml | 217 +++++-
 drivers/iio/industrialio-core.c               |   1 +
 drivers/iio/temperature/ltc2983.c             | 621 +++++++++++++++---
 include/uapi/linux/iio/types.h                |   1 +
 tools/iio/iio_event_monitor.c                 |   2 +
 6 files changed, 752 insertions(+), 107 deletions(-)

-- 
2.43.0

