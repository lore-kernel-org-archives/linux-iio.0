Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC783446CE;
	Thu, 16 Jul 2026 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188955; cv=none; b=X6gTcrORtlpsDQe7BXLhuYBYZ/z0luQOpi2XTt1o4KmzUvWhPiGgfjmcf6BMKNh45m0AOh/UBj5NKidYi3XTD8BpiRb3Iudn0FORV2tDvsYUo5nd+JYDdclotZIIektphwIF6jCpC6iEW3hBkOXFwt3aDcyTfo5d0dtYtE/+uOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188955; c=relaxed/simple;
	bh=xs8YknLjV4ZkpO4Xkh1rNRAAJ0GGNwYW0ostBkKnvtk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=HC8mdYt0GL2IE8Ra00kVr1aCrvLh5Miv7rgP81vJHbczD63nBNleqBTAcSLaSbDGKQccgs81LWbBY7BGTSsUyNpoO600Hz0yvmRJX/SXlD8xeMeHW63hewokeFLDqL7e27V0v0jsv+a3lzPNIpp3PCo1qeWNrC9zfrwlintnZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=p5vefDSZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="p5vefDSZ"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7ICTT2977799;
	Thu, 16 Jul 2026 04:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=lnMjde9WXozrN8sFk3fzsUUVDJ7
	sfB8HnP9o1lToDtQ=; b=p5vefDSZS0w3UvWQi0D3ZedPpz1m7hnlvFJrDhOb8Gj
	lewag4lVFYtvxeQq0fynzdHpl8h80obB2jMzH5ehSdCNfT7L9/JO4VZBzqiQ7ipZ
	uhmyqgS4iUf+35vWocu4zgK7ATNWkznVNPzbHDfiXDxuvQu4G/jywmB4cy9+iISI
	rmMR1IRsTW43NVv28dnHjSYzcaCt7jx42KXRhkX5gkhCMLnM5FvCRQSSfjMG1l6Q
	DxaPUxmoIrpiG/mZKlBGmiTSaic6TqDrE9riRN5Wf+EokucuArfFwahtZXuiOKF6
	t6xON7j/Q+uduz/VKq21xgw8wkj39DRudpnTxAY/xmw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fe70e4hmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 04:02:26 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66G82PPv058831
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 04:02:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 16 Jul
 2026 04:02:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 16 Jul 2026 04:02:23 -0400
Received: from analog.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66G7xo76012697;
	Thu, 16 Jul 2026 03:59:57 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH 0/3] Add AD5710R/AD5711R DAC
Date: Thu, 16 Jul 2026 15:59:24 +0800
Message-ID: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFyPWGoC/yXMQQqDQAxA0atI1g1MBh1tr1JcTMeoKVQl0VIQ7
 96xXb7F/zsYq7DBrdhB+S0m85RBlwLSGKeBUbps8M4HV1NAkRljV9XkFLfFVuX4Qi4p+WsTqEw
 Bcroo9/L5be/t37Y9npzW8wXH8QUqHPK3eAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784188790; l=1751;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=xs8YknLjV4ZkpO4Xkh1rNRAAJ0GGNwYW0ostBkKnvtk=;
 b=wEcJG1uS31KzRmtO3W+MTAOeT+SwXxXRvMacIvWu5djT1lbEWf4xjz+X08v/OL0OH+BeJhq1j
 wM+5muvdNDtDoU/JinCVgYtFSPKe0GvVA+reNLJakMlIxmKdZOUumtI
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfXwMrVlAMa4paR
 7wUSBpng9zjrStGRMQ9hLXUWEGwosRLN7qVLPtxq3JacrY4fXLKT32uiWcFVmZNGf1chZ783m7X
 YoDpsPg8OlOKYopqVy/oj0+oVbzJULfJiEC618uN1iq62yF5HirDA3sOadi2WWWZeyCZK9WtKb7
 vJICHeKM4V6mdAj70dbqTSHFd18X2luUPDwVbFW6qnJ0k3fizRWXGVDOhmqOeC6rU4OeritzKBx
 potwbHqRU0xr2jpPTrmvypNHbbTLkYM5N7DycTXteuZo9VxpauXxqgvPhS+UQbIuZ480DVrEM7F
 9/owLBdSp9weuQvUqLMJhvt5gKfrUzHb8LD7xhx983sNsCM6HiFKTYYXPU9JaeQrVMiOi9L9O26
 n+pknONT55ZdSVRYAZg1aPktEFfb4mZrMaZ2s3/7JWClPbvepSMK5BTTforYXhiLJctzoO/fMCU
 0FZ8YbKer3+TxAPPEYA==
X-Proofpoint-ORIG-GUID: U4F_UUyfeio_zskPU9qTgRdNqhrUpIxW
X-Authority-Analysis: v=2.4 cv=XsLK/1F9 c=1 sm=1 tr=0 ts=6a589013 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=Ji6D2gKqYtNUYUYuYDUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX2/w+jE+Z/ah8
 ANCR6HHuzjFnMJjSmQECgnjUnRuRJVH3EtMjyGkiHOOYebVjSCH9bSQNdncBu3TmppWPFQPkZd4
 5TYZ2tbQUKr5m2vAlTT090AVXOpDAgpFwSU6JYbscTEbpR0eQsSh
X-Proofpoint-GUID: U4F_UUyfeio_zskPU9qTgRdNqhrUpIxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160081

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
Kim Seer Paller (3):
      iio: ABI: add DAC high_z powerdown mode and current output entries
      dt-bindings: iio: dac: add adi,ad5710r.yaml
      iio: dac: ad5710r: Add driver for AD5710R and AD5711R

 Documentation/ABI/testing/sysfs-bus-iio            |  10 +-
 .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 ++++++
 MAINTAINERS                                        |   8 +
 drivers/iio/dac/Kconfig                            |  11 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5710r.c                          | 484 +++++++++++++++++++++
 6 files changed, 656 insertions(+), 1 deletion(-)
---
base-commit: aa58ecc73466d0cb8c418de98e2225490bf600e3
change-id: 20260716-iio-ad5710r-upstream-e41c298614c6

Best regards,
--  
Kim Seer Paller <kimseer.paller@analog.com>

