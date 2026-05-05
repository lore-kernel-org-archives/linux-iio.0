Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8668417A31E
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990431; cv=none; b=NVGk4fPErTbJXWCTYNtrIitOV82QxV4t+RmMMeK4xt/k2ehuam7E/xIgRztQBkXrnuWP0r891Pq4Ae3pxapATy+1z0vcNrJw7KRUabGLdTaOU31kLOpMTlXYhbYyrpLZVVgKc7b+27+hqIzZhv9t4yw58CNuNH4ALluxub0ZCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990431; c=relaxed/simple;
	bh=pDXZxZP+Wtx3FCl39AqFXXHLJLhZp/XrLD/0Yq+JryI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbjTMzOP9akrH8esdZ7fRgJM4DgM5W7RYxfCFacrjvDCrmAOcv38CPwYg0sWb/hGe9SBRbw5be/hU4+z+azo/DXMB5kEOl4dmPj9Q7X2L/tquGCvWZNBlkzqdwbBxJEkvpqp57oKBgIqFH0g111ovBGCfIx+JoXS0/gKIX0oRbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svUjQGE5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svUjQGE5"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3159884f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777990426; x=1778595226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJUTUc037pTNpw0w6Rr8BMk5S/5WPCD7ofTDRT03+Ac=;
        b=svUjQGE5YsZKXPuf5Geo/BGfmVtLwEGumOPxahici/uMc+X9o9u1W8cr5mdZpw73M7
         msDOkbErsUnawAU8smcke58mZNbZyCYbEYCO3e5yT1x4g2NszO99WIfKk7k0wTcoTQ5u
         jaYUt+N/mqhVW4c/Uaui3IwFGu30f+VGCRBYSStybDCKyvOvrmxTOto6G1MfoC3mfhKX
         b4mB4eJKHu7jj1eHLXzz09XNX5UGI+WpYWFhx+ECXsU9t1S+Is6ES7JSyYEa2fbYEs/v
         tJ3pDYuczl3mG58S6H21rWUhYQ9oxIQCSMAYKiN5SX2O9k06YvDKZo5bpsZBLXskjesV
         CFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777990426; x=1778595226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJUTUc037pTNpw0w6Rr8BMk5S/5WPCD7ofTDRT03+Ac=;
        b=dG3xHLcdy6jnidNaLnA4K5piQ5/pl0IAWHTapzaTAyE9cSplZI/IIcOCp7x7qXfBgm
         zHO08vmqfJzbS8F9Ot3bVuLNvUhpghRJ9tM1RrvhnjhHKsifJi6HjGAqkNT/n5WdHj2O
         a32xDKnG8iGyMpw3GavhTCkx9hF5DrS63osVX8jaUXFCd5K94zXQ9p3+j0F5WXy+fiMD
         7TOl9NbLWd3gqVJQ6aVTcwifubQeNHRQWbnyz+47iJebUDGIrtY72IBPjileKSQvWlhW
         3XuEff2hCtuoTNeQyXKUGv+op1zXZ5v/GlqQ37uBueb4t2cUP5/TmOVOW3rT8Znk9pRR
         PVGw==
X-Gm-Message-State: AOJu0Ywuqeu4OeNJBVC4tJZzIXE9fb76kuefA1gAdILspf90akBjcljV
	ALBa0XOEKahJvIlpdHPLJRZsQBR9MgJaSLe70cy+UdFx4PwbWUAjNBhB
X-Gm-Gg: AeBDiesllbARm32LGfX633cmQM9w4CkieUoF5oRc1LhNHSyvWbx1hJF8jYLVGuuHdLF
	+0Cd4b7aeoPLahL1Zf5Kz99rV72qmCU8LmB9DwdCfsixU54o207wc+uDG9nuUp+h5UXug/9QWfF
	KAOD6iDqdBuS1cAH0LiUCXpR5o1zWNAqMziMnTdX2jAb/RgJtKjBDeFyft/iqtsZCu+MjIAdi0H
	1ZrnVXkbJ2PBxdgS10Y0Wu12MSfTDINKoPK/CXHpEM9SvO1KfLR7YZ+yqTAM3IMURWyS3hvriga
	LHMAtekIVQzUNo8Q+a5QoUmYGpaeblO8CHT+E1lCcZVrJVU0X1CtSwThQzJP3z6Ni1fwDS3PbJo
	QKWFQGmB4dctd0Xx0FTW330ytTdSs1zGVJzdJH0QBhmjsyK4Jcvg7M+KZ1Y77gfOrUrPwB10H5K
	RshzKizq/0M0Q2GDfKKQUg49T5k30uYh0UVsvqeST8L78LWmX/tGUz0vJrpEhFeKy3+g9akC5o6
	IjmECQlY196G6rFLbAwHPUsN1CpU211qZCAi2FRK8kYRIFy9+g2zd2iJIOUKvOALRtTbOI=
