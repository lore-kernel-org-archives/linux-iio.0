Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364D3254A8;
	Tue, 22 Sep 2026 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088018; cv=none; b=RodVbru3zFGuTe9vBEawk5xFIxDno4SXhlJM6SMfGW4K4+ksTWqEBtPLsR4u+Bzs2i6lEu7DNxNuFJlC5dlyljPzW90OJ92h8M9F4Z4FG3IbtzlOSMhWc3xbzhoME/KFUo9UyBvnwpnimxYfoQEQtXbIMu0ZgXWdpyeI92W/VrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088018; c=relaxed/simple;
	bh=ZU1L5FxwTNjCoT1bS/uNXbQ6mHMkm3mg0gluJKahNMo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SlL6vfugj4cFxFsK4gJuU42+qhOj2Ox8K6SN/JSEMyC3bU117DdAZFIe5YAcFtH/GGfQE9NQwCtj5oFZ9ZPppRUK6DkTkxPD+Dz/7qoZFjJGJb5q0UaAhhgrAMzQM/FoDmnu6x2k/F7AoZhIhw3A7+A9syhxI5Suwl68lAjXdGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=h4lCMZzH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="h4lCMZzH"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBQ7sY3783304;
	Tue, 22 Sep 2026 10:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=WKIoLQQASuTTmcTDw+jxDJmXinm
	viOdYW61NdtUF+sI=; b=h4lCMZzH1R3365trAiQhqp9ROjoW16FRtcjBeQfpdjm
	td9umdJhcU4gUqgWx4WjidC2VKAfEev8MQDpWL63oltQK7nhyaad+Gcv8Sf7ZqPE
	EPav7QSEHP1oO5RJ7EyrAAkIFUTDTeX/TDRxMhuQD3Z+KBOPC7x5vEOtRxvhuNxq
	afjizyAwqk2nzhDiH2DIHjWfz/NINUFGTWN20ZaAHbbbpqjUTdlFJ5ULR6mJAbtN
	9NnBUeBU5XWaaEOtvhDhEyv16lbCS58Jc8jHT5F101pR5TYAua8gneSUhoSQztQT
	Jo+HwCu4ZHSh6nycz2mJpatP3oXU34ZJvbQLLfNLNMA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gsm83fff8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 10:40:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68MEeCuk009953
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Sep 2026 10:40:12 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 22 Sep
 2026 10:40:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 22 Sep 2026 10:40:12 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.223])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68MEe1Mg017920;
	Tue, 22 Sep 2026 10:40:03 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Liviu Stan <liviu.stan@analog.com>
Subject: [PATCH] dt-bindings: iio: temperature: adi,ltc2983: Add ADT7604 datasheet link
Date: Tue, 22 Sep 2026 17:39:49 +0300
Message-ID: <20260922143950.176910-1-liviu.stan@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIxMyBTYWx0ZWRfX2b0aCwGqip0+
 Gskl1qVZyIiyF5mPi4+HjppvWMuxyNNaLzHvSn53zovi1B5yCDfZyynPmjMfnVTOvIt6etphK3w
 CzLXHYniYwQOxBwD1VMYGOUwisLUm9mlpzECx3SSYNbVtITWOmzA
X-Proofpoint-GUID: b-l5PfEgCYCzosjy4eBtbGBdGlclt5n3
X-Authority-Analysis: v=2.4 cv=e66T2qp/ c=1 sm=1 tr=0 ts=6ab2934d cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=97kYdx552Tuj35SEOkUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIxMyBTYWx0ZWRfX+GtoF2PgCKRI
 fk5SWa5OWNPoa7ToAGSRpIfHvG16qFxsWb3hB8XeMvk+dcLBi9K/oqQnwyCUAYjUfVgHR/G1N0z
 uB9p+OTWpeO6hl4NPJReWeJ7lVC77o6hficiOQRS5umWF2BfTeFBzmLI1DfmkeSs41BwbpRsulT
 nrIe9R5mulxXOqCqqGPZFVIYYqbBS9vUtOfQXHEuZJshyHWYjEuug42YUFcpaSi3qeEuWCFsgfY
 1gUTpK5kouo+ah3DjX/OHeflzgapewqzgtw8eiAVOwtiVTLIY3VT5eyklSF2q5lFzAChnFhDDjL
 lQuEG3PCXm/Z0Vh7mED3UnWVZVPIDftncbB9+tAx1nkmFdZTfcIY0K9CzZ1mOjV8lUkzccHQ1Xl
 B+oadIFuwCMsbit8s6w72Yd+Zcrtbe+IUpfQTfBOG1iluLPay61TZ9Qc/JvQKvYlpcjoLns0DUC
 b2VQsjmucxmtV8sTkiw==
X-Proofpoint-ORIG-GUID: b-l5PfEgCYCzosjy4eBtbGBdGlclt5n3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220213

Add the ADT7604 datasheet URL to the binding description alongside the
existing LTC2983/LTC2984/LTC2986/LTM2985 datasheet links.

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
 .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 13e5f29f0588..09b809f01550 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -17,6 +17,7 @@ description: |
     - LTC2986
     - LTM2985
 
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adt7604.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/2983fc.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/2984fb.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/29861fa.pdf
-- 
2.43.0

