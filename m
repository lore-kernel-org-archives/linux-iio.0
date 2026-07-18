Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710831FC8
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784412336; cv=none; b=EsumdXd0twMh8bwx3GxuqOhpL49/PqPPhAVo5jRZtl3J9fkIEndRAr2mIgVEV7a1pzRaCkA7b8s5SAzBLcqM1Yw2bdD7iLL+o7mkds7WVOnkqqVe/W66xqOSVVEM1bToRzR+4djlJ75yyiUT8Pcxu6so5kkG8U2oUMEOV4cDi4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784412336; c=relaxed/simple;
	bh=tpzh3sR7KQ3eoLTT8X6+G8GmKjP7P6coG5sSfKU4oGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lx7g7ECTKR97NXz0U4bMTNfTbGgPjJQC3pdV3197yRkwvCupRFDovxMfrYfKTp5rHudptC5I3MYDRKJe7E6mm5+UQ7iPWwl+28uv9Erqug7sIblBBG9SrO09PDLL2x79yBEktCwiJ/vgHcfTHUUC/JDshI2qGNqHAEEANNj0I4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NDgOtrZ0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C9xOtc+w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NDgOtrZ0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C9xOtc+w"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IJpWgQ1660411
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JalgrbbBIYkxGVvXSMno2dZ9hgEHgXLXu2M+8ScgSwA=; b=NDgOtrZ0O29QbV8Y
	xb84OrhH6qX7EI+omUBVo1uSZanzfPtz4uPQ4PlOj/qeLbhYLE8VJTPCEQWidZHK
	2Cjw7bwlUJbfzMsSy+9yCRglUulpIh6lEEDDlUgeNHEZi9taaVGxKJyvFj/ZqTcm
	6DpxKE08gRnaSD1nn1xfUI8rT102IGQdBcoGnlvIV0s4kIkAW2j6p86fJF+2+HZ2
	dkUGmvFzd4jY5PCWchM5Mi6MoEBVVnOE8sUhlOyhjfsWn+E5XJqVM7ZeUwpQX7fS
	HzgarpRhWsJNA+sJSQewRJxnJIx/f53TTtzXXb5CweSFZwFs1BCbpKl1H159dkn0
	TRE3UQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnhnm7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:05:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e6f71683bso418163a91.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784412334; x=1785017134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JalgrbbBIYkxGVvXSMno2dZ9hgEHgXLXu2M+8ScgSwA=;
        b=C9xOtc+w2uozhogKd5sHW/gMhwsnsYvuuUdXcG5lhClDs/xBF9GwV7n4+zoKSGY3aT
         3VSl725N7bfIWYEhTc1+1UYeG9qxjvAJpeWBqbFHx0hkC1XJyb+dTb7scA29LrfXG6En
         wkCl63pmi/prPPMvsFhuQByn08Q37h3IDHOMfde4yOIXAJxMv17M1jV98uv3oOF2JdzA
         2PkwBzqeSRJuTVFSy6rEOQ4uk8fVCHLGqlA8mYOZieVYI/yzqs4HtjkE7Nhsj6hCmMSn
         H4myxajeiYk8P2aQd2y0XKcKTClbU1eSAeXoSotdDhm8HQA2+mOavxRd3vm2H+NxxGYg
         0AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784412334; x=1785017134;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JalgrbbBIYkxGVvXSMno2dZ9hgEHgXLXu2M+8ScgSwA=;
        b=m3GB8sNJ5pz6F0hjtU82hNmrUrFP9pV6du3lHsX+2ZbSh76qwjJcwZ0fV9IEMBBgqF
         saGDm3pm4B/lbRuYgln0MHo8fyFHXLgecOTO3ltaEG2VO4H7S5RmFXf6uzr/GxaYD5Ay
         KzskKGzk2Cmy+n56D+RFSLNd7m9FDpicNoYTihFVRavDuBZpaoLYuUCPZRvU/LyfA+ZI
         X+h6oChZTMnW+YDtPEylUJ3dsumPy6AoOu+f1ZsORxBfbcInNpSHhd/biLkvD8dLn7co
         GzbeeavYIv8jVd48gdpw5S8EBkgnW5Xef38P/6vKrm4M0eV36mEV5/i3RCu8FfCI1Cof
         cdEA==
X-Forwarded-Encrypted: i=1; AHgh+RpnJFAel7DD6Qt4tm6r25kpUrz+k4e+dpXnQ+KBKFLsDE9l2xoaC8vXrDQfEeiYPdYT8XYyQZXJ+sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9k2HtYSchA45qPzKqXKNggAkQ/UjF6+SZ0gQb0jbXfaEcMtwI
	dXel5NHgKWVkkd/iQfu7UbC+vmUNJj5a4BK2IbAyiAvMcjagE/trDdQPM00Ri+xfor1IA3D5bFi
	lFzeZmpdFQyEn+5PuH1VtwNGMcR5wF0NMLU6gVdPOdOf0YexI34ikhYnDLkRUbzw=
