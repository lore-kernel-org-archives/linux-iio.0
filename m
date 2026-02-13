Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442F3624B5;
	Fri, 13 Feb 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994051; cv=none; b=ejq35ZPf3suAE6ZzxqzSidw73UAYvEboaF+JlbIoMfaVgmD6FOh5xUR4v4S+bb2NLGvUJx3X8W16TJgF+ldRlWOawHi1CreAtnxTUxHqYF9QAIutDhMqgj7kETafLmtfuiPiROvMPzxexphGp3gsGhn9Qr5CaNNUgfgCUYj6eTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994051; c=relaxed/simple;
	bh=ktW46DHQVS76eGfL+BAIw326fv34l92AfpXauFIImnk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YL0sho64qLWssyyA7iK3X270jc/JmV0QDyl+SiRjreTauih+wMXqAV2dnlSeRG7B31duwz3Wl81OAqPWJ++23lbySTqLDC+et5wL94vAafCdqvbMu8xCH5XcXka+OnO15tXN+IUwng0I6OAF1Ib6lzDZ9KsywXKyTJ34TKdJg5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jXo7Pftg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jXo7Pftg"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DEAx3d2059340;
	Fri, 13 Feb 2026 09:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hhYVY
	AOt+yT0F+M1pDK9/ksrHK9R0b9jg9U0YcJTJFY=; b=jXo7Pftgz6F2+FVdWeHci
	yQ4DqH0+IzHpfIDSgnOHgeu11wQ8KSCcoXQdw+rjyaLJd0rmlBFRIbMuSsmx7tBT
	AvEO4IPbybW7xvGlyEm5cucyDf/qf72Ev0HdJ7NWq0zwrlIPcO8RHwnKV2j9IkeQ
	TkRRess9oIDlAzMdzb73gslmWzq79i4v0oCxhcOZaS9cboDeTOokefzWG6eYYOGF
	Q9Yun2x+K+cTgt+vHFxlqbniC7PewDzGfrx6Yk974Eduud1NxVaILI32vQxWBG99
	+TjpidomSqVfyuNIrirSW62zLeXX/qj22mLeuOT1nwQbpB98L0WpaghbPNcX08FH
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c9ss6assp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 09:47:10 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61DEl9tV041266
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Feb 2026 09:47:09 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Feb 2026 09:47:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Feb 2026 09:47:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Feb 2026 09:47:09 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61DEkrH0018425;
	Fri, 13 Feb 2026 09:47:02 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: iio: adc: adi,ad4080: add support for AD4082
Date: Fri, 13 Feb 2026 16:46:22 +0200
Message-ID: <20260213144629.16001-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213144629.16001-1-antoniu.miclaus@analog.com>
References: <20260213144629.16001-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNCBTYWx0ZWRfX8muO+mFoT18R
 opsTOrt2ewXnuVBgRkO8cydV0GSaOU2sBVfC05DZendptYpy7EBqcKa26hIqL4xTSA5xELPS/yx
 Bo/TPE9JQTvZyVkKqiKpvRlr8DPUFnaCC5Fgz7GYX/y6S0n0QrwwTby6xm9JkHzYI1Dti5slaJl
 1EJjak5VAzZIe3AMp3pTzZqMsnSzx+gWj7+SH8/USaDPrEjz8AodGcfJSvt39vufL05JQGJ3Y6b
 kgsMBpznMMq/YF6JLn/7apKOB0RxV1iiZuTv/MiwuM2PJYFg8aDT521NQrk7XEftqRektL+s/e3
 TvChJgk649uVf26AKtC7Mv6nx8WDEvrOHv46gUtoOQqo+GDx9xg7owM3n2IRBol98za+sYwNaFx
 aImRaIVlTG/2SHmDegb0wZryv16eHl9n3bS+zTQWw2BpmY6eykWedS4FNdjfZ3Qdkx81RHLUTI8
 9nJGPGcZUUNs5GChBDw==
X-Proofpoint-ORIG-GUID: UAeRw7wbeiMDHxmRbOXfkUKi5zyfxEUh
X-Authority-Analysis: v=2.4 cv=YJmSCBGx c=1 sm=1 tr=0 ts=698f396e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=31E9SOtKlBnJEF0VI5YA:9
X-Proofpoint-GUID: UAeRw7wbeiMDHxmRbOXfkUKi5zyfxEUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130114

Add device tree binding support for the AD4082 20-bit SAR ADC.
Add adi,ad4082 to the compatible enum.

A fallback compatible string to adi,ad4080 is not appropriate as the
AD4082 has a different LVDS CNV clock count maximum (8 vs 7), requiring
different driver configuration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
No changes since v1.

 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index ccd6a0ac1539..eeabf99f9a12 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -27,6 +27,7 @@ properties:
     enum:
       - adi,ad4080
       - adi,ad4081
+      - adi,ad4082
       - adi,ad4083
       - adi,ad4084
       - adi,ad4086
-- 
2.43.0

