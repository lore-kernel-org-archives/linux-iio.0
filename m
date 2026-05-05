Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845EB481FDF
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996249; cv=none; b=EL9rUYpKZ42dTFGBF6Q7xjZm2U7HKR1zkR3STHL2alHZL5azSeFk49WFoaabxiSt2MPjaHlaIwsawvQUPdHcG77EsnEqd90SCf+qQiW6Ys+GK3hi9HUr5o9VwEYuO+fsk9f+SwPX44VmzGhwCWensUj1gFRwkCh0Dyqu5DS/AuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996249; c=relaxed/simple;
	bh=v/hWIxhXuuNhpahNNUt6belSHmSLOQ3I6UbbwDV3Iz8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUP1LNXKXIzXdlIXkjbtjQLajiWtMfToL5fX3z6WLMn0Qp339Kqif3m9a5VsLicN1dj9qQvbAHRrbBBl3wYKuK8mGTBjqRbMDZmF/wmjQdxE94NZTnfr+aeKLwkbFuq53tsJ93MhF7pZg3RtsTCSwjhd7uQDTzIlzg+IlJYYcJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCeinrhj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCeinrhj"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so4367073f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777996246; x=1778601046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BBx0rOCkEca3p7VH/KaxdTzRXcplrDt28Gqjj9i/v0w=;
        b=bCeinrhjKJbm7mjIXFWpKmRpJq0i6spAUYfa3+R+iGZQwn0vIFrwhwcIhhth+cbP2U
         2JJEhXQ5lXcfiiuxH6kSN77oTXGx+ul+bnCssJx0rr6S/9JBqrjhdBmhyp+HNzreOih4
         Ye1eVhbOF/P/uY3R3beMozgSKJ3ILmbc6R6RFxK/kKObcU8pGFzkSrwqXLvckQRk/tId
         NtWpcRJhknWM5hOuWWOOEfVAQxaL4v7vd0rUSbwMd+/tbfs+Zb5xjiVNFcpmEWDCAHzc
         23isfPYockGT+VJS9G+EuviRdsnKrDD/5gn2mbrNW3GfHbJI+pdLVCn7d0ece2Xd5Vgs
         xl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996246; x=1778601046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBx0rOCkEca3p7VH/KaxdTzRXcplrDt28Gqjj9i/v0w=;
        b=sJ28sJ1vVpEgPYpHVEk4ZCjXIdyLceQGxfvQvVKk8Xcpc1xmsuDBW/1niIS0y9PQ3w
         XoVfZ6CMYdyIE5nC4Y13/4XJ/qLR+Fe7YqQ3yqzBqE/MGWwVLyzUV2YMUiGi55mdnEWD
         ATTEpiD4LoKqVQJlfFhAcXb7qnJd1HIu8FW+RKNvXphH3VQkyRJ2YBOgCS6ffXjOgOfY
         3KnuHVFdjRA0i+Q2HyV8zOzVU648oMIUIXnsThQutSC9Rj/mYFgG/Q/MunoU2a5fzEmr
         KuHNNtIvOX9nRMcgSmdOOgdiXYM6JAlyJdPZE/sw5UK8QZ6cDNL0H0aaGyn6TQ9hDuia
         rZBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CCYnn3TKA1oxK+X1/gLIWxk2eqHUTdSPRlLRv3u4I+65VxpY+6wGDkhZLTI/ABG/IPEajE0R3E1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/WW89BP0ndS2bMueYANkKqwVVrLnf/WaPfit88i3J4Mzp0gA
	TIjEhf43VDv9uzs0P45ChP8NkWchWcNGzZf8eiueWsyeKqUYF5KQN2Uj