X-Gm-Gg: AfdE7cnrq+16jY9l5Jkl8x4sgNIk0SnVF8ntbYpFxdvJEjPu17+oR29RNSUcLeeKE0v
	CgACl2dnRGzowlJ+cnPuPM6BjVoGwXKHXYVNtzjlikcZS3rm9P37RTNOeML1OUjpLlk4Z3UUA9x
	ime/yTJEtUcsV7VA1zskuoHVfGDtwJBTvKSdBYipLNAPEGqStxvASKmbmps0MXwSOsFsQP81pOe
	tgRoxSiJfiqwgokbrwqZop9YRHt9BMO5rGFNmKX1w6g9Bk4UBoC0+OpLzkBvSRpu3rr9RqS2L5e
	JttdLs3jC6NJB68B8hbbyH9lGkuFsIVlhOtuMAtLabfSJb7aIvhIOkDRBHCGAz7FPthi/gybEVX
	hHcDvY1UhW+T03T6s
X-Received: by 2002:a17:90b:2c84:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-38e4b422bebmr8808900a91.8.1784412333883;
        Sat, 18 Jul 2026 15:05:33 -0700 (PDT)
X-Received: by 2002:a17:90b:2c84:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-38e4b422bebmr8808873a91.8.1784412333424;
        Sat, 18 Jul 2026 15:05:33 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4b0e9c5fsm3304322a91.10.2026.07.18.15.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 15:05:32 -0700 (PDT)
Date: Sat, 18 Jul 2026 23:05:27 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Yahya Toubali <yahya@yahyatoubali.me>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Michael Hennerich
 <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS),
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v3] dt-bindings: iio: dac: fix spelling of 'reference'
 in adi,ad5791
Message-ID: <20260718230510.6cb748b1@jic23-huawei>
In-Reply-To: <20260718165615.1923592-1-yahya@yahyatoubali.me>
References: <20260718165615.1923592-1-yahya@yahyatoubali.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDIzMSBTYWx0ZWRfX2j6PG6Ar4UDN
 bRwqu6pykGaQY2igbJc7yArFPrIfK93vzwBUNnmW/92ffiHdJjlLsc1aonioWi2dsUHeWdwWq2i
 1pPPOJNSL8iy6bN/IODNHS/weE+i2KdNe54ESZQbHpRzC1uHTOxfoMSjmASz+wUPOX/XBUqHpEj
 XR8CugzNaHLOiXOJDBlvUAuzjLgBcURVwjfKQv8++D/Db57WrhijWz9XUmPSnUKAbMMZRC1pYtG
 O+L33SrZVjVuF2BcnNLH2fh/Bc5KQHS9E+892DO/MXvSyspQodr8OcrdISJCPLtJ0puyMFjUh1y
 iTx4Oql774JjCtecB13zazv5KRcKbW0jWTyLVrcdof7v4PQUqY9gv8VQ0Rt55EyG8LEQNFnt48G
 BZIfdZwdCSLsjh9+hgXGunjjgTVF9+h7fNVgAJ9mkYKlHNai+VihPJBNbwgQ4vHtvSM80PKwUve
 Ss2TZA+bL7bSuG7D6iQ==
X-Proofpoint-ORIG-GUID: kpvwtTRiZtydJNgppTThkUqEsfCrpTaH
X-Proofpoint-GUID: kpvwtTRiZtydJNgppTThkUqEsfCrpTaH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDIzMSBTYWx0ZWRfXw+9p/x8OTIpe
 ++ixAywaOdkXqhvcCzKvkbDvMGHLlmU4w2rmN9RuFqQXuTPSXXfhZZNckErrJ2O231Mb8huK+V1
 hlyNW6pviQzNi2PN/nV+dBKY+nZ+z58=
X-Authority-Analysis: v=2.4 cv=deOwG3Xe c=1 sm=1 tr=0 ts=6a5bf8ae cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=swzr3jCMHCTGmKo2zWYA:9 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180231

On Sat, 18 Jul 2026 17:56:14 +0100
Yahya Toubali <yahya@yahyatoubali.me> wrote:

> Fix misspelling of 'reference' (was 'referance') in the
> vrefp-supply and vrefn-supply descriptions.
> 
> Signed-off-by: Yahya Toubali <yahya@yahyatoubali.me>

Hi Yahya,  I'm not 100% sure why, but none of your postings made it
to my local inbox.  However, they were in patchwork and lore so it
might be a temporary problem my end.

Applied,

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> index 2bd89e0aa46b..80fb98035c6f 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> @@ -36,11 +36,11 @@ properties:
>  
>    vrefp-supply:
>      description:
> -      Positive referance input voltage range. From 5v to (vdd - 2.5)
> +      Positive reference input voltage range. From 5v to (vdd - 2.5)
>  
>    vrefn-supply:
>      description:
> -      Negative referance input voltage range. From (vss + 2.5) to 0.
> +      Negative reference input voltage range. From (vss + 2.5) to 0.
>  
>    adi,rbuf-gain2-en:
>      description: Specify to allow an external amplifier to be connected in a
> 
> base-commit: 1229e2e57a5c2980ccd457b9b53ea0eed5a22ab3
> prerequisite-patch-id: c8aee5eb39e3cd6f2b2f28c82163565665288d2a
> prerequisite-patch-id: 60ad32e9f0e74902635d7886b97c4225ac8dc5ce

