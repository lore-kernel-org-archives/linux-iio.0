Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82386301708
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784410765; cv=none; b=t9V/BaNSzKsgNCEbs4HKK4ExQWZkokPSDNNxZygSsQRHhJ89qbtAcNcsiUxZwiSOf0+abkxDKsp8AVmdpaXFywK//HGm7IgXdJDupMR2hIA0EVQRyHn5C3fIkbN3A4ltvKBpgSk/hJvYQ414mtVi4OMQLrpfVR5hpffMtuOz/9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784410765; c=relaxed/simple;
	bh=St8lrbOXTIb2EDDMh8Gp1CY0mvOIWlWOZZgLTowwB3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIxncYnSiRleV4RW5rnUSmKpHP050AvYxAyLQ7HYwgA3vwTwdDcVxl4AUxBn2yUw0emoSRyWdA0jCTfnWg2/IOEseTvImofQS/6t7681D+cgFbjmIGrVctOxTj4klZSdYfdLO4/HTw/uTjRcbURZ+0lfHE08T0mi7A2jG2HyqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mJh+m50X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yd9VedAX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mJh+m50X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yd9VedAX"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IJpefE1768454
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 21:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jLchW2mZfrswA2WmEJ9iJOe+wGFLOQRWz/g/uapSmbE=; b=mJh+m50XxKib3kbn
	hvf1mt1rtUkvcdGF6Z88aTRxUvvQDYFn+WkkeCpqm2RKYa/KipjB+szDN9tyXWfC
	VJTt78LFnTJ0VHv7rk8Yo+TPG8zggDxdCME7mQVsOjBR2Nj28zgaI53X5JfPRlyM
	XcUCPrnXaxhbmAFI7at8fWneagHdscWef0NknKMdH1R5ter5j+Ougs1U7BPcw67W
	0cvV80eyonxhTrlb/3Su2zccBXF08kpnO7amcz03najPkimOBEbp2B/Gmoi7WmPn
	NQNviBYI06+2SQyoeA3Lk2LPafs6KKxyrJGxUYXjN9tRHMvXrPVTA8sH1BrlfMdo
	heae+A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d91jqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 21:39:23 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb733fc5024so57166a12.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 14:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784410763; x=1785015563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jLchW2mZfrswA2WmEJ9iJOe+wGFLOQRWz/g/uapSmbE=;
        b=Yd9VedAX3Pwc9NQu1wRl6AWt6SKdNYPMkcOU+U4wDZZPYrJpsI0+gKcnsFPvtOCpab
         xJGGle6G0bxmKvdMD5+Gld3OVTMsbD86amjdP6cdw6pLyhGVqCdSnxGxlUwujCgI2uz4
         e756OpnHescnIw8vAbuDm0GVHhquYlRXD+qnO6Np1Vb09ZNHoO1uFmr0RVcXdVdfnvwu
         RRmlUNbDQ5Xu59UaGRRc16iguZ4UEPfj82pYhyz3GkkPw5A25tZ07UnNK/aV2DzdYllu
         vf/eX9fALGyWgrbMTfcFHht3SjKeYBMEfzfdEuShRT5vFa3pqSJ7lE/VbAmu/64v2/td
         GiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784410763; x=1785015563;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLchW2mZfrswA2WmEJ9iJOe+wGFLOQRWz/g/uapSmbE=;
        b=qCPMiGWguJDbwQzP67SzWjKpr6HCzLE+0RENibvTzAnStHT2uq8cmbNw+yqAWRG/Ts
         Z9zowTgl/EI2WPY9/ZHQ9gWsSRAHbdBLybCRaFRq0WY4rGYG98r//n1GSc7b5KnQhhSi
         FhWoqXOfhJivbptaTtKXxA09oQGNuuObezfFOcEWwFABiDwUl9MNfVBuH1suAVd/Lcuh
         w3CHB4Yf8bpAk3UWDsbWeQJFZW+InvVD4cpzN6Ab0/5rtwocFlUSro8ydkKBK3VY5/CX
         mHP36bxowSwYlYOIBLIq3KuRbLd6AYTTz7okEMQTDhCXHRVQzwM9QOL3DdudfsqtrKsy
         5oyg==
