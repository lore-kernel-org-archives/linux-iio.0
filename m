Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C406F4AC162;
	Wed,  2 Sep 2026 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369914; cv=none; b=Qgah6a4I0yUyEWOmEozocJnQrg1sRGjOX/DrIjGkTCRXKoXqY69KZjdvN7VAYpENjm5NRMqikXUd577s098uCuhmxU0QfNdL26snVWEvPxIvjFH73nUpGZIMfjFeHoziS+8TAEzGU4DGbwI5azIE1/vTprvyj/ebaiASdV9nUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369914; c=relaxed/simple;
	bh=EoZkHdwEbweXBN5Z3DAWWDsxD5yPX/kUQcy0QK65wY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeW5QAO9+XmKNODWRs+jSwxrcrXdLUqvlYz2vKMYrdECObSeMI4PBGw4t6jAspXlUAvxdZXOxCjoV64s8I1CPo1CDjBWqpzkWMzkRV2y5INnqnJWUst2mNECxE3yehaEvJYvxKSAP3hNU8WoSu/bVYmpSL7RR6lAZUNDW6jyALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eOln0+38; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eOln0+38"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HDPTS3088232;
	Wed, 2 Sep 2026 13:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xz+nk
	AYq5E1ZQuFSc4dIhIFrR9CS3MFTLZHdPAxdI70=; b=eOln0+38rLZULzETKnL0o
	7ND9Et+fNQ9Q8CTy/a654NQmmyVnNXObjNc3nc3c2iZeK//CILSLfhvcQYsOircJ
	Ga2eI4mCuMum1pnXHT9SbMdF9brM14Z65ZsDxyoU3ZiYDCfQjBXwNgt+tp0WCK48
	sUrIYTMs+ig/wUmmoAyn4KYsAaKK0nOkQPc36g4yGc0N34FGo9m3MRDUOFJQtXOr
	WXvdAP92tHQsad52g6GdVMnmGK9g8z0pS7NIPqSqOeaH+/+ABnN6DgIGfesN0ANR
	na6LsQFkkSqhPamuA87fnP0W6l9mjMVBlVS7cEUYJA1MAcYStSiVuQJ3rc4gROjh
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gea7ubt3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:25:07 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HP5nc041480
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:25:06 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 13:25:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:25:05 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HOp66004265;
	Wed, 2 Sep 2026 13:24:54 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 10/13] dt-bindings: iio: adc: adi,ad4134: Document PWM usage
Date: Wed, 2 Sep 2026 14:24:46 -0300
Message-ID: <de2e0a39782b403194b36ff4461e284378a25b71.1788368334.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1788368334.git.marcelo.schmitt@analog.com>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX5BXB0AXVHnZh
 7IXEVKAg3KT4eu2jxZ6V6AUYRt7woMYhsFkQmHTv6/+KwHd5BMEJVIdWDB0PMhNremEYUhtHU5J
 lz5ZykoNNX976p/dAgeWdiKCzOl62KRWLOMI5VoPbPHgW9sjcAqdNM4E1i9tWGYxLocR/IddN7V
 j2gyFOldsb7VER8EmQ4eVBCumobnY/9DpwpfS+sJwrPl6fzSB5FklBdkploWfrdWwVoWxbHw7Ow
 PtYq8vqNBeUNC+1V0V0GmANyGY5riyzQyV3zHJfCsIGcUGzscoC3ewsXMLwV/poFSDJAGROJZ8M
 K6u37vqUZ+SH363UtFr4u59CTY15xGQgQFCBs34+TYtwGxgiektviqFgQ2pFIL1m2v4XE+xNUgm
 fndgHmyFGRlOjGXhzUX7luVoZUyP1xC0U1yJ8N2ToRMlGSAaMF0Yr1xXolHj8myrXcVJzJk7BVG
 Gg2hhMh0M0lSgNTUtgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX7hALd3xPKJLL
 VP6SfYhgq24egMEqXGHJZGtlJHibfvoSs29Ah9Ahe5/Knq896eNtJ8CBGY/7Iy1up2q146+vBTG
 TQRUpsUOJ2q+lpiln4ECpg9mR8zuaYWeDDBOuh97X6PRuXv2m1cC
X-Proofpoint-GUID: 2uomb2bXB50D2uwr82oTDrKvDLwIWkRm
X-Authority-Analysis: v=2.4 cv=a6EAM0SF c=1 sm=1 tr=0 ts=6a985bf3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=XCvVP4rNNzSNEyvd0iEA:9
X-Proofpoint-ORIG-GUID: 2uomb2bXB50D2uwr82oTDrKvDLwIWkRm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020153

Advenced setups may connect a PWM signal to AD4134 ODR pin for faster
output data rates.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index d843c02a394a..34043f89730b 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
@@ -104,6 +104,10 @@ properties:
       GPIO connected to ODR pin. Used to sample ADC data in minimum I/O mode.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the ODR pin.
+    maxItems: 1
+
   adi,asrc-mode:
     $ref: /schemas/types.yaml#/definitions/string
     description:
-- 
2.53.0

