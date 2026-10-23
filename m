Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795064;
	b=nPTbFFljp5zsbn0mSFp+a9iUAfVwI5dtcuyWkldHvtIjak7uZYS+WSoQluqPkTUUQnxA
	 WLtBLInIKOv07QyozjpKT18U1VtxGkfzkMg/lhAoxEh41g3lhiHWvHZPksITmZplrjUTD
	 a32YkwPcJLieaOUutySmf6cK1sj4rKA3pHxdDbqEgckWVYAbfdfqsyzJMs9U0i6BMNBS9
	 coz9lp7RvYE0XypvTr6Gobf0Sq/SNS4op1ESWSiuZZpjm3oyFW71cHGIv64C5Td1Kb8/8
	 tlh9YyZBHJto8qsprudcOUPTK6o1GSbThC83K24vkrky1QIXB/UpWe39Dia78J/IpGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795064;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8fg8ghTQb+DStK8uWpKAgQcGfmViI8f9EvC68b2nDco=;
	b=beWezEx2r0HYT3d7EKYPQOVFUe6rbxYFWE9AP7egXwQWenvc9ZLIPLHgobFvNdtj6KzM
	 eFMxXaoPRIgRW2+sS+1r2eRwgd4xAYxMvjGPKM5TLRIYGFuB2hRzK88u4vb89QNoHQ6Lb
	 ijzwYlffnKS6B4UKbUh4YQg1fKKOMSPQ8AJqnr3qDoYIDH67aVJGnD7jGIuCT900QBCcZ
	 soiklQlkCDJITe1VxIWVG7RQoUCjs27L7PS27YJBnpqG7n/ZrahdGL42aiu/ZNQyxdV68
	 LMvMZfFlJstDO8JqgKSLFml1b/cNzrQpfB9uLnzwYfgKickk9dZNqcX1SNLO2VY9Ipw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=gzgVbcr1;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=fqjGWW5F;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FEE606A31A;
	Fri, 23 Oct 2026 22:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34FEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=gzgVbcr1;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=fqjGWW5F
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLwUhI1783962;
	Fri, 23 Oct 2026 18:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=8fg8ghTQb+DStK8uWpKAgQcGfmViI8f9EvC68b2nDco=; b=gzgVbcr
	1YG9eNuzSZ6E4Cjgo9Eze3NsjUmt2Qc8R6eOR/b7JbjaZ5HdD6M+z7gfhwj7HxiC
	04lj7Nv2KIf0B6Woc2xYDQ9fFhM4iw0PNxj7WB79IQD3htFxRTcnTbKVI4LaNq7x
	z12HsYr4Z5NyOHW9F2Z9q12W6QDVbGBNjGPFVwtLWfLBSKPYbWVANMTt9UjaIQy7
	QAEAk8e4DX4TmwIY9AzjwS2k9/Er/AuSsXfifnQw2jjsMRMAv/shV9Xr31NtF6iW
	tO7L32MLvdUsqXq5z2hP2DJAjwIPtNxJ4BVJDKJcDW5+76EODJjZTNd0EgJWQRi+
	l7smk33/b5vBgSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8fg8g
	hTQb+DStK8uWpKAgQcGfmViI8f9EvC68b2nDco=; b=fqjGWW5FjImvUp1bUb17n
	dQkOnMFq8oGCjvXDmXhOuuc931gDn71CP8ITDwAPHRP608dsklQpvXBJSqMH55Ol
	AT3SJrnBj4ZLdcYhbf3zwyuRaDR6FKUFsM4lGpNbsp3uzEn6ZL7Csxn8NEQmmQM6
	zJkhPsqgtcyArJoW1gENGmhD7x3szjnHVRs/TaqIVjRa9yFZ8/i5iFytd20oaCyH
	b/JR8XvDE8ItycDzbc1qbdBf0BEM42fNkZweHNmRa8FdEFR2QRMXScw4ezS/nOcf
	W1NYz+nlsr7WIRfHF4Vc2tyWjehcaxY5vZUNGPvax7fR/J7syZNRoZrIiJwpQFb+
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg2mvmcnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:37:38 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69NMbbRu017727
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:37:37 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:37:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:37:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:37:37 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMbMeq005917;
	Fri, 23 Oct 2026 18:37:24 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v6 14/16] dt-bindings: iio: adc: adi,ad4134: Document PWM usage
Date: Fri, 23 Oct 2026 19:37:16 -0300
Message-ID: <c42c2c20ee1bbb861ea4109c8d735a8a2697899b.1792792325.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: h8VsDmb-vUcPBIEhQ2oTlyAhsx0q-H6r
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX4zjylccGBbfw
 6+gsWn5XcN67PGKd0vNmW18n2E9jNnTLgO/WH8Vm8WiFEG0h5H1fVJ26aXuMXNvyBnmoZdDnkaz
 7kTnGq60VV0oNH+Co+WV/yJi4tY6rfQaxe3sGrzpuDB6OZ5P/0Ip
X-Authority-Analysis: v=2.4 cv=YJoKWhGx c=1 sm=1 tr=0 ts=6adbe1b2 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=J-Vyfb8du_z7m07cT4UA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX7FZNus+P73OG
 gueg8/HsLIgh5BlG16NFl3HAgVHuJGEWC18BYLoonRMcRnX5OaHfRwZurQmBNhsqymN0H5KfSEI
 yE/x4U/shENGW3sas0FZZELgB9soVHRYFxtgcCnFMKLVOzFK1zy4xYB5BTErPQHhB9vNUnLXDr6
 HbIxkD/6putQpD8wgeDC0s1MisU/kYKn5D+1vD+Pt6G4mghta+vJ6ZiSKvI4P8uZRC2PNgDI5yF
 6U3w2Qi36arltvl7Z3Nz6ExwZgYM9vrZhjNU5boz3s7II/ap6uX8m6j4eMVx+kPCBQUc6ClR/GV
 7Ex9iF+PFi9w09y+qlpmeSqARtp/JwAe0+j08tWKOPHol0lnHnGdg97WhbpYl+Hw05BeYFjYu9a
 yplrIoHADlRr/wmhXTJqjZcZwLpp1FOrkj4wLAg3x0mrivlmHCUmFabAmjCirqwTtlSPg46AYVZ
 wKUFR3a7rv+8m8xYEFg==
X-Proofpoint-GUID: h8VsDmb-vUcPBIEhQ2oTlyAhsx0q-H6r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230089

Advanced setups may connect a PWM signal to AD4134 ODR pin for faster
output data rates.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No change in v6.

 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index c70b9113cd67..6a190b7a9311 100644
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
@@ -257,9 +261,11 @@ examples:
             reg = <0>;
 
             spi-max-frequency = <1000000>;
+            spi-rx-bus-width = <1>, <1>, <1>, <1>; /* 4 lanes of 1 bit each */
 
             reset-gpios = <&gpio0 86 GPIO_ACTIVE_LOW>;
             powerdown-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
+            pwms = <&ad4134_odr_generator 1 1000000 0>;
 
             clocks = <&sys_clk>;
             clock-names = "clkin";
-- 
2.53.0

