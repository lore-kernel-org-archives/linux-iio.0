Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED63AB466;
	Mon, 13 Jul 2026 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944183; cv=none; b=YQZti27gdSG/AsaEBMWVoJpN6Uj+YBIYf/BiugVmzYYhSpW/YdHiip1baSJ/GpS8QDAu9bDfa5vP9seE1SML8Wzf/kktpOhrzeXK/r3KMTz2W+Z6eAJQbip4ZzmOGSvKzrLROrUI2YDaT3viDoxANI6N37ITOLD7M5sOtdkdjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944183; c=relaxed/simple;
	bh=Y+//TAB1Oh0xiCHBqdyIq3t5Fvf5lQdu1ewVTONXMsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4WvmDo4yPVrvdppjLdhjFAXwfPQItEQacg8pGEbo3adtRh1IsKs+19auj5OiXpSIm7c9l7KAoSGQSHPoUrB9se63rqZrfc4KgjNhXg5E1M0eHaYFVsJARuxEepe31Elvb/yVKkeTymAD6ylEhzrslLkVDBo/FF70rqnIf1rLTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RzjK+ObH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RzjK+ObH"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DBrD042638106;
	Mon, 13 Jul 2026 08:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iHEoU
	UeTGt77GxnhK6K/5pV4xnWgp3d3f5fT06epVFo=; b=RzjK+ObHs9/4xLgbQLB0X
	gyST9LRlxeWS5kaaXKicL64EvH4o1vnzwyz/5uZTrbSkL4vnx9qECWBTjs/5k7Sn
	Ttj4rCwFFCj5Tow4A3q6Fe4bRBgPfFGth93j7Q881e1dbaQk9s+0jY5AUVy0PGEz
	qOlhMhj9+jTtZXljDz0QYoUKhp6ZUWZoRZL9BAar3kiTA5UoSUdUkaY5oVj4ch3Y
	GOc2h2q4BrOs+AOO9YH/nYNsoXXPEgNP7q80F4f7OhfOIC3oV/ZS6tg0mIGMCvbr
	4ecgknTf3oP2iHfc12myFY4MUUCGOL2Df1O1ds1YYh9k8KI4Yb5YBa1MWnhOvOYJ
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fc45bc2fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:02:54 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66DC2rO5014410
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 08:02:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 13 Jul
 2026 08:02:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 08:02:53 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66DC2aSf024385;
	Mon, 13 Jul 2026 08:02:39 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Siratul
 Islam <siratul.islam@linux.dev>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stefan Popa
	<stefan.popa@analog.com>
Subject: [PATCH v2 0/2] iio: adc: add MAX40080 current-sense amplifier driver
Date: Mon, 13 Jul 2026 15:02:24 +0300
Message-ID: <20260713120226.90303-1-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703102941.1141341-1-stefan.popa@analog.com>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX3yFOwmynVt9x
 aaXuBjhpLaKAJ3Xww7Eb5foZc8wYU7aWqhEoSKgH6vcqlue4JnyeMGMACZNCieAYTOjDSUhkG3l
 eqMOPbD3C1BPlP/2QmLK2+3Ct6nZ0Gj0+ZYc7jtAuy7ut+bjX7aQ7jGtj7jCGOhIpEa8RKzmH1e
 Qlq6gDjaGG1cTDZmBquBaITQt9pWl3NdX2SFi3AYX8neur07QQnOB5Akd/5JXxrSw8HoM2Y2PoR
 xOTRHyoGLa7cUp+3yGdscYG7tsLd7bJNCqALqxsGp5e4CJtEHmE2PYWEoMw1xIOT5EZLypddx6E
 DouJegU4GV4EB12kWW4TWnXZLLsAZMHK/D8429W4eTVfZqybJhMUvbkGokS/8FVsGuK5vrWS9og
 NaIvaElCnZ6k7AQR8lqzkuQ+JNqpO7fN6bB9V/s8AjSOJg5eu0wfYp6OvWeOf4xksXfjscJVYgi
 i75jnaKo5iroGE2prhg==