X-Gm-Gg: AeBDiet21kLR7l2YtYmDy/6AGY9vyagIQQfzbKSlocDO3f5qq31mimVWW99fZLZVEIr
	hmsdwby3TIDrhocbE0wxiiJKvd1G3B1hZabYZvrhKv11n4RzPcbP9dN3DauTSOoxAqCRJO9Enrb
	y5OIUE+3bwKEwbxek1kRhGRexMUwhrYkvZokGobpI20fWTIxJo8IsluHgM7PrfCh6lxU91bmbrT
	m+FbyEKvwkkD9YD4MYOLYlY4kCLouoPsFh0826b+PQaRu7hgLnOMAmAChuZ1bAE+OfoHRDj74Mq
	83LkhbOgX13fVPCBSZpBsO6dEFON5Fc89CxIcoHflt9wkJzJnP8j952klL75ybQZIv0+h8pyVcr
	B8KgxSzuvXTKlfgTgnxhEMtaxonnwrPvs7t+pZO1LlJNXUkFzLaLLyqgVnWmjtuOzN2sC//uqQ1
	3l3Vd0kpYroCUJO8BdrMQ+L/wVl1GslNjZ8SqAPfusTq0B5m/1zDCDs4ue71S06ffCZZehOe9tc
	dImdzLaEKOr6XlmBqRZ2EsqHZYxSrDhw59Pq5to+fVKkcVPIVtimI04FmOk
X-Received: by 2002:a05:6000:228a:b0:43c:fd7e:72eb with SMTP id ffacd0b85a97d-44bb6ab1cb0mr23793271f8f.41.1777996245736;
        Tue, 05 May 2026 08:50:45 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48f63sm5294087f8f.16.2026.05.05.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:50:45 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 5 May 2026 16:50:43 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>, 
	Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Michael Auchter <michael.auchter@ni.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 09/12] iio: dac: ad5686: add helpers to handle
 powerdown masks
Message-ID: <laxss5h3n7w6ocub46l5ju3lzbqk3dskmthrg52a73yhlgjiyp@2npdo4gce46w>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
 <20260505-ad5686-fixes-v6-9-c2d5f7be32be@analog.com>
 <afnt7awu2vRI8JTh@ashevche-desk.local>
 <lnoaqgoxwvnskoklp2ucjivgkbbxezm2gps62553kouhmmgkji@dozbs2qlcckn>
 <afoMb7IJdUrifv-Q@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afoMb7IJdUrifv-Q@ashevche-desk.local>

On 26/05/05 06:27PM, Andy Shevchenko wrote:
> On Tue, May 05, 2026 at 03:13:43PM +0100, Rodrigo Alencar wrote:
> > On 26/05/05 04:17PM, Andy Shevchenko wrote:
> > > On Tue, May 05, 2026 at 01:35:10PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> ...
> 
> > > > +static inline void ad5686_pd_field_set(const struct iio_chan_spec *chan,
> > > > +				       unsigned int *pd, unsigned int val)
> > > > +{
> > > > +	unsigned int shift = ad5686_pd_mask_shift(chan);
> > > > +
> > > > +	*pd = (*pd & ~(AD5686_PD_MSK << shift)) | ((val & AD5686_PD_MSK) << shift);
> > > 
> > > Just noticed that semantically this is more like _field_modify().
> > > Besides that I would consider adding a shifted mask variable or definition
> > > 
> > > 
> > > 	*pd = (*pd & ~AD5686_PD_MSK) | ((val << shift) & AD5686_PD_MSK);
> > 
> > We cannot do this as the mask would depend on the shift too. AD5686_PD_MSK is
> > being defined with no shift, so that any shift needs to be applied at runtime.
> 
> In my proposal I thought of
> 
> #define AD5686_PD_MSK(shift)	(GENMASK(...) << (shift))
> 
> > > > +}
> > > > +
> > > > +static inline unsigned int ad5686_pd_field_get(const struct iio_chan_spec *chan,
> > > > +					       unsigned int pd)
> > > > +{
> > > > +	unsigned int shift = ad5686_pd_mask_shift(chan);
> > > > +
> > > > +	return (pd >> shift) & AD5686_PD_MSK;
> > > 
> > > 	return (pd & AD5686_PD_MSK) >> shift;
> > > 
> > > accordingly.
> > 
> > Same here...
> 
> But maybe it's over engineered, and your version is okay... Maybe we can even
> switch to
> field_get()/field_prep()/u32_replace_bits()/u32_encode_bits()/u32_get_bits()
> from bitfield.h.

That is indeed better, thanks! will adjust... 
 
-- 
Kind regards,

Rodrigo Alencar
