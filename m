Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4CDDCD
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784509239; cv=none; b=PDC9aUJJM17kERcMIV5Nmlj2ZcBWDCWj2NdQcRh7h01wwj0eoWVlgR3/F4tIvcZhKBQFFUPLc5sKqUuGsacW6Vfm/KA3NlmJFvC7zlGkWIuUS5qO0fDiYyms6OqwS13TiyMJoqSBTO+GFtRKRPlnKSExToVifXXotbV42tRn7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784509239; c=relaxed/simple;
	bh=/QhFCHlw2KYK9VBTdKgXL6pH1N+6dIVCs1n+DkEDvqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwVP8YJa9v0X6I79SFiWYpcFucQjbenE/WjArAr/ols4lk3D5Q67abT7s5ElK1jH7TAAEduNRNXh8efvm3Oj0LAS1Tm2HZJvLrMbPUx1kJgzTo9JIVzaTOxTfoHgH6iC+0QijqcXIrP9Z4a2XAA/XuwyKcR8BFfewkiY7XLJrEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A5onN1nS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jmt/94QK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A5onN1nS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jmt/94QK"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsVCi657699
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mysh0CyQeUMLIkDhwcPS0dybKuupOTe2E2KAalXj1tU=; b=A5onN1nSJbgc+wI0
	/e7zPEHwpn4qaR9y00Klbv10ADQuKWU+lcVoD3HkWSv/BbGFfrTmF2qrLp4XBZl2
	u1yedJx1KPp3kOxF4S1Doh2U0IOh1YR7Ho86/FSbIy+i49EbTelR4iEw5C+3JFA3
	a/0GkiHiFObyXRP8fOsMse0imszn3sdf+VmPFm9NWBuR/lo34ar9puyWDXF+XN0g
	YWAA55kqauoflom0TJunBc9BISleafbgWKzIKMBd1g44dmPmLn5ECPk5kfMFke7k
	FknhzEq+oqQMwVNB6k0z5K2iyy/Lqq0s9SM3sTPFO+ERqzDJhfa8WylpDyWLZbOp
	sPa9kQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2chkry3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:00:37 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84854c2f888so17633091b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 18:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784509236; x=1785114036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mysh0CyQeUMLIkDhwcPS0dybKuupOTe2E2KAalXj1tU=;
        b=jmt/94QKe2MH3r/XlFiH2GESF7njgfkGp1g/8Di1fhKtsR4A3meW1/A2HM2oBMG3a5
         HcX5FgHH/Nnrkz80A/VgHmkpd4b7n18GDVxtl4m+dcOFd1G4A755Um974JY+lewu2qO4
         66cdOrnVdEVZd1DFjktXF+grnBJ0UZX3sEyLjPQ0osBCgqmX3t7U+jEfyYxp2IMSrkVo
         yBWAOUEKLiYnBuaGFr7QR5Nfa3we+1J+D/QomzKQdJdG+kUpu9b1z2OTo2gE/+1fQmnp
         92gxUO1yjG9oCV/9tD2YitFuaMyYxTN+vqxCY+n6TFBIi6PU7kTmdbJEu6GjXEjV4Ng4
         RpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784509236; x=1785114036;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mysh0CyQeUMLIkDhwcPS0dybKuupOTe2E2KAalXj1tU=;
        b=ombhtCbMlYcsL6EUA3mlMIfZlC7jAHflp2gQGIvUvK95X+kbgW3op47LyuTHEdMu8s
         LS7WxjhV7yW31gj+O3JtWacr3W5+PIh7/hvFwgkBHPqUHtwbKC8tL5zH3AtYcwvHP4Eh
         CmKENnJZGRERiNsrc5evMNN+FzIDmcq/FWDA/sajXAq0jt5ous775eF45djIXijNmsG4
         WHdE6H0iFS7tqVUxHhJiRBcJ/O6Mv3KIi9kSPWe4SLpGtIu8buhPYhuil9fBUA6gxC2G
         GhiJif7ytXAD6OE2Y4JiyPf3ks4Lvid1eZGPrmIqNtDjJfObb8ws4KOgJtWlPHbd/6Ru
         lBLA==
X-Forwarded-Encrypted: i=1; AHgh+RrjG65LyPBMYu8r1rZLysBOD7KR/S3EwvaEhqa+hcYKJ8PIjkoTRM78797GVeT+y5cLFwArrnz+J64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZ/DX7WdkVfJqzEt1pbR0zMEsv1VID4h/4YlqPHLITD8KUZyT
	41itlauHRmetKcxmWEPbxOJmXuO0CVfLeOsPQl6lpFjpWuzGxx66WLoMQ1xa6fV4fFCf4+l90Pd
	2LwkDNAVLBlSfEYf+XKejQegLwYB59dLSX1FerFxR5ifAKDKaK9kj3iVLMAM1qUo=