X-Received: by 2002:a05:6000:24c9:b0:43e:b0b0:629a with SMTP id ffacd0b85a97d-44bb6205f79mr27216431f8f.34.1777990425565;
        Tue, 05 May 2026 07:13:45 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a488d8sm4745495f8f.12.2026.05.05.07.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 07:13:44 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 5 May 2026 15:13:43 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Michael Auchter <michael.auchter@ni.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 09/12] iio: dac: ad5686: add helpers to handle
 powerdown masks
Message-ID: <lnoaqgoxwvnskoklp2ucjivgkbbxezm2gps62553kouhmmgkji@dozbs2qlcckn>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
 <20260505-ad5686-fixes-v6-9-c2d5f7be32be@analog.com>
 <afnt7awu2vRI8JTh@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afnt7awu2vRI8JTh@ashevche-desk.local>

On 26/05/05 04:17PM, Andy Shevchenko wrote:
> On Tue, May 05, 2026 at 01:35:10PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Add ad5686_pd_field_set() and ad5686_pd_field_get() helpers to cleanup
> > powerdown mask control. Define AD5686_PD_* constants, e.g. AD5686_PD_MSK
> > to hold powerdown mask value for a single channel. AD5686_LDAC_PWRDN_*
> > macros are replaced by AD5686_PD_MODE_*, because they are unused and the
> > LDAC feature for async load of DAC channel values is not related to power
> > down control.
> 
> ...
> 
> > +static inline void ad5686_pd_field_set(const struct iio_chan_spec *chan,
> > +				       unsigned int *pd, unsigned int val)
> > +{
> > +	unsigned int shift = ad5686_pd_mask_shift(chan);
> > +
> > +	*pd = (*pd & ~(AD5686_PD_MSK << shift)) | ((val & AD5686_PD_MSK) << shift);
> 
> Just noticed that semantically this is more like _field_modify().
> Besides that I would consider adding a shifted mask variable or definition
> 
> 
> 	*pd = (*pd & ~AD5686_PD_MSK) | ((val << shift) & AD5686_PD_MSK);

We cannot do this as the mask would depend on the shift too. AD5686_PD_MSK is
being defined with no shift, so that any shift needs to be applied at runtime.
 
> > +}
> > +
> > +static inline unsigned int ad5686_pd_field_get(const struct iio_chan_spec *chan,
> > +					       unsigned int pd)
> > +{
> > +	unsigned int shift = ad5686_pd_mask_shift(chan);
> > +
> > +	return (pd >> shift) & AD5686_PD_MSK;
> 
> 	return (pd & AD5686_PD_MSK) >> shift;
> 
> accordingly.

Same here...

> > +}
> 
> ...
> 
> > -	if (readin)
> > -		st->pwr_down_mask |= 0x3U << ad5686_pd_mask_shift(chan);
> > -	else
> > -		st->pwr_down_mask &= ~(0x3U << ad5686_pd_mask_shift(chan));
> > +	ad5686_pd_field_set(chan, &st->pwr_down_mask,
> > +			    readin ? AD5686_PD_MSK_PWR_DOWN : AD5686_PD_MSK_PWR_UP);
> 
> TBH, I would leave the if-else untouched, only branches to change.

What would be the difference compared to this:

	if (readin)
		ad5686_pd_field_set(chan, &st->pwr_down_mask, AD5686_PD_MSK_PWR_DOWN);
	else
		ad5686_pd_field_set(chan, &st->pwr_down_mask, AD5686_PD_MSK_PWR_UP);


> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Kind regards,

Rodrigo Alencar
