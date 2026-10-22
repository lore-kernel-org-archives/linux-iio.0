Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667926;
	b=ngSBYpVLRK738Mmx5JBvtJxup/m7zqORO4UN/aKIQrFmPRD3fXL8kjrc8zzd0k1m1hR4
	 yFjRFo/Q+6Qe8Z0e7Mqh/bppP2pKxrlLlSMM2vunNR7/ED/XIHiI0ExsFK1QLquJw5JSK
	 50JUGTwlXbsWpGYUrypNF1Lr9Gc+zLl+na6DWAKJ+rYxlIY7UJdd0gHVJc6y3dzehBIRb
	 qqEtz9cT7Ho4qT9xQMUJ8XPcdNJZmvHNVwNLGgSU50Q5B8SDkff8sVfrtjaP5ZK3Z+YPj
	 fvDanp13JguudFdpwBicWBnbyX+nf0BqfrPbRsIcT5mwHJ0wCEVnS7uDiNziXP6pTmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667926;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-ADIRuleOP-NewSCL:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=L77fmLez31aaMMIE0JcXMhu1DnY+P/wG0XO+k5/1szc=;
	b=kuMYAYAXITfnkrLmIt7J1bx1zrSl6/IQ1B4DjR4GVCKcszdLv3pMW+ha0JTrvR4tVAuz
	 czcX0zLIzCBFWrVNx3vw4jsn7xtx0X2PXiUDmZ1KwdNEBxuWsogx7kq+3+MZGb6/Hwksq
	 1kKQYY7JG1d54QlC5SP3DB4css4Wh+NEyFd+72XXMgbmPcwDbatOT1g1VZUCESD9ObfnS
	 TTcORy4YXnFLdnuXE9l3xBduRYySU2K4LrPuMoC+kJ1Llgg3D4jmsHPIbFpBBIVyvQRLX
	 7CKOg7eM+LtIPqvwHfjOel37Erf1S+B5rgGpq6IVxRTlpKMF72OmrAqJkmrz6uGwlKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pzYXZbUl;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Je+nnF8i;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B4606A319;
	Thu, 22 Oct 2026 11:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 780B4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pzYXZbUl;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Je+nnF8i
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA1reX1591175;
	Thu, 22 Oct 2026 07:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=L77fmLez31aaMMIE0JcXMhu1DnY
	+P/wG0XO+k5/1szc=; b=pzYXZbUlEQM/QA3VhfhNnibHuPMRkaEs8gMk9GdkWbf
	q/TNclQYtjE7Pl5GD45VqN/3rgAHit1OELN3zmokDM2G8IgfTwpfzGeKR11alzaN
	A7oGtr1S7XFO3kNKgOrPsgldFWlT5KkLl+qy1l/VSfEpZ7jOlUaW+kNVSm6ohJKM
	a7HYclM0+N7vHktUMQsxVWdKZxPatPRrDleK6qecRYff+CaVT4DaKSxlI2FkLroM
	5gYxHUgAqwfx9RCRasLLg/4lJ0iPbEX4jxw9uLR+dcr0Yf0Zwinha1h7OSgGEOia
	fuOiGflojMT4NMLdjH3LdslFCgsPrQ14T0aO3AnxOxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=L77fmLez31aaMMIE0JcXMhu1DnY
	+P/wG0XO+k5/1szc=; b=Je+nnF8iCHQvqxGL2h+iOpHt/JgTMmwZQv0UTzu4Zbo
	rqTdBFv995tfldW9bEOJb5beZAb1q4Vvvq5vWAc+lr15+Hl+PcSsae3w5K0ZhFxQ
	mrfOte3auRSMQUOuLtq92WBHcUU3o2vNLUUe3MV9d61puPwTLdWx/ytdZpSEQIAi
	cfDfWPyc1u/meDo16yQeY4jUoiwduzwdki/Wf2loIZ1FhE3SoI+WDI6XxH4X+kyh
	LjSpo9sO6wlv/V1trgVhTQ4QzKzaKnqx9orh2eUCLVBEugodh0mwdpjbj7JSRb8M
	bhB3pV9kOgXyBOPxZRz3dbn4fApWhSOsnQcu50DOGMQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hf927tpwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 07:18:27 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69MBIQlE055321
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Oct 2026 07:18:26 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 22 Oct 2026 07:18:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 22 Oct 2026 07:18:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 22 Oct 2026 07:18:25 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69MBI6LE005667;
	Thu, 22 Oct 2026 07:18:08 -0400
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
        Joshua Crofts <joshua.crofts1@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Radu Sabau <radu.sabau@analog.com>,
        "Janani
 Sunil" <janani.sunil@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        "Jishnu
 Prakash" <jishnu.prakash@oss.qualcomm.com>,
        Jakub Szczudlo
	<jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 0/4] iio: adc: ade9000: add support for ADE9039
