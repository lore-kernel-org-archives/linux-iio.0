Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C1E31F999
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989997; cv=none; b=ErOfVHcNsPQmv2yh6I5seWbLqCDzGOsN4jKona4O1A9RvD7eI8sHYBbX379skaazwG6hKCKQktENplb29XkmLePKrAoMsCfHnWgwnFgVPMTIY3yldrNC3H2gZ8tQD+zi5XJidlEbnRf//Yy+vAHQIyZfUSAO3wzTm+ofHfioLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989997; c=relaxed/simple;
	bh=6sc7BdcESio/3bS6KTdoaUbmUT1O6gMVQgIhsJm+f18=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlZYq/TT+LAAq6pwvyJD2NnQa2h+m4ftXmC9XJ/ZBx9AtQdJjqUez3hV3LOKjApGWNXff6lj/jhWOWs+3AMVTCOD3IueSgm+H8C8qdNtnMAc2xI1G6FjufU7qK/2BJa3HxK1yjE32uqoSz2WJBZB0t9QNq70MnDx4pQj57n4pFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ogAUaVHP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogAUaVHP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ba840146so46630705e9.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777989994; x=1778594794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JPsjrMLWhTKi87oaq93cX579khTL/mpaobqofSJB08=;
        b=ogAUaVHP3q4wZ0WcxSn7Da5qUWGv6IIIvdL7DVL34b105HDfYq/iMa3/BDtgL0Jxa4
         Ff6IgrVZF9A4sVbBrONMuKNs18+GQjgE0tX2bqv8SO5r9RtTiI8RS46ycRwPZ45anL7J
         M0hUvIYwNb5hB33E+X1GLr3RfgY8W0+8+rnYsLHFPVSJ92SFscuzDAN92R14DGv9eaJe
         +Wewx90m7hMiCVtaDJiajYMi2EwyNHeuwPmsiUJaUWjnCJuH8WYtKeeI7L9stqJCSc7e
         vhyX0wXOprHUpDrPW78ToFtg5q51pgB8gGar/hbCQ4K+9zoO5jWauraDz5A6SAaySxkz
         T06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777989994; x=1778594794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JPsjrMLWhTKi87oaq93cX579khTL/mpaobqofSJB08=;
        b=P1x0sUj4lfnwqyaKtJ2hSlrkh6EjOlgQTeRDA9iNdY9WYx/Rw89vXwAO0dyo4lHErL
         Lx/qXE6qqIQ5NywRfYVk3CpnpVZ3r0MH9BLgdbvo8gLqX7ZQ41gszO9yIzgGE/LOUxJG
         pnYdVT1+7Gbk/ub5zHV/mGKN9ENXeO0b6MuZ35NlgfqaHqVSA1e89mH8NKjUNRp+hkjO
         IHubnhf+Ua8o8fdBhsT6N30N5/YdpviCvGtNTJzZkF6554KOUEtDEnDsfAtZZkafOWMg
         MuqKYcxP43z6iCKmTH6k09uHHWz1pMdvgjBjf5ZAJGwXHpi5m+GcqHvXrbJuxMVHBLbk
         RJAA==
X-Gm-Message-State: AOJu0YyODt4tvAcNktcAkm5llzcs+iy8YlLlZ6rURZAUK+YktXgCrP23
	ThwDNymQ6UjJIzef6Itg4UNUQsTvB61b0CvbSQ1Vk6V3kktCg1Iv7zdS
X-Gm-Gg: AeBDieucKKSh89Q1EkKlcXQAKKtm+GdbBXO1iC2HNQjQr4xUBB+aPQlDjpeMRLm8VIi
	Tg820stK7xTllLK+2pa+znBFQGcSOpUCuLCg/bU4gtuDzCQ/E9RjEgyru1gjYp3CwQDkbu8BC3T
	P06rsQLrFFWdORGGsDw1hFxVpoflYFy4CNYSCv4BpfuO+Ok8tkyrarMbBbEJE3I+G5yYN+Ch/1Z
	/2aeU9A4c/cRnyFb9js291tc2JxPbN/BxIc9jBZN1yb1ewTNhBQk45pZ2WEYXZwIxe8ygr0uAJO
	u134sss55+TP9oSB5qppefLuzqunMtBq/4xen0lMpmuC2AWDcEoW2O1ozZVLDWpOh4cxeyuEQHO
	caZDsF2czxYYcbfUVTosJMENYJwjB+uGfTpJ8+CZYYZ6rz8VqSX0DXhIBRHCd23yBUj1yhnFJwr
	xxb8atibnanvoArAMSGJ8XTnM5nQrWrhyAGGlN+jb2vFtkUbBKmUuZeogm5qXcYDNvUyJp6n/6A
	IRx8XLDnNbeoeR4zrwd1wPs5sH/a9mPhnIUrAnrqU9eurS44Xq/ofZ040t3
X-Received: by 2002:a05:600c:4e15:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-48d186dc89emr54856845e9.5.1777989994096;
        Tue, 05 May 2026 07:06:34 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb2f32sm358033015e9.13.2026.05.05.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 07:06:33 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 5 May 2026 15:06:31 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Michael Auchter <michael.auchter@ni.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 03/12] iio: dac: ad5686: acquire lock when doing
 powerdown control
Message-ID: <a2tm4z5urvnurh3z2ntbm7rddv6eg236gbkvtz5cididtc2rv5@skk5x6kykaij>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
 <20260505-ad5686-fixes-v6-3-c2d5f7be32be@analog.com>
 <afnpkRLOn7ZDzSj-@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afnpkRLOn7ZDzSj-@ashevche-desk.local>

On 26/05/05 03:58PM, Andy Shevchenko wrote:
> On Tue, May 05, 2026 at 01:35:04PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Protect access of pwr_down_mode and pwr_down_mask fields with existing
> > mutex lock. Each channel exposes their own attributes for controlling
> > powerdown modes and powerdown state. This fixes potential race conditions
> > as those the write functions perform non-atomic read-modify-write
> > operations to those pwr_down_* fields. This issue exists since the ad5686
> > driver was first introduced.
> 
> ...
> 
> > static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
> >  {
> >  	struct ad5686_state *st = iio_priv(indio_dev);
> >  
> > +	guard(mutex)(&st->lock);
> > +
> >  	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
> >  				       (0x3 << (chan->channel * 2))));
> 
> Why not use ad5686_get_powerdown_mode() instead?

powerdown mode != powerdown mask. The powerdown mask controls the on-off
behavior, while the mode controls the possible values for when it is off. 
 
> >  }
> 
> ...
> 
> > static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
> >  	if (ret)
> >  		return ret;
> >  
> > +	guard(mutex)(&st->lock);
> > +
> >  	if (readin)
> >  		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
> >  	else
> 
> Similar question here...

I suppose the above applies here as well.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Kind regards,

Rodrigo Alencar
