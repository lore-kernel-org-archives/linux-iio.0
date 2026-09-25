Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6CB4AD7CA
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357730; cv=none; b=p50hMoZRlHBPZArLgv3y0CzH0TteEOjwlRocquMro0QcBS9O5Ih8Q5F3PXfc0F10QE1NbKCGTRAPuOBQdG8wHsrjSBOH2dAE+YxB84qPqL3QrEJErLO6CmA9E4KlKIxWPRHBoisvI0vRz0xw+2FmJxcGP+GIMYnFkzUAq5NzgDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357730; c=relaxed/simple;
	bh=fzcoyo69KXGefqxSS7X+PXbTEIdF4MESbyCrnQvBXr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfNZPa1xjEfcaoeRDvuLNNYht6dRR+VoqTgmeoTpDTmKqNzIUc+2YBpMQM4I5ZFZuG3kS6R5N7zjYan08tevfRb/BM6f8ejlPvkMFyZpN9gFr1C3WpQpcLOIg7PIHpDgKtkd5fHuliotu69e/L2HYeiUujPkdDdqoIneOEmHAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd1jQ5RN; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd1jQ5RN"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-9832c759198so618802241.3
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790357728; x=1790962528; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nej2ob9CdbG1DOfUQmIUHXKCzCnebeOZh/kYsDtKROw=;
        b=jd1jQ5RNLXOulslwVfa4fECC5p5ayy6GW+VSH/wYRKtiwr7ugBUQHRTRVla1HFWQka
         bt+wTn+kjHCLcc2q6vC3/UZe6tb5JNKkadyOYLYhJtKIUjZCoH0rSGLHk2wE/0rKGzqn
         HYGWGJF+aGC8ib/RK2PrFHko+zEA+0kubMkIlVk5d3oaQ8bCoV5ovULS/qVJkrvnOZcw
         Y0gLzqQDL1r0h6k5bk6jXZxNYja6d58NpOc55a3OessRSwmnc71mywaTmDSg1q0Xlu23
         Yvj2HSeYDfTDarXIsorgRS8vx8tcZ3CwZzPr8QZB4fogMtkZIHjaPU3J8rH0Evg/cUoB
         Bexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790357728; x=1790962528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nej2ob9CdbG1DOfUQmIUHXKCzCnebeOZh/kYsDtKROw=;
        b=GHVKe6pPXbLFNLs9hhoHNjwOo/u634Ks9ljjnHD7FGaC5I5qadeTeKDLvQ69mnnzJS
         U0t1jdZYPCYEK/PL0YfvKNJTtoOmq+DlFtdDS3i03EJH988mbnt9CJnNcyDGBPyV0nk1
         6kwtebAnMPKWzxY/OLo15tPSSO9QOo/y7EiZftYRQdM39ccHivygT2/2LNo/ZiSVmPcD
         Rdq0M+3qptYK5ypK8dEslelse+VUgEOIdIu9gfvzOjgHePHqfKAU6zBPJGDPIlgG8x2D
         Qo6vmO7vFUkZQoomz4hMsXt4PznDOU7wYzsOxFzwEmNcZTH0AUT00N+tWnk+5wqaQcUI
         gGNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwyEg2OVtI2jybAzzrcqZ3Bzk8KtMRYZpPTKHuFvQs1S1/IiYdQnfBuSExxHgf2K1M9MUOhMvqZVHs=@vger.kernel.org
X-Gm-Message-State: AFuF++kd6BL7wI9YWgr3Pq/PuUFtWU7FwjakoUv7W+XvKEQC8GMoyyGS
	xkLJc1RwFc2xy0fv3H4VD0S1zLviTA29qWdLUMmcbn5LN4FCMO2Y/L13