X-Gm-Gg: AfdE7cnwtgz0zfeHaEv9zTJPCniLOypIueM5AdNQ/HJ2X14wsV5xsBTQm+Gbk82lqCF
	HvpxjP0AFXoxLMnIkjsFrdT6rVARQIptGgh4VyqhAPTdfXd0Z9cPUhfcbfoHqmQNX9dQd7gv8v1
	NNnGaXeALh2bi4Jf8yKrs2J4PswjMCLKL8HJ/S4PnGlNwEWMraLxGd6nGJzpcRARhJy5kTZspCq
	eV/uzshyBmovrYgYHVAFX23WWjrN42SdOTcbrpKh0Ps/7ibNxI8qlxy1+X7Uz9yMBQPcZwqAoiA
	ppmw6lwarkQvsnowRJgtBp/UEn1REOjHVHsZd4X/UrljXCEUW7B5kNxLqL1ZBI7px+UItUyK4f2
	IK9STOldl/JYRUQNf
X-Received: by 2002:a05:6a00:aa0b:b0:842:2a81:4c63 with SMTP id d2e1a72fcca58-84c292ac538mr11639360b3a.25.1784509236322;
        Sun, 19 Jul 2026 18:00:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:aa0b:b0:842:2a81:4c63 with SMTP id d2e1a72fcca58-84c292ac538mr11639288b3a.25.1784509235824;
        Sun, 19 Jul 2026 18:00:35 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af30b89sm4748636b3a.33.2026.07.19.18.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 18:00:35 -0700 (PDT)
Date: Mon, 20 Jul 2026 02:00:29 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
        David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Siratul Islam <siratul.islam@linux.dev>,
        Luca Weiss
 <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: add support for QST QMC6308
Message-ID: <20260720020029.18e959c3@jic23-huawei>
In-Reply-To: <20260715204657.46657-1-jorijnvdgraaf@catcrafts.net>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net>
	<20260714202842.340293-3-jorijnvdgraaf@catcrafts.net>
	<alansZsKEH3nX_UN@monoceros>
	<20260715204657.46657-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAwNiBTYWx0ZWRfXxuCwR5NZ8SdO
 jJbk6ikzuTZFxmJZ3/FAg4hso8oUj1jDTodr4RJMYxp9cC3Zxaz57kPH1EvY0yjqRH7iNnh/KOU
 HgpFlbfTIB44ruE/SFj6A0NXADH7rw4=
X-Proofpoint-GUID: -Eq7ZqJwyc8apDDj7Lc_KnhjDNPlhECU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAwNiBTYWx0ZWRfX+K7Ifr6F8XW4
 V6reFxNrDN+/iVb8q6ue89ZF8mUtcUTUzVGdzENKks4YClrx//OCLJQNlD9JsJRjDMNHnNPA4P5
 N2+OW+5qwX9NrqLO/MZDwBl+CLR2RK3G68R2FPX1nVVHQ1EljMH4Iacd7wfeThm7gt+bWFIhanJ
 6UPqHtKPU1sENXFE1N1S1xFAOwQA+RTXs20aaQYsB5+4d1j0JAuK4vWj7GAgBcrTjx9+W9FijmP
 686R8VYMkvdt9p02wQejK/cnFO2YcgyjpzqF35RuAr5bUbQLGSnKvpQwO0xDIs/a/viDcfSKcbV
 /2a795zH8X9O1jklzaMaySpEXc6wrhc/fbVinuSCZ4RCmAvXaVbzg5MkNUtxqdiD5aTErDel6Nq
 0U24StScjQGlaKF3wwaZN3pDPwJj0hN/1lH6ySORCf273F5imbwOBA4B9kX3x+5XI/YMzGTYwcc
 XGVsLGI4TNftGb3neIg==
X-Authority-Analysis: v=2.4 cv=T5K8ifKQ c=1 sm=1 tr=0 ts=6a5d7335 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=GYSh3LzNAAAA:8 a=ppxX1AgU5aaD0Fy557wA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=lWcdFasyL5yHfcDTNXXo:22
X-Proofpoint-ORIG-GUID: -Eq7ZqJwyc8apDDj7Lc_KnhjDNPlhECU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200006

On Wed, 15 Jul 2026 22:46:57 +0200
Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:

> On Tue, 14 Jul 2026 23:21:18 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Tue, Jul 14, 2026 at 10:28:42PM +0200, Jorijn van der Graaf wrote: =
=20
> > > +#include <linux/i2c.h>
> > > +#include <linux/mod_devicetable.h> =20
> >
> > Please drop the include of <linux/mod_devicetable.h>. You need
> > i2c_device_id and of_device_id, both are provided by <linux/i2c.h>. =20
>=20
> Will do in v2, thanks,
> Jorijn

Hi Jorijn,

Welcome to IIO.

Small process thing.  Don't send replies like this.  They add
noise to the mailing list and we all have far too many emails
to read through!  Instead put a note in the changelog for v2.

Basically we'll assume you have accepted any feedback you don't
reply to.

Note I send this email at least once a week to someone new!

Thanks,

Jonathan
