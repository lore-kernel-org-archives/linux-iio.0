Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5144B48C412
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998713; cv=none; b=pPYG+Qa/avxqp1zk1Wl+okOx9KoV9D0HfEy187T8FQCktGeR7oKVLIcSDtpqolX77sRJoF6ltO3cKoySPWOxI/ewnq4st8cvnnLz9HrTguZnO7pKPkCzMzsm5gdsBpeUmkS+bCmeTwT5D+LCk+NE714CHOmkGf3mSOLN+Kk/dWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998713; c=relaxed/simple;
	bh=rHITs/TCgO1iYRA90hY4N4lvJhv3tF9X/SbxZJuQxvk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkfeyxQDL953tyRo39IYqdakVHmH/c7Glo5KfBAmVVzWergMIenTMX6aMX7Mmu5Xf3lnBBa95tL1e9poaalZZjU0laZSMiMzXxipClfVrN2n62izxH1saNcysxIRY5ZKFXcM3r9DvA23MhlHbf02KjHSD7I8n3VLRGZH00z+QXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4o9GYqg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4o9GYqg"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ba840146so48083075e9.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777998710; x=1778603510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HmhWIV1D7jtYqS5l3aAwxlY+orL5Zgj0qVde6b+8RqM=;
        b=q4o9GYqg2gIUYrvu3/CpzfyeUPKOIqZctFDTwP6VN8ooHgGG6wxg5c2XO5xfBrLTts
         yJ+zQTaUZ1kCevqseMDET2gml32ucsmmMSuFyLWIutmgbl2ta7MBrtnNZL2pMIeUTfuu
         ObOKO6jYHPgB0r0D+KU5cOhSOvBWIbIgDKCLAMIbw5tNY7Yd2NURc/O7jOnEHVyHZ3My
         wDcQev2ppXwkHEVPt3pWt33xePOuFCOwa6MxmRzr/vxHh3WPW4+RT+qFRVfLmVNydYQg
         lNVQbceIsb+sHas8akCZwDanDeXOUKduiqgEXejOEiEt1XE4FNO7D0E+N8z+0zZG3bnq
         eGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777998710; x=1778603510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmhWIV1D7jtYqS5l3aAwxlY+orL5Zgj0qVde6b+8RqM=;
        b=IxXK6K9/6rgYgrf3hVqyygbY6x1Ha6Nv5E2NYcXS/aGC0NVCzy9jG2KEaj90OpsHey
         PRXe+CNaZc4399Tvk9uW+N5p3NZCGvXDFl2zbfvqXQ9/9mOkd0nwYY8qrGa1U/XYkg5y
         bFN6TY7ubyosWZBo5eMT7kH4o/6+uY6g1tybS0Xx50bnQ3+0uRMpKaZOJ8Gd/3/qMAQ9
         dOsH+34sOGCka7ED0z5+ZRWVF0kacdZY13mNdliHYrQmjvNfhiyiZgHvaPBf1Ewu+Fky
         ffh9j9NggsK9BA8ibm+StNKuIN535Mbl88PGm6cs6DsA8F+Sp10dhbvS9S6BDMMkJKMI
         63tQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QvaAO+C6gC8pou//r+XbWgtpYRc7peHvZZm7jb70T5NPlZyVsEPfT92Px+JrK3AQVEtlbXZqhask=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhn5aRuKu2uOJikZfsgwuBzyN7ICtw+pvBqcyRoRbMKf9Ryzd4
	fFuIxhtUUBD1OeGOuQAm9ks/fqp6GHDKCxpLnecrPxF4Uezy2ug3jNKK
X-Gm-Gg: AeBDiet5oI0ykaI0z1b8DtLIFjA8z4/I6itqoouv4To5TM04fYBQdzM+uMh5k7caId0
	vHP7v7vDPW8O5/VFrHjnhVH4zUDaWhBfZdb1WnXEK8MsYPoLCU178/B+LGeI12/0Dryc0BmIr2z
	1oZAEi8ET9/rNJDUvDgVP1xQXZFeLbNdnuJGTL4pJTE8faBn90KnFLOz1UU/7X/XBEar1Ha+fJH
	U1zvE+JyPggS/XjQESL9SRSdIDJcZHmVvXRcT8tTQFchjtLO323myHiMcwLmrUgD1ixFIURCdAa
	eyeMBt9n9Xp3hd9QYug/KlezvKkIIfHcqObZOTRYjzajwFQfvSCF7HvTTtFwTk8Y9SCH31WfrLc
	B+9uClDqTYRhg/NaPKXgXKyxnzOSMNHMiyWJ9muF8FO+yBneqz+auu1kFVwg/kLmAeuGfGVnRhk
	HaK2Mwz0pgg6icoKpgGakX5gg0rmM7WL1AXFMc4jQChdcjbBZAjupXCcmNlllrlDe1zDtsZRVxu
	JcI/JWKW/BiDW4s5zCGKoygA4Qg9gtyvJj3XzJkFIww25951acJF/cBjBDh5JTIcF3ltJs=
