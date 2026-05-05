Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1E386C25
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979775; cv=none; b=XmrZXmWotSJipd8QaHwCAEKtDSQw1SAjsrkw06zgEXv+wkZdoRSkAKUm/BtARINV6KcQ+2DdeM+MA8+LMxBsN/cwY6Ep6Ze0Dbdpj/1lGRtzSHR5UzgtPonkB2Tqqf0YPjczc79E5sm4y6OUhY8lKRpKsRnivJLhCaut65eqWy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979775; c=relaxed/simple;
	bh=zEnyn9O8EWtILtR8fJ7RSW67bEd26Pc3WMfxRq4HB+s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRuB75wjgJLllH3rUZMGL24LAvhe2V83+WW+Uv5fg1PPtVEfcxgdJLCm2S1APdseSM2qM9W0JBSRtNKoLmWtdUvv47Y1akA3ujhNZe5RcG9lkxo6TyHys5gqWKIT5z5kx1rIZQ1qH8JY/Teeul116Wg7ZD01r1s/TQ+SOdaclcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGxVfEPK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGxVfEPK"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3030060f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 04:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777979772; x=1778584572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOwles0dUgh71i0leTKoF295WFgD8XbrkDR3tXQep4s=;
        b=HGxVfEPKPZL1RQot59y+Cozf4iuSnPgJ+RPX1GnASz53TwjNiTkjXixZwgOw9j0HFK
         VLMPcIiyqqx2wUP3RLukq9y4XL8KakePjMj4M+6n2LhfP3r/0zH77oyD6ssUZoko0bI1
         zNkcvU3A7mG2sHmID+dHr31BChfkoME1Qq/MVbrapyrQrXlfYf5b8To41R5SxKAJO03e
         tYAxOrccJNXtquQw1H6DeVTksxZbPaykqMD6UTwTC8BXlKMZY8wUFc4jVh+qrufM+0k/
         GfOQILalRxqFYn8eFwGShW+bUxRsv4vlUJyo/4jcRguu/PFG6MHCmU/vhjBmVUGg+nuj
         Q1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777979772; x=1778584572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOwles0dUgh71i0leTKoF295WFgD8XbrkDR3tXQep4s=;
        b=tI6A+Ne6U389E3YnInLpwpE33S/Lj7tFNmhsjE60KLwfFpKzmKFjIgZh1rcauYF8bd
         IzCElKJ4HhrvcehvhKHdSFy9Hc5EF+hVAj/FkbxomOpgF1nqC1vkDT+2APYvhiarnRHV
         IlFk47wiJuXqK25JVJsq912L+Bl3kImBNVNPsKepRVeLx1YuE/GFYYo7sZBB2ldcpGXS
         lU6UD+ah7gWoG/fyPOX1xwOtRmCHv8gLob9a8nuEje4ENU5JiVoC32b2I8pAXAWxxQq7
         uKmRFZdZsp4RBSbdyIJ46//D89thyDHDe1v3QrJBbGNA41krlVbileOVeBIy+eAF9GIE
         fHOA==
X-Forwarded-Encrypted: i=1; AFNElJ97yNyIV8FeICbxZxmnbcbQhfDRcghI4DjxvwGbp+gEXGucjvJg7GuBPyDoYbmJW15LahkBW6U1xik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQPLwDlVneC+0QyQ+GoYWnl+andj3xyrf7TUea/b1fsuQwT55
	TOz1ZBlEAfd1abmK5o4wotc76dwah1DggiUwmuQlDY20LxT4JnB2nrcS
X-Gm-Gg: AeBDietR0Sy74NqaNQK61xMGCqITNN9muA4xEB4ZrHRyU84oNCNNkeYJVH42dj2/xpH
	LTcav7k80zD6f/YM6ozG6wyLtsY7Pd1zY6+HNvGMgy/poVFnk4e6/QL2qsGrvD2KduHySSuOro6
	0wIvGq+MG5vbr58wa/WeyYNu/seITOf6t6gMWnXKITXHgC3OTdpZ9YKihvA8jFbkq4UmBgruwaW
	FXHNywlDZ8vSOy9GvDh8NCllZCIhsH7Uh7mIXcmg7s66Qc0ah9bZ/1EndlIOwsoHQfr92+alN2Z
	JReSY7GBXaRESea6ehM5L5HQkWEEZci12tp9jzzW9u4qUGertXve53EQWxkjTciGkpoizg3Qb1C
	qbSupoxnG/jdxvo+9SvVam8yGGzFv6PW/NpPXV0/MFtT7m5nxY83NOYH1zKqtg4S2/Ls+uo3nJp
	neWl4fL50lXgRHX8vRhXziwnPqXubKAAQtmcD/fWFeBquE6YKTAPuPOheBeLb7g93ZUogol+Qb/
	85NybjgL2auzEkt65EUGbAwGkpWbIFNptVxhYpUeUz0czethXMLFt6oZQH4
X-Received: by 2002:a05:6000:24ca:b0:43f:dd40:bbc8 with SMTP id ffacd0b85a97d-44bb52abc0cmr22358990f8f.24.1777979771966;
        Tue, 05 May 2026 04:16:11 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48b23sm4100340f8f.14.2026.05.05.04.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:16:11 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 5 May 2026 12:16:09 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>, 
	Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 03/12] iio: dac: ad5686: acquire lock when doing
 powerdown control
Message-ID: <iu6ybzwcpkforriv5fgtryzekfldddxnx5cnzpdmzdz2xll3fh@5ymrecfbtmn7>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
 <20260501-ad5686-fixes-v5-3-0b2f45488418@analog.com>
 <20260505120544.693cadf4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505120544.693cadf4@jic23-huawei>

On 26/05/05 12:05PM, Jonathan Cameron wrote:
> On Fri, 01 May 2026 10:14:56 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Protect write access of pwr_down_mode and pwr_down_mask fields with
> > existing mutex lock. Each channel exposes their own attributes for
> > controlling powerdown modes and powerdown state. This fixes potential
> > race conditions as those functions perform non-atomic read-modify-write
> > operations to those pwr_down_* fields. This issue exists since the
> > ad5686 driver was first introduced.
> > 
> > Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> https://sashiko.dev/#/patchset/20260501-ad5686-fixes-v5-0-0b2f45488418%40analog.com
> 
> Reasonable concern about possible races in the read path leading to
> -EPERM rather than simply the wrong value.
> 
> The other bit about not updating hardware is true but I think it's fine not to change
> what powerdown mode we are in whilst powered down.

True! I've seen sashiko review for this, I have a v6 ready with its feeback.
Just waiting for some more reviews (like yours). I might be sending to many new versions
for this one in a short amount of time!

  
> > ---
> >  drivers/iio/dac/ad5686.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > index 076fe8b8bd85..69358dd66cbc 100644
> > --- a/drivers/iio/dac/ad5686.c
> > +++ b/drivers/iio/dac/ad5686.c
> > @@ -39,6 +39,8 @@ static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
> >  {
> >  	struct ad5686_state *st = iio_priv(indio_dev);
> >  
> > +	guard(mutex)(&st->lock);
> > +
> >  	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
> >  	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
> >  
> > @@ -77,6 +79,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
> >  	if (ret)
> >  		return ret;
> >  
> > +	guard(mutex)(&st->lock);
> > +
> >  	if (readin)
> >  		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
> >  	else
> > 
> 

-- 
Kind regards,

Rodrigo Alencar
