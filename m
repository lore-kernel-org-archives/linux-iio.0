Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81C3A1CD;
	Thu,  5 Feb 2026 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310101; cv=none; b=KM5HIhd+R9SGjw0E0q3MmQbj9DNPpmfKFzyRrvNPjGU5EW5xI3Hs9HcBVRyyHSA+Va7zsmfzUhkGtBEwiWS6xSMiKHIakS7/eSmWFgYweYmT1YBkig4F4wde/YBkxePJEvundlrOBvq4cOn7ZG3Dq66Tu73ggzBhw66S2b6vXq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310101; c=relaxed/simple;
	bh=IVpWq22j+OgqEi0paqV0/lqXWqcFnK/b9Wv90ZJarII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMqHWVCkoqng1LCHGktMDRBoRwvw456Xokqlo4n4nzeQk3Z8lbImfaj8APD3/ehx4xu7LDBBs29D+kkNAd2zlyFozvTGDp0Oq8K1xYXitwsLmgIu3a2+Kx0xChcsMdeLOHG7zlBg3d6OICNgoDeQQszf3BDUGR1DUthqqjYWPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gAPcoDMg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gAPcoDMg"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615Ad3tF2523875;
	Thu, 5 Feb 2026 11:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Q1NWt
	rZFJZlXNO0o85gGJO8xJvR4gCO+TflmSlxLEBM=; b=gAPcoDMg5ATuxlrqUDBMy
	iCOuRYnZez90yQZa4akPv7N7co/d73LCjBIba/Vn5crmweGXIolNMbBDe36K6luX
	AVXAefGSudTWyhBUS54ahayvrmBgO9BM1qhEP13XgJR9RuGapnEmhYm7k6/XHg9z
	1zL0LqdKTC55BPSqQ3cE0vBM7Cp4nOncXsppkHrszVT7T8Z483zOmSi98+vCZJMt
	aTBnmQUnZ1b9LtwfpvaksEhvaeM2XwmKfKySIJdJYPOTHjJM3xFNsZeInAnjBYy6
	Z+xKuEn6xsp/tCQSHAawbbRWPtCzkRT6RnzAuwlLBmxAZkhGv1wJbg3kxa/ExbB5
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c4q2f9sg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 11:48:17 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 615GmGKs045241
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Feb 2026 11:48:16 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Feb 2026 11:48:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Feb 2026 11:48:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Feb 2026 11:48:15 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 615Gm2AX000452;
	Thu, 5 Feb 2026 11:48:04 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v7 3/8] dt-bindings: iio: adc: adi,ad4030: Add PWM
Date: Thu, 5 Feb 2026 13:48:02 -0300
Message-ID: <085f379d4025f110ff3002e0fff493793965c453.1770309522.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: uxcBTD5d0Qk79NSn220YCLv5bP5vCOC4
X-Proofpoint-GUID: uxcBTD5d0Qk79NSn220YCLv5bP5vCOC4
X-Authority-Analysis: v=2.4 cv=MpVfKmae c=1 sm=1 tr=0 ts=6984c9d1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=IpJZQVW2AAAA:8 a=XYAwZIGsAAAA:8
 a=gAnH3GRIAAAA:8 a=DUOLLnRY7vFq0fwDtzIA:9 a=IawgGOuG5U0WyFbmm1f5:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNSBTYWx0ZWRfXxAdIxt+Odyre
 OM15+GDtSyb6MIAvGYCMErGZ4oQxfFWzqSuLqr936ApZjXcuShHAnry/+UwP1sLoaW3RkZuxsmu
 8scRDZGE3Im3MzmioYBVJbJqP+O5AHmvbsmIZZ2qkhGiGdGuzZoKUSFroUOyLelpYykgOxi2dtC
 3PluH1g5viU6i9GpHssM6MTjIlMdDtkxyqWcog+P12q8gLCpFCeffz0i+5C3Mip4hZusby027UC
 6aWvNMEKGytH4O829nSx98jJefI+2I67nE9xD03v9YNKBrydsjWd2hDg5JBWOmFW62Sz9LUC8G9
 WNALCBcshqp2ZLAQZaq9ygZtucZ0OmRsnoEbr+C7wBMrni9xhk5e0CqTL/wOLWmQB71UENEtXo8
 Vhqlyjp74dhcO4uaJdydUzIK4Ee7E72PFL/mh301hTiVDQ1482NlHevSLeQUXzVHqcYo4RVSIje
 bQJw+Ft8hmonRQjRADg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050125

In setups designed for high speed data rate capture, a PWM is used to
generate the CNV signal that issues data captures from the ADC. Document
the use of a PWM for AD4030 and similar devices.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v6 -> v7
- No changes.

 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index a8fee4062d0e..564b6f67a96e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -64,6 +64,10 @@ properties:
       The Reset Input (/RST). Used for asynchronous device reset.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the CNV pin.
+    maxItems: 1
+
   interrupts:
     description:
       The BUSY pin is used to signal that the conversions results are available
-- 
2.39.2