X-Received: by 2002:a05:600c:35c5:b0:488:a977:8d6 with SMTP id 5b1f17b1804b1-48d18be4578mr68715655e9.19.1777998710328;
        Tue, 05 May 2026 09:31:50 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48f63sm5524552f8f.16.2026.05.05.09.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:31:49 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 5 May 2026 17:31:48 +0100
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>, 
	Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Michael Auchter <michael.auchter@ni.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 09/12] iio: dac: ad5686: add helpers to handle
 powerdown masks
Message-ID: <twmplpld42lfibgcp722wgiovpe6cb4ojjadcbqtmytil5au3j@fiapntlpaboy>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
 <20260505-ad5686-fixes-v6-9-c2d5f7be32be@analog.com>
 <afnt7awu2vRI8JTh@ashevche-desk.local>
 <lnoaqgoxwvnskoklp2ucjivgkbbxezm2gps62553kouhmmgkji@dozbs2qlcckn>
 <afoMb7IJdUrifv-Q@ashevche-desk.local>
 <laxss5h3n7w6ocub46l5ju3lzbqk3dskmthrg52a73yhlgjiyp@2npdo4gce46w>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <laxss5h3n7w6ocub46l5ju3lzbqk3dskmthrg52a73yhlgjiyp@2npdo4gce46w>

On 26/05/05 04:50PM, Rodrigo Alencar wrote:
> On 26/05/05 06:27PM, Andy Shevchenko wrote:
> > On Tue, May 05, 2026 at 03:13:43PM +0100, Rodrigo Alencar wrote:
> > > On 26/05/05 04:17PM, Andy Shevchenko wrote:
> > > > On Tue, May 05, 2026 at 01:35:10PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > 
> > ...
> > 
> > > > > +static inline void ad5686_pd_field_set(const struct iio_chan_spec *chan,
> > > > > +				       unsigned int *pd, unsigned int val)
> > > > > +{
> > > > > +	unsigned int shift = ad5686_pd_mask_shift(chan);
> > > > > +
> > > > > +	*pd = (*pd & ~(AD5686_PD_MSK << shift)) | ((val & AD5686_PD_MSK) << shift);
> > > > 
> > > > Just noticed that semantically this is more like _field_modify().
> > > > Besides that I would consider adding a shifted mask variable or definition
> > > > 
> > > > 
> > > > 	*pd = (*pd & ~AD5686_PD_MSK) | ((val << shift) & AD5686_PD_MSK);
> > > 
> > > We cannot do this as the mask would depend on the shift too. AD5686_PD_MSK is
> > > being defined with no shift, so that any shift needs to be applied at runtime.
> > 
> > In my proposal I thought of
> > 
> > #define AD5686_PD_MSK(shift)	(GENMASK(...) << (shift))
> > 
> > > > > +}
> > > > > +
> > > > > +static inline unsigned int ad5686_pd_field_get(const struct iio_chan_spec *chan,
> > > > > +					       unsigned int pd)
> > > > > +{
> > > > > +	unsigned int shift = ad5686_pd_mask_shift(chan);
> > > > > +
> > > > > +	return (pd >> shift) & AD5686_PD_MSK;
> > > > 
> > > > 	return (pd & AD5686_PD_MSK) >> shift;
> > > > 
> > > > accordingly.
> > > 
> > > Same here...
> > 
> > But maybe it's over engineered, and your version is okay... Maybe we can even
> > switch to
> > field_get()/field_prep()/u32_replace_bits()/u32_encode_bits()/u32_get_bits()
> > from bitfield.h.
> 
> That is indeed better, thanks! will adjust... 

Now I see that the "over engineering" is that field_get()/field_prep() recomputes
the shift based on the provided mask, which was manually shifted. The u32_*_bits()
variants seem to rely on constant masks, as I get compile-time errors.
  
-- 
Kind regards,

Rodrigo Alencar