Date: Thu, 22 Oct 2026 14:17:53 +0300
Message-ID: <20261022111759.6019-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NCBTYWx0ZWRfXx9lGhHwqb/6f
 +WCPdHQdHvteNVvq215eC8WTr1J+ICwUxOT4RHDwB6neS9/z7BbXuIH+/mEI6cElMpqEbpi+tLq
 k46ol4FGz9bwrZYHle+9gaBMIHoCpW5Yp9lzxBLa7Qwl5bxDn7Ic
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NCBTYWx0ZWRfX1L6jr2sSo65o
 3qg2CSsacy7RVPhUcYZJWPMk8WfdB5eeYeDUE6e0qPgSro1HdYW42qYCz175iLIu7SMC49sCsmH
 mAudz/vqvIEGHZRWhhyDYADdNBvj2EgzMnOKaN6Wo+vn79fON6xfZFUMetznhvKNG7pvURYCk3F
 34qze3LFjeHMtxXMlF6jJmqDoXES5iHvaD1Hy4kq/T1wmk0NC0iUV4m7UlZbbojxLKmz869bQWs
 Kvf4PNx4UizxLpT43OsRIsyu1P52G6xFaP0QQw0E1iAIXzoHjg+YduHZoSr0CdPETVwvzlY3UJU
 979OW48Zt8fb5+AgvHRjltKgkPo0aRGu7ihQvmFi+LqXo8bkGD2G5sbIulhlVBvp889Doqsm0gd
 of6MyFaOWsJAg1t0ijzh17d3RXI3yHoO0A7yxPUeP7cVb1IJW9PW6T5Oy9xDGQj2x4NBSOW2Uob
 AynK2VqHWn6tf7xje7g==
X-Proofpoint-GUID: MTbMS_dUTbcSSwi9vc6HAtKZHxZ4zgz2
X-Authority-Analysis: v=2.4 cv=U/cHnuru c=1 sm=1 tr=0 ts=6ad9f103 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=KKGNxSBjvV0_fYGOc-oA:9
X-Proofpoint-ORIG-GUID: MTbMS_dUTbcSSwi9vc6HAtKZHxZ4zgz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220044

Add support for the ADE9039, a polyphase energy monitoring device in the
ADE9000 family. It is register compatible with the ADE9000 for every
register the driver touches. The differences that matter here are:

 - full-scale codes match the ADE9078, not the ADE9000;
 - dip/swell detection and the digital integrator are both present;
 - there is no total reactive power: no AVAR at 0x211, no AVAROS at
   0x010, only the fundamental AFVAR and AFVAROS;
 - maximum SPI clock is 10 MHz, as on the ADE9078.

It is the first part needing dip/swell present together with total
reactive power absent, which the channel-array macro could not express.
Patch 1 adds a second selector argument for the reactive power entry; it
is a no-op for the existing parts, with the preprocessed ade9000_channels
and ade9078_channels tables byte identical before and after.

The missing total reactive power channel is omitted rather than
repointed at AFVAR, which would make in_power[0-2]_reactive_raw mean
total power on the ADE9000 and fundamental power on the ADE9039 with no
IIO modifier to tell them apart. The fundamental reactive energy
channels are unaffected.

Changes in v2:
 - List the ADE9039 in numeric part order everywhere it appears: the
   binding title, description and datasheet links, the driver's channel
   declarations, chip_info definitions, SPI and OF ID tables and Kconfig
   help text, and the documentation title and datasheet links.
 - Spell out in patch 2 why a fallback to adi,ade9000 is not usable for
   this part.
 - Turn the ade9000.rst introduction into a bullet list so that adding
   the next part to the family does not reflow the paragraph.
 - Picked up the review tags from v1.

v1: https://lore.kernel.org/linux-iio/20261012111342.48040-1-antoniu.miclaus@analog.com/

Antoniu Miclaus (4):
  iio: adc: ade9000: parameterise the reactive power channel
  dt-bindings: iio: adc: adi,ade9000: add adi,ade9039 compatible
  iio: adc: ade9000: add support for ADE9039
  docs: iio: ade9000: document ADE9039 support

 .../bindings/iio/adc/adi,ade9000.yaml         | 29 ++++++++------
 Documentation/iio/ade9000.rst                 | 29 +++++++++-----
 drivers/iio/adc/Kconfig                       |  1 +
 drivers/iio/adc/ade9000.c                     | 39 ++++++++++++++++---
 4 files changed, 71 insertions(+), 27 deletions(-)


base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
-- 
2.43.0