X-Authority-Analysis: v=2.4 cv=CcA4Irrl c=1 sm=1 tr=0 ts=6a54d3ee cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=xt0BtDm08ObDgclQVrIA:9
X-Proofpoint-GUID: AGjrrBuPds_sE6E1lPzo833u5R3WrZLi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX9HX+UHpHaNzu
 /6cd6ohD+AnlABlW3zY961oxXBADAWHasfg0z9rmVkeU1n3I9F0JpBPoR49unuKcPLclooSUR0J
 /IQOfZjzul5YUDy0xTmbi0dIldLJh09otTIaPjUHoowXCaQ49loW
X-Proofpoint-ORIG-GUID: AGjrrBuPds_sE6E1lPzo833u5R3WrZLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130125

This series adds support for the Maxim MAX40080, a bidirectional
current-sense amplifier with an integrated 12-bit ADC and an I2C/SMBus
interface. It measures the voltage across an external shunt resistor and
the input bus voltage.

Why a new driver (Andy): No existing IIO driver covers this device or a
register-compatible part. The closest relatives (max9611, max34408) target
different silicon with incompatible register maps. The MAX40080 has a
unique combination of bidirectional 13-bit current, 64-entry FIFO, mandatory
PEC, single-measurement mode triggered by SMBus Quick Command, and two
selectable input ranges. See the driver commit message for the full
rationale.

The datasheet link is in the binding YAML description.

The driver operates in direct (INDIO_DIRECT_MODE) mode. Each raw read
triggers a single on-demand conversion (SMBus Quick Command) and reads
back the matched current/voltage pair, so results are always fresh. It
exposes the current and voltage channels with raw and scale attributes,
a configurable oversampling (digital averaging) ratio, and PEC-protected
register access. The two selectable current-sense ranges are exposed
through scale/scale_available (the range is chosen by writing the
desired scale); the current scale is derived from the
shunt-resistor-micro-ohms device-tree property.

Continuous FIFO buffering, threshold events and the alert interrupt are
intentionally left out of this initial submission and may be added
later.

Tested on hardware with four MAX40080 devices on an I2C bus.

Changes in v2:
  - Add vdd-supply and interrupts properties to the binding (David)
  - Add types.h and time.h includes (Andy)
  - Use USEC_PER_MSEC for poll timeout readability (Andy)
  - Use 1 * MICRO for default shunt resistor (Andy)
  - Rename field macros to include register name, e.g. MAX40080_CFG_MODE_MSK
    (Jonathan, David)
  - Add indexed defines for RANGE field values and use in gain array
    (Jonathan)
  - Use array lookup in get_oversampling_ratio instead of formula (Andy)
  - Use switch statement for chan->type in read_raw (David)
  - Simplify update_bits: one-liner RMW, return write directly (Andy)
  - Add local client variable in trigger_measurement (Andy)
  - Add braces to for loops and use C99 loop variables (Siratul, Andy)
  - Flip if/else in reg_access, separate declaration from assignment (Andy)
  - Add .name= in i2c_device_id (David, Siratul)
  - Remove unused i2c_set_clientdata call (Andy)
  - Reorder declarations to reverse christmas tree (Siratul)
  - Return directly from oversampling case in write_raw (Andy)
  - Add blank lines before return in read_avail (Siratul)
  - Add Co-developed-by tag for Ciprian (Andy)
  - Use Link: tag for datasheet URL in commit message

Regarding mod_devicetable.h (Uwe): kept for now as the replacement
headers (linux/device-id/*.h) are not yet available in mainline.

Stefan Popa (2):
  dt-bindings: iio: adc: add maxim,max40080
  iio: adc: add MAX40080 current-sense amplifier driver

 .../bindings/iio/adc/maxim,max40080.yaml      |  62 ++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max40080.c                    | 627 ++++++++++++++++++
 5 files changed, 710 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
 create mode 100644 drivers/iio/adc/max40080.c

--
2.53.0

