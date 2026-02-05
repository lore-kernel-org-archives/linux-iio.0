Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657F2DE702;
	Thu,  5 Feb 2026 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310078; cv=none; b=t64bO88T7wqp9KgRs0hFqNgQiPHfwmyYJVstdD0H+7nT0KYyddH/CapUzPEm8rlrJd75a7KkNGnQBVh1EnUdVBBwajpRp63loEiNQzO4QR9xQpDEuubJI4ujb8pQl9rQGxjz2AGR9SY6t10GlecnVY0M41J8Io7pehcfBwMubsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310078; c=relaxed/simple;
	bh=99WaiGcsEkIiIjSbOEGNEFTX3nKaer9lP7FUpEVw66E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFBf9viNOKZMeiXUJta6zaOMfVif34zeVAV52KJm+s89eDD/mdETckLQfshBxRtLxCjMbnZ0r0GgFX6LA/1DnybA5HLvfrh5SZ7Q72hnxPie3aEaZ/+cqRThs13+Q48pkmedDKBOMhME9v/bejtU/q6zx4w9CSvUYeqlJ4APJuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uTLXsAh+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uTLXsAh+"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615AbPaj1300804;
	Thu, 5 Feb 2026 11:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=V2oSh
	DnSUuYFygxI7sitsXZbRghfjdx6Adg4qAE9pFo=; b=uTLXsAh+hWInZfYoBDV+I
	wyX03QWUvcFTdohijcep/VkqPKnIZbDl0aJIa1YF0I2/9he3x0XGu38I0zAsadAy
	eh6ZuK87racVX/M4Zcn2Y6OEsKu9RUwsob4fZT36LAj2/ifF4GWfShvoLAF58daH
	bO2ZgfPOiXt5MrvSnsMoTlAk2b7P5LAXS77WTVPbJSphBQ+zNNuvD4GrrDtm3lDd
	oyjzVvRE0hItcWxuaOd/gTZYAnx4D/yhJJZ1MZXZxMMRUFp3FbyxqJfUFDqJm/P9
	IMaariT5Jvvdd44+2uDYlQGy45IZj+2+IU60sdJMmq7CraQMm6h+VMoBvciL2DdP
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c3vyp7yju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 11:47:52 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 615GlpQa045211
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Feb 2026 11:47:51 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Feb 2026 11:47:51 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Feb 2026 11:47:51 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Feb 2026 11:47:51 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 615Glb9t032765;
	Thu, 5 Feb 2026 11:47:40 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 2/8] Docs: iio: ad4030: Add double PWM SPI offload doc
Date: Thu, 5 Feb 2026 13:47:32 -0300
Message-ID: <e0580df9b5db5eaf8bc203665de82a74b732ac1e.1770309522.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1770309522.git.marcelo.schmitt@analog.com>
References: <cover.1770309522.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 9HcYHJVQtcsh2YLY2oSbdVMB2acurVy6
X-Authority-Analysis: v=2.4 cv=RujI7SmK c=1 sm=1 tr=0 ts=6984c9b8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=wI1k2SEZAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=Z7BqY8bEq__jAXHbdh4A:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=6HWbV-4b7c7AdzY24d_u:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNyBTYWx0ZWRfX2bHs1vpY0uH0
 gJGrbw05+/5OVue78/xQ3/WeMjCOdQL4h1H7uDgGX0V1S/JVQr3I+l0dxNhgbL11uUiacFuewzd
 WPIiivOQXtyVIoApSlnm6y3IiYpBQaOU5kssgNzY3A7dMIFKEf9Ji/wuLbR/z4bdJiE6CC3e6D2
 vzAHAgvuDvyywQiCd1wAx55SUjc+IyJsxOl4EwcQR7C1hMg8D4drGkkiKbuNYhuQxKgrfDxgmVt
 A8PILzaH1c52dp8NejzLT1YnWY3gGdWSp8YQLyWBZLQtQx8pBgscggTMf5iiETFtQ5XVRPDNeH3
 cegtmjfLA5pjLkygvaKlJ4MT9DCrEW9+7krVXydfIeVNtk1pq15l/S9GEs6n/T1WeBk4v5YdLKQ
 a7lJh5ajvDABxKgzK0Myy40UjhdrbhS7XuzctTka/mvri1KUjQkz/+4VVXHNWtJnWCbGJFsFb7I
 j8Wx2phmpX/BOnov9gg==
X-Proofpoint-GUID: 9HcYHJVQtcsh2YLY2oSbdVMB2acurVy6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050127

Document double PWM setup SPI offload wiring schema.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v6 -> v7
- No changes.

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

