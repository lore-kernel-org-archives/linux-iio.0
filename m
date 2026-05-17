Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1817F29D291
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779028898; cv=none; b=aiBu05UC3sYcZ8uKFDZDxpB/bUlIxuhSy8MdV7QbvliU8V7jcPWvSB3p6rk7fYIwvuPUzshXNZNlBDKOGYXMWE1ZCnqkeSpQDKgWZtFamttQlJ/KxcmLX0iCtmJpvn0+LhWITUoSUFmvXEO/LCYw4wX2O18+BLvAx9ljG4UUxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779028898; c=relaxed/simple;
	bh=ndan6G/ZsGabCsiQWkiLyAnPAj3IaOc48hKTkWHgFpU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n06kflAsmJDomqLFMaT+Ya2YFYvx/CPBQzJ0Dwgfkvc8niqQ1w59aHIehAXYJUKZ1YMeQy/u8Hrk2LTFcPKwGG4Zgu9sQWyRkTzIsZNVh2p4dBOvAVzLWgt+tkUTaO+3T9WPb8bqMiT3pmW09/1zdTSeT3Noah+kZmJCCO3GGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVDYeacE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVDYeacE"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4585a116a4aso1086944f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779028895; x=1779633695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P5tOT+2lq91gtrvoC5yl7qwwyFGywyyVSTNDESsyqjw=;
        b=WVDYeacEfmFNnEuCPT8BRpPSPUDi696T6izO9Juduuudfdy6LxfabmxQs8861fuSmy
         ICyhbgXCJxSvbluLNaA28AJ+9gJJcFdjBfIvdRYVK5dr+HOESrAYb4P5ol1DdOd13X98
         DlAs+dQq6DDmGnmEOwuxJ1xGBarZCOInOJrJ/DmiPXV61urwzlgWK038GnuJkpcMn+SF
         UrYeQETKfey+USzfpZaj0Mm+Cj6bmrQGHXLbZMSBIPcVGV0xxIwIijmxizJnXfIs+/Lz
         Bh1QQ1ROVuUNaWiHNZkLCsJajCDiTOUe3kETQ7qsS6IDh699Hz0LaReXnxzrVdUkhfbP
         bKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779028895; x=1779633695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5tOT+2lq91gtrvoC5yl7qwwyFGywyyVSTNDESsyqjw=;
        b=BYFmvWfIdF+HiYOpWCEY+DzIQhGhQ+0kJncZPyXMIA/nUUFCmYFpOtMoFNQpV9/gqy
         2K2RCci/dEtRcroy9slQXk68iOKYJMqoBM/UL23APWIKA98WtkKqdBRh3oGfZEetRNQw
         dJiEUfvGd67nBm+QNCc75sKrHLmj2N9IU6sxLh/IdcFaRW03ZrwgF21mmf7NJ8cvRe2e
         COyWHssGVBOVOMIlONZPU/SkJm6Mbnj0HAIaGqmP7w4wp5ItC6U16gSnecqLTdduXQN/
         B5EdgG0TKcEQvKaeiShMbXJW0Yut9HC1ekf7ufxo98252y+CXcC5VJeQRV/v26c+NZnf
         oq4g==
X-Forwarded-Encrypted: i=1; AFNElJ/qdEy9154WADayVGSn2uFHY852Po2UVgk4+qCxXuOGIa1JU3zcYp21YUxzpcUcehukzjLLIhErheU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyeczeGS6s0uA++XUC548LNOzi7TAWujB0xGzagjOIl/r3I+PC
	Dkc1028x8vkirnt7MP6zWRU0RJkBDHDjk3bRIyOT5D0b3vY9Qx5I8esf
X-Gm-Gg: Acq92OF9HG46cvK1Tmgx1YHrmbsHlIGHjTLfY40UOLrxTArltzsKgQSU2903cfFNee+
	xOmNQkDqCvO3Qr4XBBGBNCpSxAo4ggMn06roZkmnpjoHxmmYZt5rNYvq98YzIswZmglCfhgVDcy
	0Chb9H5OYiM3OYG1BXvffcR96RXsUWJ91dN4+01jOvmAav2/a+0vahrcBSp4LJJ71KsVTEhajjQ
	M+t6U4OUXeNRhuEBm6qddgAuM7/lf1SImJyHi+uG65nh7B+FjcJxE+VQYDa9aUZIO32Cfbh3U36
	T8sUy5LNzKrmvSvk8jOm+kp+GB7hkLv7x96wwGU4Ay97HHRKLOIF2FG33IhTgUSFm2kluCdVGT4
	5/6AizOISIPxT8hnPJzaviwIV5JacuL3UPYJyOrbHSQTbyhQyt+U331eCF76iELBO+MmGuu/aH5
	1+eUJoif2c2KhCrSK/s334XknqlNJ7kIjPsqNzp5r+9uKPgSBDrCTHAvukFgQwN6/5QoDgV2+i8
	06Oyq1NB/ULYilpjvpBb5RGb7NIRfyk5sj+IaQU5MIiGQllMg==
