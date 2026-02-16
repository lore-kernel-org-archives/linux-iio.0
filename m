Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E0314D0F;
	Mon, 16 Feb 2026 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253992; cv=none; b=B3t6Oebt9P6AjDovQiaHAVdYDnePBBW2Wy/aFS2mMY2SQtEN3cah9kx6YFtPD6ocXLK5tlQs2a87kukqhX4Ri5UF4vZtOmZM0IoTDVsSkLuYOL08vUuI2M2q27iQUP+VvKU8yYDTLFailaKYG2OITtJFcGMedF6Nf55xuKUjIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253992; c=relaxed/simple;
	bh=Dwp/ijJqMuFboBXFT9d+dI9UkToWB3LYC8QQQ+pSLvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEujBsJa345D+UXnhp2qXBjkYDJgB3xgG7kPuhSGSsBLtJQbuzrm4oAaUY2tjsyi1OePQZjJb5R+Jo6nGojc1YwYyAqtKScrU9z5l9cYq6YPn+jCi1Gp72PDwwg83d8pmFhG0P5gUs7f7N+6X1o8l3cK0o0oHeF9rdV1QbGoqYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zzDn58E5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zzDn58E5"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G8Qvgm3758382;
	Mon, 16 Feb 2026 09:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=13FV5
	FamYZxIAoCcz8pphn+KD+c8R7vDKQZQZs3I5UI=; b=zzDn58E5P9JgXE874oXbX
	qfqcVnzfHUU57LP2YttDnVpb6v0oqML6N2i0kyJ6Hr1Q+ahgaWdno5oibzahIlOd
	ecYZeOhlDnlemuZ7UZZua7Ivel2jhqS0mKFGzACsNbZYaG6Cj70OsMOpAsTzdADx
	MFLt7eik8x2Eo40/DLhMA9QdL3ltrqisTRQDJ+neEqoEz+s0Y0c2TTPkaeDQBrIY
	tQNs/sNspzHe+YUJg+AraDRQlhMdHHNSbPWcb6vfZhKp2cLYRnoMCiYvh9gw2wCh
	Ugz49UGiLNEVsBPHJfMY/BZws5dk5IuUKS9d2msw4PfPQtSZFVszZcRpemaqKnwp
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4capu4fayn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 09:59:46 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61GExjSE019697
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Feb 2026 09:59:45 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 16 Feb
 2026 09:59:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Feb 2026 09:59:44 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61GExTjK016021;
	Mon, 16 Feb 2026 09:59:32 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v9 2/8] Docs: iio: ad4030: Add double PWM SPI offload doc
Date: Mon, 16 Feb 2026 11:59:28 -0300
Message-ID: <a8fe7df99da75bbfe94cac79d29754bc00720f15.1771253601.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1771253601.git.marcelo.schmitt@analog.com>
References: <cover.1771253601.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyOCBTYWx0ZWRfXzmTUB+VBqpf/
 J0AjVZ25HttbTIGpFQdWSW5YVWctaLa073xRLdzZPFxDzHBjanmJN+YsvUpiq0ja5Pa0r0XJQC8
 PpQReVUxVaKnrj+7venrxUuqIPECd4L0gVBYL1WoB3dbmBHquEcyiZOtcVX4VyeCCLnrRbG75TH
 ChqprLyqCZBVMkkdpYTGvgukvDM/8P7K/bc7RiuOKx8c8LgXABKfJ4nVRbTU8bvAjnH9UEbpuc+
 /URoXMbQdmPcMizIQbbWgFG4uuf/Ftu/5+34mUZfDPpz09CDr1B2PCTQ8xb8+KemF3Y22LIHdOA
 pa8r+AmqHOvMfocmUzNsaXn0H9vEtNrSBn1Fd77QvpTcL5Ar1CVSS2o+vb8mHVYEwPgjG8xTRaa
 JTVy36683UH69MDlV2gXqu3bTHcv/eRBXyPTMbRtAzzPa+wEOqU07ENgXWbyjukPN8NHNw9z2MC
 Y4Xdtd2q6TJSYtdOCMw==
X-Proofpoint-ORIG-GUID: 8LKyoKI1Xa_HIfSWa9Kv0blOWO_Ohd_I
X-Proofpoint-GUID: 8LKyoKI1Xa_HIfSWa9Kv0blOWO_Ohd_I
X-Authority-Analysis: v=2.4 cv=EZnFgfmC c=1 sm=1 tr=0 ts=699330e2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=wI1k2SEZAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=Z7BqY8bEq__jAXHbdh4A:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=6HWbV-4b7c7AdzY24d_u:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160128

Document double PWM setup SPI offload wiring schema.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v9.

 Documentation/iio/ad4030.rst | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/iio/ad4030.rst b/Documentation/iio/ad4030.rst
index b57424b650a8..9caafa4148b0 100644
--- a/Documentation/iio/ad4030.rst
+++ b/Documentation/iio/ad4030.rst
@@ -92,6 +92,45 @@ Interleaved mode
 In this mode, both channels conversion results are bit interleaved one SDO line.
 As such the wiring is the same as `One lane mode`_.
 
+SPI offload wiring
+^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |         CNV |<-----+--| GPIO        |
+    |             |      +--| PWM0        |
+    |             |         |             |
+    |             |      +--| PWM1        |
+    |             |      |  +-------------+
+    |             |      +->| TRIGGER     |
+    |          CS |<--------| CS          |
+    |             |         |             |
+    |     ADC     |         |     SPI     |
+    |             |         |             |
+    |         SDI |<--------| SDO         |
+    |         SDO |-------->| SDI         |
+    |        SCLK |<--------| SCLK        |
+    +-------------+         +-------------+
+
+In this mode, both the ``cnv-gpios`` and a ``pwms`` properties are required.
+The ``pwms`` property specifies the PWM that is connected to the ADC CNV pin.
+The SPI offload will have a ``trigger-sources`` property to indicate the SPI
+offload (PWM) trigger source. For AD4030 and similar ADCs, there are two
+possible data transfer zones for sample N. One of them (zone 1) starts after the
+data conversion for sample N is complete while the other one (zone 2) starts 9.8
+nanoseconds after the rising edge of CNV for sample N + 1.
+
+The configuration depicted in the above diagram is intended to perform data
+transfer in zone 2. To achieve high sample rates while meeting ADC timing
+requirements, an offset is added between the rising edges of PWM0 and PWM1 to
+delay the SPI transfer until 9.8 nanoseconds after CNV rising edge. This
+requires a specialized PWM controller that can provide such an offset.
+The `AD4630-FMC HDL project`_, for example, can be configured to sample AD4030
+data during zone 2 data read window.
+
+.. _AD4630-FMC HDL project: https://analogdevicesinc.github.io/hdl/projects/ad4630_fmc/index.html
+
 SPI Clock mode
 --------------
 
-- 
2.39.2

