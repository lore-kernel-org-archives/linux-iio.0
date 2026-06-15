Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40942F7F00;
	Mon, 15 Jun 2026 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504469; cv=none; b=HKnEwc6DdoZhU26/bvoayA5j5hzKPQ+ZHQ18PzbK1cWiDlPH3OhvMT6elZ88CyxEpmY89CVuucKuklDZa3A08Ex9GcFfXU1a8ZZkLSTa3NedG7oP8sjUpRk6Nw9d/2kzt2uMPtRl7ywq30UagIhkYUyV7Kdy6A64KOr5FWQulBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504469; c=relaxed/simple;
	bh=lMtFTPguH3HxlOZDioW3kCSoNEK03ztHKpyTwRxuG+4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=LGyqQBTRh5qWwDBBXm2rnVQUzW6VPZlv5cEzeoSgh3Zjg+Kj5pKj6PP6P7LGXQ/qqbEB9YtTQIeMlKxQLsSVuKnLx7pKW30UtpNuC3PnsPK5PRnXKH8RpmKjumtEhamS1OD4HytkTwIYs2lv4a64Kg7h97ny7HVPNuJi6xu/cPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=urQWh3KD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="urQWh3KD"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6K1s8380094;
	Mon, 15 Jun 2026 02:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=PnvvxvlwZZN4t/5SalBjtNhYDDg
	q8099wtfSLGml0Fg=; b=urQWh3KD9JPAdbqcvp980vMZj34mVCQ6qysl6YPUeNh
	5xMyut5CGlOH5Qd02OT5ILkI7l9y88jXPTHdgftUPW1MKAA/SlPyHK6JCCssWbDJ
	IL5b408Ti27wO37iljdeC9rMnfBD2+Zdu92XWXz90KCUYpT380/9ITt9BGQPEUdu
	gj9oUzFf9YuunSPtsFMO3Wmf+FBBnN5lNOZPVNotYlsydcb0CEr/dGFbGm5g6zns
	qQXNHV0y/zpLmFW3Tpf57LwS7gJg7UNArxwNZ01sXygG2RECV904ZZKdwP0DGr6j
	iQoSth6cAB1Op2Kv2IeVVkDtdt+q7niNpSsgrFlaPLw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4esvwwa4hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 02:21:03 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65F6L2YX020898
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 02:21:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 15 Jun
 2026 02:21:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 15 Jun 2026 02:21:02 -0400
Received: from 10.32.22.147 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65F6Kk5Q014857;
	Mon, 15 Jun 2026 02:20:49 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v2 0/4] Add support for AD3532R/AD3532
Date: Mon, 15 Jun 2026 14:20:14 +0800
Message-ID: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJ6ZL2oC/32NQQ6CMBBFr0Jmbc20pRBceQ/DopYBxihtWiAaw
 t0F3Lt8yfvvL5AoMiW4ZAtEmjmxHzZQpwxcb4eOBDcbg0JVYIG5YPbCNtpoFUWaQvBxFKWpsCi
 pwpwkbMsQqeX3Ub3VP07T/UFu3FO70XMaffwct7Pcvf8PsxQonDZGtRVq2dDVDvbpu7PzL6jXd
 f0CmNFieckAAAA=
X-Change-ID: 20260604-iio-ad3532r-support-759067e904e1
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781504447; l=2923;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=lMtFTPguH3HxlOZDioW3kCSoNEK03ztHKpyTwRxuG+4=;
 b=Bbmp87rwPKU4HmUkNnXXbRu0Q43oSZMCdZmLiMiYgm/eKF0lcSugxRw9PEphkD1a9P0/QywjG
 wiHIAPKpw3yD6fZ7RNA8VKfpDPxJZMMqmPg2iGMkyb390THH85vIl0T
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: rNT9ngzBnsZGEoHK5fvUaW8XCQ0bEF15
X-Proofpoint-ORIG-GUID: rNT9ngzBnsZGEoHK5fvUaW8XCQ0bEF15
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA2NCBTYWx0ZWRfX6ewQWYon2X7C
 5hnPP1z7glUTMqyrw1s2rYFB634ldZbYv1lzkXPIxr4BJ0TNrCkXSh55Gj4SJdJ8snxkzrwN2SR
 FTqOSSUz+Ftl9KoAS5FnZub257XDwoK4WEGcOwS0h/5fYcvREE3pMLXLaRAMEN0ybPUzXYzj0nB
 xdlfQDRr76ZOn9biNOmaiFgDKjNLWMDXT9z1wIAi4mn9mtcyaOWX0KU4fhs2ISsdexsZ7duxguE
 yakxGJeWIoijd/1xlkXiROazOACnYNtpw0eCSOgvrF+FjnB+urXhmSEZ5F4a9DnSwOcGku0snJ0
 VK65HIgr0Risr+neYgfzQ8TVqfCOeaxfwyjeI/XLm+xNaklZuVibtHaP7ThtEHIQ2gwDLdvfo5i
 itYY3KziZ8YxCQgQsRaHoMOifp+hcpniR54JYGpbQ9j0FDE+Y/4TyMGwvkOtuRvR6UQafpkB7Ac
 UeXNDyKxzo4qBqhQUQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA2NCBTYWx0ZWRfX3tq1IDqm5/CZ
 g/hmVd06npThwtfRw+yYO1MAI3/xLtoEMXDUhU0/ZI/Q5dHqDq07AJtTSHFi9RiIZouhryC6gC3
 uiCVgCjug7pFRqkZdp6UUrWIXlwOs7O4rxKzdExBUl2O2sDI7UhJ
X-Authority-Analysis: v=2.4 cv=OM0XGyaB c=1 sm=1 tr=0 ts=6a2f99cf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=CncEN3ZIlnoDoKoaisEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150064

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
Kim Seer Paller (4):
      iio: dac: ad3530r: Refactor setup to table-driven register bank approach
      iio: ABI: add DAC 10kohm_to_gnd powerdown mode
      dt-bindings: iio: dac: add support for AD3532R/AD3532
      iio: dac: ad3530r: Add support for AD3532R/AD3532

 Documentation/ABI/testing/sysfs-bus-iio            |   1 +
 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   |  16 +-
 drivers/iio/dac/Kconfig                            |   4 +-
 drivers/iio/dac/ad3530r.c                          | 352 ++++++++++++++++++---
 4 files changed, 326 insertions(+), 47 deletions(-)
---
base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996
change-id: 20260604-iio-ad3532r-support-759067e904e1

Best regards,
--  
Kim Seer Paller <kimseer.paller@analog.com>

