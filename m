Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3083624D4
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784330668; cv=none; b=XIEBAG7YSHpn+JXKuJya/qXR0Ieu0cVuBYjX0uTU09JlqpGys4YAz2H2S74mdzvouySSMk0ES+w/eMKMJxh/dgHC/2+WuTrqZ3D0J6hTBwbZ6RXQxYDtLjhClv7BAqFA5t6QXPDkba4TfAeSBzRfzeOTpDx6iqNNoNhejT51mEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784330668; c=relaxed/simple;
	bh=rC4PVzYTo4YilD+SyjjkLRJt7vcc/YteVFDoLytTv58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbWHFllf0KRTGLNSoqedpFG7so284Hc99c+f8FxOeoZ2JljSj9Olz3oU5Mtyqn+7KaiTox3wk1x+IxiQBVX77rnkOdUklVycXC3DtD6vsqZCIs35FYZMNs2yfTxayWsxrwA18MobFDZB35Zt5aa8akj/RbOlx6d98Q9IhSKBmGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pFIVzOuF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DjPXazTC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pFIVzOuF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DjPXazTC"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HNEK0a3023696
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cDB2taGW3BezzU40vb0osimk3zSpoauQxFEzUlZQg0I=; b=pFIVzOuFlL87cmi0
	jDegPaEznDlZxOTQykkEFoDHvfMMWFeXSu+8ff/GKTrElLYZxg9OHsgJ3mgmYp/X
	7aBXohvG8f7P7x/hTfVIsMuZSyc/gFfO6FXRJoevhU/K6m/dVwKKhPlfso1efxw0
	WGWTd0Q1t6PNGEVg4LjjXUUnXNYqvzoR8Ix+gx2ctxRm6rwoNOcX/k+SjKSvoi2q
	Zzz4yVlCCAmDTQkl6T/JxSW2uCD+2WoDkAshIRjnq/WqFEee9uZ/WsslxOyINT74
	QqXrye97CsdVn/AumQZDLkWY5EWrWN3Io31vkX5AKN3CbVJUyKdqpcYqBpSZBy5F
	kGUtuw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrp8s70h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:24:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3811279d51aso9002809a91.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784330665; x=1784935465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cDB2taGW3BezzU40vb0osimk3zSpoauQxFEzUlZQg0I=;
        b=DjPXazTC76w9lSTAgf6RnfQify+xEwNIu0vrmyqbp9N+Z4eYYtzzLb9YcbXBCG+H+X
         6YUo8IkDBT3Xnr40k94eA4vtPPXdak3iSdW/biLhMXA9rq+VUgLNu/Rnig7u+puyhhKL
         2Y9Hbwh9VG9F2i+cF556K6oKkdXo9Y+NtYZGwEC0uWI1ajvc3mk+FiUTFTkXSkMt42rj
         A6qlzqRSbF6cQLNB/6jXBT0Rdpar1d8RuRpUKugwQneg0GJoR7FKJNHlY+3ObFve3p7n
         uEbAyKIbVhKpdvCr8SNN4u6d+wseNORkEldufxMvNLc18WJ3GeFrexEn2a0o/Nn9s54U
         UXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784330665; x=1784935465;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cDB2taGW3BezzU40vb0osimk3zSpoauQxFEzUlZQg0I=;
        b=Z4GmQtoId4TbFOkkwr6SmcRgXKAtg+c1ZcscePb6SW5+6Pw9mULsOe2N1xs+7q6D4E
         T2CXrRSik45csrs/E9+ZbjuyTR3mjPIK66taCj0o51SfnXfYHuVjevFrNt7/n22fVV2e
         ws6uNi/2mBo22cvdXLgI3sbSmzbEPQYuRwWRMu750kvEHovk5LLyEkLY80uvdKk8ryep
         pSo/I1K/RcDgjieHd2Lt1OMZ4SVmfnNu07SlTbAkelCPw/S6P6aU0ivncjdLNzxNUkBW
         Ivd6LHo+2gvZluB1HCtzoZf/R/Ev7mcjdAQvjzWX6a+MMWC2Csf7OlAnGOyyta+wT74/
         mDQg==
X-Forwarded-Encrypted: i=1; AHgh+RpvARIa3CCyoXYf+oMjcJmvLPa2613eFxp351AKpGPG0kVY2iHi8tHDD7h2g+1XlyIuXv/hiNa+ymQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7GncCAfUjtg893KkSlN3CfEL638deFWYnwVJChRoNOStcAmZ
	pVPDVE7VX9q2yTBBzPTOPdYoOQuOI+tIwvGsKZ3N0Pk4myNyUbcJ8eQ8OiXGT8PdtTKqAuzS60j
	Xk46z1veP2DTnPtTe7ym0iUoeXa2CPQk2JAF+TvFcVVXSWchBEVVC7IbWkeKp61A=
X-Gm-Gg: AfdE7cl0GnM0Ga0WyqLHEmN2b/EPumHREh0S4lBLhVoBeH/z27fiJE5G4BMXZKu37QU
	OQLPZtPm3wH+W+oT9bQjdmOyReNYfmPvXnVdKvUcUjhBTC4rBhuo9Uc0hWp7fOVAn9shAGN4pBm
	0gvUcX1TjQUcWHIZvyiY6llaQtKUxFGkkNjxmQ/amN/BmDieRCC7YXQNUCIlbx/j56Rok0UuIUi
	rey/pQwFySWwfgGmNns2HLnErYlL4UdKEaXmMNNt8u+MlXzlMsshMd9APC8xLgncf6J+6Wy+K2g
	3tGCPt7/uOWIEk7y2GDGyUcOtzDKvpTKpmJpc3kLLpkUXaIfEeM+XcUZQtd6XW+vc7ji+7CiMl5
	5vadd9Qe+hdkWXzwR