X-Received: by 2002:a05:6000:40cd:b0:439:c62a:6dc2 with SMTP id ffacd0b85a97d-45e5c5ddd3dmr17668117f8f.41.1779028895308;
        Sun, 17 May 2026 07:41:35 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17ec2sm27560778f8f.24.2026.05.17.07.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:41:34 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 17 May 2026 15:41:33 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Michael Auchter <michael.auchter@ni.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 09/12] iio: dac: ad5686: add helpers to handle
 powerdown masks
Message-ID: <su2bgtiwlopfatfedwdllm77mtq7ojl247saosvfeaxukz6zxs@xsxmy6oaoq4m>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
 <20260505-ad5686-fixes-v6-9-c2d5f7be32be@analog.com>
 <afnt7awu2vRI8JTh@ashevche-desk.local>
 <lnoaqgoxwvnskoklp2ucjivgkbbxezm2gps62553kouhmmgkji@dozbs2qlcckn>
 <afoMb7IJdUrifv-Q@ashevche-desk.local>
 <laxss5h3n7w6ocub46l5ju3lzbqk3dskmthrg52a73yhlgjiyp@2npdo4gce46w>
 <twmplpld42lfibgcp722wgiovpe6cb4ojjadcbqtmytil5au3j@fiapntlpaboy>
 <20260517152518.2520de8d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517152518.2520de8d@jic23-huawei>

On 26/05/17 03:25PM, Jonathan Cameron wrote:
> On Tue, 5 May 2026 17:31:48 +0100
> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> 
> > On 26/05/05 04:50PM, Rodrigo Alencar wrote:
> > > On 26/05/05 06:27PM, Andy Shevchenko wrote:  
> > > > On Tue, May 05, 2026 at 03:13:43PM +0100, Rodrigo Alencar wrote:  
> > > > > On 26/05/05 04:17PM, Andy Shevchenko wrote:  
> > > > > > On Tue, May 05, 2026 at 01:35:10PM +0100, Rodrigo Alencar via B4 Relay wrote:  
> > > > 
> > > > ...
> > > >   
> > > > > > > +static inline void ad5686_pd_field_set(const struct iio_chan_spec *chan,
> > > > > > > +				       unsigned int *pd, unsigned int val)
> > > > > > > +{
> > > > > > > +	unsigned int shift = ad5686_pd_mask_shift(chan);
> > > > > > > +
> > > > > > > +	*pd = (*pd & ~(AD5686_PD_MSK << shift)) | ((val & AD5686_PD_MSK) << shift);  
> > > > > > 
> > > > > > Just noticed that semantically this is more like _field_modify().
> > > > > > Besides that I would consider adding a shifted mask variable or definition
> > > > > > 
> > > > > > 
> > > > > > 	*pd = (*pd & ~AD5686_PD_MSK) | ((val << shift) & AD5686_PD_MSK);  
> > > > > 
> > > > > We cannot do this as the mask would depend on the shift too. AD5686_PD_MSK is
> > > > > being defined with no shift, so that any shift needs to be applied at runtime.  
> > > > 
> > > > In my proposal I thought of
> > > > 
> > > > #define AD5686_PD_MSK(shift)	(GENMASK(...) << (shift))
> > > >   
> > > > > > > +}
> > > > > > > +
> > > > > > > +static inline unsigned int ad5686_pd_field_get(const struct iio_chan_spec *chan,
> > > > > > > +					       unsigned int pd)
> > > > > > > +{
> > > > > > > +	unsigned int shift = ad5686_pd_mask_shift(chan);
> > > > > > > +
> > > > > > > +	return (pd >> shift) & AD5686_PD_MSK;  
> > > > > > 
> > > > > > 	return (pd & AD5686_PD_MSK) >> shift;
> > > > > > 
> > > > > > accordingly.  
> > > > > 
> > > > > Same here...  
> > > > 
> > > > But maybe it's over engineered, and your version is okay... Maybe we can even
> > > > switch to
> > > > field_get()/field_prep()/u32_replace_bits()/u32_encode_bits()/u32_get_bits()
> > > > from bitfield.h.  
> > > 
> > > That is indeed better, thanks! will adjust...   
> > 
> > Now I see that the "over engineering" is that field_get()/field_prep() recomputes
> > the shift based on the provided mask, which was manually shifted. The u32_*_bits()
> > variants seem to rely on constant masks, as I get compile-time errors.
> 
> I still have these stalled on the fixes making it up stream (and into an rc)
> but in meantime can you confirm that I read this right and plan is leave this
> patch as it stands?

Yeah, I suppose we would not need to use field_get()/field_prep() because
they recompute the shift based on the mask, but we already create the mask
from the shift. I think the helpers are clear enough and there is no
real benefit on the change.

-- 
Kind regards,

Rodrigo Alencar
