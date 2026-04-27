Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537903C6609;
	Mon, 27 Apr 2026 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296581; cv=none; b=JG+gnI5GUFE+ylPGlH5SS7kDw5aziGDkAH3jcEIyGyg6VBTl6S5IZl/5Fh3fKuZ2vF5cYAhrTpwRKAiEj1gBWDhKxFVVPkWyjZj+Q0ixetM2NkDfWa/6xjL+/nsWPqtEwKHAPPWCko2nAIbLjnS6MzGklYSfNtyhCZAxQiNNqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296581; c=relaxed/simple;
	bh=uEZXCUYMP5TZP98YdFzo8GcpWfItsNUTGOrMg3mBNqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jll7GFuqsyZ3DGroeEFrkhjwd81SKyGz9U/ewWdFOkKMx5Y8sQN2ST0PhPGcW2H6NqO1Z7Bbb76D3XJbZXBIBfvxxsmBJd13uOF92zaXhNDrUZiRhVE/VYx0YgfJQtOJew6hGZ/rUcJM92zoplRFy522WZjFWLKfU4UHcoDQzn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qapyWVrX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qapyWVrX"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RB2ufU670081;
	Mon, 27 Apr 2026 09:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=pWsVxStCNnkJvWBFMrJAq73zwO0
	1OInXWnnZ7Hc7qI4=; b=qapyWVrXBCX6DgKxdtu1RdfoWaUDE+lYNySRfzmfSXR
	QOy512vE6dr144VVUgpvNnAi1p7jWibT5+6NDFwl/aK2H4t54sYAS8m7lyOh5pg+
	kboayoFW/V3xPSTLR7q+1N3nGyR9/tnDWW9XqS+1AMKYLIU2NGto1HGVqQvEKhC0
	e/FKQFzTHtxRv8T8K7Yc4kx/jD4M567w7DZcDZ0IOzOT9Bptfv9t6aS/KbxJ+p80
	RKc7CNUtg7pToHTbOrHpJHUfdMmD2DkwCDePecDfxZPALRSG8PPgGbooDDKLCpV4
	jsbKKhlq8VuNcSzkmbAs+rsx8tHnq9onGljEa863buw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dsbxcvny4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 09:29:24 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 63RDTNTN003137
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Apr 2026 09:29:23 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 27 Apr
 2026 09:29:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 27 Apr 2026 09:29:23 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.107])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 63RDT8SQ028079;
	Mon, 27 Apr 2026 09:29:15 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Liviu Stan <liviu.stan@analog.com>
Subject: [PATCH 0/2] iio: temperature: ltc2983: Add support for ADT7604
Date: Mon, 27 Apr 2026 16:25:06 +0300
Message-ID: <20260427132526.272716-1-liviu.stan@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0NCBTYWx0ZWRfX2PQ42+ZRffmi
 d9xM5ErMZdxCpxHk2MSpxQ/5MGJ6g5wAsgaF0eyYIvpLMmVbRbj20IdHvFVr8/QSh9qTQGXZS7z
 bgu3M4hJFVPRWdR1j1IWhjVV2zslWIRUjVd5VlCZuCDKeHDVqehBE55Gvsj7LIk0S5FA/spcYQg
 WqOgV88rGVqGWAKNQ6q1eqyQiGaRQRBoapNQtiy1/XH5KEj02IScRC7WHHTy+24jOxCnjyN5M+X
 RVabAQsqG8ykxZGk76+J+iK5JV2dWPF0g97uLdy+PQkWEZwwrLtGN4/uHcHMHGub4i2pxe4R87y
 q7WpMJ3LahE0MtU5SWx+wgpcOTbigFaz3QZYP9C0d4XVk1sZz5ywukjYgsNP9JgN/a7+IbWLexF
 U8dipWYzCPg8LMv7Zc1Ad7nRFA1HhgTxdkMI6Yu0QExQXausrlLJbuCWu2jJPr3zVDzbitLiGaZ
 UrMZM0f9vd3Su9Rvgzw==
X-Proofpoint-GUID: p2NHPDHxfmeViHrCXpBG5O3S6nObt28Y
X-Authority-Analysis: v=2.4 cv=SbjHsPRu c=1 sm=1 tr=0 ts=69ef64b4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=GEOGvlTdorwptlCKM64A:9
X-Proofpoint-ORIG-GUID: p2NHPDHxfmeViHrCXpBG5O3S6nObt28Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 spamscore=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270144

This series adds support for the ADT7604 multi-sensor temperature
measurement and leak detection system to the existing ltc2983 driver.

The ADT7604 shares the same die as the LTC2984, reusing its register
map and SPI interface. It repurposes the custom RTD sensor type (18)
as a copper trace resistance sensor and the custom thermistor type (27)
as a leak detector, removing thermocouple, diode and direct ADC support.

Patch 1 updates the device tree bindings: adds adi,adt7604 compatible,
copper-trace@ and leak-detector@ sensor node types with their respective
properties, and an ADT7604 example.

Patch 2 updates the driver: adds adt7604_chip_info with a has_copper_trace
capability flag, the resistance result register bank (0x0060-0x00AF),
hardcoded sensor configuration for both new sensor types, sub-ohm copper
trace support, unsupported sensor type rejection at probe, and IIO_RESISTANCE
channels with appropriate scales (1/1,024,000 for copper trace, 1/1024 for
leak detector).

Tested on EVAL-ADT7604-AZ connected to Raspberry Pi 5 via SPI.

Liviu Stan (2):
  dt-bindings: iio: temperature: Add ADT7604 support to adi,ltc2983
  iio: temperature: ltc2983: Add support for ADT7604

 .../bindings/iio/temperature/adi,ltc2983.yaml | 170 ++++++++-
 drivers/iio/temperature/ltc2983.c             | 347 +++++++++++++-----
 2 files changed, 418 insertions(+), 99 deletions(-)

-- 
2.43.0

