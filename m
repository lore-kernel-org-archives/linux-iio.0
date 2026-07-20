Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181C3F44D3;
	Mon, 20 Jul 2026 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545736; cv=none; b=gfPANtxBVzE3k4+m8mEHHGnycliNlUvTjQ8BxGDvF+Bt42JyeaLJjc9Wi/inCbrZmYHorvK3uNjIHHfzy3amNR39EDHD05do3iQDJYngsSF1RzCfT+VwfLasjr0mHedBDRaF+w3I8zUsWc3GXbRj2AFL9AWRbHk7JfnpGLxxq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545736; c=relaxed/simple;
	bh=hWFe0ecnQcUQSMIYZD+mzmuzSF2Cw8zD7HT3rsKQcXU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzs8hvtjLMAlTevO/Gk8PQwCu36tYiWkrc0iLalc44NoxhRdxGigcx3IcQCkxp732WWARNSzb1lVBLUq8mfVvJO86L/5o7AhSR9JNz8gNvIpd0PxrWCDZ/p71byTzme1HA+twQz9/rxL/jB9kQwmcqkCA/ZNaIQX9Rg58JTfpQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LIpkVI8F; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LIpkVI8F"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KB037Y1779716;
	Mon, 20 Jul 2026 07:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qdPT8
	ZxebWPScerPBsarwdPl2SnE05MlhbpNzsiEUB4=; b=LIpkVI8F/RGzui6vDROr9
	8nFfNpPFrOBO3ZIc821KaaUXh3Mop+fk8J/4JQcwOroAc51ieHLeWBUmDb6Fyrd9
	yolXOFnvJ1rdW5kDfwlqZSdxvd33j3GDtxS6SYQ0IOFt9SYvyBoOiRTHLlKWxA1M
	4fT8GSBWD5BXfyaIj7/T6DjwimaTbJqxBIGBbOnYJVq8rFUgLuQUY6RtwLfztpOZ
	yfm0yu6XIAFcGb95215KnsFD4jFDiUXpBWEKvQXR9UXF6uC2WV0YKQU7V5xHZ3uG
	ksgV9OUNR4HWwrm/OwkxdmGMsTjIZJhrYDPSBC4jHA71oLqTlBXh2ZSQ0SNFoveM
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fgttgbrsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 07:08:48 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66KB8lgd062909
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Jul 2026 07:08:47 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 20 Jul
 2026 07:08:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Jul 2026 07:08:47 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66KB8HRL024360;
	Mon, 20 Jul 2026 07:08:38 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Radu Sabau <radu.sabau@analog.com>,
        Jorge
 Marques <jorge.marques@analog.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Jonathan Santos <Jonathan.Santos@analog.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 4/4] docs: iio: ade9000: document ADE9078 support
Date: Mon, 20 Jul 2026 14:07:47 +0300
Message-ID: <20260720110754.7674-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720110754.7674-1-antoniu.miclaus@analog.com>
References: <20260720110754.7674-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: OduvDxZK793egffVO1Cc0si5fjo4khDi
X-Authority-Analysis: v=2.4 cv=DagnbPtW c=1 sm=1 tr=0 ts=6a5e01c0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=dVqSPRu-xMqTFQGYfZQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyNCBTYWx0ZWRfX0+lr27AQn7g7
 novLIl9Ry0bMJZMVOOJ3Q50mmAjKPGxgMgQc4Mnz7HBtnPv/w6ECXlAjQ6Z02wBihV3BBcuHPe1
 jte+GC80DWnlVo2tU5gh7990whcg7qLhq/0CHPUyQEY7P5dImtBw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyNCBTYWx0ZWRfX5Ze2mEmHU3My
 1l2mYmV2Lvx2eeswhefPHua1bsCJZTOrRsLVVSM9eXLcqoXsytKNf/9J+aBnDJK8DFJAF70o1y5
 nQGzhMtCgev1+xAjaBVgFzA7Uw/hXJjQ7OP/80w8tmXMafZ0DQagh87t/wynzfORdX7tWHpSImP
 QUPNR7AAZnJiFLi7kqfUp/Vaby1S7+IEv7BYiBhWISS7i6UYpd+m4J6QSz1oprMPl7QXqeABlFF
 pWZsA4N/TqTlN0KE40sx+gQPCY7etvJGax3+EkrSTYn4GOsDXclnHoCiHsxybnJ2RcKx/DvUK6j
 WuC8g1OKrdfXL11L1cZ4y7uEtYfffXm6h4R/Vmf/yfP61/qY+nM5ydY/5doDd6lDiYYOHWDE0Ar
 mIzX5jOVv/t6LT62a178vzqQJlJFJMUFnG9w7PshChTUjgqXdu6IbIhx+TLEzS69e9PxLPyjBx6
 BkPuOPTJbrWG3ns4Wlw==
X-Proofpoint-GUID: OduvDxZK793egffVO1Cc0si5fjo4khDi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200124

Add the ADE9078 to the list of supported devices and note that the
dip/swell voltage events are only available on the ADE9000.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/iio/ade9000.rst | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
index c9ff702a4251..72737b5ec59c 100644
--- a/Documentation/iio/ade9000.rst
+++ b/Documentation/iio/ade9000.rst
@@ -1,24 +1,30 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-===============
-ADE9000 driver
-===============
+======================
+ADE9000/ADE9078 driver
+======================
 
-This driver supports Analog Device's ADE9000 energy measurement IC on SPI bus.
+This driver supports Analog Device's ADE9000 and ADE9078 energy measurement
+ICs on SPI bus.
 
 1. Supported devices
 ====================
 
 * `ADE9000 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf>`_
-
-The ADE9000 is a highly accurate, fully integrated, multiphase energy and power
-quality monitoring device. Superior analog performance and a digital signal
-processing (DSP) core enable accurate energy monitoring over a wide dynamic
-range. An integrated high end reference ensures low drift over temperature
-with a combined drift of less than ±25 ppm/°C maximum for the entire channel
-including a programmable gain amplifier (PGA) and an analog-to-digital
+* `ADE9078 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9078.pdf>`_
+
+The ADE9000 and ADE9078 are highly accurate, fully integrated, multiphase energy
+and power quality monitoring devices. Superior analog performance and a digital
+signal processing (DSP) core enable accurate energy monitoring over a wide
+dynamic range. An integrated high end reference ensures low drift over
+temperature with a combined drift of less than ±25 ppm/°C maximum for the entire
+channel including a programmable gain amplifier (PGA) and an analog-to-digital
 converter (ADC).
 
+The ADE9078 does not provide the on-chip dip/swell (sag) detection available on
+the ADE9000, so the RMS voltage swell/dip events described below are only
+available on the ADE9000.
+
 2. Device attributes
 ====================
 
-- 
2.43.0

