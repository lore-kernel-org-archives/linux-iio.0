Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D438911E;
	Fri,  8 May 2026 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241403; cv=none; b=RS+QjIi7ZspHJTqvo/Xu7wZv+fTtotnRXCaVnfxex21G1TpCU46Up/fAaDDNwcnjy6rkGablTUde69EYmkznqk5cNTDMvPe2ahD7Kk9Y3NYvqfIrq98mg6KoZrQEtJgbd2JEskQO+v1b1eN6/ibKEOZ9x7Kr68ze0TE53Ky7ZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241403; c=relaxed/simple;
	bh=fbDuAxKAfdiERygBHfOJC2QhPBHyUoS9LPt4mdU1wtQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=pjtCmbybHWI0n+hOp6cVaGa5ks+VuGqtK9D3XaVmRE8y7xLkzD3jRH6vv+FvPWWPTxnZEgJIFuePN/F0yz6KXj+HyD27XbXAwgmItiwjgsbE0eO7nXC8pPwxyNTBcbwA8foIHF7QGexivNuOjso1Lh0sBcx6zNXQPKbKJbOllvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=K5lw3phT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="K5lw3phT"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6488vSPC3611580;
	Fri, 8 May 2026 07:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=hk62+xfqDHCxd1SiTveEfJeoJyE
	i+VJAscx9p6EewQo=; b=K5lw3phTTiqJ9L6+rCfGoRad1NF3BljopnQu9ZWyEcC
	qKeeRs0fKGe1PXItVka3VoCgZXNAG4CXadqXK38kMkpp2hCywIqOP/qMnWBUEl1e
	FrCiALEt4AVtJUCpIPZt8d0UkZIdrXIAYTvNPcUk0wZadjUHBHu5SY/CS5BVNaOn
	eNVN5del74CJ3a58RjddMFEci6oQ6Wrh3OpsFvr02TZGF0c8Dk2pXs4RfFw/R5CD
	EOTfegJJQ5LO7inXMuP9ZL1bwBMTTXhUeYPRZl3d7goAdQo7cCi2nV2kuuD1/BK+
	FzIMiU52MUNSqYg5aVows4cJ5ewbPFgrsi2bo0ejlyA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e04pjj6my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 07:56:06 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 648Bu5hU041457
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 May 2026 07:56:05 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 8 May 2026 07:56:05 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 8 May 2026 07:56:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 8 May 2026 07:56:05 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.80])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 648Btmn8001846;
	Fri, 8 May 2026 07:55:52 -0400
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v2 0/3] iio: dac: Add support for AD5529R DAC
Date: Fri, 8 May 2026 13:55:46 +0200
Message-ID: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAELP/WkC/3WMQQ6CMBBFr0Jm7ZhSoaIr72FYFDqFSbQlU9NoC
 He3snf1837y3gqJhCnBtVpBKHPiGAroQwXjbMNEyK4waKWNatUZrWtbfRF0wpkEO2OGwbnONI6
 gSIuQ5/cevPeFZ06vKJ+9n+vf+zeVa1Q4NI1R/jSW9Tcb7CNOxzE+od+27Qs0c7OorQAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778241348; l=3114;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=fbDuAxKAfdiERygBHfOJC2QhPBHyUoS9LPt4mdU1wtQ=;
 b=NuhsfWhHwxe0nvtD9e6n3E1wGn/M9AXJUCkJMZ/94GJpQ6jgoWU3prNjjt3haWgNFXdaPqv8J
 Od4HTzCA7gbDxfvuSt9xube1qSzYrUTeok3doDTqzytp/rnOqfA30Ax
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyMyBTYWx0ZWRfX8VfS10vsgkXG
 KV1FNeoLN/7t6XYbjzViBgOUoWit9DaO4CCImChIubVKlTRUGD1MxZj4GQouRRu48s92a7Pz3zB
 Bw6fLqv+HZpktF43Cc/pBFAQ3eScnh+octOes6R1+U9mFGnrLX2Wy2N5CsT0OLoJSJGtDUEgkze
 MABwIPU4x1nZrKzsEc0M4TTmVSp+wWfFhJtW29i0uJJhQR8/t965Vvfgg7+6tac6qMo96oG2/+c
 e7jydFrIwgakC38gDvE+UWk175pMZ5lXM5+05rMvzsf3uexRxe3Mkzlk+JrcMJcWcRmyS6c8gi6
 +/zxBT2pQ4V9riJKO/Nw+dA491267aoIsWy+ShOrCbvEj/JZMTBHAZE4JpMJqpxE8oVvDOix+tc
 C96YajXUOVcPxlDD03rQnzGnJtyhQTj6Lao4OyF13amnyjcBgalmswSzsIn/Gdp4er6U19/gt0m
 CZAwChO4BcZ5wPv2/IA==
X-Proofpoint-ORIG-GUID: vuobr1JFZtDR4_Rv7jP1Lp9bNaSFNyjW
X-Proofpoint-GUID: vuobr1JFZtDR4_Rv7jP1Lp9bNaSFNyjW
X-Authority-Analysis: v=2.4 cv=Fss1OWrq c=1 sm=1 tr=0 ts=69fdcf56 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=YxgiqPtEoaFku8kIEysA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080123

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
- Automatic detection of 12/16 bit variant with product ID read.
- Reset support via GPIO.
- Dual regmap configuration to handle 8 and 16 bit registers.

**Patch Summary:**
1. **dt-bindings**: Binding documentation with channel configuration.
2. **driver**: Implement IIO DAC Driver with regmap support.
3. **documentation**: Add driver documentation with usage examples.

**Testing:**
The driver was compiled and tested on the EVAL-AD5529R-ARDZ using a
coraZ7 with a mainline v7.0 kernel.

**Driver Rationale:**
AD5529R introduces:
1. A unique register layout
2. Mixed 8-bit and 16-bit register accesses
3. Product ID based generic identification
4. Hardware specific features like function generators, multi-die
hotpath registers etc.

The device warrants its own drivers due to these fundamental
architectural differences, that would require substantial changes to
existing drivers without providing reusable benefits. The standalone
driver also allows future extensions for related devices in the same
family.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
Changes in v2:
- Fix IIO scale to use millivolts per ABI requirement
- Fix documentation voltage calculations (2.5V not 2.048V)
- Fix bipolar ranges in documentation (±5V, ±10V, ±15V, ±20V)
- Fix alphabetical ordering in documentation index
- Add missing newline to documentation file
- Fix scale units description (millivolts not microvolts)
- Include a section for driver rationale in the cover letter
- Reword contents in cover letter 12/16 bit generic->variant
- Add dependency array for spi-cpha and spi-cpol properties
- Link to v1: https://lore.kernel.org/r/20260507-ad5529r-driver-v1-0-b4460f3cb44f@analog.com

---
Janani Sunil (3):
      dt-bindings: iio: dac: Add AD5529R
      iio: dac: Add AD5529R DAC driver support
      Documentation: iio: Add AD5529R Documentation

 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   |  96 ++++
 Documentation/iio/ad5529r.rst                      | 216 ++++++++
 Documentation/iio/index.rst                        |   1 +
 MAINTAINERS                                        |   9 +
 drivers/iio/dac/Kconfig                            |  17 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5529r.c                          | 564 +++++++++++++++++++++
 7 files changed, 904 insertions(+)
---
base-commit: 93df88612859e8e19dec93c69d563b4b73e9bd4b
change-id: 20260507-ad5529r-driver-866bbdd864de

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>

