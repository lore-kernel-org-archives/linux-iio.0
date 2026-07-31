Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794193D6CD6;
	Fri, 31 Jul 2026 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486654; cv=none; b=tF1UwfsC1jIyxBLzDssLWV53iGJZz/80QTk6veGeb+lANnQSriKTRTiNE4gk1AuaZk1jkNVKm2FcfVZNHYjceXWErFOA8/P7zbLvA3B5V3C7hFrMwlgXcpRSwHB2qvgaPrgqXHYK7IDXNIaarM5F4ZOFBkiFhv0hEusJvLOF6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486654; c=relaxed/simple;
	bh=6lO9MHfmRpa6O6qi7S/4noXoN2heQ3jAjAFZ6AumsiI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfnjE24aHlHLTHwK1BdXHgN2Yqkllli6ghXQBc8zxNeYqeGCMsS9KR+pFsjjZlUJNLjPWctStjKX+kbepxL6g8gYg+y2neB7PEpnMP0Zo8gCtcB8bf6OxZM1bVyPdbX5KJH7VuTR+yGNsASAuko7jDGZ/PzylWlyynLfPtPMZE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=N5juf2XL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="N5juf2XL"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V7wtAC2639205;
	Fri, 31 Jul 2026 04:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZsfgY
	+t0vDVH7QvQ4Go+4FMxhU52/s+h1whAHFcJC7A=; b=N5juf2XLbVBEhde/j1SGy
	OgYNo4++0zmLi0h45T5fx77gzouU3nVhJJYorLYD1h3yeVxdP/QnAUvZJmA/xorW
	vVl3Yk1XfrTXJvJL6TMDUbU13PzTF3zFi1R8TV5WV6qxIsEyjryz8GQKUnwqDX1I
	3wuFarcvewHIo/k1iKjBKa6EPQ2a09LQ/4R8g0nz2CmYPHMqpxukWQNDtQlRzl/S
	1Li/NQGhxWs8Ya4vmp917xKNqcBWZ/JDY080DrRbYqStQUF99l3/UqOiqOuNtSkf
	tInCagAHaA/lzHHEGZnxEWg1rCpSS+B/Uzy/uuyzybmwcSUGX69M7QAELRWYtpiF
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fr4s2ms10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 04:30:44 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66V8UhdC039912
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Jul 2026 04:30:43 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 31 Jul 2026 04:30:42 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 31 Jul 2026 04:30:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 31 Jul 2026 04:30:41 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66V8UDNA026738;
	Fri, 31 Jul 2026 04:30:36 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Shuah
 Khan" <skhan@linuxfoundation.org>,
        Radu Sabau <radu.sabau@analog.com>,
        "Marcelo Schmitt" <marcelo.schmitt@analog.com>,
        Jorge Marques
	<jorge.marques@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 4/4] docs: iio: ade9000: document ADE9078 support
Date: Fri, 31 Jul 2026 11:29:50 +0300
Message-ID: <20260731082951.1228-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731082951.1228-1-antoniu.miclaus@analog.com>
References: <20260731082951.1228-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Hyb2w8owQrDQGXpopuN2lJZW3HTLNUMB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MCBTYWx0ZWRfXyJMmPXZ+A8JK
 yfqxoPY6EzsK+T151iUv7ljyWzeic4o9BR7PcagWMGt9fDjrnzZCkhPYJ91xHIr6yqO91L6kE2t
 Y891d6MEzGrRsIcdhwSDQkhBik/+Irtw4N/BDjTu3OP2nogROMih
X-Proofpoint-GUID: Hyb2w8owQrDQGXpopuN2lJZW3HTLNUMB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MCBTYWx0ZWRfX03/g5QTLgRRF
 /8pi6oKRddBbFPAS7gROrtjtScXBFTepK3qQzDYpnHPRsS9+En72uKaTGzIos7FyLbsbyTJt+rc
 oe/gVPuRZNTcxRCydrLvHtuN7DDlVr+bxw7KZLJEsxGfncZXCGYoa9LrvajQRSVDxNNweOoJuqE
 QT7tFkCLC+TYXH3ps5xCoFWj8RvNKAoXu11m7R2HQq8dU7/0MkFyacIzg76yHVFBwJf+m82TrhK
 Ch2TpOrZLj3Safc6YEKeRk2TVfOhLNReESP9Wsc7TWqhY8ximGKkYGUvByhNSnvCPRcwM1fF/IP
 34pgXoJYc48Azg/87D7f3SJEzYJH0EVvvTDGYBhHt6j5NvbSQE8lkltf9U7rH3MQAlgl2bomFYb
 wUAGjjCcWF7X/6Hk5kunUwJnCNijU7/MtECIP9MeEY03HsOD2UDF6iw0vp5yOFBgl5JgDIqjx6G
 fyqnnUL46C8GUVBvzOA==
X-Authority-Analysis: v=2.4 cv=PqOjqQM3 c=1 sm=1 tr=0 ts=6a6c5d34 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=dVqSPRu-xMqTFQGYfZQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310060

Add the ADE9078 to the list of supported devices and note that the
dip/swell voltage events are only available on the ADE9000.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v2.
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

