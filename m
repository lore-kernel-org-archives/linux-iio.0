Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72D402B88;
	Thu, 14 May 2026 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770154; cv=none; b=XZevcQHYkMzhZTUB9QV3/69iDnIv4rUDRD2W+JqKrfTxugiWdoSgO90MN/sHtSOb/EMQDpKTqNdh6KCA6eu9kHi29Xms81UNntNjgGApGluW+7DtYW+D2552Tf9NE7E9BX3F+LG+fuc9ArTuSfpO/YCoygN4ixzG++JlUp2oBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770154; c=relaxed/simple;
	bh=SnymCFRM1FrxiKwlqKOZ2VIBK5t5DfV7t5vKGusXk/0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mrvVU9kD+mjRrwvUbTIt/0JVVPmryR8lBlrND/FMEaq3Dz38v/GGCRIguaXBdggn1mEt6gOf4h4PJ76paM4gFWyOfbyAnpjANSbfMCs51+kZbXEbm74Dfkz/OhT9bZ9GaIryWiofm4HYlVlJxxz4rAMfh4EwGMMaKw8evQPCSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1USuFEvV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1USuFEvV"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EDgIHi2904955;
	Thu, 14 May 2026 10:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=IjQjGm3lm+m3lluOPKbPcn9FXOv
	stoZuc7CL+XvH/OE=; b=1USuFEvVNYEmOQAIV7jrRBm4o27E1lWAuvq0xyYGLmP
	wdNr/j0VsaWfU5jX1WkZ4PjOt9egNXxwj0zl9wmjd6tzmDLcG5lHUZkd6mdrgeb1
	X5BRW5v9oH8QR8/GkQx6TfG9vAb1AwwQw3bLuhjTv5o9HBwPK7CH5Iu08bdhL3jW
	kVWPQxI0Rf6/a6UJ0oC4EqlM/t6Wkc/3+/QbOdTfoJdzjhMVzZHpaOSSctjeqvKn
	DGzyrdc5YpIjbwvKfaT47OBwLB4X1BJ1uRUnqBf6EbD0KocbLcGvTVof2AoOOkml
	4k+N4309Ne7/TZ4r2ytymq3QfOfKZqT6uVNJZtrVkJw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e4t1xvw9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 10:49:01 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64EEmwjL041689
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 May 2026 10:48:58 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 14 May
 2026 10:48:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 14 May 2026 10:48:58 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64EEmjAX014051;
	Thu, 14 May 2026 10:48:48 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Antoniu
 Miclaus <antoniu.miclaus@analog.com>,
        Liviu Stan <liviu.stan@analog.com>,
        Francesco Lavra <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/7] iio: temperature: ltc2983: Add support for ADT7604
Date: Thu, 14 May 2026 17:46:47 +0300
Message-ID: <20260514144712.64374-1-liviu.stan@analog.com>
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
X-Proofpoint-ORIG-GUID: yeHHjT5IipQtgqEJgnyYZ6mmHM5mX4fj
X-Authority-Analysis: v=2.4 cv=Wbo8rUhX c=1 sm=1 tr=0 ts=6a05e0dd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=pS_OWUl-FR1AhwFSjVoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE1MCBTYWx0ZWRfXwnGf+2OL3y8D
 7INff+AJAtyZQQoinDSxnayl/TuKKBREe3gYWWTc2zf8zAEv2jZRKHxeqUpEwzz8I9XH80xjwgE
 GFYtTJbEflEPCAsZ7pkbMFqquWqwXTWxhNQW9XT5wwQk1OdqnKFjl26mulmN8hjEhAYVKjPXgmm
 fwX7UPxAX/3Or6YMD4cWOlQ8BYSJeKSB8CjLuu4eTQD90xzPJUNUUevQqXZHe5961wU2EvFbYxd
 v4xlULePQrgMI1B29c8hwPfTnV9m+YtKcC5wsTQhJFyUYaqQUsRL70ZlN+5SC0MhnKJrAF0aUqm
 t9EdZXT6zB18V+YiuvbBkVkR6BuHs0SDtWPnDHkqnJSvJ0GLWIz5qFTM92aYVQTyyXq4AAa5/ZG
 5KLJG2omNTWcbvmFwRz4mY25wI5OPUsq2ex7CbZbVhDbyyyoE4KYL/y4U0cwWCSh1u8q6zUTtQP
 y0WiWqqYbQ/05S4Beew==
X-Proofpoint-GUID: yeHHjT5IipQtgqEJgnyYZ6mmHM5mX4fj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140150

This series adds support for the ADT7604 multi-sensor temperature
measurement and leak detection system to the existing ltc2983 driver.

