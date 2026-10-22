Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667937;
	b=0vpkbcldBY59HBhSCxpAm3qyrE/SbWJJpXeTDlmTGXHjX1n6Vjx8kaQut9n7oL7XQZhz
	 RU0/ItZYM4CvMm3Dx3ulMH9EnMIHBwqGPOsLeR6sVHDwAsZaJwFD7vnQJ9vKL1EQWm90R
	 pV0BtaJdNnqonipmzU4LhqPzYxlMKAePJSer58seiGOzkKYBebmvt6nX2qB+0xixYSKoN
	 hHiZI2dKC4CAcuh3jPXODEy49LYMdlWALqzKQRdsf4fPJgUjqm/Zji+fB5EY3AqFOUJgh
	 bmmx9J0D3rg0rORJeD8KxsQd45JgqFFhzpSRJBHyI5XwhMCNeiLhd2SBgvJHpUMhsGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667937;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TEv4jXWyI3Wdq9RxbDS6oL6Z9HZAR4C/XAF2hQfFO3k=;
	b=0EpnhwbRnDVdhendmqx9QasM9enIcgT0m6FBQxi8BGC7DybLQFcYOSroOwapDPnPD9DP
	 qmIhlD+CHVbQ+OJV4CVTl5xmt8fbHvx24Dd+/z4YlGspTbscbvP1kcYLxH0aS+qnyzOnB
	 Zxdqk4qtX7J2ScZKTH7EaF9bu63VaC4GZwiLZKfwN4pR+U6IN832itG7SABNsBf9FhutR
	 6YKGwEOQrl5ej5Mk/bnssbEDLrbG0F06/dovzTeYEdBW8RZvY2ae3H5muhASr4ZqjUY7F
	 mEcgEpI/sDkMjFv9uuoLzsa8mc17TdhbIwvSXlb+WFF5XKdMhecq1JW2dSPYq14xpcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=FecbmGcK;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=iEDYwXos;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C66606A319;
	Thu, 22 Oct 2026 11:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6C66606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=FecbmGcK;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=iEDYwXos
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA1hRU2803371;
	Thu, 22 Oct 2026 07:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TEv4j
	XWyI3Wdq9RxbDS6oL6Z9HZAR4C/XAF2hQfFO3k=; b=FecbmGcKN0qOtzdXEbU7A
	f+jmID/N9VFuq+GzY1KLQJBbFvhkov+zBhqk00HMWwWQB0E280L1Rv6Yse35EP2x
	MoGgZlZlrlZfjEoNMslNSs21TPbiuA6HYGoE2xjUUlODsba61j+ztVbH3/IWFVyS
	KlKW3vAzl0YYZI/ZuQep5CNZSPfk6x18ZXRolAnTtKfuKUq8H6izvSTQL4YflSqV
	StXmAjXlYRc54NxBEHZHkftUR/xu0naMZoDCwFE/yGorp2qs3Sc/Wh/mPf9uzXyg
	wFGKt86zSZ2imur9inkCSUx2ch9fX+ERxXWqS9rGaf77JZj1oc+xEtJekLT5EgoF
	A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TEv4j
	XWyI3Wdq9RxbDS6oL6Z9HZAR4C/XAF2hQfFO3k=; b=iEDYwXosTlJnJSpWIYxdh
	ERCfR0nbUtfSpzI241xRytx+x8rcTDt+GCMiHtXxGp6cpAP0+2uu58cTte2U1xV6
	Mp7gvLaGLDFt1VJoIFhehVcWIiVSE3jjnCVGWOXg0iTYbzxtD4bR+lIzJEPY9Ssq
	7pg39RHVqr57e+ezUBQ/GHWXCMIDKU7eAK/PGF2ngh0uZytJ9dSeLj5G89pHS7Pq
	oblAW9dAFKOeZvto7O38u6HIyXKHCM6pp04xcK77DNB1m8fIt5HIXWzTEr+eNcUj
	dwgTZBEOHNViK9xLFaudVbgKrPJvMEHgJ6RnD4IaRsiQWS1Nyycn8pTzoNRMImsf
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hf927anv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 07:18:45 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69MBIiuZ055337
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Oct 2026 07:18:44 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 22 Oct 2026 07:18:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 22 Oct 2026 07:18:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 22 Oct 2026 07:18:44 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69MBI6LI005667;
	Thu, 22 Oct 2026 07:18:35 -0400
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
Subject: [PATCH v2 4/4] docs: iio: ade9000: document ADE9039 support
Date: Thu, 22 Oct 2026 14:17:57 +0300
Message-ID: <20261022111759.6019-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022111759.6019-1-antoniu.miclaus@analog.com>
References: <20261022111759.6019-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NCBTYWx0ZWRfXxcKyHM5904Ya
 vxgdZdr/9f/mvr3sXXfLjUrr5uFu/P5doXSCmFLfzibWfJ6xgI0YtybvYMwD1pQvqR4Xa+dCkBv
 PaPTZYWNQrYeJKjW++TmkGdgbZpLJLbxlLv7Q+1gOyvotY9TChZs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NCBTYWx0ZWRfX4cXoevfMT3OM
 rAw2RdSDl18f3nQZMFGkW3GXpwWj8hw/mmMWTOyzwAd+tc9RLE6Njl+cQCLJc+ibc3QHf7YPF1X
 QXo2fQuJN2/8Y0hzv8ZnUBU6zLMiHrHU6oB5N3qhxCcEidT9/WFhAaQ5Zg8wsNlCaxNjES1NGly
 8FUHERnGeCvGOixyxbX5c72WTm2v1lfZeJ+FTwMiLR1N9SgQn8K9jsezXsJnY5XK0Uu7tAnUmYv
 vRzTIcJNb4mg4+K1qv32OVaARyMqtOPU+8JB/Nmkp6io+TPggyib/3/5SEFGRFJ3+BLj8d9Ls16
 jR32SCQzKgriwP9Fd4J4islwcpOtjNTYRhOroAQGoUUcqtRjDcEXxZ6pt50CYcN3SCYspAu9+RN
 fYqSwpcYo0bwR3pE7XcOw8A/jjk6gaIpN4frRiTFfKi2zehQ206xCbq8AmssHQFVERUlVzAdAtP
 gQqbKTk4v51pOhBSV7A==
