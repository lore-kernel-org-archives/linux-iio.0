Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA723ACF05
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607653; cv=none; b=JArPrzArYcoi+ylNOHdPd7rPDn6Xd63xCmcX5GJ7z9HmBD7+xwpAGZ+R5lDNwJK9hgQM9l87Y0dFkqX1freoOG/5ayLnsoR5qOY0YAHnt4/Hqt6I7S8j3ZYBo6at4ZD8Gr3l1PuHMOfX/sN+x/SIaPGeL0CZAW4dvrRiLnIGBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607653; c=relaxed/simple;
	bh=z+qESeFpb2XkTbR/Okjo5v5Qr3euoD+chi96tqKTTqs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYdRP5KZMNTGQB89ZK3m7ZcaTt8zuZtOwNVr7f38n7v03XoxoeQYxs4e4k/FBTuR9ystx1tj9VzpSWVsBfvLfUpJEZUwwfryAjlLlzQNwOJBYWzVB5r42Py0+gMu+xlRkjS1xNQms8INeJ3X9/pONQ8tt8LOOGZojygexlXgiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwCb3wmD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwCb3wmD"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bec450b950dso618879366b.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 04:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607650; x=1782212450; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9bZm1yyHX30uMCUt+HLHYBYfIefkCZ4T7Ob1gBqI0/A=;
        b=GwCb3wmDSBcGiuACUIqdGpuzq2GbWc0KdPaUlYqos+6L8IUWvdwVBAmnYY0vYXoSJR
         +VcPZvrZaubOdx4Nc/m6W8SwoTpQ7BAg72RbOZFZJ93v4zyjFc+oCuNEc3sWR2PHB+BK
         LfIydCd48Cw/sQmxqytXXRQ8fIR+Hs97mbFVW+VApdO9ZnGMLjvUMWZ4sQs9ugTG456A
         y6aOSU1UDqwIyN84uYX7tsD5g/+MX6dVTAca6AwjWVzWKva7rt7PSh7LwaWspZsSBtxm
         OLwfLLW774EFUllphcIYjQ6m/fLpwuBvEOcG5U4QFlq/iZX5OSESbiTTghyEE32G5hk0
         /qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607650; x=1782212450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bZm1yyHX30uMCUt+HLHYBYfIefkCZ4T7Ob1gBqI0/A=;
        b=E6+5QnHTHzxveM5aj3X4j7Ss0Ajb62Do6F1CHHoWurrpqhGBjcXAYAIR0xv2UE0KbL
         FFGl+Hb71k9ur9fLsVQM4m1u9Qb1bNt5ihAZQIYJhfnXSpG800ysoKLsy5FhvFLJHe7/
         H2LKmCJFK/J96T4a7Eg95gLmUnnRJl3Bxt+FLS8GOPzvLcZt4L33GG7xEip8n9TXVjiH
         ki+a/GNNTWRYiRJntv5xgLDIwjvA4EsomzFHloXQIWyfaTE0egyv9tjYpxuRd/KCPwlq
         pbGddBKgrDOZe2IdRxn/ekR7SXafdSP/w2uVXe2naGSvixX0/EBQHjsRjPGW63foc6Rm
         PEuA==
X-Forwarded-Encrypted: i=1; AFNElJ+6H7ekBm6C74kHb4TPykbqtYLwE2zJdeMqaPsLEE09E0MpgASAIN06CObUyuxPc07dGy7yJ+YhiSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydx5q2n5xesO/4Vh2VBG9GLmtFS0gT9e/Ilg/vOUXhorTLIHAA
	hhzN9OqoVOjhvMTtZWQnLMSSWjq0HkbGXy1ZEXdb+Piobo6TJXPTFUk1
X-Gm-Gg: Acq92OE3U3MGLFIYvCo+0X/TE0KIAZTCUM7GyaJaoLrT31Gcwt/WMjqR7wu1v4R0+ma
	iARWNJApJ1QsNCnVDpurfGBQU2ExTaf8dU9APVI2Cu7ipcc0t4aKp9JVDTxUmxSNXnrg1y1iPRU
	9gw5t6E0Qnr3GOj8dJ16A+wTx7/43ALiwIeZeN2lysg5nmRW8D8wpjax9yT06sfIBt9mOdiwiaK
	m+N2BgvWzkDNt4gh5fJcAhl6DCoRG8+Lb7YT3WmUyj/G9LKYH3ISStQjpSqy3x071r+PMxmZtBC
	RFrHPCm+M2UJPArsP5VM3xUOYB/t1KpLlZFd52DY15XLr9osRgi2jgat15ztoXpsUNp3v/j11Cg
	+xZwI173G4VJoFiea8NP9yRzHfS7AiFKeKOAwCPqHnqyC9hl+8kf2oi7VxRxXA6MAQiJ42F0+bb
	kRGnPcxFm/K+QpnYDYbHcfBBv+Jm9+lMetyoMsUJuDrEHFSWA0hoAzMsr10jfUnYjClzpg+vwDF
	07i160rgSuT4q1JzmNpYvjmkU4NhsmwyUi/e34=
X-Received: by 2002:a17:906:ef0d:b0:bec:157:a630 with SMTP id a640c23a62f3a-bfe28e12485mr939660666b.23.1781607649727;
        Tue, 16 Jun 2026 04:00:49 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4b240bbsm640211566b.18.2026.06.16.04.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:00:49 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 16 Jun 2026 12:00:47 +0100
To: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Maxwell Doose <m32285159@gmail.com>, 
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v3 11/12] iio: dac: ad5686: read_raw/write_raw: use
 guard(mutex)()
Message-ID: <dpxl3uucfdlsu5e644zrezquf7raeuy2aaiximxgy5dfjwtdt6@zp4hnebhfwr4>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-11-f829fb7e9262@analog.com>
 <ajEo5pOp3ElX4cP7@ashevche-desk.local>
 <bguen4zngbwsnoxbis7mfrmo6q3vbccpntfzr6bsiog76kdhvp@3lcygxwlg2kv>
 <CAHp75VeBE12U6dELhtxnL7ah4WEmAMVk-jq7vky1ynzdp_SAZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeBE12U6dELhtxnL7ah4WEmAMVk-jq7vky1ynzdp_SAZw@mail.gmail.com>

On 16/06/26 13:52, Andy Shevchenko wrote:
> On Tue, Jun 16, 2026 at 1:50 PM Rodrigo Alencar
> <455.rodrigo.alencar@gmail.com> wrote:
> > On 16/06/26 13:43, Andy Shevchenko wrote:
> > > On Tue, Jun 16, 2026 at 09:21:17AM +0100, Rodrigo Alencar via B4 Relay wrote:
> > >
> > > > Use guarded mutex lock to facilitate code review when adding new
> > > > attributes. This will allow for early returns, avoiding error-prone
> > > > locking and unlocking in error paths. This also adds missing include
> > > > linux/cleanup.h. Gain-control support will allow the scale attribute
> > > > to be configurable.
> > >
> > > What about interrupt handler? You just added yet another mutex lock/unlock
> > > there. Perhaps this patch should be done before the previous one?
> >
> > Can't add the guard(mutex)() in the trigger handler because of the goto.
> 
> It might need a refactoring then?

It would deviate from other examples... would either repeat the code in the end
inside an if statement, or wrap most of the function implementation inside
one. I suppose the first option would be better.

-- 
Kind regards,

Rodrigo Alencar