The ADT7604 shares the same die as the LTC2984, reusing its register
map and SPI interface. It repurposes the custom RTD sensor type (18)
as a copper trace resistance sensor and the custom thermistor type (27)
as a leak detector, removing thermocouple, diode and direct ADC support.

Patches 1-4 fix pre-existing bugs in the ltc2983 driver: macro
parenthesization and renaming, inconsistent use of the local device
pointer, inconsistent channel wording in log messages, and missing
fwnode_property_present() guards for optional properties.

Patch 5 adds IIO_COVERAGE_PERCENT, a new channel type for sensors
reporting fractional surface coverage as a percentage.

Patch 6 updates the device tree bindings: adds adi,adt7604 compatible,
copper-trace@ and leak-detector@ sensor node types with their respective
properties, and an ADT7604 example.

Patch 7 updates the driver: introduces two new software sensor type
values (LTC2983_SENSOR_COPPER_TRACE = 32, LTC2983_SENSOR_LEAK_DETECTOR
= 33) with dedicated structs and parser functions rather than extending
the existing RTD and thermistor paths. The hardware configuration bits
are fully hardcoded for both sensor types, and several RTD/thermistor
DT properties have no meaning for them. A u64 supported_sensors bitmask
in ltc2983_chip_info gates sensor type validation per chip, replacing
the has_temp bool pattern. BIT_ULL() is used for the new type values
at bits 32 and 33 to avoid shifting beyond 32 bits on 32-bit builds.

Tested on EVAL-ADT7604-AZ connected to Raspberry Pi 5 via SPI.

Changes in v2:
- Patches 1-4: new prerequisite fix patches addressing review comments
  on the v1 driver patch.
- Patch 5: new IIO_COVERAGE_PERCENT channel type; replaces the v1
  IIO_TEMP workaround for leak detector coverage output.
- Patch 6 (binding):
  - Title shortened to "LTC2983 and similar".
  - Description device list alphabetised and converted to a bullet list.
  - Separate copper-trace@ and leak-detector@ node types retained
    (rather than extending rtd@/thermistor@); rationale added to the
    commit message.
  - "ADT7604 only" wording replaced with "some parts only".
- Patch 7 (driver):
  - New software sensor type values LTC2983_SENSOR_COPPER_TRACE = 32
    and LTC2983_SENSOR_LEAK_DETECTOR = 33 map to hardware register
    values 18 and 27 internally; v1 exposed 18 and 27 directly as
    adi,sensor-type values.
  - Added n_iio_chan to struct ltc2983_sensor; used in
    ltc2983_parse_fw() and ltc2983_setup() to count and assign IIO
    channels, removing to_rtd()/to_thermistor() casts from the common
    path.
  - New sensor types with dedicated structs and functions;
    ltc2983_rtd_new() and ltc2983_thermistor_new() are left unchanged.
  - has_copper_trace bool replaced by u64 supported_sensors bitmask.
  - Both sensor types now share the same 1/1024 resistance scale
    (result in ohms); v1 used different scales and incorrectly
    described the copper trace result as being in mohms. Since the
    sense resistor value is specified in ohms, the output will be in
    ohms for both sensor types.
  - Leak detector coverage output changed from IIO_TEMP to
    IIO_COVERAGE_PERCENT.
  - is_sub_ohm replaces sub_ohm in ltc2983_copper_trace struct.
  - switch() used for IIO_CHAN_INFO_RAW base register selection.
  - Unsupported sensor type validation uses BIT_ULL() checks against
    the supported_sensors bitmask.

Liviu Stan (7):
  iio: temperature: ltc2983: Fix macro parenthesization and rename
  iio: temperature: ltc2983: Use local device pointer consistently
  iio: temperature: ltc2983: Fix inconsistent channel wording in
    messages
  iio: temperature: ltc2983: Use fwnode_property_present() for optional
    properties
  iio: core: Add IIO_COVERAGE_PERCENT channel type
  dt-bindings: iio: temperature: Add ADT7604 support to adi,ltc2983
  iio: temperature: ltc2983: Add support for ADT7604

 Documentation/ABI/testing/sysfs-bus-iio       |  10 +
 .../bindings/iio/temperature/adi,ltc2983.yaml | 194 ++++++-
 drivers/iio/industrialio-core.c               |   1 +
 drivers/iio/temperature/ltc2983.c             | 532 +++++++++++++++---
 include/uapi/linux/iio/types.h                |   1 +
 tools/iio/iio_event_monitor.c                 |   1 +
 6 files changed, 666 insertions(+), 73 deletions(-)

-- 
2.43.0

