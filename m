Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BBC3932C2;
	Sat, 17 Oct 2026 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202446; cv=none; b=fWGlWsMxLywwp4GaaDfcgp3lRAJsKLgBlUxTlv/rLxg6s8o1MzQsij0+FjUDc7zL59f8s6TBo1C1iUqhE7c8ayoHc+jPvC2JiRfd3gIfAvxnP3zGB7r2jErHuX5WehKLjUZGkhYzwNWcE852Z+y96xtDNxV9VQfqsJM68i6URSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202446; c=relaxed/simple;
	bh=VatUsSgrhnenXfZLnqv0WcK3ddD5De179uKgK/XppwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbWebZlsSiabkCPtLNSFEmDmg+c8XpbdG+G2Doy+3e5ZkAdxwDGeJsCPAwa3I0/4AfzTuij7F4jp1V8+rlv6XTMKabphxjXUvxycTYYKmbJ9OSzf68StHzqggF8CYURRNdbgvjPywTlv3D/dxFFn5tvDR5LtIX3xEsfdr2fxnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=Emqngjfc; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zN0A3jlN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="Emqngjfc";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zN0A3jlN"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNHVpO2680768;
	Fri, 16 Oct 2026 22:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=TqXzzDGi5jiL9wZ2uYuOJN9fUm2YxxoXUm2eVi+8DC0=; b=Emqngjf
	cSKVgGjhLglXe58rI5ixGMhxfGTfkY30kOAMIcIPvSAqdfrLpiXkC9FBwEpbSqUf
	G3jjpY04Iv9DNtJjUstqQBO67cctUT4bmLKalua2sXU37eQHFvyqxCpfrLtbDkJt
	TQch0NtJSFWF3Ee2GKVqoj78SoXtQyDkItBl+IuUa3yjyBlaWB8/tw8b+nRtntmZ
	5IlJPLQjo79j13dve00AdnH2RJN6+YEdOghuwAMJEfaYdnhPVr4wEuLfhoi+68ZO
	TIhVri9ON9cbk99nZJiPChybwtrhNdjQlOCuQIYRPfk+Y2UP5MtHsyFOttynn2L5
	HhhGMpH6hCbMBuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TqXzz
	DGi5jiL9wZ2uYuOJN9fUm2YxxoXUm2eVi+8DC0=; b=zN0A3jlN7y8vmDWRFbDAP
	7xC5onF2voYzutShUrkXKreU34QYQqvGFZQOw0kEKtvG4v/8gwvuhIWAOBTmyxhV
	4VNIvrlbGMvhlir3eorfMfzxKXZRt1h4YZ3+dR6AXowhhYAI99F+6zT/IoJDh00s
	+XOJLHGpAQaIqkKML/785HGYCdMbzXLfT+QZa5xFnnQYxE2Z1TNCJXnxvL5SJ/eA
	gbo+dboR2RmoYfNqEhnxrUe9M9B1tJ5IWSAWhfzdUhFv/eeXZEiQpg0qcv8PMzyo
	73VKVY0GJ1s3WmOKLptoKHfFiyXqcLpZjFQFl8+spmD/BY6+4OCzdO/kA4V0Qve1
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hbmr4uatb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 22:00:39 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H20cl6062266
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 22:00:38 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 22:00:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 22:00:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 22:00:37 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H20MK1005182;
	Fri, 16 Oct 2026 22:00:24 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v5 13/15] dt-bindings: iio: adc: adi,ad4134: Document PWM usage
Date: Fri, 16 Oct 2026 23:00:15 -0300
Message-ID: <79d2da7cbdee45d0fd12aa9fdb1b129f43af1998.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX9hdj/xdsD/Zo
 KTuW1wvz5WQIb5jdzXargtaEgoPkIlc9tK/yPHtAl2fONsdCXsWYFgSgCuQXaams4VFnJnD7drW
 iEEztCVzFQee0uqh78n0k07pufPZOoNcYl5ztqbFC0UH/DMoSYm9WBJOJ4i3IbmcHbgC5hfULl5
 YhtUqszVo3XLh0PQ0M9T1HnLEH94OkbIdPXreV5t0UNgtZ4ySIOZAK6DoXDSleE9dba2g0ornZt
 QNNOXiRuQwhlnQE8VRrzwF6FH+wZwHBjPg/gwoV7ePT/0gzRO12MmAZDRHhBa46WrX0p/cv3dXf
 tIOCmW8FB3PVmMq9lVfWQle9Wcm8fBcQtPALG4O1QEnzjYX9ll2FoEgdlJ6EByUrUTLudpBy95S
 irf4gn6DE4SRYDBdjiP2EQcHF47EyZ36m2UxbvZ7I5FL97brnpc2HB221GZmBoh0cAF1p/DqWdM
 ASrsAAeYTu5O6cikjHA==
X-Authority-Analysis: v=2.4 cv=TqtzFzXh c=1 sm=1 tr=0 ts=6ad2d6c7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=J-Vyfb8du_z7m07cT4UA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: K5gHoO08JMoKrmWBqm1qHDw-eRnyfoxo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfXxTlqaTFSb/Vg
 l9nOzo2MUYjJPdFNAE2PCqZHXiKqqGvdJiHwGPW5YgxVQ5EkQ3wBWevPt4ERvwX7jIEFAUdt7Zv
 DYBIUtLEvXgsIHro0vCiSmEwFLatzIeU4w6oaa/yc2gyuPkV6Lts
X-Proofpoint-GUID: K5gHoO08JMoKrmWBqm1qHDw-eRnyfoxo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170007

Advanced setups may connect a PWM signal to AD4134 ODR pin for faster
output data rates.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
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