X-Received: by 2002:a17:90a:dfc3:b0:38e:79f:76c6 with SMTP id 98e67ed59e1d1-38e4b5455b4mr4920670a91.24.1784330665265;
        Fri, 17 Jul 2026 16:24:25 -0700 (PDT)
X-Received: by 2002:a17:90a:dfc3:b0:38e:79f:76c6 with SMTP id 98e67ed59e1d1-38e4b5455b4mr4920632a91.24.1784330664806;
        Fri, 17 Jul 2026 16:24:24 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e1b8c4sm3729426a91.6.2026.07.17.16.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:24:24 -0700 (PDT)
Date: Sat, 18 Jul 2026 00:24:18 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: "Maxwell Doose" <maxwell@maxwelld.cc>
Cc: "Pan Chuang" <panchuang@vivo.com>,
        "David Lechner"
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        "Gustavo Silva" <gustavograzs@gmail.com>,
        "Maxwell Doose" <m32285159@gmail.com>,
        "Tomasz Duszynski"
 <tduszyns@gmail.com>,
        "Matti Vaittinen" <mazziesaccount@gmail.com>,
        "Siratul Islam" <email@sirat.me>,
        "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 (The Capable Hub)" <u.kleine-koenig@baylibre.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/13] iio: chemical: Remove redundant
 dev_err()/dev_err_probe()
Message-ID: <20260718002403.6034f4b2@jic23-huawei>
In-Reply-To: <DK16R0RUSGG9.2LHH6CNKD0IAV@maxwelld.cc>
References: <20260717094408.509583-1-panchuang@vivo.com>
	<20260717094408.509583-4-panchuang@vivo.com>
	<DK16R0RUSGG9.2LHH6CNKD0IAV@maxwelld.cc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX9XmRDPf5h6zF
 i+rnQPCHnozRSGP0OooBDnE48aahy+oide0tsE07C15bfjz4c1jPn4/U1aUBFFXtJo+UsVW1nC8
 2zqCVfSiMW/TfeXfUeWBTMh62fepMUI=
X-Proofpoint-ORIG-GUID: 8xSWCXVTNm36rGQa9-Gt5-iUCgn1Um_q
X-Proofpoint-GUID: 8xSWCXVTNm36rGQa9-Gt5-iUCgn1Um_q
X-Authority-Analysis: v=2.4 cv=fMYJG5ae c=1 sm=1 tr=0 ts=6a5ab9a9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=1WtWmnkvAAAA:8 a=SKPda2vfolqSxXLdt1MA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX2ifncZVhTpbn
 8fFmf8NOnqYamfXE0zkRO3QpvSs+gzr/dNXut2oyiqhS1vglVk086oPw4YoXCFmtXTYxDNQgUTC
 1sO1dpli8jfUO4XOmd7iuMrAm5P8Hze+mPxxTPtIWpwXnBmS8Cn0vVdTF7l3q76vSCNV1QHpK6b
 DVUUAKrcF5y71YDyT91LJryJjlG6RhiCocpm261+NbSWPw9IKE009C6gssx9Sox2hYphB5NgYlU
 klkJcz//yrsjvCjYEqLkXsHAuedDUVku5m22EpJ+29hB1bW+o3HAtK66Fih8XjpEv+jv28R8+Jf
 mVSSAEqk3msR825PgYoG3hRPlEsImdi7+TWAvNjB9QYzn4QGvniUTjVShmQI1Uh3ty9vb/P9IaK
 61Vzw7qIbtVYXinSUxVJQhHkpwvMkgcvM3a3Xl3Xsud0BYj2uTX9ifSUnKW8WXMT1XyCJfM8Yaa
 MnpKZmCfWgffLB6W+9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170241

On Fri, 17 Jul 2026 17:05:22 -0500
"Maxwell Doose" <maxwell@maxwelld.cc> wrote:

> Hi Pan,
> 
> On Fri Jul 17, 2026 at 4:42 AM CDT
> Pan Chuang <panchuang@vivo.com> wrote:
> 
> > Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> > devm_request_*_irq()"),
> > devm_request_irq() and devm_request_threaded_irq() automatically log
> > detailed error messages on failure. Remove the now-redundant
> > driver-specific dev_err() and dev_err_probe() calls.
> >
> > Signed-off-by: Pan Chuang <panchuang@vivo.com>
> > ---
> >  drivers/iio/chemical/ccs811.c      | 4 +---
> >  drivers/iio/chemical/ens160_core.c | 2 +-
> >  drivers/iio/chemical/scd30_core.c  | 2 +-
> >  3 files changed, 3 insertions(+), 5 deletions(-)
> >  
> ...
> >
> > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> > index f85cdd8bd84f..770571c21521 100644
> > --- a/drivers/iio/chemical/scd30_core.c
> > +++ b/drivers/iio/chemical/scd30_core.c
> > @@ -686,7 +686,7 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
> >  					IRQF_NO_AUTOEN,
> >  					indio_dev->name, indio_dev);
> >  	if (ret)
> > -		return dev_err_probe(dev, ret, "failed to request irq\n");
> > +		return ret;
> >  
> >  	return 0;
> >  }  
> 
> Please split per driver and resubmit and feel free to add

For large and simple repeat actions like this it's a trade off between
the noise of a lot of patches vs easy handling of any future conflicts in
backports.  Given there are 60ish patches if this is broken up, it is a
bit marginal for which approach is preferable.

For more complex changes I would entirely agree that one patch per driver.

So I think I'm fine either way for this particular series.  One patch
per directory, or one patch per driver. 

Jonathan

> 
> Reviewed-by: Maxwell Doose <maxwell@maxwelld.cc>
> 
> once you do that.
> 

