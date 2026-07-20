Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48729BD87
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514501; cv=none; b=QC8PnMY2/Bf/bdlf/A6yspU3L48iy3K0C9/8pDS7giLVAb7nua6RLmimg29tfwf+XPpOOGXQawsLX2a8YFbkurc4QAgzwnY3s2scgbkL3KaaI5cU7S0sl1ihSkX3Rd5XkJ4Kpw4711WcPUlazU7kec5ZERbrkzGMlvynGpQ6WMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514501; c=relaxed/simple;
	bh=+cA2/8KnHOcLjJklNMIphIkE0VFl036Nx66yo40sks0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/O+bn5ohqRW0eXhUTORqA1PFxqGA8siJPwWHI3PAopBMvLie47qeDKhPj/NlTVka1xiqSUBcKcy039tHF9VRAXljL29nK2D/u2LB1zTcSs0eZ4MSVj7KYUNBzlp95SULQbV6xffDgHWKt6inv5TqxXR2cRYmi5oQ3IehI+mFls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NlPT8okw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KE7dOEpn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NlPT8okw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KE7dOEpn"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNth7I915020
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	poxv4xx40oxQgMlpfFyOe+9+XO7OX7AMZ3eqJCAriiE=; b=NlPT8okwgn7YaR26
	0gDC5w2oHuLAjqL5F56/BSYSHSsYoN6vP/8KIUzyIZ+ZIuqgi6Oe1YThvD0WyTJD
	ZgiCs4foONtR+vOmtPhFny6w7Y6rYoSWL+eC15LIgDnkAVA85J+uIfB1P5EjXLlt
	UOT1mGWdLIAp0qHx6Qt4vvozKsUmCWXt4yfrjihsuv01wjLsq7fdKRueZP5GZ9q1
	m2NR+wUlhuBsJ5X5LkHkHBNS/jyS0CyPfFvk4FtVqSSggVYw16xBr1iRdY6NT1MB
	eN1uD5PJY8ZpKY94aIRLb8YcB6Rg4ef2E2dreMH/Tp2PjlapIrRBRvC4EV2gTka9
	37d0yw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af4090-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:28:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so442676a91.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784514497; x=1785119297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=poxv4xx40oxQgMlpfFyOe+9+XO7OX7AMZ3eqJCAriiE=;
        b=KE7dOEpnw8026RR0Xnnwc3IpxXO8o54m/3YCUlSELyQ8UciVSAQ5A1Lk/11q0NbrsS
         bpBSzzdWwTmsG2BeQzZzPWv2mk+KGbSnMsfVTtEhXIAaoZuhMLUeQlkobrUzyuvZMoKE
         nvPPuQbXAF8bv2hVfXuwAtSxj3jGOMfkIaBtOCm/t4YzLi0HB+8SvhYPniS9gVGnL/GC
         FoZWYvfMS/xZ/21VIPn9aLpGd/0EhRFWP4VOt0DZinjww5qMUbDWyET69Oh31LzEN82D
         N5E99uzwlbbjSCTuYyhYiq9szCoerlw6s9T7E3IICfekS5IwanYIJxLXc14Nt6w/ebLj
         XGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784514497; x=1785119297;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=poxv4xx40oxQgMlpfFyOe+9+XO7OX7AMZ3eqJCAriiE=;
        b=olqP8fQY/Dhe5w6WaCHFS0zqeBLC8+DY+EvzpLrAfVgwYHuE1M6WX8NIgf1fWEONZy
         PGYxYeV+/NnuDumHD30qifIEK/P/xNwBLFTAUo8IcL1G/8+73SWWl63AWTJUWD/YixwM
         7dQq7EyHVTl8u9oWsAo6P8xdfJtnT9JS5P32uA/bIhI65HCLd3FlcbxrCFVzvZu5hl7S
         S9pi/PZ3G2j2v6E6CLIMkOck2IvDo7D6bFM6OMzP1y+0L8tQwh8iNkVg2DKm/xHPZ4Bv
         KAAaRybaDzkG/1KgOmKc5Mn93dDWNkQhcBOOM2soFeFciZKkJDH4VW8eweuk+LJJvFY4
         4SVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq8ORskigkaBjuIVKzTEfctpLVPtGQhAncali6MLyX5AL4ffnboG/0bQKhaa11Ox4b1MluGO6kY+/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs6TLwLeAq+wteXaqt1+u9hF4RctmNXdiIugeH3Pu82LtzCglD
	hE0PzKRkwbHuVnYHTDxRVQ5BN9YSZsnaFZWFoTUueG7DFK4g8CUmsymA8r6of5YSIvyHxD9nsxP
	9F+swNQ8IyQ4BEMpfbsMne4dErprIW3JQZQQ86N/z30TpJ+Zo2ethRMVNN9z1irI=
X-Gm-Gg: AfdE7clrr+JR1/Ak/hq79SykZYwGEjGohu6MbPIn68sHY3xBqRpb5gjzkrV4dXxsK9V
	Ibo0uJJ/yzwulkvtjnOi6qUYYlbGhCsWbKUF75/TLF4GH/MQMBPn7fCvjSlSoQWHeWbNmih07ZB
	LlY7Td+gUJfjhLW8QVuMoDHGBY+vaM6qp/Uk3/TGL098KUMGolFnB/kuseenfdVleaFXLhgZqDz
	l8arO45k10oRkhviRfZSflE6e5fHnkGvLNBGRw6UC/xgAS4t6g7guuGX7dm98soJdqd2Dmb+oTh
	cmaOofqz8lkN4Ivao5BldYMQZ9RgTw5kx1GsocKTPjfpYQ/lCxbT6yY3pVs+W38ZUXrNW4y9MyW
	aARKtMDWppEzd3S65
