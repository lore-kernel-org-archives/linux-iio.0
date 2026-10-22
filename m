Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667937;
	b=fs+qYE2Ui0lnjjID0+LZNataTSGl4apseH85XXfnH9J+lDKfb8L6AmnPAacIGswtW932
	 ewsjoYyW2MW740Y4VRMOveTHbXDngVx83CgziuxWX30FCShRPGPhDg74FC3o2KXgiKc+A
	 KsgJDdWpKeR/pYl84nkVgnPsPgKdqiEm6Ilf7SUmGnTigC6n72avj8gk/uqpAuXzCFblz
	 s538OKIBiE0atY7sd/3QLxRXTs0ZF4neERV/udTHhSoXFYT1rmpXIc37aB112IDxfpHXz
	 /38VCXk/pP7guQc+5hnNWpWDl+Gc42UkYImMvD56ychmm8YMeV2Z++XqvWYRlJs2iKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667937;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=SDn1KWDGixNU3Tx9Qn7V0mUXHnk+yC2mqSluylsnneg=;
	b=00CwjPsdHI/N5cdfUicZTLLJqLa2jmm5WtY2bgKJU+Xs/gG9YTHZPUCdI14J4vJPfHvf
	 C1CcnlbNgiH/G2ucnNvsDKFjhTXeAPC4OUgUShWTkEgSozIonR+gQJXi51Q7FdCWqZRa0
	 Ew73VtzNsNM54R/QA5YFyhwNzfPH+EN99OjUiXjRYp4WGWTHWz85tI6c7j3ouAl46GIDA
	 svh3BMDzsCcXALy/i7FdC38T/KZsZ1wJ1caY9sPkzoqUDIDWDNpA4D0rDmhQQZ73OkZle
	 YoJRkaArZYlLiIdhVdfupBgnGQBX9B0C3yk+yWXeA9atpiCuXjPSBCntfwC0VOPvEzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=DG0pFAHf;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=EN6Oqquu;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF2606A327;
	Thu, 22 Oct 2026 11:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6CF2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=DG0pFAHf;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=EN6Oqquu
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA1Qpp941166;
	Thu, 22 Oct 2026 07:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=SDn1KWDGixNU3Tx9Qn7V0mUXHnk+yC2mqSluylsnneg=; b=DG0pFAH
	fdV6hNuH/LBsu6OHDkmjniV+SeWuXAsfe7wBrXdNCkUQ/aAOt20bXXc28lHvNeRI
	GPzi5cUxBOHmKne9vozTD/jJ2+xczVHtZDnHjpsi5yVkQMA0Zd2poJFJyoupQMCv
	7uFXajpFkcL8cQYz4d7/hA8AatgGF4D5H3wxfz2DtedzC7d5K1NPjiXYF88oftNu
	oJn+T7vSgQaqlMfCm3sn4l/RKga5PomgpSvKlkV9sxheMdOfNMkxci4/QE4J9CHc
	Q8Y7qLrcsvLT4e9UKAIr2fFdLpF6NqJ1bZDxJs8fko1a7tN5JaIqYCUHukk9d+Yp
	EqVsigeJT4F0oiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SDn1K
	WDGixNU3Tx9Qn7V0mUXHnk+yC2mqSluylsnneg=; b=EN6OqquuZcuN7ioLEdtrW
	/zOcdvlmq6qdVppxsQkIRP/c/4FkkcoaA0lPqJuO1dicjft71f6qcmSxuXWSd4bF
	WzfBL7YweLuwpKZx5TKPc07oqdMVXnnB946Th4vXI8SHgX24zr2zL8IxZJu9ajHQ
	ODBpN7bw7zWZbnCoiuz97bOC8SgKxPiNUiMMf4Zq7maz5htf1HaQHeA8HBYT2kx3
	+r0UV4zRSk4/Rj8VaLjWb5Nfcg/m35qC1t7O6gX3Cbo5vO1xxTl4MaKflKSpmAzi
	/MjxWqU8H3Z++RzxiASjF2gPnpzRXWyJyw8nVmEVgJ5+2x6KL0AElPgQWTvF9CIS
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hf9f5th01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 07:18:36 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69MBIZ8Z055330
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Oct 2026 07:18:35 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 22 Oct
 2026 07:18:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 22 Oct 2026 07:18:35 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69MBI6LG005667;
	Thu, 22 Oct 2026 07:18:27 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joshua Crofts <joshua.crofts1@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Radu Sabau <radu.sabau@analog.com>,
        Janani
 Sunil <janani.sunil@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Jishnu
 Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jakub Szczudlo
	<jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/4] dt-bindings: iio: adc: adi,ade9000: add adi,ade9039 compatible
Date: Thu, 22 Oct 2026 14:17:55 +0300
Message-ID: <20261022111759.6019-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022111759.6019-1-antoniu.miclaus@analog.com>
References: <20261022111759.6019-1-antoniu.miclaus@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NCBTYWx0ZWRfXwCrh3QdLj9QO
 IQAzTjlc7ABhMfBt18Rc9d2XeBtKxnlPGv2iqXQJcBwuHV3pqYH5QL5myKuyhC0leIpY89K4sXd
 8DJTHgdO41OylW1ChqBgHY2r96IcXo5dE9CzLbm7W386GMTcRxWR
