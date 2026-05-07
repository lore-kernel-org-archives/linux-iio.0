Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE0043CEFB;
	Thu,  7 May 2026 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171349; cv=none; b=Yo6E6JkTCNtBy8DO4mlnsltiNXYCzwHjmV/yAR13/gMYkbOdaapN/UVR0aG5QYnOpAT/slxIlC38jUtKBzQolyCinHR6cy8CTHgpVU9JbVqeczJuLFzyMC+JsuOjfCks7y5Mceyk1Dh6ZQfhBZ/K1Hznr/O1oAiPIEcLyzUBuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171349; c=relaxed/simple;
	bh=5Sa4VZO0SqSH1YZ1xIVDU0ZzfB2sxhGGbWBASPInkrk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Q2Yd7wvCXHKMd40EneKsaSyeZcAo3/svVmm6SgMSMv0EaA53gMkVv5HtaEPhDXtK/xMC2rjOrRl2gdgv5YdOE8xyjmIJOxLkdbrzRMlGGs2Z13KoPIf07vKKfYu+hkc6NBbtttjzMvPepFLPm2WkPc5Uxfk23goJrEugomV8OYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Kh6BwpDZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Kh6BwpDZ"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647Ekp0m3611580;
	Thu, 7 May 2026 12:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=FEjDVLts2YhERmV0gF7bRd0gSmw
	gGO5l+n11cUIs5mA=; b=Kh6BwpDZvyrffat2qsk97dxBhOwQ+Xb3V3pDoW3hrFW
	TM1iGwF9pC70RJyJOhaq5+F+nGisAzsWviG/WsvAYT/GSGKfW9tqquXUZjiCLhz9
	T3nYRh55nQHk+7YAFCoiVqZJvBPYidtcHtbBeX+QLXWabULpG13yv/BqxcgAtjTm
	rOSAh9oXzT1IE5sU5yvpZuFBmP/PvQfqmLTTJYvmKEj68+Tc6gK2Vq4JpzEebvWD
	Y7AyAjB6Q8AHSCxe+BxLS/2a/6KimBUz7/BlaqYcQDkzgaANHaAqEVCrXaFqrFjj
	58DSBb33fvwlZPxDQtOSupTlsBMf87/rR7pN/5tNYBw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e04pje3sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 12:28:41 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 647GSelq021369
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 May 2026 12:28:40 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 7 May 2026 12:28:40 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 7 May 2026 12:28:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 7 May 2026 12:28:40 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.4.71])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 647GSMkL030829;
	Thu, 7 May 2026 12:28:25 -0400
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH 0/3] iio: dac: Add support for AD5529R DAC
Date: Thu, 7 May 2026 18:28:08 +0200
Message-ID: <20260507-ad5529r-driver-v1-0-b4460f3cb44f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJi9/GkC/x3MQQqAIBBA0avIrBNM0qyrRItspppNxQgSSHdPW
 r7F/wUSCVOCURUQypz4OivaRsF6LOdOmrEarLHeONPrBZ2zg2gUziQ6eB8jYvAdEtToFtr4+Yf
 T/L4fxIL23mAAAAA=
X-Change-ID: 20260507-ad5529r-driver-866bbdd864de
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778171303; l=1936;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=5Sa4VZO0SqSH1YZ1xIVDU0ZzfB2sxhGGbWBASPInkrk=;
 b=vCv3mgA9NCuy5clbFzpkffzLLE9iYWGGd56JfuSvFhAXbteoLZ4U8P1Lh4T7lBXmJUcZSXjbu
 HfnvaR3MPeyCG+/N9nYsivKozS9LVlkoGXHFRumoUXU9lgMPHn22ezL
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE2NSBTYWx0ZWRfXyLwSnIGTc/T7
 1NZ3EPlaQcnnQk9Az9ecxN57BCZjU7mTjCfXMIsgVvqU7Xpt4sUHq7UpFXEtgu7uKo7aKroXSY8
 LuETZk/VzK4L6TxiqrnW2Y4QoBg4e4wqi6pPeBYprES+UMvur+lYsmWz86+OR7tgNKKrE3Goyl4
 uJYoUuosjBYEmZhejbPHJ4sdXZtKJXDWSwr/F/CFZ6wNXcJah0MkhT2sp1ktzJH9lZ/8iYvoQ22
 aKYMHbn7sn4cYhaZ15yCiAfJFTr+biz4MlOP3O6j2nyGWkEZM9d7dlLsgT7Xo5iyh3g94aWWubF
 uawrQ/aml/TEO8deIfXoJi+hpFbsJQ/rP3ZulUwXed2dPzLdlZP/mCyxeF/HD9zYMSVIatkXVZP
 JXongmffVwzEvZmtxx74i/BQgAP0rE/fOCzegT1y6fsRezXMkadss789U6I6X+dt7fq+EyqumU9
 okpQZoYrt5sQzHRjc/A==
X-Proofpoint-ORIG-GUID: I-MxR6FQmn6zU6kKPjWxhI3s8EVmFXz2
X-Proofpoint-GUID: I-MxR6FQmn6zU6kKPjWxhI3s8EVmFXz2
X-Authority-Analysis: v=2.4 cv=Fss1OWrq c=1 sm=1 tr=0 ts=69fcbdba cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=JRHt1TshlDf7fg1QQcYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070165

This patch series adds support for Analog Devices AD5529R, a 16 channel
16 and 12 bit voltage Digital-to-Analog Converter (DAC) with integrated
precision reference. The AD5529R operates from both unipolar and
bipolar supplies. The device communicates via SPI interface.

**Device Overview:**
The AD5529R features 16 independent DAC channels, with 16 or 12 bit
resolution, allowing independently programmable output ranges. The
internal 4.096V precision reference sets the accuracy of the output
voltage.

**Features Implemented:**
- Automatic detection of 12/16 bit generic with product ID read.
- Reset support via GPIO.
- Dual regmap configuration to handle 8 and 16 bit registers.

**Patch Summary:**
1. **dt-bindings**: Binding documentation with channel configuration.
2. **driver**: Implement IIO DAC Driver with regmap support.
3. **documentation**: Add driver documentation with usage examples.

**Testing:**
The driver was compiled and tested on the EVAL-AD5529R-ARDZ using a
coraZ7 with a mainline v7.0 kernel.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
Janani Sunil (3):
      dt-bindings: iio: dac: Add AD5529R
      iio: dac: Add AD5529R DAC driver support
      Documentation: iio: Add AD5529R Documentation

 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   |  99 ++++
 Documentation/iio/ad5529r.rst                      | 214 ++++++++
 Documentation/iio/index.rst                        |   1 +
 MAINTAINERS                                        |   9 +
 drivers/iio/dac/Kconfig                            |  17 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5529r.c                          | 564 +++++++++++++++++++++
 7 files changed, 905 insertions(+)
---
base-commit: 93df88612859e8e19dec93c69d563b4b73e9bd4b
change-id: 20260507-ad5529r-driver-866bbdd864de

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>

