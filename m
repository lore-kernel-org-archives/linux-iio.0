Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3DC3F8EA1;
	Mon, 29 Jun 2026 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725563; cv=none; b=OjSN5MSBclZOT0wodS+tDhhaghiE8J1Csa/n9Vks+1UV0OcDq/WI5z/kf4zZeblRmOCH6uj4OR1y0G84Dgi5vEp1NG04GbdRc6crpUnlKoFFSavQMUtBQHCq8dKVIOAB+ESXaO/JskGBaxoNFgf6wKo3+MRiIu5+NgUfY8L+m6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725563; c=relaxed/simple;
	bh=p05yBjmRfIM5xcXyOjHBN0a3UxpSbkwCE+TzU5H/+sc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=VWX21CU8Es3AlahSWWvjnd6Wb/RsrlYpWnW5e0zbx8ckwb1uh6X6s1+hIiZjJRqCjw8EnYcoZfqzWS0UQXRITRVbfguH0hjFrWC9cfO46xFXQ0GCrQruYjqlIqT/p/LiqL7SVzxq+exk+HD6kciA9RBpKZJxvmOkUGol8WdbiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JXc3gcaN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JXc3gcaN"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6kGwJ1423996;
	Mon, 29 Jun 2026 04:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=gtRs9K8WHcG1hZni2OIyiQpnrJm
	/GLGF6FSWaUPLf9Q=; b=JXc3gcaNsfOHloY4eBQ8E86/Pfe9skGwQkcuKrjZz6Y
	CMjgRpmFZGGKT543QXoW3sqZGqxImTh/BOuQqkbMBl3nigaqWsX0bdIBUZ8prsQG
	khSxX/Nfl7EH2fRKqAHFTlguroKyJctM7A2+MMuwzsum/TwlkS4uiZjhEAPKhH8d
	J5arWCh5qRb/E1+37Am4keoKsb+vNElj9EV2qC+bQwg4ucxdjHXXMcEcb5nRqYJA
	7b4QsAdKRq8jVkWq5cDdKpvHJd6Pzvf66GZZC2vW4i/GL/owRx2zxoeHKOuExN4r
	9K1LtrS4ftfH/uYR1MKF74v/GuND4i5aURfSPX5haXQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f3gypsafq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 04:31:33 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65T8VWiI022760
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 04:31:32 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Jun 2026 04:31:32 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Jun 2026 04:31:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 29 Jun 2026 04:31:32 -0400
Received: from 10.32.22.147 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65T8VJke012929;
	Mon, 29 Jun 2026 04:31:22 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v3 0/4] Add support for AD3532R/AD3532
Date: Mon, 29 Jun 2026 16:31:03 +0800
Message-ID: <20260629-iio-ad3532r-support-v3-0-f6e4f4abebbe@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEgtQmoC/32Nyw7CIBQFf8WwFnOB0ocr/8O4oO2lxWhpoCWap
 v8u1I0mxuUk58wsxKMz6MlxtxCHwXhjhwhivyNNr4YOqWkjEw48hxwyaoylqhVScEf9PI7WTbS
 QFeQFVpAhI/E5OtTmsVnPlzf7ub5iMyVVWvTGT9Y9t2xgafe/EBgF2ggpua5AsBZPalA32x0ae
 ycpEfiHhMnfEh4lZaZA6bIuhVZfknVdX+sLvU4OAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782721879; l=3531;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=p05yBjmRfIM5xcXyOjHBN0a3UxpSbkwCE+TzU5H/+sc=;
 b=Tuk+Vww2AHQyhQvAMB+ayTTQTiZ0BhWJqGS3f3hLZKHf1hv6YEFFlaTmtR5Ni+TUd5lLvsiDh
 d2Pqx2WEhVQCH0ME9aMgqwZZWyxGOmxlTfOvmrNyevCxBkOrQklESdB
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfX/s4rCnfsKd9L
 SITiV1lOcfwvIhT7Z9YEYrtNIuzAX1B5f+3Y+Ns2c1o3yMbSZ08dL/GIxVtNPWXJF/bDlxNf283
 Ml9Wj/nhS3GUlz+jbFeeL0+Tr0PlOILTihw+xhlf6KtS4ALm/u1buZ1chfbdCQ+LRdq7YE27hyP
 5lQQoDrtIkU/9AnuyYm0iJTDtAphD5yxtB86jO4lTe7mzql8WuSxUSV5EgEF/w5+Bd3vcONSHrV
 qtNDnJjq5Z34bb+2lZCtbGrsGIu9c64qlYtJ9eCSzQuPofNgfAt4DNcssp5c/EUh+3tRh3xd4g5
 znNQD0kdsu4p2mJXVWKp9IHUbMAK9wt1VPLaIL7a6K06RP++hybeCoUfMW/xt06aoo/A7CWPQKr
 bTiwn5gZiaOb8gcgt/+9BC+tgBiKMn0BasFeAIIR6Z7CfzGuXATLlCu7HezAUhNSwygsVzSDPWA
 cuUQrYZqpUfIEdnkKSw==
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a422d66 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=ep6SA9rybd9mEnJAnAsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: yTtQ4k9h-4Xjpot8vI0KTD087zAvY3db
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfX5EmwqW2EH0Oa
 A/Ru/1Z5PSJ5pyCNVWsOc0Xqi72CAl2pc1M7vS/lk+Iq61UHrCpaDt99+NTz9GAYTzD+MOw6g7D
 0ytIjJdPLy59syGzZQ6IqDg3kceK9Pf3BJC+TBIGj4haQMVmxtgF
X-Proofpoint-GUID: yTtQ4k9h-4Xjpot8vI0KTD087zAvY3db
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290067

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
Kim Seer Paller (4):
      iio: dac: ad3530r: Refactor setup to table-driven register bank approach
      iio: ABI: add DAC 10kohm_to_gnd powerdown mode
      dt-bindings: iio: dac: add support for AD3532R/AD3532
      iio: dac: ad3530r: Add support for AD3532R/AD3532

 Documentation/ABI/testing/sysfs-bus-iio            |   1 +
 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   |  16 +-
 drivers/iio/dac/Kconfig                            |   7 +-
 drivers/iio/dac/ad3530r.c                          | 350 ++++++++++++++++++---
 4 files changed, 331 insertions(+), 43 deletions(-)
---
base-commit: 7667a80340e99fd45357d0c90ae05813b01bbfef
change-id: 20260604-iio-ad3532r-support-759067e904e1

Best regards,
--  
Kim Seer Paller <kimseer.paller@analog.com>

