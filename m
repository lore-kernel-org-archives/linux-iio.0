Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549113F1ADF;
	Mon, 20 Jul 2026 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545722; cv=none; b=YHomvfS959AyPyY3EsP1nnS2G74/Q2p9ByrLvyiIlxJbwre3OBaaysTM55gDesoBDoLaGyxKqU4JCfc6rC/xGmc2Pe/1eKhSAYMGzbk7nL+QzGzeVLT8vrtxxcXeBuSpJU7k53sdjX8R1iFHiukz7RM5iU4B+QcDVtRgjeYcGy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545722; c=relaxed/simple;
	bh=vrqaP6fj5vmKB+3e0Gw8kXl2gFxCwhcPrcNjPvkrmho=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nFcUuutxUQdU9wlsrIV7rRkjQmPKQB/f3MTwFYJ1cuob0ibqPVD2RAOw4RoTQGum3gEWswpION+ag62bdMM56dmEwzG3Is1ONQFCnXO32JPd2JJx/v18SDsevxisJTttMsjkYpiycF2X/UK5+Rw49lg/UDpqRR3wwiK2cjCFg4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=h5+fums+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="h5+fums+"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KAx9pN1485542;
	Mon, 20 Jul 2026 07:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=FhOuaz6VkoaSNa+bmwnStalmSCJ
	u+QOLYx3oX4MSYgs=; b=h5+fums+UOk7vrHC7YNdc6MCUwzlcPTULIfoGf564sa
	qejYkPli/318gll+FZIrZEr4KjRVgyjgsL6ny0j0FfcLQdS1m+8W8Nj8HUD+2Zad
	INJ/ykn+TNwjAlu6IIY4sFGCLD/ZttamXOaoksqwGnRXMB0VLSZ2P4JD0D8qqP15
	lk7eCEq7o9+CgYz3rJcKdoYyyL8rBbNgDmLh7+UkJ/GICSyDap1gZCACXh8J70ll
	5CQUZyfQbnSAPJiS2aS4dkRy0tw6KUQXO7afU6PE7PmxMXDUrKLZbr/7/CYpWttO
	F8vDmlOd4Q3SHjsUovtA3/A8XXHmExIy2Ko3GJ3TBaQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fgqte42t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 07:08:35 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66KB8Y0f062891
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Jul 2026 07:08:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 20 Jul
 2026 07:08:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Jul 2026 07:08:33 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66KB8HRH024360;
	Mon, 20 Jul 2026 07:08:20 -0400
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
Subject: [PATCH 0/4] iio: adc: ade9000: add support for ADE9078
Date: Mon, 20 Jul 2026 14:07:43 +0300
Message-ID: <20260720110754.7674-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyNCBTYWx0ZWRfX2fSejIDziPB0
 ebi+I74+FGLhYOeoO/yfQI8cxoAuYRk4RIdWNVjzcO2gfGpjtH+EsIRnQANXsiYaTLtSrdHLTWW
 xvl+mjEm6HIi5nEIUb5kFr3jKKd3U4vgz7vAR1XNHzQtabrBIV7YDQsXuHo+Q/v9TjMjiGWoeil
 awteBzdPVlZ9+ASK8U48UilVgJ3C5F/4CBEbirrNUd49lW1eCofLRbXjnwOLSSlfP2kzArzFN7J
 nCwTZnhQpCrOQ1Zvr8BRlprLFgrZE7Dgcv/f7KuOcwm0Uhpd8LtTxuUSB53qIXePoJiMxi22ZOd
 ZyBRORe1jU4J5foyIzL5TAXcx+1EJb+5AIxyz23trXZ21DFySuiNEEH9wCbHyV6A6V0N8fo+Hj1
 GoX7sdDabr2c75Imf4mgDvsQhfNaEtbiBJGIDKJYYpVeGfnyU2AcmoraTYDEhDXeqRlIkt9GpLA
 65MX40bxKVdJOCEJixg==
X-Proofpoint-GUID: FilM7l3nCfvgjeSAft0pa1Fd8n74HXIf
X-Authority-Analysis: v=2.4 cv=Ed/4hvmC c=1 sm=1 tr=0 ts=6a5e01b3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=zsVk_H6PqY_VlGaDqAMA:9
X-Proofpoint-ORIG-GUID: FilM7l3nCfvgjeSAft0pa1Fd8n74HXIf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyNCBTYWx0ZWRfXzPZ8qWsOyiT3
 bml/edlQVKheJ/bxnyj8uxPvT73QH+sx64345m7F0BCNGMvl0nBPMhPh5u+BddqMK1JTcjC32vf
 8uSNBDovRB+usnIaXCGoTw5JrKn9kpQvcMNHiHC3VQkAK0qheW9/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 clxscore=1011 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200124

The ADE9078 is a polyphase energy metering device from the same family as
the ADE9000 and is register compatible with it. The main differences
relevant to the driver are the absence of the on-chip dip/swell detection,
a lower maximum SPI clock (10 MHz), and slightly different full-scale ADC
codes.

This series adds support for the ADE9078 to the existing ade9000 driver.
It first refactors the driver to move the part-specific values (device
name, channel table, and full-scale codes) into a chip_info structure
retrieved via device match data, then adds the new device tree compatible
and the ADE9078 support itself, and finally updates the documentation.

Antoniu Miclaus (4):
  iio: adc: ade9000: introduce chip_info structure
  dt-bindings: iio: adc: adi,ade9000: add adi,ade9078 compatible
  iio: adc: ade9000: add support for ADE9078
  docs: iio: ade9000: document ADE9078 support

 .../bindings/iio/adc/adi,ade9000.yaml         |  30 ++-
 Documentation/iio/ade9000.rst                 |  28 +--
 drivers/iio/adc/Kconfig                       |  14 +-
 drivers/iio/adc/ade9000.c                     | 178 ++++++++++++------
 4 files changed, 169 insertions(+), 81 deletions(-)

-- 
2.43.0

