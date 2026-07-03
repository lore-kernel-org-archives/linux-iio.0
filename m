Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19AE3B14DB;
	Fri,  3 Jul 2026 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073455; cv=none; b=r0ISnQWEmh/y8rWCt23wy62JoeboHdP8ty5faT/bHWC44AkeVtegsA34ifHyvMT5hpC84d2bZmHnufUmVz4n6JrnX33zj5PhAMbZNHotx62LyJPW601zXMNllgD/WIkCPnxdiJ8xZlJkryzaGKLIXBVDl2IX7OnY2dQYih/9KGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073455; c=relaxed/simple;
	bh=tBY6Qh7A9ATk1He6dAfalUkmersgC0oUvaoTO0bspZ0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Ip1UnFO1TaVQSlBWwM5CRsxY7/oKXKN5S6seFYUl6JuqRJZT0H3XltYP+GtBW4mzjzhXzYzffNaD6q+AzTVUFTbKIJkQ62TFo33pfEs9bP6U9lmmpWAUX7g79ru21fZXnPghNvkBjcJOvDLQttpt3r2fyoZbAddqfESfL/6Evl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TwT3352y; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TwT3352y"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635w0pK229410;
	Fri, 3 Jul 2026 06:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=iwbFdLLPpynQCPq0DjneBpDXlhZ
	0jfTQUDp4yhx8+ck=; b=TwT3352y6JdxAREHftitVgmwn4VcYTd6HwGYeQeskCv
	kDCsaoRhwaFkV9kRMFxJujPAeWgtDXIOQ1tS9Z6fKpx4j/SYar1vlwnMDYjARxKl
	M7L7uAdmUbtHzv4VwV2IzXyTgDW5Lw2zqNCny8HsPFJx+CZ33k0TuPI2tB44rjw5
	4o98AfElSp6f2/YSmZUPtLUqOYsb+EfY1ibixCwGXVfBU7RW6C4rHMI9Ba3IlW9Q
	uMnlDc9oFBJXkfIgIvzDbbs9/hME8w5GNPdcBfAmMx/Onowz8YQNOo+36Xp0Jgk7
	6rKKxePF/j1O+RipAprft8oVQC1HTBxO5lGvteudDqw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4f65ckhdyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:10:38 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 663AAb0G010997
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 06:10:37 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 3 Jul 2026 06:10:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 3 Jul 2026 06:10:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 3 Jul 2026 06:10:37 -0400
Received: from analog.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 663AAOlE024695;
	Fri, 3 Jul 2026 06:10:26 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v4 0/6] Add support for AD3532R/AD3532
Date: Fri, 3 Jul 2026 18:10:05 +0800
Message-ID: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH2KR2oC/33Oyw6CMBAF0F8hXVvTJw9X/odx0cIUapSSFoiG8
 O8W3GAkLm9y59yZUABvIaBTMiEPow3WtTGIQ4LKRrU1YFvFjBhhKUmJwNY6rCouOfM4DF3nfI8
 zWZA0g4IIoChedh6Mfa7q5frJYdA3KPuFWhqNDb3zr3V2pEvv/8JIMcEll5KZgnBawVm16u7qY
 +keaJkY2Qahch9hEcmFIsrkOudG/SB8g7BiH+ERMSkII5QGrb8/mef5DVGAWJtTAQAA
X-Change-ID: 20260604-iio-ad3532r-support-759067e904e1
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
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783073424; l=4373;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=tBY6Qh7A9ATk1He6dAfalUkmersgC0oUvaoTO0bspZ0=;
 b=e+4ltKo3wIiet6rOqCX2Aeytd1x80VBRAsBTK9SjtF5gNKgITJt4HDLwOdw4e6QKc3J+KQ/dr
 yB0gJRnGUwXBirEqH5Mk1zgt7wecTs64Wr7t2xRvnte5xrPK9jkU2Oq
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: VVWWsx3TbJzivzE3rKrPDlh95aBeixLy
X-Proofpoint-ORIG-GUID: VVWWsx3TbJzivzE3rKrPDlh95aBeixLy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX1/jFHF6Sj4sk
 gRf2cXZQ1yn5QI0BHUAdsQjs7u5If8TROkCo8yjxob9A+/bSjYJEiQiVZujcBy4JCsSxQGn2ZY9
 QAGKwFpWw7IegXjzVuvqve/3F1X1J6cqqV2nS6lgFKXV1g11CXCY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfXzwWIqRCKDu6D
 nO+lkAomZd22gS9+L/VG30mZ40xppVwER8Kam+E1Ugy10zNde2QpS8etRI5GGWkRSwY7NsfIisf
 5i1XyaT0FO3uO5bbBZ/wmXkepSaq+78uXGWiPQfWtdp+AqWP2rsPw2x8/TByXTak2LFRzD2Ia8h
 9NziwDhKUfY7i5rBMP8KAuX81h1m7Q68dJzf3zucckB8O8OaDcJzQW2FpB5zhwGaOD9kkqybrOt
 VLW6uLqyUPLevxNHEkx3BQ7abxA3iZvdZFCGsu+Omt1i7hrmhVpy+42c296Vzth9T492h6gIUSC
 RsGqdS9yGHVh8Anhf9ct2WgPZ1crQLkzSREuIwTeKd3vnWgbu1Gh6q2USfcbMo7Lvtn+gpFuHIA
 eWbeIUJrgwr1Uyy9xMxLlNCoQ37PsVcVaHdcR4XCpAg9iAPpjHL6ic0zUjd5KippxqCWI/kO8/q
 s0HwIIddh8Ew/8dJMCg==
