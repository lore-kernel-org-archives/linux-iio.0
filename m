Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56B31F9A4;
	Sat, 29 Aug 2026 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787988578; cv=none; b=q99o9a61/giFaUa1Am2wlT2OoevDrMTTjcrOYwI6bzQsluEDK9guo0DNe3dt8rOko7RP6IIj1FXvm+zw9kZ96YY6JQqhXbY6wNXm5ffqVfD/Mil0htFKSkR93hYhIR7DqHMByEwhg6REfbqc4UNM8lGcZfSFLmfA5+pdOYWc8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787988578; c=relaxed/simple;
	bh=KjMMg9KOsR/37eS+nuApKbHCZuneEzWIKQRtj5uivTs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=OubfuVmO6ATciagW8ymg28AiEbh/flwhZkrTDbOGcxYT9+3D8Q5HCVB7uSKkeXlVhKb267SVbfQagFdhs1yJB+FQ8/TToWvlrCdr913A6M/HncrpIbky0jJdQexLDvszKTerjpvxnWHwlbdX+J1QhP42wjO4waXgeNDwQDIBw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=I86sxVHV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="I86sxVHV"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67T5ABNo3386055;
	Sat, 29 Aug 2026 01:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=2STPiAWpM9NUgyh/UHC4FPDuABg
	zamOUYtEMp7PBB5I=; b=I86sxVHVHYBgbq53+b+FIqDtvtEABnvVihq/TJ27pct
	HOzEI/2T0T/K+2ai49+HlyS7Ki3gcy4544S7nxIjQaKa9w9qcMZDEVSbMAzqYm/d
	nBypZT4Wea7pKIDzVFs6PWfLe/rSmBaJ+VXS87AL/oolAYwhDsV5CtgITZQ/TszA
	D7uHpaEAfOAnyA/oAS2QcGfCCWPc5qc4CPFxfG4BkOBNGnl5MZ1T9KVv0rPlLy3H
	aHTbAColgq7eboZkhubwMZ6qVriqZOyAFSp2uyRzRA5U7lTEmLsE6ovkcWO+AVkb
	7e2YROjQV7rtDNUpXWuY+refR3P0BFe3gLes4Q5edOg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbqmh8cm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Aug 2026 01:59:50 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67T5xnDU035549
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 29 Aug 2026 01:59:49 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 29 Aug 2026 01:59:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 29 Aug 2026 01:59:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 29 Aug 2026 01:59:48 -0400
Received: from [10.0.2.15] ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67T5xYj9027223;
	Sat, 29 Aug 2026 01:59:38 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v4 0/4] Add support for AD5710R/AD5711R DAC
Date: Sat, 29 Aug 2026 13:59:19 +0800
Message-ID: <20260829-iio-ad5710r-upstream-v4-0-8af3121c7d21@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADd1kmoC/4XOQQ7CIBAF0KsY1mIYioW68h7GBdBpxWhpoDYa0
 7sLdaHGGJc/+fP+3EnE4DCSzeJOAo4uOt+lIJYLYg+6a5G6OmXCGS+ZhJI656mu1xJYoJc+DgH
 1maIAyytVgrAlSad9wMZdZ3a3f+Z4MUe0Q7Zy4+Di4MNt3h0h9/5MjEAZRSWUFsZIBs1Wd/rk2
 5X1Z5I3Rv6mcPih8KQUXFSiqq3ktf5SipeiQP5QiqykRxppKiuV+VCmaXoAP9kRAlcBAAA=
