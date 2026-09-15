Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DBF4CCDDF;
	Tue, 15 Sep 2026 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499791; cv=none; b=Mus7q8UNBYj8KjIDhsY91qmyPTzURIcfCZ5wpKMkN2nMuPROuH5IiCX5VcwJNEC0OOccpBIKY/F7LlpQ+blAxX3+krHlRt9m2kysnfQbGPere2+3GMgyX6NDWv31LoOhV4jLnwR8H1efW1jgdnR4b2NaLSwPkEqD7i4MPL14gxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499791; c=relaxed/simple;
	bh=OsoIZ0VqYPS+B1vaRtDJdbBvPmO4A7Z9Q8GbFDjVBpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gbY8OT92L4I1NBmWpbxnD+UNJb1StSZdsmqsNOb6MIt16VofFOKbFTVF61aMEwaC3Ro1o0c5F7Mzf8U5IfoR1MwApJSXPN5gQCxNtmOWX4LGo2ruItxlH/BC0bROhdYLQiNlKIRnamjfdWAdFsRN2+viTPnCN6rCCQkywi+N8P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=O8fa9Q1P; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="O8fa9Q1P"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FItjYq685827;
	Tue, 15 Sep 2026 15:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=chV2d
	qcMtIdDwxIorfuhDFywZm3jACEx2ZBwScejHOU=; b=O8fa9Q1Pk4k/Wpm1lBSHZ
	9cdDMuv/5/QtMOqhY8pc1BkqRfrgj4JHeijBlTJKJyHOmCxVldxxXjsqh+0nWIKy
	KKXpcNgHb61QTo8PWeVaFR2RE/QjHvEzQONsUHw9CqopzwxK9sExwasF7/QJodGg
	m7+HoFHG6v0gHTgBr5cORGMnUU7ku4DMfg6w1AMgkYdD4iS3HlwrcDmXKZtl9qFL
	ZiA33Gq3pQE1jODzNJpCr6cY5ih8lJzJ4y6UwJSQPR4eBq+IOLrpoaw5+M3hglf+
	mwCJVl+nsyQsoYKnx920zB8QqaZJxxXIZnaL+vJelPcxY1Rm/j1Ih+RE2NTXsggi
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gq4v9jgkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:16:09 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJG8CZ019637
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:16:08 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:16:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:16:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:16:07 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJFpMA028221;
	Tue, 15 Sep 2026 15:15:54 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v2 12/15] dt-bindings: iio: adc: adi,ad4134: Document PWM usage
Date: Tue, 15 Sep 2026 16:15:46 -0300
Message-ID: <cd2f5b843df513809405d854c4e1af823f3f89e1.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=JekpPkKV c=1 sm=1 tr=0 ts=6aa99979 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=JRIIml-gwpeNru_CARQA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX7h461ziebw5g
 2xmfCxm8WCAAh7WI+Wm1nP8Ai6VI+i7RGiu4f3vw3iVBvqY5bF4cseD0YL+kdfLhvRfFBhpsc7G
 15KRZWQ+4aIG0JMtmkeWRTic0Ddm7/2wYQMAjD1jahpR3VmzlqTpQ7FxlnUlOgIgsCJLsG0ZDNk
 Tv8pJ9aeboLbJgqw0HQ5Z1Piku2c+rW6eBSS6x1EzBj/6u/7FCJKl/OT+r1AEWJY/d5BK3AxcXW
 a3GZ17hnZkvANuNAt0V+xnaFX68G8utkWi0gC5UklhdCA4MXdfmfzmAcBGKvqxxzeUAcn0fBpol
 f9saNax9UEZc8rIMOON2wzPZTrcMb9XBaR1zR+Q1rXDawOKqBR37TWum891Nqpm/RMYWT4CoCYa
 /MEwLe3DvQh9npEbWyG/S+JRs7Nl30LbM2DuW6N1EhiUdkOd/7cO3slpU16pFwqLQIn4P9WRNVk
 sX4nfzdZwrHQeRtd5xA==
X-Proofpoint-GUID: VW-t7xL6lkcO0UZSfcuKkdgB6-ocKw5U
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX61/XqR1Ilo8Z
 NbA8v3ALXmdzFJIvUYQEE7smcH1EX/GSsUmuEIPXjU00MDnacfM8T3qX+ChAd9F8lgreDyfS8l9
 rdFCBCBLDQMHbPhfklMvVXt/JNrmA4Jb47lEomkKDcXTXLRpO55m
X-Proofpoint-ORIG-GUID: VW-t7xL6lkcO0UZSfcuKkdgB6-ocKw5U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150280

Advanced setups may connect a PWM signal to AD4134 ODR pin for faster
output data rates.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v1.

 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index d89134ce4af6..ad67d1cdacec 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
@@ -104,6 +104,10 @@ properties:
       GPIO connected to ODR pin. Used to sample ADC data in minimum I/O mode.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the ODR pin.
+    maxItems: 1
+
   mux-states:
     description:
       mux controller node to route SDO and DOUT0 signals from peripheral to
-- 
2.53.0

