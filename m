Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC0342EEBB
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607040; cv=none; b=JZLyPBi0xaCReomGUSOpFjfpCd97qF0yj9T1egOknNuQJXeFHaDWHG3+qoIZ7kzUpP7fxE+Q9kiM7LWONuDCcpnN0DW53f7Rvbv3qzRXXD3JPkgm8dgSUmjyHg1KVGN2i7osAMlBqWxBVnsLfylRx87vU9Q3QF5PDYSATA5G/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607040; c=relaxed/simple;
	bh=AFZbwPP7w71R3vFmyUl/YWruPemeG6PUPisAo77XqH4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJEHEXLYDvaIYnb4/Ooq6c/Qjm1umNdU4tS0w+pdROv1Dpi9RGWx3ORgdEY5m+melOWmALxJLX1rFSMPvjiw0Y8vdpP/NBfakw4PyMqR46gzOW3N+I33UKaC0XyR9JP5C1SgP7ZohcdZxoHA8eIcerQ0pC6hTWzSfVhtg1gEGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spRF5NW2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spRF5NW2"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bec2ddee9bbso890454466b.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607037; x=1782211837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FSOtc80dU/otDlrUcdfBMeT1OJvI4JOzA58AylAD5gI=;
        b=spRF5NW2xPrrildt9MVpLrGsOEQBhXsiXJaZaguRGPS2Jm6YSLqIrGpUMV41OoVwpC
         vCSLuGuWcTyGkRCI+3BIschVF2Uhne/qc87NqnHe2e7bhfx/FjH7MvuQifMRN9HwaGsL
         OGIVIzvkCmmyhvL8KP0ghTQNsy0AGmqu4F7fm99Rm76EIfJU2hFUHKKH6GaOzl+QMPri
         8zkn+FN6THbpqFrb+SFFOBUCCfJh4q5w+0scYaUs4Hu+E8u3m2t/u47iyCJvTLNj+HmD
         Y3n4cw8FXdp/Y9Q54sG7fuIoYfNkildQF0iRspxC84dIezXyRhTLPMPib1VW1SOvcf74
         21rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607037; x=1782211837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSOtc80dU/otDlrUcdfBMeT1OJvI4JOzA58AylAD5gI=;
        b=pPoWvTauYzh4cdXM/cJmbY/cCCz3DSeU3O+nRWNfKZN19VJvd1pqS9TfE3lRzrcgCk
         J5GAm3+cgvFMxCM8RPR4eS/iW7ARRW+6rX8zsi5Rj0kkbeTmbteai1vtrJ8IbMOad3AC
         4nOraGspwC0Wt8tdl5920IzWhwnGEiCrQnmsj0onUsaNM5ny4w4gDUoCZbW8UhWQj7hz
         eGnUL3U4Z9C1XQxyDDO4mCUjmGGTAa9TI+/j1RBXZgOH9xLHbZYnSNEQZWv6Mp/2HVgM
         8SjCLhHsbKk3mrOX+HNNipwyvQS1/o+K/gqybXIY6Tj26xnvjfXDbJ+aon5T9hC/GNXC
         dBRw==
X-Forwarded-Encrypted: i=1; AFNElJ+Pdy4MmslOMCJTGrgLzyShIaalP8uWwd/QJ2/JasrxwyGcdxyhesAGk9VnySHSWblnofC0CNll2wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+1kcC8H2Gq0U+znIs4TVc33TniBE10aHE+gExj+ESHiMGT9c
	o9s2uehs5eBPlnzL2A2rnC7r8Nv+/0b5KFUNZlSZRHN18IqZcbQbvRO5
X-Gm-Gg: Acq92OEag4toVARSGjH7eZR4zKe82zqw3Ho4UG+zrqrgQks+q+kBsAxvyl6HLJryGha
	gmAdiiy6rzupoborlaW9M5ciu49NZ3JVlgdBZsYvPKGmqJmxUsmbXuU47rBQHnrbTK4K9RdwW6w
	bmmSrOmiHxi3VyVAhlcd6hR2GrAls8xmugTT/2e+fn5uoQYtlG5TS3f2rTda5pwcZ8T5KUUJGJd
	tTdxVP4dVoWYyMusvLnSlXbs/D7rFbbbGpjYXUcnxJ6zkRhPQ4uC2PAl4AwFbpdIBKO3bJuLuK1
	y8FL4GmXO9qa/+NRBswEk6dXUVmYdR5l+Usdw4nwqlQy9O56O8SznTVzbgjAoyIkYiB3FQlZ3+A
	NGVjgBOd+TCGTK2kASJE+hOjLGFuzEdgTgh8QQ1j3hSOsm/+a72xQqnWMoN/c/NP4b7JhBhjEiS
	55TYlEbmWNPW4GRuIjWRj9/SK2g7Pr5XN1PNprO2whccp1UtW+fedo51WSalORiOFe36JtcXOwF
	J9Wl3JX8oGnfRvROex1Z6fS2LqGtNVsOOc5vwNbNeXkdK4Uzg==
X-Received: by 2002:a17:907:2d2a:b0:be2:11d7:8b05 with SMTP id a640c23a62f3a-bfe2a2194b2mr906819666b.24.1781607037132;
        Tue, 16 Jun 2026 03:50:37 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb9014501sm634114866b.60.2026.06.16.03.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:50:36 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 16 Jun 2026 11:50:33 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
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
Message-ID: <bguen4zngbwsnoxbis7mfrmo6q3vbccpntfzr6bsiog76kdhvp@3lcygxwlg2kv>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-11-f829fb7e9262@analog.com>
 <ajEo5pOp3ElX4cP7@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajEo5pOp3ElX4cP7@ashevche-desk.local>

On 16/06/26 13:43, Andy Shevchenko wrote:
> On Tue, Jun 16, 2026 at 09:21:17AM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Use guarded mutex lock to facilitate code review when adding new
> > attributes. This will allow for early returns, avoiding error-prone
> > locking and unlocking in error paths. This also adds missing include
> > linux/cleanup.h. Gain-control support will allow the scale attribute
> > to be configurable.
> 
> What about interrupt handler? You just added yet another mutex lock/unlock
> there. Perhaps this patch should be done before the previous one?

Can't add the guard(mutex)() in the trigger handler because of the goto.

-- 
Kind regards,

Rodrigo Alencar
