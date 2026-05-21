Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B6349CC2;
	Thu, 21 May 2026 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381905; cv=none; b=Ir6Tu/KU1GCDvzJKXSNDh5Jrh6tl+DQnwxIOFpadZx7nna/4UT9mWxeLBGWVpxEQOnxnuGHnLtYLpmoRuRvhdTkzF8jolaAofkmR96q9v+E5FDX74j7Sj9NeGVlon9hX6mg/CfpksKi7psqyCo8FhYed8giQ8JqtOEPDWr/K7nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381905; c=relaxed/simple;
	bh=xRNjCnoR/SPsKEobxA0W3f+iaxNlnGV6AuVW68+NPb0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N4Traj5eBy8bJpdq1hPunJncut1Xp13cxFQY8kCrRj5fHyUF5LEbUdWblDwntE3xKOAsm20slX5ikKNUXIMNsontnxXBynjuzp81SQyJ6QkbOuyflAaDT1W3tvjjvzbttsa3c+O9JYUatAgJyWdFtkIb2xhBi5F8aqKshutcGd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GaAOUOei; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GaAOUOei"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LFM4iQ263011;
	Thu, 21 May 2026 12:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=2EHJeNaWfNh8JvLXtfxmgvJeAIW
	w6ex+kWjlzYqiykQ=; b=GaAOUOeiFvZcEmoIyg2Xlvhtgz3ikzxaIMRbxXWEkVv
	FzanBcvk3zPc33BBtNn5Fh7PNZmtCJZMqUhEs0YlbuYNhR1DKXvCwxJrXX0h1gKv
	WazOTf0o/W5xtphijO2q/HwmC29s9kkeXaW7FG1KcLfODn48Ff/qGj9YPcqUG5wj
	ymdF/ubh4Ag6aaITbvJnrxG15iLohWnVFeulIW3YVAr13n9ZnuOZ5tkHRMbSSgbN
	N7Q6CE7hCBpIjj4Zf696fArznuF7B6TqJ1SaA+cxtm6Aq5nETuMrxcMhVsF9x3+a
	w/e+JW1x+4xbwNg5XVtfDnnpEhZW0/uNurp1dm1BVdA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e95e2fa71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:45:00 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LGixED000318
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 May 2026 12:44:59 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 12:44:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 12:44:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 12:44:59 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.208])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LGim0k024538;
	Thu, 21 May 2026 12:44:50 -0400
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
Subject: [PATCH v3 0/8] iio: temperature: ltc2983: Add support for ADT7604
Date: Thu, 21 May 2026 19:42:53 +0300
Message-ID: <20260521164323.770626-1-liviu.stan@analog.com>
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
X-Proofpoint-ORIG-GUID: 1OJL2AuGoFbv2L46Zknt2w-0g0r8XvUm
X-Authority-Analysis: v=2.4 cv=Fd0HAp+6 c=1 sm=1 tr=0 ts=6a0f368c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=OXquYun8vk4aEYobkVoA:9
X-Proofpoint-GUID: 1OJL2AuGoFbv2L46Zknt2w-0g0r8XvUm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2OCBTYWx0ZWRfX9uAewAKMYToZ
 nOIb9qqiMq7xKFH6Vgq5gx3FTE25XaDmf/svkk4aKPk2tOmcoqyvnqXuHMWGRXpCC1w4QNFqlzj
 VfOnTwG/y1fhofMva2oVVkxuVtL9Jz4AwQZeZK2Ht75XoddNN1LEXrjqpsMBJIfr4Fc08ubM0S9
 q1LQ2P8sje4hi7NNsgRyr4SF2fpa8TBTzSl3cz/bC8/nanlxNdKtLEZy5+MHEuC9Z0IqZk6mOVt
 nqQdwcaz1A9+Y1NfP/v7ZtxE/rQwmc3JQoIZj3LrdnNfQGdIhoMQ45M7cIhEy2CDd22ekhJW5fl
 QPxGCGVYnOZb/qeXY3lehnm+F6IKIlpnHud3Z5qIGmCABu5yCve+sRFa27I6eEbvuZ0RZ1mI4kS
 NFO2htWxRWJDPmTXQb88v1cnCHzKnxq9WhVhIJTTtUved7slFlOgI4vBgJnkuyw4sxhi/Zqqti1
 H8fsxeDo5uKWkU8zj6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210168

This series adds support for the ADT7604 multi-sensor temperature
measurement and leak detection system to the existing ltc2983 driver.

The ADT7604 shares the same die as the LTC2984, reusing its register
map and SPI interface. It repurposes the custom RTD sensor type (18)
as a copper trace resistance sensor and the custom thermistor type (27)
as a leak detector, removing thermocouple, diode and direct ADC support.

Patches 1-5 fix pre-existing bugs in the ltc2983 driver: macro
parenthesization and renaming, inconsistent use of the local device
pointer, inconsistent channel wording in log messages, missing
fwnode_property_present() guards for optional properties, and an
n_wires default that silently bypassed the current-rotate validation.

Patch 6 adds IIO_COVERAGE, a new channel type for sensors reporting
fractional surface coverage as a percentage.

