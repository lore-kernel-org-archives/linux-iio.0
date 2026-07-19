Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E6B19DF4F
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784425133; cv=none; b=J9hsxdBmn1uEBZ1HkqEL9+Ou8hRHqDXI3y1PWn56umU2PfQiQXpPEB5t3gZ6CxbEo0noEWTJsxQnJYlMEihY7/OUdCONDPy5nN7FWpa1FpLq9d7tQgvG9lxiVpk6RqyhjOQD4fz8wckroiJQAwImbF4arPVDs87RLBv9OSY+Nww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784425133; c=relaxed/simple;
	bh=1EmBQGh52jgRXdM+be8zMYBOnylKmYUJnkNrFI5qBzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwAOcO6nn77fVIOo8+P1h6qHfN9GRtZEDxF8TloTPr06D1xit6GO9TR8eepzUHM5Hbc+a/al8nYfcGYjITxnt89qu9iyS6I5g9wxBPJ1iST2ykRbGb2VJrXaandO5JG+VckHPUloqr/u95e1YcO78Q/Hag2WJ4gRohG+g23zdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ebxwMkHC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hr/mkmsT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ebxwMkHC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hr/mkmsT"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IN28CG2050384
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 01:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P2HpN0Z0gZhfo0RGpjiNpjfgBm8Ktu5eG+AyaINoZr8=; b=ebxwMkHCNLZO3c05
	M4qPmmzhMiwY9dFVwICnTFntNXJUWAgLtdJ4PsgI+cQjDWytKyHZa8+P4cR5JwUd
	I/5Rg261eHTahRHAGic9lsaXNYcrbJsc22SjbK9ZRXwEW+J5AmKqqMYPK2IMeCzw
	plrRFkHpQJBASZD8SwctJ/KnJQ3YSCN9XOw+Z8FRV+NnHGkbd5yb5Kk4jjL57eJj
	oY+wtgkelhQjUvaVAmBjzhJJGf5UUfK/1qwu+93PraT6b7G6LDKgiLhlxGLYoag9
	73n9PYlo2lwupEGqIY/Q1+HVURHgt1cW6Yv2TxN2GkFKhZ/nrxQ0yJKDcDbwLh9K
	/YunNQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af1vw2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 01:38:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so2826359a91.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 18:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784425128; x=1785029928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P2HpN0Z0gZhfo0RGpjiNpjfgBm8Ktu5eG+AyaINoZr8=;
        b=hr/mkmsTH+wYwDBYrBQ5iyggJLLpUkLWsvRxo9edIeQc8B68SgPSBLeTCHFg1X4Iep
         gO9vJ+0+VKe12N6QVVCFaDx1ecY+R90OGQ8MFhC/RifAK1gUYtgOaTAPfoaN7aIH095T
         vp6OFi4ummvk0lbNOEMo/fnLWCifAMpkQmTvjtq67O/kkWUA4S2ehh+FLCCuMefvMCEq
         C1g61hocH/kKao0NSm3ZuKEQuwOJIQfpGKpKN4Q9hKgpMfzVTYo0duuHkfAVdIV37b6q
         eR1d/MDSaZbBwp2fUBW8KRoF/GXLjqXdVrAQJbNWOB/ksLkG8sIRPGI+hx/h3JQiIZi9
         eisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784425128; x=1785029928;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2HpN0Z0gZhfo0RGpjiNpjfgBm8Ktu5eG+AyaINoZr8=;
        b=CPc0Yxb9lkipc9URUQLe2GlkyLFAPN8pQhmDJkjjo9ZE/1iiOqG3NtGA0/wdjOfzkU
         ht28L4cZ0R7Otg7YwO0KnEM2WLpnhyFgjGZJW74RqDJgtSoD85ehmMVyl7JwYVnheohM
         Z9E49Qz0ILKYp29CVzlxkbCG6Kd4EsHh38WluHnKdR42tocc4LgCBvQU6tb1Fki75Yn/
         e7VjI+Vjd8qj8Ris/UZ9HxcX8p6+tOdKCdWOaAPJn32FFljmQD1iQd9F4r734c3f+Y+9
         bHgm59VlvqtNYTtqqwwpeK8LPeM7nM8MNDiJ4OLWZzwzlKdUYCVAaocYvXtB7lL3msOI
         tOYw==
X-Forwarded-Encrypted: i=1; AHgh+RpzPguM096Ww3TspCOK6YS2LZUX/Sd4kGMoY32govQpjKi/nMDz0gm7KTbgld7daXO/QiJapxs+0+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92BkEeN4emJk93fUuMKMi/s3pv9pcwd1R01shb2RPQ7ahFhDs
	OqTJPsKkmu1AUw1+5347ncG6STjnXXbn308Yjg/ZMpC5StbC+o0bt1O3ck0FHdYvtH54kGHag7C
	6cNiZqDI6jSLCrtdmy+6/py5Yml32KxWIcM6OEPfXBW/vw3bcG74o95QypcVVuMM=
