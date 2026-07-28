Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BC3D76
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244290; cv=none; b=ryS06AA8fqTudV627XNN8pK44Se/9/SYKbeXBH6D1IVJqMsurlOBMqcQPLutETcZ/Bln7Y3fPIJhiA7R09F1cscY7PwobuFAJldX96R0X0EXl0r1Nq5n5VsYzPOwB45snSX6qdlvwtH6aCbyzQ+XYYWHfqjbHugSMzKdwUE0SgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244290; c=relaxed/simple;
	bh=ICU62a4M/EaMJi+11NC4QXk4bKTL6YCpSQRypY6kR9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnhTHwqctGdokC+AmY1AAxFGdeI2elrTGlBL75dOiH/lHUUJa81Vbb+yTRyiQfM+KvL/GMw5A7ckjKovj1rXYh5pS6aEGEeRyZ1ZLU8I8YU1EnNTZUW3lTeXm/JLD2qumPV07a5FqF+NajQK/bYnZDUvfcmjEnH7fDqJbXfQKQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmsxC44x; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmsxC44x"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7389cff36bdso1366676137.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785244287; x=1785849087; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TyvQqlJVIFXzdizJw4kAZvTS+F6Y0W9n6wOXYzXOeDM=;
        b=OmsxC44xfwkeYbNGYw8ZoANC4hx2RUshwo7rrrx8U807e2iiymHw0DpqqS7fIxo9CB
         pthl7N3dKVcBuUFyARILcgAyPgIWJhVNmlSwzrBGf6dzvz+EVTWWBs/VyPRkTDfE0T90
         zq7+hJQQh5TNzqz7jh7trrfgSbDBOJFRbmGjtrGiX2moUaY1A9OAHyC+3q3IhXLuWYVl
         u0zG183RLS4iGusVEoxJhXwEtx27a64Nf8RUann6ZTY+955641o1U5i4zrAKv+umIDH5
         pzu/+7+IvnSXxJFvmwGeEWJqiVDAkpjSDcNuXl7qIE8/0Qbhdlw3VIxS4NgeA2WBIPiJ
         gI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785244287; x=1785849087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TyvQqlJVIFXzdizJw4kAZvTS+F6Y0W9n6wOXYzXOeDM=;
        b=pAXdnrmjrSS29aQxpNlKZ3E/sdn+EuVtsjvSdFlGVhg67G0XVpJkQ5gZYP/7LGDjzy
         f6YozHoAcvqkMS1vXCJO48LIq3DvjEquEgqBKpL7Knla+cYS5mBc4+XqxE4tv58xdGTq
         DhxJbwr1RuqTy6GqeHF0H/pQ4vYOzc3X/feIjBECXHbUmGhU3YbUcP2xoUCHtL966MH7
         3kQFpZ7L09pe65ERnzAbRGrLjtScNNexsbJTkIjAuWzoDaL32gQKb+36wq4RVRKA6xyH
         OpqVuY/aAlcHB63PanfX12imW5MoFtDGNdqXWRk+Z9y2ANoBNZdc9gtrVY18HJq0xDFS
         ptjg==
X-Gm-Message-State: AOJu0YyYWhkWkyEmgMZIJqVhHKQX2f65kPvbY1H8hcH6k+V4y35jQooZ
	joRjq+KWbvZS+pqVbkjm7s0R9/PPhp7mpZ50LTRRa3uq3BFahQ8D72A7YZHnOQ==
X-Gm-Gg: AR+sD13UICkzueIxfgk5eiPByH3wbu+fUQHAxhFKWermlo0/1WlP0yvgH5ton0RLSmf
	/Cedo89NEC3aj74Ou8rQeZzq0FT9DWwq1OJUPmjOi1ckqmkFoHdV+WSJXO2oXC3Mf7QxrrCK96C
	FgPLI3A9Xbd6TCbeTTtuv8Wf4HDdfiWknuPGPeScGA46sHDT4jagxjbC06jispEHbXF7o/7Ysbx
	hTwTHDgoangeUZVIeg5Wo/4w65uZ8H6DqrplNRBb7TNqLZKNGl5hYnWPcqfq1CiUv6mJuliPWIw
	hiio+OMn7WyX7F3iBobWg5ONKHjpRQ2m9VjLTri11LG6tYMLvYxLlcScW5a2aLBjFB3qJnwnJWh
	sVqujMxh9PogUDzDTebCrEtj0ObNwk0DlhdrNOu8Cxtn9HlrasSyePMWCQvItKASrKdxuYrEQSR
	W6BLOQP4RIpd4=
X-Received: by 2002:a05:6102:3e85:b0:6d4:ba3e:bf97 with SMTP id ada2fe7eead31-7549fa597cbmr951669137.4.1785244287420;
        Tue, 28 Jul 2026 06:11:27 -0700 (PDT)
Received: from localhost ([2804:30c:2739:da00:1cf1:e457:fa41:ad98])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774ce146csm7173731241.7.2026.07.28.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 06:11:26 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:12:34 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, conor+dt@kernel.org,
	robh@kernel.org, devicetree@vger.kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v9 5/6] iio: adc: ltc2378: Add support for LTC2338-18
Message-ID: <amiqwmIHsgO7v8zC@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
 <39f2ff86cf736ff97286d6451fcc45fdba6732f9.1785186980.git.marcelo.schmitt@analog.com>
 <20260727214022.C81191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727214022.C81191F000E9@smtp.kernel.org>

On 07/27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Declaring a variable immediately after a switch case label without a block statement causes a compilation error.
> --
> 
> --- Patch [5]: [PATCH v9 5/6] iio: adc: ltc2378: Add support for LTC2338-18 ---
> commit 29728b1d34f34b2970657e2d83536de22940ee2e
> Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> iio: adc: ltc2378: Add support for LTC2338-18
> 
> This commit adds support for the LTC2338-18 ADC to the existing ltc2378
> driver. It extends the driver to handle the internal voltage reference and
> input signal attenuation specific to this part.
> 
> > diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> > --- a/drivers/iio/adc/ltc2378.c
> > +++ b/drivers/iio/adc/ltc2378.c
> 
> [ ... ]
> 
> > @@ -383,7 +395,10 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
> >  		return IIO_VAL_INT;
> >  	}
> >  	case IIO_CHAN_INFO_SCALE:
> > +		struct u32_fract fract = st->info->internal_div;
> 
> [Severity: Low]
> Does this declaration cause a build error?
No, at least not when I built with clang/llvm-22.

> Declaring a variable immediately
> after a switch case label without a block statement is not a valid statement
> in C and usually causes a compiler error. Could this case be wrapped in a
> block to scope the variable, or the declaration be moved to the top of the
> function?
> 
> >  		*val = st->ref_uV / MILLI;
> > +		if (fract.numerator && fract.denominator)
> > +			*val = mult_frac(*val, fract.numerator, fract.denominator);
> >  		/*
> >  		 * For all LTC2378-like devices, the amount of bits that express
> >  		 * voltage magnitude depend on the polarity / output code format:
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1785186980.git.marcelo.schmitt@analog.com?part=5
