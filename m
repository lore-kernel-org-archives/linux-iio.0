Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA361237713
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784426634; cv=none; b=fGJLAIX/lZaewzrrcb/3qCdOeNSTuETBROmh4KYDrlWUZWbhS4ilsGpMuonhotAi/EDi5ZO1FANRlQva41oR0yClzmryqo+WRRrrE/gI8V4PXKszs2HqK1s+teFM7eZwQh7aD3alWy54rRIgZ/YSvEjc7XmfbhW2mfu3aF1UDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784426634; c=relaxed/simple;
	bh=uf18FcNDdDuMsAOphkbWQiZwUFiSVlHL99xAn1lxX5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8H+DKO9i8nBSl5FvFt8I1IhpnPSHe57mOojVZjC1RmdyLbrprwjBUBe/cAs4VCvw18/5W7M/Tn+odYNic65T/vLM6bcGNuCSzPjxIeY6CrK+m5sglBK8h+zgIKnv35GSIVI7ac7/+/cpjsZGKy8wLt17HaE7sApfD2kH0iuqjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XTDhzQyI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=djcx4qBo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XTDhzQyI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="djcx4qBo"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66J21VPn2522225
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 02:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CMvQfXqzy8Bt8M5EW9UchREOfTtVi+CfN+7bgISMiW8=; b=XTDhzQyIrDvcH5be
	Smwaeu51/xFwL9dakuch5iV4dynnm4CKHZHiHnkoKziou+NVibwRC2Ja6IYK0eq6
	0UQPWjs3/BclUx0VfWTg/uAWBD28U2rn/RbEEvY7TWpPOyxJsRkeJwFva1cuz2+a
	UJXLC1PJehgUxOwFtapctNlP/eCwydVBSks1wQsg2HmFEOZ+4Owevb4/otn2IvTn
	hY0KTgfBC/jo1EdQopZqzZ/Jiik75epvIvFZGNZAB0VoYq2HrO7Sew5+HdXn/HtM
	IBvSGRArE2p3cUnQHeriIsDW7bF0gkRNpuyDrqRzkh0Kl0XXUnU0eFb9viVws8WS
	f38Y/g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d91wdt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 02:03:51 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8484ba00601so7111805b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 19:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784426631; x=1785031431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CMvQfXqzy8Bt8M5EW9UchREOfTtVi+CfN+7bgISMiW8=;
        b=djcx4qBoFem4P+bfgBKYn2LG37sH59XRoPh1Q09I+Y6X8eI+6grXlASuhAF8Qm7qDe
         eF/HaaD0i+zn1w7CI4DonD7A2G5TbGfEa5mjX35MC+HL5+/rNvTvIjVX7GqVFBDs7aU5
         B9kiBh9AR+2BriE/Lz2oYI9LRklsgxWaCSDmsNEJM97ijLIdtVWEByJJxTMaYj114Zbp
         5X794G4SXVJa2lnog+IeZVz5fi2B+8vGUp7n+cn77MSgn9UhfxanD4ntcuSBO78NZdff
         dNRPAutCPDc6Lrc5IlXlzvhD9gBhJxUEsUReMb1w90jjmIhyBJGzsYWGwItF2MKGSFZp
         TZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784426631; x=1785031431;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMvQfXqzy8Bt8M5EW9UchREOfTtVi+CfN+7bgISMiW8=;
        b=JdVuvLaYz6mDEepNIUNvflTgsKp84+7CMUWkpWXebvYkc2vMC5YNt4CIZhSFNPFe+w
         JUKy9egXBtjiS2rIuhopKDPES2LgChm3VTZGePMUleXzm49mmGZZxhefJk+dwfzfNwI1
         20qj/D8u1XM2sVp1ymi68VZ8eDTkNbeE6sOxZKA8Qx1XJDnh51Jvs3eBMl/ZEseADX1h
         lWENPW0rSMmG+wu28HaMKf9ry3kl6HHrmhGal4R2xj8QNWg1pMxCM4zOymSTWr6zfmBp
         nY+gYQO/YAClctiRpL0rJZXxF/vEBkid86gZHB9O89kfVWX8DuqTVCNRv0rUFscnVPK+
         Yftw==