X-Change-ID: 20260716-iio-ad5710r-upstream-e41c298614c6
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787983175; l=3708;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=KjMMg9KOsR/37eS+nuApKbHCZuneEzWIKQRtj5uivTs=;
 b=kxXTUjbB2YDIMItwSe0YTmTOVVJeAqor85QjZm4QlNbP63E3JnYywKo5fb9JeeHcNZmPD0m3O
 vv/YmI8qVpIBMI+lu0KIKK+7znLLVlZ6gxVWWd4ewSjrfxv1h23cHI7
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Yf+NIQRf c=1 sm=1 tr=0 ts=6a927556 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=sA7t8LQeDx_RY9wWMiUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: _ANgz8bwS52WwpSYD75bSSdbghsckE-J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA0OSBTYWx0ZWRfX538lt6NvsETB
 UP+07O7Ti1AOSGhcuioUkgPY5i9+w2tBTGt6n3ygYGx0i0CMjlP4AnOr0aOpAqlzOl1R7KiJjGd
 VXeC4SOkCgQZRTt/v1DCVO3K/x23ob0Eui5ZYmXPHQI9BzhU3X3zAtsAzpbzXPYqbys10FYGimY
 gFvkaojljxW/PIF04H7Qa+MHeXSpIkG7KxU/4AQgP8g2p51+IcYkmXr+0iD+C2HqOo/eqG1xCzw
 90sXMF5RWYpKpvJRPHChSU9eFQvVR1WVjog2xGHbUi5qzGDMRxnWpa+WSwQKmvlQLMfq9ZKwXww
 TKf4R1rVn179/OVFg3AOspj/ErtgAeuGnTaHlcE4bBIVTFrQc3GOcuaTPW+hei7INPjBxJf8hj0
 zrV4AHxc19NY26RRvDpAq0fdVfR+U+CaFktOZFwySBK0aEzwaMl0BVxxffLPycR1gW4ZI0wVafW
 v6pk4IQOIarTOtrUoLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA0OSBTYWx0ZWRfX3Irbu8Dk17GY
 bqnlln5+AdCCNqOSVSkKg5o9XO/KtrNvtv0JlmynYPGgioEA7IfLPQtEf7mFCiQ1CalFzdJ438z
 5vGP+h3qXp8Jq9OCs0yBArRN+Ap/dWejG9b44SQe36CHei/SpMVC
X-Proofpoint-ORIG-GUID: _ANgz8bwS52WwpSYD75bSSdbghsckE-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608290049

The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
configurable current/voltage output DACs with an on-chip 2.5V reference.
Each channel can be independently configured as a voltage output
(0V to VREF or 0V to 2xVREF) or a current output (0mA to 50mA).

This series adds support for these parts:
 - ABI documentation for the high_z powerdown mode and the current-output
   powerdown attributes
 - device tree bindings for the AD5710R/AD5711R
 - basic IIO DAC driver, supporting per-channel voltage/current output
   selection, per-channel powerdown, software or hardware (LDAC) DAC
   updates, optional output range doubling, internal or external
   reference, and hardware reset (with a software-reset fallback).

Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/ad5711r-ad5710r.pdf

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
Changes in v4:
- Use GENMASK() for the raw write bounds check.
- Add a comment explaining the AD5710R powerdown mode negation.
- Return -ENOENT instead of -ENODEV when no channels are found.
- Link to v3: https://patch.msgid.link/20260817-iio-ad5710r-upstream-v3-0-3a4bf7b9c78b@analog.com

Changes in v3:
- ad3530r: factor the op-mode register/mask computation into a helper
  shared by the powerdown access and channel parsing.
- ad3530r: pass iio_dev into setup/parse and set channels/num_channels
  directly, dropping the duplicated pointers in driver state.
- ad3530r: use regmap_test_bits() for the powerdown reads and drop the
  unused AD5710R_NUM_CHANNELS macro.
- ad3530r: split the file header comment into separate AD5710R/AD5711R lines.
- dt-bindings: drop the redundant items wrapper on channel reg and tidy
  the 2 x Vref wording.
- Link to v2: https://patch.msgid.link/20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com

Changes in v2:
- Drop the standalone ad5710r driver and fold AD5710R/AD5711R support
  into the existing ad3530r driver.
- Add a preparatory patch parameterizing the DAC resolution in ad3530r
  so the 12-/16-bit AD5711R/AD5710R can reuse the raw/scale paths.
- ABI: drop the "high_z" powerdown mode, which is a synonym of the
  existing "three_state" and use "three_state" instead.
- Link to v1: https://patch.msgid.link/20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Michael Hennerich <Michael.Hennerich@analog.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux@analog.com
Cc: devicetree@vger.kernel.org

---
Kim Seer Paller (4):
      iio: ABI: Add DAC current powerdown attributes and 15kohm_to_gnd mode
      dt-bindings: iio: dac: add adi,ad5710r.yaml
      iio: dac: ad3530r: parameterize DAC resolution
      iio: dac: ad3530r: add support for AD5710R/AD5711R

 Documentation/ABI/testing/sysfs-bus-iio            |   5 +
 .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 ++++++++++
 MAINTAINERS                                        |   1 +
 drivers/iio/dac/Kconfig                            |   1 +
 drivers/iio/dac/ad3530r.c                          | 306 +++++++++++++++++++--
 5 files changed, 434 insertions(+), 22 deletions(-)
---
base-commit: 6d44bdb3c696639ed06797c7d33b547a6322550f
change-id: 20260716-iio-ad5710r-upstream-e41c298614c6

Best regards,
--  
Kim Seer Paller <kimseer.paller@analog.com>