X-Proofpoint-ORIG-GUID: EcZipgHUiH9Cz3eH3OevlyKmroFI3lcJ
X-Authority-Analysis: v=2.4 cv=WYKZ+EhX c=1 sm=1 tr=0 ts=6ad9f115 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8
 a=POg-ucaDcjGRvUgx-3oA:9
X-Proofpoint-GUID: EcZipgHUiH9Cz3eH3OevlyKmroFI3lcJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220044

Add the ADE9039 to the list of supported devices and note that, unlike the
ADE9078 and ADE9430, it does provide the on-chip dip/swell events. Also
document that it exposes no total reactive power attributes, since the part
computes only fundamental reactive power.

Turn the intro enumeration into a bullet list so that adding the next part
to the family does not reflow the paragraph.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v2:
 - List the ADE9039 in numeric part order in the title and the datasheet
   links.
 - Turn the introduction into a bullet list so that adding the next part
   to the family does not reflow the paragraph.

 Documentation/iio/ade9000.rst | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
index 0c0a8ea8213b..893166f5fc32 100644
--- a/Documentation/iio/ade9000.rst
+++ b/Documentation/iio/ade9000.rst
@@ -1,17 +1,22 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-==============================
-ADE9000/ADE9078/ADE9430 driver
-==============================
+======================================
+ADE9000/ADE9039/ADE9078/ADE9430 driver
+======================================
 
-+This driver supports Analog Devices' ADE9000, ADE9078 and ADE9430 energy
-+measurement ICs on SPI bus.
-ICs on SPI bus.
+This driver supports the following Analog Devices energy measurement ICs on
+SPI bus:
+
+* ADE9000
+* ADE9039
+* ADE9078
+* ADE9430
 
 1. Supported devices
 ====================
 
 * `ADE9000 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf>`_
+* `ADE9039 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9039.pdf>`_
 * `ADE9078 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9078.pdf>`_
 * `ADE9430 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9430.pdf>`_
 
@@ -24,9 +29,15 @@ for the entire channel including a programmable gain amplifier (PGA) and an
 analog-to-digital converter (ADC).
 
 The ADE9078 and ADE9430 do not provide the on-chip dip/swell (sag) detection
-available on the ADE9000, so the RMS voltage swell/dip events described below are
-only available on the ADE9000. The ADE9430 additionally has no on-chip digital
-integrator and instead uses an external analog integrator for Rogowski coils.
+available on the ADE9000 and the ADE9039, so the RMS voltage swell/dip events
+described below are only available on those two parts. The ADE9430 additionally
+has no on-chip digital integrator and instead uses an external analog integrator
+for Rogowski coils.
+
+The ADE9039 computes only fundamental reactive power and has no total reactive
+power register, so the ``in_power[0-2]_reactive_*`` files described below are
+not present on that part. The reactive energy files are unaffected, as every
+supported part accumulates fundamental reactive energy.
 
 2. Device attributes
 ====================
-- 
2.43.0