Patch 7 updates the device tree bindings: adds adi,adt7604 compatible,
copper-trace@ and leak-detector@ sensor node types with their respective
properties, and an ADT7604 example.

Patch 8 updates the driver: introduces two new software sensor type
values (LTC2983_SENSOR_COPPER_TRACE = 32, LTC2983_SENSOR_LEAK_DETECTOR
= 33) with dedicated structs and parser functions rather than extending
the existing RTD and thermistor paths. The hardware configuration bits
are fully hardcoded for both sensor types, and several RTD/thermistor
DT properties have no meaning for them. A u64 supported_sensors bitmask
in ltc2983_chip_info gates sensor type validation per chip, replacing
the has_temp bool pattern. BIT_ULL() is used for the new type values
at bits 32 and 33 to avoid shifting beyond 32 bits on 32-bit builds.

Tested on EVAL-ADT7604-AZ connected to Raspberry Pi 5 via SPI.

Changes in v3:

Patch 1 - macro parenthesization and rename:
- Dropped the Fixes: tag
- Removed the "base" parameter from ADT7604_RES_RES_ADDR(); the resistance
  result memory region is (currently) ADT7604-specific so the macro's
  modification belongs in the driver patch

Patch 2 - use local device pointer consistently:
- Dropped the Fixes: tag
- Fixed one remaining dev_dbg() call in __ltc2983_chan_assign_common()
  that was still using the raw device pointer instead of the dev local
  variable introduced by this patch

Patch 3 - fix inconsistent channel wording in messages:
- Dropped both Fixes: tags
- Removed the "all" from "all occurrences" in the commit message
- Fixed some missed "chan" / "chann" occurrences

Patch 4 - use fwnode_property_present() for optional properties:
- Dropped the Fixes: tag
- Fixed other occurrences brought up by sashiko

Patch 5 - Fix n_wires default bypassing rotation check:
- New patch

Patch 6 - IIO_COVERAGE channel type:
- Renamed the sysfs attribute from in_coveragepercentX_raw to
  in_coverageX_raw
- Added a _scale ABI documentation entry
- Corrected KernelVersion in the ABI documentation from 6.15 to 7.2
- Added IIO_COVERAGE to the event_is_known() switch in
  tools/iio/iio_event_monitor.c

Patch 7 - DT bindings:
- Changed the custom leak detector table encoding, users now specify
  plain coverage percentage values (0-100) in the device tree and the
  driver applies the +273.15 C offset internally before writing the
  hardware table
- Changed custom-rtd to custom-copper-trace to better represent the
  copper trace custom table, and made it required for > 1 ohm variants
- Made custom-leak-detector required for leak detector sensors
- Updated commit message to reflect the changes
- Updated leak detector node description
- Updated adi,custom-leak-detector description
- Modified the example leak detector custom table to match the datasheet

Patch 8 - driver:
- Relocated the "base" parameter addition from patch 1 to this one since
  the resistance result memory region is (currently) ADT7604-specific
- Updated the commit message to mention the base and base_reg parameters
  added to the result-bank read helpers
- Stacked the IIO_RESISTANCE and IIO_COVERAGE case labels in
  ltc2983_read_raw()
- Added LTC2983_SENSOR_NUM sentinel at the end of the sensor-type enum
- Changed the sensor-type bounds check from > LTC2983_SENSOR_LEAK_DETECTOR
  to >= LTC2983_SENSOR_NUM
- Reordered the ltm2985_chip_info_data struct initializer so has_eeprom
  doesn't look like it was added to the ltm2985 in the diff
- Changed the custom leak detector table encoding, users now specify
  plain coverage percentage values (0-100) in the device tree and the
  driver applies the +273.15 C offset internally before writing the
  hardware table
- Changed custom-rtd to custom-copper-trace to better represent the
  copper trace custom table, and made it required for > 1 ohm variants
- Made custom-leak-detector required for leak detector sensors, _new
  and _assign_chan functions were updated for both sensor types
- Updated commit message to reflect the changes
- Removed "..." from "rsense channel must be configured" error message
  from ltc2983_leak_detector_new()
- Removed blank line before hw_type declaration in
  __ltc2983_chan_assign_common

Liviu Stan (8):
  iio: temperature: ltc2983: Fix macro parenthesization and rename
  iio: temperature: ltc2983: Use local device pointer consistently
  iio: temperature: ltc2983: Fix inconsistent channel wording in
    messages
  iio: temperature: ltc2983: Use fwnode_property_present() for optional
    properties
  iio: temperature: ltc2983: Fix n_wires default bypassing rotation
    check
  iio: core: Add IIO_COVERAGE channel type
  dt-bindings: iio: temperature: Add ADT7604 support to adi,ltc2983
  iio: temperature: ltc2983: Add support for ADT7604

 Documentation/ABI/testing/sysfs-bus-iio       |  17 +
 .../bindings/iio/temperature/adi,ltc2983.yaml | 207 +++++-
 drivers/iio/industrialio-core.c               |   1 +
 drivers/iio/temperature/ltc2983.c             | 614 +++++++++++++++---
 include/uapi/linux/iio/types.h                |   1 +
 tools/iio/iio_event_monitor.c                 |   2 +
 6 files changed, 741 insertions(+), 101 deletions(-)

-- 
2.43.0

