Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4536C9F9;
	Mon,  2 Mar 2026 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454350; cv=none; b=g5bXxByxTdJ65jnb5MyUNfs7UBXzRtru4HsWNnDqUAbhWfaly/aiyzexId32kvrRhE0L+Pof2F7b9eTxr7Y6Oi6icSXIeqNtvRiWocPAU/n6cTQIJeHBxbtCj+fC7kOmj1knD/iyAOrOP8xf2ZF8bVpTuhqAgEABliD8bl8QMeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454350; c=relaxed/simple;
	bh=DaCN1aQyyd2SYSvSaoMZJtD+z0xjxkvi8XYuLe/8Pag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBPmcKf4Umbb/Xg+hv1NY0NmGw5i/MsY7sNLG1VqISlLJu4Dk23hK5Xl8ne1X3xZO3zHCA2vFD5FgBsUTJovRsvkKaUwhnCFoe8kr1NV8PYVvH95KiEB9+rQTBNREtkR4wZ2PsRTorw1l0lJzVfh0u/UOQA9jjd42at/Jcxi7N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yqWwSxY/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yqWwSxY/"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229A3gD3723204;
	Mon, 2 Mar 2026 07:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=09Cp0
	uFe9HBpEUpVJlcazL4ihzYiu3RjFNNeVmd3c2E=; b=yqWwSxY/hbHl7UHPt0uJR
	MhX9Wit+iomN9SnYdwxk/mMh2U2DPm+18G/fhMz5Z2hS6EJWCyp6jrDVQRUgU7Qy
	kSgXUqqDlC8zZsaP76bMrNXL9C2hFb7V8txko2NciD9ocYQgv/f17u53LkErMxlV
	ZNeowhpscWDrxciTTG8Z2fBjli4tKGyeYUIUtfkfiVpi+mAyzSoK2NocE/W7lZ+/
	fSmhwUhrbOOEjbvLL300HBJzi5n9baEfEF/DVafxmp/g4bvzl8UKUfbt4bkpVd4o
	4M5tc7CvYE+tLR6T2c8E/IhuZy4jnomRtBVt7JzkC7O+qJSdITquJIUURR5Qp7X1
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ckx546ht4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 07:25:34 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 622CPXQr002635
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Mar 2026 07:25:33 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Mar 2026 07:25:33 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Mar 2026 07:25:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Mar 2026 07:25:32 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 622CPJKP010657;
	Mon, 2 Mar 2026 07:25:22 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <cosmin.tanislav@analog.com>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH 1/3] dt-bindings: iio: adc: ad4130: Add new supported parts
Date: Sat, 28 Feb 2026 09:38:43 -0300
Message-ID: <0b290dbdfeada56bdb513b7a57994d84e971fb34.1772078999.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1772078999.git.Jonathan.Santos@analog.com>
References: <cover.1772078999.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: wOzX4ao2AKRUkbczwnUGwsHET3FjXDAT
X-Proofpoint-ORIG-GUID: wOzX4ao2AKRUkbczwnUGwsHET3FjXDAT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEwNCBTYWx0ZWRfX1kukaLRnz21C
 RqO94WkhN2laJrepMWd/5o3Vh5itjo45KEpHiAULW0bQ1D8h3Y2Ba5iabY/GwH8uAEhnAIf0IR7
 ChVR85E+0JJeFivQ0WfBlZEoorNhOrNWY+7qO2l+2mTmpEs6CtOcTqu1EDZGN4jtRn8k5FkKJlf
 1h3BV3JJNB0AxtheJqCT1E2u16RvWgUy6cLKL+ktqfsZm0sGN4bXMZCtCn650ajURMK3QJN++q6
 MpnXo5AMiYTzwOEy3D3ieA82bPE0saJo1anfl8HB2hK9sPDT071LBHuRcSTcA8Ts6EtxoA+te/L
 tktii+Vs4Jxc9BDOtVXMXmJNTtLfLjczF6cjnaHo2/2H/4wAFMBACUvORLbP/YRb+j1m8ri4lAI
 80mfQohByGtalsviReuS1qnRttf994E6mW3ENJjDi+toDOfF8MpkmbahqxBRSM2PSL+IR2FJMRo
 oSat15CIkVpKECfACEg==
X-Authority-Analysis: v=2.4 cv=HtJ72kTS c=1 sm=1 tr=0 ts=69a581be cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=asbD4md8-q6e6i43ReAA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020104

Extend driver support for AD4129-4/8, AD4130-4, and AD4131-4/8 ADC
variants.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4130.yaml   | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
index d00690a8d3fb..075ce62cb4e7 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
@@ -5,19 +5,30 @@
 $id: http://devicetree.org/schemas/iio/adc/adi,ad4130.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices AD4130 ADC device driver
+title: Analog Devices AD4130 family ADC device driver
 
 maintainers:
   - Cosmin Tanislav <cosmin.tanislav@analog.com>
 
 description: |
-  Bindings for the Analog Devices AD4130 ADC. Datasheet can be found here:
+  Bindings for the Analog Devices AD4130 family ADCs.
+  Datasheets can be found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4129-4.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4129-8.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4130-4.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD4130-8.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4131-4.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4131-8.pdf
 
 properties:
   compatible:
     enum:
+      - adi,ad4129-4
+      - adi,ad4129-8
+      - adi,ad4130-4
       - adi,ad4130
+      - adi,ad4131-4
+      - adi,ad4131-8
 
   reg:
     maxItems: 1
-- 
2.34.1

