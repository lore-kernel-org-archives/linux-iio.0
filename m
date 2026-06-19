Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777732FA2E
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885868; cv=none; b=nNZFzstfVXnNAdp5U2fPxm5ljs3Hm+Y/YaEQTlWHA2IYQ/dDg4olhKdw8knkf71rmdkDfucuAHsGh7reoshPXYRYNAUo5aLTkFaMpYELazW+CglRA/NdP/ge4FJFrhsPeEKczSsu2gWYEXgp0ImAfZ5lnCHllf2sYJa6jAaQBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885868; c=relaxed/simple;
	bh=juKFP4M3ulZMZvtYnJO+EyGKkoHe95cLoiQ9GeTdJzw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qwr2EU8eBb0pKjwOivUxBsF1ObF+QqUK0tB9yiK05JoLPrf/enarVU0TVchPK0Gat2CMt1LGKDO7QLYcz6OPDarlSRANFlO1LtoyP0yWmO7JMCwv8U9SuD2/0VAWnGoEkE+6ohb+375Ofwq2eT6D5k88TZoeIntSyAVO+Jofl4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKx0kjzu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKx0kjzu"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49230a567a9so11507835e9.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781885864; x=1782490664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NHhY6r7tYGyh00foyp4fyhhHDc2Zg99GnNa/YDtNxNU=;
        b=JKx0kjzuaL5MgQCNxoqYE+gI3UeRXYeWKa7Y9C1Fih8uARcV1fyU17AnN4MVGkDryu
         d27V19+qTwpY0pMFWBgFPq3u9xtqFIdl+6WtsnUL68ELEpcyPXoP8+4Izdg1hbC1TpiR
         qRUvkNK+VHWDx/eei9sruZw2eJ0NMkQ2Hi80wFreEDd493iW5SsRjvOLAMdB4sJTxC6d
         E1I8Ty2GHIB7aOqMoxMngskkTYv5yvFP2ld5elA3GzYh7dsK32W0jajVVau4JQDlz+bh
         /f++z4iUNqBR8h5SRMBLAiBEtbwlSDolkA87DIHsUko6otg+itAIywwX0TQemzskcdBA
         TfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781885864; x=1782490664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHhY6r7tYGyh00foyp4fyhhHDc2Zg99GnNa/YDtNxNU=;
        b=FzaByqjphvOcCzeBVUAwtmmlud3V5K4XG33oCo8RrqqPmtSQWDkELNhYEHKp2TAoHi
         Qa4T+1yf1pzocogAQoIMxi+9FVSwDXIYkUhLQS9T/R+oxbe+gvYbvfVbWEg1FqepDOX3
         QLT+Ye3dBmwvYcRJhKRN+pOjCsUnTyLKiY80fizHpsTTSxakjsgsJc0B7guyXRBU3QnX
         JQt6BOorPEjvxs0U5u9CQRJdGy9DXY/vt/8MVHFLhoNLN1Tj+c/+jpQEB66z3PiNucFE
         PDhEah9Wmm1c4xxYziFBQwpzGRJp2Gv/jI99AGBmwW+jm82ybh4NCXlGXTjzGQV8BdsU
         TFuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/eAWBWgg3ow+GzYEw5etUd5+vYSbXcXIbd6g+O4Kb8Nej3isXl3sCFaaoZqxKRflEqRP1Kki6M6OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQVo5tvLTj+ZCvtzcA4B22k7YbhKUFXkTsPPosMDhlSkrmIId
	/2TNnwLsyLYPTBm0zdzeXnJxXUGjZGuXPhTD8D6MG+56Nb7lQ65DQ0am
X-Gm-Gg: AfdE7cl25rqlHAHKB7CTKdie9k3zHzR9BhQ6gHDw7nRF8wvS5ztF4xLcsNixxiPTdBq
	qwjQoy4IVwFtAlfZiy4S16tU0QerjyryowiNOaFyuHpDiqq5DgyPYZIm5RWl7bmcr9sgOTXSeam
	MwRNmyq4BKqktaAR2xE3Tq7BjdMQlciOHWkZP6Qdq0ba7hAlf0Xnt6tOG/vqfgpdVmVZqu7emO3
	o+fnfp9UUeMp55o0PlFC+mESIgW1vQdxi4XpbMsYzmqO7ZbCqV9O9DpHYhTEcFZ/FS8UzqCyP73
	c/E6it2XXtGQEu9DjO+qTpm2aN5chCSGbdZsldxDwVa+swiFEv9/BAT8aa54BzGZ+UGmhG2V5fL
	+CN1H/UVcXQbUxxX0tykn9zGJWOpVUNmTzLkW3Ms7fhqiAjLLYTyNYhDotMF85iG2o3lO4SGqq5
	4KnOlVwGf2OCRFeT7SODtJYWWkm09wRQFZO97GO+aakVILUm4O7SjvP2Y+oEDKhGCBV/QsDrFDD
	X+7JgJHlM4EiHQvQWep3EcZW4vc
X-Received: by 2002:a05:600c:1f92:b0:492:3670:85a7 with SMTP id 5b1f17b1804b1-49240eb1347mr71855945e9.35.1781885864196;
        Fri, 19 Jun 2026 09:17:44 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57b8asm131866f8f.26.2026.06.19.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 09:17:43 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 19 Jun 2026 17:17:37 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 12/12] iio: dac: ad5686: add gain control support
Message-ID: <jcn5gqsjezxrnk74hrsujp56e2iqlr2iw3nwvtwd26zvexri5p@a25egmpppagh>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-12-f829fb7e9262@analog.com>
 <ajEppnu-AWSbbihS@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajEppnu-AWSbbihS@ashevche-desk.local>

On 16/06/26 13:47, Andy Shevchenko wrote:
> On Tue, Jun 16, 2026 at 09:21:18AM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Most of the supported devices rely on a GAIN pin to control a 2x
> > multiplier applied to the output voltage. Other devices, e.g. the
> > single-channel ones, provides a gain control through a bit field in
> > the control register. Some designs might have the GAIN pin hardwired
> > to VDD/VLOGIC or GND, which would have no "gain-gpios" device property,
> > being able to set "adi,range-double" if it is hardwired to VDD. The
> > vref_mv field is moved down in the struct ad5686_state, so that the
> > overall size increase is reduced.
> 
> ...
> 
> > +static void ad5686_init_scale_avail(struct ad5686_state *st)
> > +{
> > +	int realbits = st->chip_info->channels[0].scan_type.realbits;
> > +	s64 tmp = 2ULL * st->vref_mv * NANO >> realbits;
> 
> As Nuno noticed in other patch review, this can probably use mul_u64_u32_shr().

This would be need in case the multiplication overflows, which is not the case
here.
 
> > +	st->scale_avail[2] = div_s64_rem(tmp, NANO, &st->scale_avail[3]);
> > +	st->scale_avail[0] = div_s64_rem(tmp >> 1, NANO, &st->scale_avail[1]);
> > +}

-- 
Kind regards,

Rodrigo Alencar
