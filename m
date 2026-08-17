Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2A83AFD07;
	Mon, 17 Aug 2026 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948675; cv=none; b=FHcKTV5gWK5tsW8Y1Yhm0sDzSeZ4QJNrgylW8Jcdp0UFlHn8048V8xCANRxWGhc1E7bp6G0BZC8CjlMnJWzMCeUr+httcQvC4M2p+w4/Ao9NXUER2ZCgvOSjnK8ORxmGVW8qL5PYODjkI5tVUa7i65blCR/ICUCIOxt7qXTIt2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948675; c=relaxed/simple;
	bh=jX+vn8QhyoMg/6UX4vvLwa6ME/A9fvS1x5hzoddQIs0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=kFcfeolrvKqhrp0CgexMbsfM4/Y/Nw+CCr6/zjhB1OTn4g0Jy9uKgb2WJtSVgGtXvWHmVbHqu0zpAkx8D/aYG1jYVpqgzGSHPkyIcNWMAiRZ6SwzKI31jizkTZSK+e+/uCBkO1FPpGTXcU/mLu955pUiVEp67jIVHHu7eMqZOYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=z1GtAup1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="z1GtAup1"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H65x9F2808878;
	Mon, 17 Aug 2026 02:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Rle1P/G/l5CBuEm3jeqr7oB8K9E
	GSkp3LgiUF/UC1t0=; b=z1GtAup1jJIShI+dJ67HwY2C5iicRvgxpUvsLpDabuO
	KDz2ARA2qhlW2dBPW6hG1e6+QhtSe7JpQPXnAZuUNHQ4UvYXQ/NwZsvgetef06D3
	w9NTHCD3yDOrTseeCNkN0paD2HLuQcVrCsU0GwCcgiUiCasMuQxq4MQlfswMmD4a
	fr+spejCqc2o/gWF5efSdiqJ0NJzWWmjBDolPGTDv5a/QiKRpbiJAyg2d+5BTNy3
	+GRJcQdtBw4+rspXT6VQxITiqWyzEpyAj427aR9W8pkuM0AedGkxqqPCQCuuAEdo
	hPnioeoRBek1E4JZYPWojaqzdExXjjZXVkIp61zbHAw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g39efkcng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 02:37:46 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67H6bjYh012489
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 02:37:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 02:37:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 02:37:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 17 Aug 2026 02:37:45 -0400
Received: from [10.0.2.15] ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67H6bW5O022522;
	Mon, 17 Aug 2026 02:37:35 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v3 0/4] Add support for AD5710R/AD5711R DAC
Date: Mon, 17 Aug 2026 14:37:10 +0800
Message-ID: <20260817-iio-ad5710r-upstream-v3-0-3a4bf7b9c78b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABasgmoC/4WNQQ7CIBQFr9KwFgMUoXXlPYwLCr8tRksDLdE0v
 btQN7owLid5b2ZBAbyFgI7FgjxEG6wbEpS7AuleDR1gaxIjRpggkgpsrcPKHCQlHs9jmDyoOwZ
 ONasrQbkWKF1HD619bNrz5c1hbq6gp+zKi96Gyfnn1o007/4kIsUEQ8UrxZtGEtqe1KBurttrd
 0e5EdmHhdEfFpYsJeM1r42WzKgvy7quL62VaPYRAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786948652; l=3412;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=jX+vn8QhyoMg/6UX4vvLwa6ME/A9fvS1x5hzoddQIs0=;
 b=4yzI5BW2wurjng+XTok0M8m4iWDj+mNkog6evJeOUbPXobr6Qm824K7XELmbMY99+wlCIkB8+
 8HpLGD3po1MDkc+eXeSUrzLoKoaSm0+EV3Pr1+ulD+tUXwDUQCf1twV
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: xYO1SK42ydg1ccfkUAYZJa7dwktRMgy-
X-Proofpoint-ORIG-GUID: xYO1SK42ydg1ccfkUAYZJa7dwktRMgy-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA0NyBTYWx0ZWRfXwtA/cOZIBJPe
 iHVGrhHO28xhMrC3Pkhj8FAo63IDt0LRkDuvtxyWNpc+qL+nzSnuwKHLWkk15Jzt5CyTO7GQ6mn
 6pbsmQdFJ2Og5oUUHkdygAOP6X+mCGiix/bWw0r5EXC3jSA5tbX7
X-Authority-Analysis: v=2.4 cv=VM/tWdPX c=1 sm=1 tr=0 ts=6a82ac3a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=Cq0ByINQD8B-c4KUiCMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA0NyBTYWx0ZWRfXzIQmES2lk48u
 UvsoThbvdIA0g8RSDGmlLwdVVD4peHm0WOBzyUUamPMKy5xXMxeiTCqxd7oRrjNAQavguWKAH+t
 Rz55Cl4JgJxLJVDNiF5NoLxgLVJNary5iuJo8dvNvzCMs46ZddemswKtC379jR9QIqNO3mxsjIc
 12PrPFyEYupJO6/OJCQcf4IpldfZ76ruJmsONbdC/jX2ASN+Efo4tTcXEpZZeGG13ndt6Tp/0Oi
 5jocpbLX1k92q8NHOsgaPRhGTGgehKfy+/VVCOzxoT09VVTQj1B5dSEaNXbvRVEQfnNVEcnRl0D
 39/vXNl8fg51jHbaHcNblY4qmEvHTtYaoyUv2yZc6S/AC7NrvK9+ddPxrSWyesgobRowu9CqAkO
 nMOFd07onLSC9WDLMbyCGyvsT7py8ioftGql8ti4w1CtN5M/kmIvc5rQD952Hn++lNtmIgwzYI3
 MWLCvN9x4EuHbSgDoXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170047

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
 drivers/iio/dac/ad3530r.c                          | 302 +++++++++++++++++++--
 5 files changed, 430 insertions(+), 22 deletions(-)
---
base-commit: fc69c7ed31f2c36d0232a6d04750acec8f9e0c31
change-id: 20260716-iio-ad5710r-upstream-e41c298614c6

Best regards,
--  
Kim Seer Paller <kimseer.paller@analog.com>