X-Forwarded-Encrypted: i=1; AHgh+RpUx5dP/KV1CgnDhd2NdlHLTH1C909Pe9e9ARl7UguAZwMj0/7fyROMw5SQu28HLKvkQpOb6jCchHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIdiGigf+ryM1kb0h2Dy/stYTzrQz51JxKyTRrDzb+vobzn0Q
	rwjx+FGy4dhobqATScJRfl7QO9Av6kkAEl6FuMsdOj/S6PJYy/4gwYFJTBbYwuTpzhZlS+hTF+D
	7WdLiFyUMOI5NSzsN8EbGXGlB7cTbJVmJU6g7Fc2YcbHZS00gGYk1UPmN7EtVRww=
X-Gm-Gg: AfdE7cm70MK/2fvnUSSDrh3p4RVbRUF7uehHEja3uGBoErNEclzUTCLLOAMQVyDL4yP
	0NEqjaGG14PpdBb0T5FK2mk9adGmDQKSoPw50iDLbRUjkezP6+vBjQs1C80QI0juAq47fbDun7x
	ruiW8i+okWxi7ndmg5OrMzCoXfmniNpJgjF1QGgRdrtNOrQREuduJT2HNyYpp/GcnzjcrtdVjaO
	1kA6KvzdMDGvK4qZUOEQKHgjEBKautjkxfOXp8a1Fg1cKf2ZUXyWb5zYdyGCyqkFMLHATqhIEx0
	5ot/7E9FdyUcY0YJGr6y7mmLag8PtGcZrGJFx8+HepoYOg1oaGVCG+mEb443FL2HBApUrG2voo6
	lRLRDrfzcEcR3+85/
X-Received: by 2002:a05:6a00:1492:b0:848:2f73:8ffb with SMTP id d2e1a72fcca58-84c29528564mr9028592b3a.68.1784410762903;
        Sat, 18 Jul 2026 14:39:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:1492:b0:848:2f73:8ffb with SMTP id d2e1a72fcca58-84c29528564mr9028577b3a.68.1784410762406;
        Sat, 18 Jul 2026 14:39:22 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2abe3e23sm3252413b3a.0.2026.07.18.14.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:39:21 -0700 (PDT)
Date: Sat, 18 Jul 2026 22:39:19 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: sashiko-reviews@lists.linux.dev,
        Marcelo Schmitt
 <marcelo.schmitt@analog.com>, conor+dt@kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 2/4] iio: adc: ltc2378: Add support for LTC2378-20
 and similar ADCs
Message-ID: <20260718223919.0cf0475e@jic23-huawei>
In-Reply-To: <alvKfTS8Kj1MF3db@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1784235595.git.marcelo.schmitt@analog.com>
	<5108c89986ae8723139419058db1b2f2e74daff6.1784235595.git.marcelo.schmitt@analog.com>
	<20260716212838.95B3F1F000E9@smtp.kernel.org>
	<alpab2gBs4nPDU5g@debian-BULLSEYE-live-builder-AMD64>
	<20260718024628.3e2872ca@jic23-huawei>
	<alvKfTS8Kj1MF3db@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5bf28b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=P2-tWYp8ALOPO-qZRlwA:9
 a=CjuIK1q_8ugA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 8Ye_oN-10iinwIk2sMME4irkcnzSpxWh
X-Proofpoint-ORIG-GUID: 8Ye_oN-10iinwIk2sMME4irkcnzSpxWh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDIyNyBTYWx0ZWRfXx1zrxleTaaDl
 Gox4asbL4A7ANOkOJ7XdVH9XrFD+BrWCBxnJ4wcgW+GO4Xj3gDFNqeySvvWDJNpwjI2YnXp+MXL
 xmor0oN7EaOqGz/pQR0SR+6hjmC7p9wDVO0qka0w8h7+c94Gkhm1dRBZ018/641oSK63BiWb+32
 QR7YJBQSv/byrZCcMrGqWPdJ3x3cgdO/cir7H9oXwg6Muy13kK2wy8p1tz0Tkdwfu/JzEalq2mD
 z3/fLlRISpbqmaEVMB980WyzXlnr6TmBfZDcDUKsatff8D/EhfW39Tw9zI0jdSzq7dh0M0Vglk3
 Mat/nbtW/6hi8Lv3Wk+fPyhNxxf9ujQwhquDLcW82euOjk0Ar4C63+rcLNgbZyjhg0X0OgQFxGF
 fiHsMD57iUYLWsYlHC1mIGA0MS9asAhRcW7uZOjjZ9K/y8Fz3laHkNWsL1+/D384GvdOsl0enXM
 pypV0OT8P9NtsspONgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDIyNyBTYWx0ZWRfX2ffvAS2oIl+p
 S0I66uQO8VUhT4zM1i5AZOsCzbMqxbHYlodsLdV1CV8N+27qUZlPn+YCvWbsUyMjjF0gKenQRHd
 0PoBExHoqK81lHTIAPBZ0OjG86h9xwQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180227