X-Forwarded-Encrypted: i=1; AHgh+RrmTaT4A0AOZyYmtWFfy0xF/XdsEGEnkcycqHJTmd6calYNekhdeCKm8OADhTKi0OBJoI/t5hScJ60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHzihziWDo+66yoWslhtJTMTOazQttdE5HVBK2ygKkvmwzA0Y
	LaiHpfIOKyy3e6bUrI1OW+arUL+d4Xy6ssqnYhOMiNdoopfEhz/eV4h2EWSd4i9NZHoi7byJfN3
	8OD9Iav59gjfR17VoJBX1Ngl3uUl0szNyom7vC59rz/j9xZGFMaYFc6oYyAOq4MQ=
X-Gm-Gg: AfdE7cnxMGQteAto0Y4sCywkX6elTj+nhaA4iO+0o3Cry/ZhkQPMzXRmPhdirVwSkN9
	NPw2PXNO32XiES1YADIUTRvEWwwuRgwm+iwhWLEzvzmermkoVLKu1Ka2MQRjvWo8lKXe1A44Ei7
	Fx/0ur/pNoZ8BN8A2XyglpDB+IZeFZDqJpbuLZvGCkRKe45+Gqcd8vubYTonbPKYH0zahKfHx/h
	NvkiHmMbWYqPJLAmxIE4Ny5XGg3tXiFROmDsvWnE29zOJmquXruocd2/ZMZD2SqaxxfILYTmx8v
	3rn8audFBSbmAKLfQ4MbmhtGUcrdNP7fycquFJL3hsn6Ghctb4qLtRxrqaBEgiQUHwqIDG3cEHI
	xeNXyNWaOGQFr/6HL
X-Received: by 2002:a05:6a00:c93:b0:848:635c:5e8f with SMTP id d2e1a72fcca58-84c29494509mr8567833b3a.56.1784426631053;
        Sat, 18 Jul 2026 19:03:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:c93:b0:848:635c:5e8f with SMTP id d2e1a72fcca58-84c29494509mr8567809b3a.56.1784426630537;
        Sat, 18 Jul 2026 19:03:50 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2afae3afsm3511313b3a.60.2026.07.18.19.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 19:03:50 -0700 (PDT)
Date: Sun, 19 Jul 2026 03:03:46 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <20260719030346.6fb9670e@jic23-huawei>
In-Reply-To: <20260719030057.1c1be07c@jic23-huawei>
References: <20260715-iio-dma-cyclic-v2-1-268a3a28ff84@analog.com>
	<aleX0UD96t12s44k@ashevche-desk.local>
	<56f7bzba56atwu4qvgxpm4p7k347m4oqqdy3336rsy7xi3e7oq@jzoj2jtu3qu7>
	<alewxmtqJmEkRfVm@ashevche-desk.local>
	<20260719030057.1c1be07c@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5c3087 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=c92rfblmAAAA:8 a=gAnH3GRIAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=m5YLph7rcCB5XLdtb8kA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 6F-SAmhpSv1KXN6ourwI5ov0r5fWvtI3
X-Proofpoint-ORIG-GUID: 6F-SAmhpSv1KXN6ourwI5ov0r5fWvtI3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDAxNyBTYWx0ZWRfX0CtRGf0HK+E8
 qWM5II15MikdHiPvhFL4L5gMTMep1BijJa/UZNeDxdXnHHQcdtEl98ltODq8BVQ3UhAwxnjdLwC
 PxP8FH5TP3Ng/neAp8cANaIog1Q+R6+S2akPx0QXKqHKM/iJn3falghGXkd21YHJWpTByT0u4jE
 tgYwbWeVk5mYxLHsZvSLizrKIyZfneAwWiNOza4ZXIQVC3BweOWzTzApGdLNe202SUeT+XNnfAN
 EDCMLVXfp/ENjP8KSttU9mV1smcxXX84MdyPXGq0sD1Ec0ZslV6TfWguMlYgvvDNmAKcmiXddqV
 5J5Pat5nLyCUdcvnSsIdibx9oz5G6oxsl36zehC2sS6XG/F68iDcet+5WfeNbqAn883eiIk42ft
 UDMuZaCfg7A8bOmDJEvSk/RBt+lVSUQA7/SFgvIC0QHtXGIBSyXL2+QUeuBQ/OSv5xk/Ig3eEf2
 kqI9rpIisSlcVI1IRGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDAxNyBTYWx0ZWRfX4nvn0GcMXQrU
 Te0iDRihoE0uwZ+1HdJbVzcT/n72spefuTiCMmCfuvsrTib/aCHXf3g9w4K4vwVZRxt/LSKO3JZ
 TSYvK0MuWKvwjslKrhN+PpppVWLMNG4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190017