X-Received: by 2002:a17:90a:c104:b0:38e:679f:3b3b with SMTP id 98e67ed59e1d1-38e679f4dd4mr5071276a91.29.1784514496837;
        Sun, 19 Jul 2026 19:28:16 -0700 (PDT)
X-Received: by 2002:a17:90a:c104:b0:38e:679f:3b3b with SMTP id 98e67ed59e1d1-38e679f4dd4mr5071268a91.29.1784514496348;
        Sun, 19 Jul 2026 19:28:16 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afcc117sm4771860a91.3.2026.07.19.19.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:28:15 -0700 (PDT)
Date: Mon, 20 Jul 2026 03:28:11 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Maxwell Doose <maxwell@maxwelld.cc>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>,
        Rodrigo Alencar
 <455.rodrigo.alencar@gmail.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: iio: flow: add Sensirion SLF3S
 liquid flow sensor
Message-ID: <20260720032759.579e16cf@jic23-huawei>
In-Reply-To: <b2c6cc45-5a52-4992-b72b-dfde02cbc94d@kernel.org>
References: <20260714085358.20842-1-wafgo01@gmail.com>
	<20260714085358.20842-3-wafgo01@gmail.com>
	<b2c6cc45-5a52-4992-b72b-dfde02cbc94d@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAyNCBTYWx0ZWRfX5Icj4FrD+YVw
 eZyoCL5uu2f1hoIO+8njY1DEO3xZbs9DZduviV5NeUSXNCswDMSw4G0KsQDao/zc1uVHIWTC4yT
 XQx03IjAsw4OVJHntOqbvRfCI/2bqaA=
X-Proofpoint-GUID: kZvujAaV4TwuowDQkVnwctucDi5OWys_
X-Proofpoint-ORIG-GUID: kZvujAaV4TwuowDQkVnwctucDi5OWys_
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5d87c1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=lrFNs2ZA_w67TaOphz0A:9 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAyNCBTYWx0ZWRfX4wgpkwUlRtPl
 EsmXzb3oYT286fmLii26nCZC8ICQEUS/pxEniqhbqO4KoBS+QivVzsmpJPAlRrjEWUspusVb6XK
 5CpQADZdqc61e7Z1NUtDuAsoU8DgIP/Xn1KWNmTBDQ/ZRG1JLoOmJ0ydlfwSdDcIMCpibZCL9CS
 I5BK+qLKr5i4KuYpA6suzmM9iWryGRM54PblPY58oEiiuSVSAlwW21VjLiVd+gA34zmm+ilnf6A
 SAonbejWzztlvgylxQA9buTJp6xojQWz28asGivyYVam3WBJ3qySnbHXmytHyhMZQdaptJcXmo3
 HOQDMuhV39Cc0Fa4zY2WF2xYaGdax+QtCgPyY3RCp2e57dSpPn76tWlwhBd9SV4t2MY0pBe7alT
 OPmLPOzN7tBvu6cIEd0OkTVop+Hb6oVlSv7UZzEqK2WlNHhltq52Bz/D1qcG5r2dxHmeXWO+Yvd
 QOp7Dcjxhu9lnm8/SfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200024

On Sun, 19 Jul 2026 08:19:34 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 14/07/2026 10:53, Wadim Mueller wrote:
> > Document the bindings for the Sensirion SLF3S family of digital
> > liquid-flow sensors on I2C.  The family currently covers the
> > SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.
> > 
> > All variants share the same register map and are fully detectable
> > from the product-information register at probe time, so
> > sensirion,slf3s-1300f serves as the fallback compatible for the
> > other variants.
> > 
> > The active calibration medium (water / IPA) is runtime-switchable
> > via the in_volumeflow_medium sysfs attribute and therefore not a
> > DT property.
> > 
> > Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > ---
> >  .../bindings/iio/flow/sensirion,slf3s.yaml    | 58 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 +++
> >  2 files changed, 65 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> > new file mode 100644
> > index 000000000000..c054a505b75d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/flow/sensirion,slf3s.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sensirion SLF3S liquid flow sensor
> > +
> > +maintainers:
> > +  - Wadim Mueller <wafgo01@gmail.com>
> > +
> > +description:
> > +  Family of digital liquid-flow sensors from Sensirion with I2C interface. All
> > +  family members share the same register map; sub-types differ only in the flow
> > +  scale factor and the calibrated measurement range. The sub-type can be
> > +  identified from the product-information register.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: sensirion,slf3s-1300f
> > +      - items:
> > +          - enum:
> > +              - sensirion,slf3s-0600f
> > +              - sensirion,slf3s-4000b
> > +          - const: sensirion,slf3s-1300f  
> 
> This is fine with me, also fine with separate non-compatible compatibles.

Thanks!

I'd prefer separate to avoid confusing me at least! :)

It needs new version anyway as the driver (patch 4) doesn't seem to have
reached me or patchwork.

Jonathan

> 
> Best regards,
> Krzysztof

