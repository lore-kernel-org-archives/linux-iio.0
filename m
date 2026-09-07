Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3D411F95;
	Mon,  7 Sep 2026 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776390; cv=none; b=WZqS6IIq9lfnPeRbtN47M1n2Kcuc4uVaWFHQp3hWHeTUppqb71RENOpIuxGJUxiLgApOHvaikCLXMPgD664zLvyBDM/GgJtaVLUX/6GjIQM9A7RgN7kGAip0qUrfMScmkeFxStmci05y+m27U7wDldTzUFjfN5VN5JhRyjLgmIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776390; c=relaxed/simple;
	bh=AeDehaS3lnZVD+uqFs7acviz1mmh7H0aERDlWs6DYjA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/58C2D2Pg1JJy7dRvycGCAo1j+W4Q1WHbevWiR35QqL+h3c4VQ66jeGsxX6Hy9qNlIwomRaDUs5OnMEXrevC4B/qEdg57fs840KWCHnafja/kRj1kAUE8i2nUXaoGuCU8M04C46BgyKfAI7uQHKUn7ndmrcmCblt37a8UsakK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=y2tlmDd9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="y2tlmDd9"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6879YNfb2726330;
	Mon, 7 Sep 2026 06:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jkmVh
	fazNEFBnoGm+hy/0GNdF8QmsKMbuWiFAzVD0z0=; b=y2tlmDd9Ls3gAeqymZ5tj
	+SZH4Jl7Qu+oCNpwgAMpC5zsufecLLwPduFda8oxB7PcenWf1KuC0JLZlmU3dCgZ
	puhtuvHpnh5eP5HurqexwFCJOOIRmA9/FWWySKVboeTseq+u4CEaIOHKSxD4t/PB
	vlmAHq0BfgQystTuIjN5hw/DrSghUXo6gpB+c171GG3CdvTjWKIH76EK0/OblnEc
	6UMKuJEDTN7pCOjX2P4tiYA6QkSgK7krlQ7zt6TYZub1LyMxtHPD6YzktbrjCAOB
	HoiCJ7i7hN18EGco5KFQGAWOYvdAjcKvibqEFJbWH1F7Yl33TWosGZVV86D86quD
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gh1dbvuqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 06:19:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 687AJUAE010597
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Sep 2026 06:19:30 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 7 Sep 2026 06:19:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 7 Sep 2026 06:18:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 7 Sep 2026 06:18:38 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.185])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 687AI3Dg007412;
	Mon, 7 Sep 2026 06:18:31 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Shuah
 Khan" <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>, Salih Erim
	<salih.erim@amd.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        "Jakub Szczudlo" <jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 4/4] docs: iio: ade9000: document ADE9430 support
Date: Mon, 7 Sep 2026 13:16:21 +0300
Message-ID: <20260907101623.8730-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907101623.8730-1-antoniu.miclaus@analog.com>
References: <20260907101623.8730-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=XOsAjwhE c=1 sm=1 tr=0 ts=6a9e8fb4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=91yIaBucF7qhNAsP3n4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExMyBTYWx0ZWRfX+xO4RbdqucOZ
 pJliXDAHvdxhnIDbcLw4MbqaZjEhtq/xrpq1Fz6P39660FRcH4EYAZDQ6h3HsvgXqxhUAFIdlmL
 mNw/s8j4nGk5dTZSgGSdP65IFInbn3DuVXJ6wPsCm0cKMfaPSuA6
X-Proofpoint-ORIG-GUID: ZG7r8CVvf5mQIUmKzBRRRMmwmsVsK69s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExMyBTYWx0ZWRfXw9lYtqTbdvcF
 JlED/n9TadSw+DmeR3MHaqLuRpzABOi2tgUJY0UaL6HdwDddrHoPaA+iXWNwsbJC4sgJryMRKb1
 xN88LEq2KPbcOrMTsSYNQNDmkizFYWBsrqhBR3DtPphY6gWuP3q5Uc9GDcjJhAmYZ5TQk23mBkM
 /1aAzeiSgI0Dzm16mWOagN52JZMD9q23SVornVmTPeBp5C6sf97r/jlDKbhxbc1+8+sAVzCY31G
 UOaa4Qe38HDCYU8or01ddeAtqvzgMfuCE0+CVM3GYQGRsA/k/SlhHLEWWisJx0SYNr7M8yHceVQ
 zIq7xWT44j/km65dOEb64XXaz/mhXi4QdtXBD7s1nioOl06tCd+TxSOh0bxIyXyQrbdSxFQP2VO
 tvn0J8520sLYN9f0TJZfL3ucvkvd939RmJGn/ugbSAXvr5oaILz9Mlr1gLkXpvrVy9dyGSOXNG5
 Rs8qubYaUa4YnDfMxuQ==
X-Proofpoint-GUID: ZG7r8CVvf5mQIUmKzBRRRMmwmsVsK69s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070113

Add the ADE9430 to the list of supported devices and note that, like the
ADE9078, it does not provide the on-chip dip/swell voltage events. Also
note that the ADE9430 has no on-chip digital integrator and instead uses
an external analog integrator for Rogowski coils.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/iio/ade9000.rst | 36 ++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
index 72737b5ec59c..881b7ff2ad3e 100644
--- a/Documentation/iio/ade9000.rst
+++ b/Documentation/iio/ade9000.rst
@@ -1,29 +1,31 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-======================
-ADE9000/ADE9078 driver
-======================
+==============================
+ADE9000/ADE9078/ADE9430 driver
+==============================
 
-This driver supports Analog Device's ADE9000 and ADE9078 energy measurement
-ICs on SPI bus.
+This driver supports Analog Device's ADE9000, ADE9078 and ADE9430 energy
+measurement ICs on SPI bus.
 
 1. Supported devices
 ====================
 
 * `ADE9000 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf>`_
 * `ADE9078 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9078.pdf>`_
-
-The ADE9000 and ADE9078 are highly accurate, fully integrated, multiphase energy
-and power quality monitoring devices. Superior analog performance and a digital
-signal processing (DSP) core enable accurate energy monitoring over a wide
-dynamic range. An integrated high end reference ensures low drift over
-temperature with a combined drift of less than ±25 ppm/°C maximum for the entire
-channel including a programmable gain amplifier (PGA) and an analog-to-digital
-converter (ADC).
-
-The ADE9078 does not provide the on-chip dip/swell (sag) detection available on
-the ADE9000, so the RMS voltage swell/dip events described below are only
-available on the ADE9000.
+* `ADE9430 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9430.pdf>`_
+
+The ADE9000, ADE9078 and ADE9430 are highly accurate, fully integrated,
+multiphase energy and power quality monitoring devices. Superior analog
+performance and a digital signal processing (DSP) core enable accurate energy
+monitoring over a wide dynamic range. An integrated high end reference ensures
+low drift over temperature with a combined drift of less than ±25 ppm/°C maximum
+for the entire channel including a programmable gain amplifier (PGA) and an
+analog-to-digital converter (ADC).
+
+The ADE9078 and ADE9430 do not provide the on-chip dip/swell (sag) detection
+available on the ADE9000, so the RMS voltage swell/dip events described below are
+only available on the ADE9000. The ADE9430 additionally has no on-chip digital
+integrator and instead uses an external analog integrator for Rogowski coils.
 
 2. Device attributes
 ====================
-- 
2.43.0

