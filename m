Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC953E95BC;
	Thu,  5 Feb 2026 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310040; cv=none; b=FDg5Wzoacd7ySYvqhGatkcqzZyeVYSeB8hg+YKfmuzUNcpr14DRKqjBvRp+LK29EhVyJ6QGWz+aiF5zthXVoM5Rmju3kRJ/bMLluGuFzckGQphPcUligVCLF2SgoNyZEXaiihcMJbTkjoeD7KZ4HniH78mtnkQv460/x+lXGppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310040; c=relaxed/simple;
	bh=CHtw49nNn29KPoNB5Ee4FqcgWWdoXC7gFsQ88iK7e30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2IeLJm/O8m/4ueep86HI8u4bVwQnZaY8BeWMALOZHCTH2Rw1OnGuaT7K6WMz9vlaOyCJWx2ZjnqsQ2aepc7j4NFHx5QHW/APmfxIFveoXZlhCxoauAdj9yf7ctzS4r3OPpJD82BklL4KlroN3zk2jKNenfP/AkdVRS1s/TJ56s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sVoz0H6y; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sVoz0H6y"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615AbjxZ431253;
	Thu, 5 Feb 2026 11:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3krSA
	PfVzD02hbcHhuttBEOo3oAthslbALLfAPomR6Y=; b=sVoz0H6yUc277QPz/sAHY
	OFAb00r2G+aPLGLVBTbdpRemr06jDU+hp7TkBiibcdZWYR5o7xn7MV17GfwYoX+0
	Zr33cs9QY+FnNXbw0KcHMrKJXmEkthbswddllM5F2TtxuZTbpN/Kuojgm4Q9c0Wk
	VKtxnVeWXrMqQI4XatK5FHvq10t9jOF66GozMaTljEt4EqiO2JUvxoVKx4CkND7d
	vZbiwI0xyGoYApllQ0qgu5NI2/fkYm+9t51wjL5TBM4fwvEghGVl3SVFV/fvfGeB
	t/DDCQOCw4M4rsp0LKdf61RZomdO9FcnvO/XSDTmR6t4E3RSRMAjJ8Au7h29pjQs
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c3vybg3jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 11:47:15 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 615GlEeI045147
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Feb 2026 11:47:14 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 5 Feb
 2026 11:47:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Feb 2026 11:47:14 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 615Gl0EY032757;
	Thu, 5 Feb 2026 11:47:03 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v7 1/8] dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
Date: Thu, 5 Feb 2026 13:47:00 -0300
Message-ID: <a42aaf15925f9beac4ec3727954bfc9ef2576f87.1770309522.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: a9RYwxXFklvM2HHee_iBPxEtrGsnIufi
X-Authority-Analysis: v=2.4 cv=XLI9iAhE c=1 sm=1 tr=0 ts=6984c993 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8
 a=EfQ9L3lKGMo9VN_2EekA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: a9RYwxXFklvM2HHee_iBPxEtrGsnIufi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNyBTYWx0ZWRfXx7Wy2TKS2zTA
 NMqHzRHfHOnVJYgHpxw4Rr2xucfLV0M62ygOOAk2mi4zR5shGK6bFQEHuoUS9mAtspGSTKYaglK
 +77RjlYMkrcwkM6TEkzE/rZv6kZ4y3ptWySEBFVSP6eb7r8X8pWqRhKGnmT1Id87+wTC0e38y+x
 YXSmsZYRkzhdT+cXS3yzfFYQC/DoXPnPAf1dQvUfDYBtvxXewo7FEr7dan/LIW0xD4IoEoS6QZc
 tMwxewkM766n58g0frKQDSFfxcj6cYB8C2A1oYMIm1DPLdWNbX4ZdSl6LDXiUP32g2h5gs9jNb5
 qniFbR8MBpI0o8ISFbzSyf7wcWDuZtZbU9Nvr6MFkHl4H93T5+IRWPshjFxF6sBAmfeu0vuy3js
 tPPZQSs3ro3rZOXfijupkg14jpItCEck2e0WRX3bGSt8tjurCD6mnhQXJeYbIYtqz6duzwbHv4Y
 3Psmxg2AnwoUW5lR0Cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050127

AD4030 and similar devices all connect to the system as SPI peripherals.
Reference spi-peripheral-props so common SPI peripheral can be used from
ad4030 dt-binding.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v6 -> v7
- No changes.

 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 54e7349317b7..a8fee4062d0e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -20,6 +20,8 @@ description: |
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
 
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
 properties:
   compatible:
     enum:
-- 
2.39.2