On Sun, 19 Jul 2026 03:00:57 +0100
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> On Wed, 15 Jul 2026 19:09:42 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>=20
> > On Wed, Jul 15, 2026 at 05:13:32PM +0200, Nuno S=C3=A1 wrote: =20
> > > On Wed, Jul 15, 2026 at 05:23:13PM +0300, Andy Shevchenko wrote:   =20
> > > > On Wed, Jul 15, 2026 at 01:24:53PM +0200, Nuno S=C3=A1 via B4 Relay=
 wrote:   =20
> >=20
> > ...
> >  =20
> > > > >  static int iio_dmaengine_buffer_submit_block(struct iio_dma_buff=
er_queue *queue,
> > > > >  					     struct iio_dma_buffer_block *block)   =20
> > > >    =20
> > > > > +		if (block->cyclic)
> > > > > +			flags =3D DMA_PREP_REPEAT;
> > > > > +		else
> > > > > +			flags =3D DMA_PREP_INTERRUPT;
> > > > > +
> > > > > +		/*
> > > > > +		 * A new transfer may need to end an already active cyclic tra=
nsfer
> > > > > +		 * before it can run, so always set the EOT flag.
> > > > > +		 */
> > > > >  		desc =3D dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->c=
han,
> > > > >  							 vecs, nents, dma_dir,
> > > > > -							 DMA_PREP_INTERRUPT);
> > > > > +							 flags | DMA_PREP_LOAD_EOT);   =20
> > > >=20
> > > > Logically I would expect this to be a separate line with the above =
comment.   =20
> > >=20
> > > Hmm I can agree to some extent. I guess it makes sense, yes. OTOH, it=
=C2=B4s close
> > > enough to be clear what's happening.   =20
> >=20
> > Close, but not enough in my opinion. This currently is spread over pure=
 flags
> > manipulation and API calls.
> >  =20
> > > Anyways, can spin v3 if you feel
> > > strong about it (will anyways wait for Jonathan to take a look to make
> > > sure this the only pending concern).   =20
> >=20
> > Not so strong, but lean towards my version. Let's wait for his review a=
nd
> > decide if it will be tweaked whilst applying or next version.
> >  =20
> Applied with this tweak.  Hopefully I didn't mess it up!

I'll leave it on tree for now but I forgot to check sashiko and
it asks about plausible sounding races. Please take a look and
let me know if they are real and an update is needed:
https://sashiko.dev/#/patchset/20260715-iio-dma-cyclic-v2-1-268a3a28ff84%40=
analog.com

>=20
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers=
/iio/buffer/industrialio-buffer-dmaengine.c
> index 639bac135539..ecc02a427b92 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -132,9 +132,10 @@ static int iio_dmaengine_buffer_submit_block(struct =
iio_dma_buffer_queue *queue,
>                  * A new transfer may need to end an already active cycli=
c transfer
>                  * before it can run, so always set the EOT flag.
>                  */
> +               flags |=3D DMA_PREP_LOAD_EOT;
>                 desc =3D dmaengine_prep_peripheral_dma_vec(dmaengine_buff=
er->chan,
>                                                          vecs, nents, dma=
_dir,
> -                                                        flags | DMA_PREP=
_LOAD_EOT);
> +                                                        flags);
>                 kfree(vecs);
>         } else {
>                 max_size =3D min(block->size, dmaengine_buffer->max_size);
>=20
> > > > 		/*
> > > > 		 * ...comment...
> > > > 		 */
> > > > 		flags |=3D DMA_PREP_LOAD_EOT;
> > > > 		...
> > > > 							flags);
> > > >    =20
> > > > >  		kfree(vecs);   =20
> >  =20
>=20
>=20