X-Gm-Gg: AYBFou1bQta71OVFmzHRqcEBg7WNH9oiFFV/5JNF9oQkZHoQjzBqE9iWyOclDl7QAlT
	enmKf+4xWEYZxKwLyHPARa9cGJtwlIaXKn1lNJijcw+TYo4j1H/vGrIuH3TiIWfgjYqep+1eqDP
	jNOEDee2n5AhSgBV+S8LR2I/N1wIjC+CrYn47kRnX8U/2Li9FEGwqj2DHTwazHaWqjZ+hqjMhOG
	+T9KA8X1NoDFVI8+gB5vZ2drPhzmvSRfYlYpmvfGRPZC9lvOYBDwgcHm0VSj22Qj3EEkcv6i+Sr
	5Y4DuXcSPydMVsiXGcj5DVi1oESt8N3+AhaVBjdoJ7ojgfEWc4bNytFLCHzclXss9k7tknwM93x
	CO6T+ZPbDG4dbyikxeXBQbNobMprUso46uetH3eveCTNqDD3fJFhIKSAb84qtSzZilivDdHJcAk
	Ca9YMwT665RCDvIKEErZSndzQY+P/c4lTSe7nl2FcaU2f/4yDkS/4uzUj/JcGzH8wwGy5Q4UkHV
	/9Dwl4arIFT1MT7hWsCi1u8mWxpbJt0LCP8ZOKVl3xA0aNK5FuDyLpu2nAqkawfF7YA
X-Received: by 2002:a05:6102:5613:b0:7a1:f7e2:aae3 with SMTP id ada2fe7eead31-7af1e6f3a10mr2817620137.21.1790357727527;
        Fri, 25 Sep 2026 10:35:27 -0700 (PDT)
Received: from archlinux (dynamic-190-24-104-85.dynamic.etb.net.co. [190.24.104.85])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9861afee2d2sm3436422241.6.2026.09.25.10.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 10:35:26 -0700 (PDT)
Date: Fri, 25 Sep 2026 12:35:24 -0500
From: Carlos Casadiego <cdcp206@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Carlos Casadiego via B4 Relay <devnull+cdcp206.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Olof Johansson <olof@lixom.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bmc150: check reset write error
Message-ID: <arawwqTgXBuAsX1h@archlinux>
References: <20260924-iio-bmc150-check-reset-error-v2-1-b6dc74d7aaf4@gmail.com>
 <20260925040500.0f637249@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925040500.0f637249@jic23-hlaptop>

I have not verified this on BMC150 hardware.

The datasheet documents the soft reset, but I could not find a guarantee
that the I2C write is acknowledged before the reset starts.

Given that, I agree that propagating this error could cause a regression,
so I think the patch should be dropped.

Thanks for pointing this out.

En Fri, Sep 25, 2026 at 04:05:00AM +0100, Jonathan Cameron escribió:
> On Thu, 24 Sep 2026 09:48:45 -0500
> Carlos Casadiego via B4 Relay <devnull+cdcp206.gmail.com@kernel.org> wrote:
> 
> > From: Carlos Casadiego <cdcp206@gmail.com>
> > 
> > The software reset is required to bring the device into a known
> > state before reading the chip ID.
> > 
> > Check the return value of regmap_write() and abort initialization if
> > the reset command cannot be written.
> > 
> > Fixes: 1c500840934a ("iio: accel: bmc150: reset chip at init time")
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Signed-off-by: Carlos Casadiego <cdcp206@gmail.com>
> 
> Just to check: Was this verified against actual hardware?
> 
> Quite a few devices get going on their resets before sending
> acks on i2c which means you get an error on that particular
> write.  That is often why you don't see an error check on this
> particular operation.
> 
> 
> 
> 
> > ---
> > Changes in v2:
> > - Remove the blank line in the tag block.
> > - Add Srinivas Pandruvada's Acked-by.
> > - Link to v1: https://patch.msgid.link/20260923-iio-bmc150-check-reset-error-v1-1-b8c1ebc4c947@gmail.com
> > ---
> >  drivers/iio/accel/bmc150-accel-core.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> > index 46bb36d9366e..43a39e1ccce5 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -1561,8 +1561,12 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
> >  	 * Reset chip to get it in a known good state. A delay of 1.8ms after
> >  	 * reset is required according to the data sheets of supported chips.
> >  	 */
> > -	regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
> > -		     BMC150_ACCEL_RESET_VAL);
> > +	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
> > +			   BMC150_ACCEL_RESET_VAL);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Error writing reset register\n");
> > +		return ret;
> > +	}
> >  	usleep_range(1800, 2500);
> >  
> >  	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val);
> > 
> > ---
> > base-commit: d8c0f48f0b1583308a98401c0c7b1a65d1d43a6c
> > change-id: 20260923-iio-bmc150-check-reset-error-389b096b0ad4
> > 
> > Best regards,
> > --  
> > Carlos Casadiego <cdcp206@gmail.com>
> > 
> > 
> 