On Sat, 18 Jul 2026 15:48:29 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> TL;DR: Will switch to voltageY-voltageZ ABI.
> 
> On 07/18, Jonathan Cameron wrote:
> > On Fri, 17 Jul 2026 13:38:07 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >   
> > > On 07/16, sashiko-bot@kernel.org wrote:  
> > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > - [Medium] The `LTC2378_DIFF_CHANNEL` macro defines an IIO channel that is intended to be differential but lacks the `.differential = 1`, `.indexed = 1`, `.channel = 0`, and `.channel2 = 1` attributes.
> > > > --
> > > > 
> > > > --- Patch [2]: [PATCH v7 2/4] iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs ---
> > > > commit 5710d5f25b45906977e2522567c1964b1d3219f8
> > > > Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > 
> > > > iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
> > > > 
> > > > This commit adds a new driver for the Analog Devices LTC2378-20 and
> > > > similar analog-to-digital converters.
> > > >     
> > > > > diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> > > > > new file mode 100644
> > > > > index 0000000000000..5600c820c7f45
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/adc/ltc2378.c
> > > > > @@ -0,0 +1,416 @@    
> > > > [ ... ]    
> > > > > +#define LTC2378_DIFF_CHANNEL(_sign, _real_bits, _storage_bits)			\
> > > > > +{										\
> > > > > +	.type = IIO_VOLTAGE,							\
> > > > > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> > > > > +			      BIT(IIO_CHAN_INFO_SCALE),				\
> > > > > +	.scan_index = 0,							\    
> > > > 
> > > > [Severity: Medium]
> > > > Does this macro need to set .differential = 1, .indexed = 1, .channel = 0,
> > > > and .channel2 = 1? The name suggests these are differential channels, but
> > > > without these attributes, the IIO ABI will expose them as single-ended
> > > > (e.g., in_voltage_raw instead of in_voltage0-voltage1_raw).    
> > > 
> > > For parts with multiple inputs and configurable differential channels (e.g.
> > > AD4130-8, MCP3561/2/4R, NAFE13388 [1, 2, 3]), the voltageY-voltageZ ABI helps
> > > clarifying what physical inputs make up a channel. For differential only parts,
> > > the ABI seems to be flexible by only requiring a 'consistent labeling' (either
> > > voltageY or voltageY-voltageZ IIUC). Will set the channel with the differential
> > > ABI if maintainers believe that's the best way to have it. Might slightly tweak
> > > the channel macros to keep .differential = 0 for pseudo-differential chips
> > > (e.g.LTC2369-18).  
> > 
> > Whilst I get your point on differential only cases not really requiring the
> > specification of two inputs, I think that does provide a simple indication
> > to users that they are differential channel.  
> Agree. The first ADCs I've worked with were single-ended so having to provide
> the negative input when working with differential ones was something noticeable
> to me. Though, one applications engineer once called me out for the
> voltageY-voltageZ naming arguing that a differential channel provided only one
> input to his application and thus it should be labeled only 'voltageY' or even
> just 'voltage'. Despite understanding that argument, I share the opinion 
> that an indication of differential channel is helpful. Anyways, besides the
> possibility for application to display channel names differently in user space,
> I see we now have .read_label so the whole discussion seems pointless.
> 
> > 
> > I would prefer that we make them 'look' like differential channels so make up
> > a suitable number for the negative side.  
> 
> Would it make sense to adjust the ABI doc to encourage the dual numbering for
> differential channels? So I don't fall the temptation of single index in the
> future :)
Yes. That would be good!

Thanks,

Jonathan

> 
> Thanks,
> Marcelo
> 