X-Gm-Gg: AfdE7cn+16mrE3S2dFetlS5L8OcsmXau5HxI5cHn3ee8g63dlmJ3lWDVmwj1ViEUTPK
	cjyEWZj9kdIi1Ln0i7SaQYAMnDhc+h9mqAMJWzBU7Qa/rjK4JKdVzdlOntB5PIaqAaelR/3iCgE
	X6zFxmMeS+gMnJeRuDZO0Q00NbQ9X4suri5xzAdDmawuojMuY9mGvJf+0m2t89211ZUTrvYSDJo
	CfHhMXloVmYypq2+3lUJYzID8bSApYGfqAvBzFfzJEYfJdyJ/rTQm+WCOmOz1qnmGYsgMkYK28b
	NvG7Q37SZVxpFBULpA4e71BnKe8MEurnv02dygCoRlubPFV5+jqrncv+wpjX06f3mnwHV++Eb25
	heNfHKdJNtp9z47QU
X-Received: by 2002:a17:90b:380c:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-38e4b403720mr8970987a91.13.1784425128369;
        Sat, 18 Jul 2026 18:38:48 -0700 (PDT)
X-Received: by 2002:a17:90b:380c:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-38e4b403720mr8970960a91.13.1784425127773;
        Sat, 18 Jul 2026 18:38:47 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e3a11e36fsm5460347a91.17.2026.07.18.18.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 18:38:47 -0700 (PDT)
Date: Sun, 19 Jul 2026 02:38:41 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nikita
 Travkin <nikita@trvn.ru>,
        Maslov Dmitry <maslovdmitry@seeed.cc>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
Message-ID: <20260719023830.5f99d335@jic23-huawei>
In-Reply-To: <pnxaJvFlsLehHV30SMlmWECZnbQ6Rqb2cvWWlVbjYKsg9v0i_Wyu28e7U_OYfV1XooewL13ZLUMBjODBTYnBuiI0t9m-bxt8AdKsz9oizok=@geanix.com>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-2-d18af55edab5@geanix.com>
	<20260716-adept-kraken-of-calibration-cddebc@quoll>
	<pnxaJvFlsLehHV30SMlmWECZnbQ6Rqb2cvWWlVbjYKsg9v0i_Wyu28e7U_OYfV1XooewL13ZLUMBjODBTYnBuiI0t9m-bxt8AdKsz9oizok=@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDAxNCBTYWx0ZWRfXxd+oOwXXi7m7
 xU0PvwwnKXZDkNjdmLYfdPzZsUme2VHyrd3/TjwIdlRjDTR5KfHoRWSHEktqS136Pv11T8MUlgn
 ithouLud0PO1amP0bedhlheovpFu66o=
X-Proofpoint-GUID: HBfwWudPyLW3jhDX8gcDoiNQJPkJxXx_
X-Proofpoint-ORIG-GUID: HBfwWudPyLW3jhDX8gcDoiNQJPkJxXx_
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5c2aa9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=ilKATfAMAAAA:8 a=VwQbUJbxAAAA:8 a=Y9KZW4ktMZT_zLnUvHoA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=73awMTU50e6eLoBjGbzZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDAxNCBTYWx0ZWRfXyIqSSeNTHhi0
 kKckbB7pIoxJ7Flzun/S6yesy+fqVg0sqbpjUTQexjG4Mmhl3GUDsqH8lqjo6Z3UgAOX/cu4PNI
 E4BxvBPrX+sVcMsc5byY+YqiQDjrBSVjAiO2S/Pvht+XcAChgirNOQSy+xD7slXS3jdlrL7i5Lp
 6i978h3C8os43rAyGzTUgSMdME1ZhWmKGHaH4VAnoQYdu12z0BhSt6bOCxrJLSUdNjbPbfRe5Ho
 5Iwywn2WhOONZM9LZ+CkaETzeEAIBI6RwiX1TgPvXgfNCXLi9KgCFFMyV1IvPp9V71eUZ4y/6Kh
 zOPTgUtCcLRa2q+XoEit2j+cUZR/PBeeeRDJ7ULgNY4rNWLgYM8Jp/3JQYdWi9/EV6JMaQX1iGo
 rn3EkAbqhyqhKskLbYT/jKQjcxNkkLveHbHwnx9AsFyyNIwppKFMgENPYTtcETNiaNuZFxc++xE
 wQ7tGXruBMcqqWVAqXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190014

On Thu, 16 Jul 2026 16:14:55 +0000
Esben Haabendal <esben@geanix.com> wrote:

> On Thursday, 16 July 2026 at 10:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > On Wed, Jul 15, 2026 at 02:27:24PM +0200, Esben Haabendal wrote:  
> > > LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
> > > without interrupt support.
> > >
> > > Signed-off-by: Esben Haabendal <esben@geanix.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> > > index ab9bb68dd736..76e81eba7ea4 100644
> > > --- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> > > @@ -19,6 +19,7 @@ properties:
> > >        - liteon,ltr559
> > >        - liteon,ltr301
> > >        - liteon,ltr303
> > > +      - liteon,ltr329  
> > 
> > Do not grow lists at the end, they are ordered alphanumerically to avoid
> > conflicts.  
> 
> Placing the new entry at the top would produce a rather strangely order list:
> 
> ltr329
> ltr501
> ltr559
> ltr301
> ltr329
> 
> Should I add a patch sorting the entire list to avoid this kind of
> confusion in the future?
> 
Please do a precursor patch for that  Also do it for the id tables in the driver.

Thanks,

Jonathan

> /Esben