X-Proofpoint-ORIG-GUID: GKR__Vcyp8V6I9Lzo86C-hDuUCPLRmTA
X-Authority-Analysis: v=2.4 cv=C5V8WgP+ c=1 sm=1 tr=0 ts=6ad9f10d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=XYAwZIGsAAAA:8 a=9EeE1HNB1sYntqoCoaMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NCBTYWx0ZWRfX5b9f8Ab2Wc2b
 V51EOP9oB/yHCCNlhgwpShqV+BuGizS73wl+EV1Ul9xUY7tjvNysw32RiA5gQyZos4xnPYN1ClV
 gw755jgmmW3LbqWIJAr5CYAEBnN/e9Br4UUm7qJz3R3u72scr/OjU8/z3grf+05wJEivvGzkQu5
 3SKmLJ/ofXtoJ2hkvjKG+WgeK+r4VnWXSoDH3AOFh3CNrsTJncc6OChhR3By4ImVGdv8qHIJKWG
 WOPSoRvWmO8RIxLSf+IVj0eV5HljGcvO3sta2uYorPzktpR4uzw1RwXCFHX3mQfQ8z2RgKxGicd
 6rYNel27QNiaPy3ntqYov+4U4WyQenvuP4JzAshjQNpL+x3k/bpjmGNdq+E1FXK/hy4p/WxsMpw
 ECrRzkG+k4RRJsVJDD9RubgBHPmekDxAnqvEL4FVD59QuT4mpjlQ7IRf59D5rN8dt1yG3udyBNG
 VmYOI7OBVIWOvkesLog==
X-Proofpoint-GUID: GKR__Vcyp8V6I9Lzo86C-hDuUCPLRmTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220044

The ADE9039 is a polyphase energy metering device from the same family as
the ADE9000. It is register compatible with the ADE9000 for everything the
driver uses, provides the same on-chip dip/swell detection, and shares the
full-scale codes of the ADE9078.

It is deliberately not given a fallback to adi,ade9000: the ADE9039
computes only fundamental reactive power and has no total reactive power
register, so a driver matching on adi,ade9000 would expose total reactive
power channels backed by a register the part does not implement. The
difference is noted in the description.

Like the ADE9078 it supports a maximum serial clock frequency of 10 MHz
rather than 20 MHz, so extend the existing spi-max-frequency constraint to
cover it.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
 - Spell out in the commit message why a fallback to adi,ade9000 is not
   usable for this part.
 - List the ADE9039 in numeric part order in the title, the description
   and the datasheet links.

 .../bindings/iio/adc/adi,ade9000.yaml         | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
index bcc166aad713..580ced2730bc 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
@@ -5,24 +5,26 @@
 $id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices ADE9000/ADE9078/ADE9430 High Performance, Polyphase Energy Metering
+title: Analog Devices ADE9000/ADE9039/ADE9078/ADE9430 High Performance, Polyphase Energy Metering
 
 maintainers:
   - Antoniu Miclaus <antoniu.miclaus@analog.com>
 
 description: |
-  The ADE9000, ADE9078 and ADE9430 are highly accurate, fully integrated,
-  multiphase energy and power quality monitoring devices. Superior analog
-  performance and a digital signal processing (DSP) core enable accurate energy
-  monitoring over a wide dynamic range. An integrated high end reference ensures
-  low drift over temperature with a combined drift of less than ±25 ppm/°C
-  maximum for the entire channel including a programmable gain amplifier (PGA)
-  and an analog-to-digital converter (ADC). The ADE9078 and ADE9430 do not
-  provide the on-chip dip/swell detection available on the ADE9000, and the
-  ADE9430 has no on-chip digital integrator (it uses an external analog
-  integrator for Rogowski coils).
+  The ADE9000, ADE9039, ADE9078 and ADE9430 are highly accurate, fully
+  integrated, multiphase energy and power quality monitoring devices. Superior
+  analog performance and a digital signal processing (DSP) core enable accurate
+  energy monitoring over a wide dynamic range. An integrated high end reference
+  ensures low drift over temperature with a combined drift of less than
+  ±25 ppm/°C maximum for the entire channel including a programmable gain
+  amplifier (PGA) and an analog-to-digital converter (ADC). The ADE9078 and
+  ADE9430 do not provide the on-chip dip/swell detection available on the
+  ADE9000 and the ADE9039, and the ADE9430 has no on-chip digital integrator
+  (it uses an external analog integrator for Rogowski coils). The ADE9039 only
+  computes fundamental reactive power and has no total reactive power register.
 
   https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9039.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9078.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9430.pdf
 
@@ -32,6 +34,7 @@ properties:
   compatible:
     enum:
       - adi,ade9000
+      - adi,ade9039
       - adi,ade9078
       - adi,ade9430
 
@@ -79,7 +82,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: adi,ade9078
+            enum:
+              - adi,ade9039
+              - adi,ade9078
     then:
       properties:
         spi-max-frequency:
-- 
2.43.0