X-Authority-Analysis: v=2.4 cv=XoLK/1F9 c=1 sm=1 tr=0 ts=6a478a9e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=n0PZOr7OyglNWn7LZCEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030098

This series adds support for the AD3532R/AD3532, a 16-channel, 16-bit
voltage output DAC, to the existing ad3530r driver.

The AD3532R is part of the AD3530R family and shares similar
functionality (channel configuration, LDAC triggering, powerdown
control). It extends the existing ad3530r driver as the underlying
workflow remains the same. The main difference being the register
address map due to the dual-bank architecture, which is handled
by table-driven helpers introduced in this series.

The AD3532R uses a dual-bank register architecture (bank 0 at 0x1000
for channels 0-7, bank 1 at 0x3000 for channels 8-15). Per-chip
register address arrays in chip_info are iterated by bank helpers,
replacing single-register setup calls for existing variants and scaling
naturally to the AD3532R's dual-bank layout.

The series also adds AD3532R-specific powerdown modes (1kohm_to_gnd,
10kohm_to_gnd, three_state) and a new ABI entry for the 10kohm_to_gnd
powerdown mode.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad3532r.pdf

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
Changes in v4:
- Split the table-driven refactor into three patches: sw_ldac_trig_reg
  function pointer, table-driven register banks, and a no-op per-chip
  regmap_config precursor.
- Use regmap_set_bits() in the bank helper instead of regmap_update_bits().
- Split the AD3532R register defines into separate bank 0 / bank 1
  comment blocks.
- Derive the bank in ad3532r_input_ch_reg(), ad3532r_trigger_sw_ldac_reg()
  via AD3530R_CH_PER_BANK instead of magic 8.
- ad3532r_set_dac_powerdown(): narrow the mutex to the shared state and IO,
  use regmap_clear_bits() on power-up, and drop the pdmode.
- Link to v3: https://patch.msgid.link/20260629-iio-ad3532r-support-v3-0-f6e4f4abebbe@analog.com

Changes in v3:
- Reverted the spi_device_id named initializer change from v2, to avoid
  crossing with Uwe's tree-wide SPI series.
- Reworked the Kconfig help text into an explicit per-part list.
- Removed a duplicate .input_ch_reg initialization in ad3530r_chip
  caught by Sashiko.
- Sorted AD3532R register defines by address (bank 0, then bank 1) with
  a comment about the two banks.
- Split the register/mask calculation in ad3532r_set_dac_powerdown()
  into named variables for readability.
- Link to v2: https://patch.msgid.link/20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com

Changes in v2:
- Split AD3532R patch into refactor only and new device support patches.
- Add ad3530r_set_reg_bank_bits() helper for set-bits call sites.
- Use for (unsigned int i = 0; ...) in bank helpers.
- Add per-chip regmap_config to limit debugfs register space per variant.
- Switch spi_device_id to named initializers.
- Fix line wrapping in ad3532r_set_dac_powerdown().
- Link to v1: https://patch.msgid.link/20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com

To: Nuno Sá <nuno.sa@analog.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: linux@analog.com
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Kim Seer Paller (6):
      iio: ABI: add DAC 10kohm_to_gnd powerdown mode
      dt-bindings: iio: dac: add support for AD3532R/AD3532
      iio: dac: ad3530r: Convert sw_ldac_trig_reg to a function pointer
      iio: dac: ad3530r: Refactor setup to table-driven register banks
      iio: dac: ad3530r: Make regmap_config selectable per chip
      iio: dac: ad3530r: Add support for AD3532R/AD3532

 Documentation/ABI/testing/sysfs-bus-iio            |   1 +
 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   |  16 +-
 drivers/iio/dac/Kconfig                            |   7 +-
 drivers/iio/dac/ad3530r.c                          | 351 +++++++++++++++++++--
 4 files changed, 332 insertions(+), 43 deletions(-)
---
base-commit: eb787019c42072cf13470afca673dab0b49cabb6
change-id: 20260604-iio-ad3532r-support-759067e904e1

Best regards,
--  
Kim Seer Paller <kimseer.paller@analog.com>

