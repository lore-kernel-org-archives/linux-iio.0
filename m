Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9333B9931;
	Tue, 21 Jul 2026 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623674; cv=none; b=b7b4voRzHnDOYNnLtPMDn0Igg94xsMTPG+G9pYXe+QL/XpbkUw5PfvlwSvS3o5fsAQMwt6gUHz2DNFHHMzn28i1Jp9gbfq96ia4dVWuDt/Io8sX7bDkAJWwJ5HFY8OlnDdiicrAtn0bzvxc6Y2ArhV6l5GT1S+3MZ+V5jdWSRVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623674; c=relaxed/simple;
	bh=eQsmeBeCzgBGFtNP3hgtrOKFJrCQ9BguSoanMiRB/G8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=eoOTGWZme+Yv5APA6WIznfpna5JF0r0pFhy3n049j4XaWPRf9fBnD0h0feF3LhGZGINo8ezhkJuKNjuHo/XJ9yrMbcS0HKQIlk0Y0JTiWw2pZfx0WbtqgppaGBsuqaFx43MHWMDocALzScDvVVeSaJL3wnjr+Se6UDTiG1ygssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AeiOE3ZP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AeiOE3ZP"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L8R3No3310656;
	Tue, 21 Jul 2026 04:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5SyKdz56/+lazfKCCXiwjIqVXTj
	PhOK4RdNzYnscksc=; b=AeiOE3ZPCfqqVbkxoW2FOswrSZxpRkbjDdKWdwm8cyg
	1fLkqR9RcoalNtu3SGuYjhvoJRlJZ4kFI3xRB5J76SBf5Qex3hYJypu9HtorSuXf
	a/SftcRN5HWyKAjWEhMRy4EVMcQIrHW9KF5x6C7TLDisaqgjisZj5pw/LTYI2xvi
	5et/crJcicn7OMTeEoBoZBssdQkY6a0XhTeUBJFUqjDZxQ6GfAMo9eqxkDuniX2c
	TUgj62iLD7/HDCTHu+psXnMAZ+DiweDEBQcIpzFuosmRue/q7WChefNYViW7RbKt
	rUG846wYniHcs1TFHWsmQ8/3+nx8DsCVsuATX88L5QQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fg3ay30y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 04:47:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66L8ldLi000804
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 04:47:39 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 21 Jul
 2026 04:47:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 21 Jul 2026 04:47:39 -0400
Received: from 10.33.20.150 ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66L8lNHU015326;
	Tue, 21 Jul 2026 04:47:27 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v2 0/4] Add support for AD5710R/AD5711R DAC
Date: Tue, 21 Jul 2026 16:47:09 +0800
Message-ID: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA4yX2oC/4WNQQ6CMBBFr0Jm7Zi2qQVdeQ/DopQBxgglbSEaw
 t0FPIDLl7z//gKRAlOEW7ZAoJkj+2EDdcrAdXZoCbneGJRQRuTSILNHW19yKQJOY0yBbI+kpVP
 XwkjtDGzTMVDD7yP7KH8cp+pJLu2t3eg4Jh8+x+8sd+/PxSxRIBW6sLqqciGbux3sy7dn53so1
 3X9Ao9xmNHLAAAA
X-Change-ID: 20260716-iio-ad5710r-upstream-e41c298614c6
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
        Conor Dooley <conor+dt@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784623644; l=2747;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=eQsmeBeCzgBGFtNP3hgtrOKFJrCQ9BguSoanMiRB/G8=;
 b=8oOrgYuY91d1t7V3P+1T6PzW6O3+pgG8HDG7jglIVTzhiPqW+5h3zIvCfx6xZAGsEegeCTwCd
 S5FxX0CkvGhBil4ov25PmXraS8yLe7o9+lX2SKo73+XaBFhXUdh765q
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5MiBTYWx0ZWRfX7bvG8I7I4Qxc
 J1yTsN/z1Vqq+3did77Iywu9WSWEPxSr6RJzWBtzsiPyJkq7b9p14/xAoyfDBqLOTM36dK0XTiL
 aFylJNd2tg+EiAIgb9TDnJeoowncAn018lRQIH5c7XUOn6zdfhY/Cn5Nt4Y9vUZlArqo81S9yv1
 R3cT5g4MxSrA2h96hH3J4x4lquNCU2n6sERTamOz3YSP+FBLmahKVnucdlRcDmEGzdZ9por86Ud
 io5BPVHOa3YoEARMAfdRnIVpmixKSu1kCKlpdjZxav0qlPKJKaXcl405IVP/RTkStv8ZQs2+Nzz
 /SxMdMORVtuK0hBNkMQpDiP3tvd9BFLAr0ZsG2zSWTDFeJaiQ6D34+Advpezos/S6yBXqdMcnMc
 GdbA4ziWQ6sO4Ow4f3Tx9b7oaC7JgOtPWlIJtPQ+tzTywX3bRzh0DGXsWbCAeHoSKUo6WDvc9Ej
 wdl3iteLy6X7H7jfpDQ==
X-Authority-Analysis: v=2.4 cv=evjvCIpX c=1 sm=1 tr=0 ts=6a5f322c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=k6iJZ2R4HUqnxew3aQkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: N0Yqxmq9mALfu1tU0ic5Qmi7nB5IsZ-C
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5MiBTYWx0ZWRfXyRsHiqRhK4sE
 gVYwlQVXLLbOr0ql3YayEAAuqDg/1jL2qXTmzqQaBoY3cPwE6NOnDbx7nFO628h5TRKv3cdu7aF
 BHJL8ToVNSnqBEwmTgBhpjnL+4ctCba4pWP/zIgxDl7k67TExLBG
X-Proofpoint-ORIG-GUID: N0Yqxmq9mALfu1tU0ic5Qmi7nB5IsZ-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210092

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
 drivers/iio/dac/ad3530r.c                          | 295 +++++++++++++++++++--
 5 files changed, 425 insertions(+), 20 deletions(-)
---
base-commit: 36c12dbda81c284d72f3c64689461647497b643b
change-id: 20260716-iio-ad5710r-upstream-e41c298614c6

Best regards,
--  
Kim Seer Paller <kimseer.paller@analog.com>

