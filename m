Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505563A6B76;
	Mon,  3 Aug 2026 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785792928; cv=none; b=NoLuQDj+9cEOcfYFGB62jxOJN0CT1IP4vZJuIlhWY4ApzjTyRB2WrmFsc068UJbIRXZoujjXIOSslunMI0PvX+zVCeJ/a43IbgYEppXkPMlQDG3iNzt0yurHQ+KIqZqi2k7jZVBeEBsWvJtj/yufqVreRmf7EDzQeO4Ow2pPRDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785792928; c=relaxed/simple;
	bh=3n8w35p/3OwGPmPUiQaFDESXD458de8OjR2qWTgwxHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMyy5D0TzwfdXzmMUCS/ZLy8LRTiYwAFC2PCCHQGcjnsU6eICbt4eIXXCdt+NJm1l6MsKZiWIva9Imgbwt/kJ/wgkGK9qU6V2Q0KmRM0hJLzp6VMpfsEg7ASadCaD5PCqL//qVAYvNbw1I7RKt879ETNyusDwtkuQyybAEvPDYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jztQmdut; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jztQmdut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E041F000E9;
	Mon,  3 Aug 2026 21:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785792926;
	bh=7f5O73n5KfjKRBZf5E7ytNS+WTEwuN1FZwpn3Z4J9DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jztQmdutc+RuMSb06syMlHt82f50WUUIehYZQchj9bZnOvZt1hN1w90kQ1sVosMq5
	 6iU2PJrScfWQ5YQP6DFp2YQltrYiM6Afw/Eovc7Y7elipu9Z2bP9Jd7DBzfTqxlo51
	 p5hk2ObXHGxdTiXkH6EZK6LnIFvOjl1xgdqcxnqlttIlZG4oyLO/tNFa+Ub7H936dX
	 K+Rf/3alOiEOwtJyaeuAErhz/Fzgn0ik5t6SZPtOkZLIJQU13qJx5gWtGgLuxltcea
	 HN3E2sQSPa9CajQt/DGpdwWM3pbMB+BgBWMVXRXcO/gfr03+jPS+ZgbPQbXONUPqKR
	 EPfPPWAUQinIw==
Date: Mon, 3 Aug 2026 22:35:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: tsl2772: fix ALS calibscale readback
Message-ID: <20260803223522.7494bcc3@jic23-huawei>
In-Reply-To: <ambhLVO6CkMVzqKJ@45fec588b341>
References: <20260724-tsl2772-calibscale-fix-v1-1-00a7789f4deb@gmail.com>
	<20260727031407.44a6d201@jic23-huawei>
	<ambhLVO6CkMVzqKJ@45fec588b341>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 04:40:13 +0000
Yuanshen Cao <alex.caoys@gmail.com> wrote:

> On Mon, Jul 27, 2026 at 03:14:07AM +0100, Jonathan Cameron wrote:
> > On Fri, 24 Jul 2026 23:46:01 +0000
> > Yuanshen Cao <alex.caoys@gmail.com> wrote:
> >   
> > > The read_raw() implementation uses IIO_LIGHT to distinguish between the
> > > ambient light and proximity channels when handling
> > > IIO_CHAN_INFO_CALIBSCALE.
> > > 
> > > However, the ALS channel is registered as IIO_INTENSITY, while
> > > write_raw() correctly writes to IIO_INTENSITY. As a result, reading
> > > in_intensity0_calibscale incorrectly returns the proximity gain instead
> > > of the ALS gain.
> > > 
> > > This causes the following user-visible behavior:
> > > - Writing in_intensity0_calibscale appears to have no effect because the
> > >   readback reports the proximity gain.
> > > - Writing in_proximity0_calibscale causes both in_proximity0_calibscale
> > >   and in_intensity0_calibscale to report the same value.
> > > 
> > > Fix this by checking for IIO_INTENSITY in read_raw(), matching the
> > > channel definition and the existing write_raw() implementation.
> > > 
> > > Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>  
> > Hi,
> > 
> > Fix looks good and the explanation correct.  Was this an AI found
> > one, or did you either spot this whilst reading the code or best
> > of all saw it in practice and went looking for what is wrong?  
> 
> Hi Jonathan,
> 
> It's actually a bit of both. I first noticed the strange calibscale
> behavior while testing a device with this sensor. Since most part of
> this driver has been around for 7+ years, I wasn't expecting to find a
> bug there. I asked ChatGPT for some ideas about what might explain the
> behavior, and it pointed out the mismatch. I then went back and verified
> it, and sure enough, it turned out to be a 14-year-old bug. After that,
> I checked the rest of the file for similar issues, but this appears to
> be the only instance. Also this was tested on the device and it works
> as intended now.
> 
> > Give it is fix, what is missing is a suitable Fixes tag.
> > Please see if you can figure out what that should be.
> > No need to send a v2 unless anything else comes up in review.
> > Just reply to this thread with the Fixes tag so I'll get it
> > when I use b4 to pick up the patch  
> 
> Thanks for pointing this out.
> The missing tag is:
> 
> Fixes: 3c97c08b5735 ("iio: light: add TAOS tsl2x7x driver")

That's not the patch title. Unfortunately I missed running a
check on this and it surfaced in linux-next forcing a rebase of
the IIO tree to repair things.

It's an ancient commit and the title didn't follow modern conventions

staging: iio: add TAOS tsl2x7x driver

Anyhow fixed up now

Thanks,

Jonathan

> 
> Best,
> 
> Yuanshen (Alex) Cao
> 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/light/tsl2772.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > > index 244f44379c36..2287585711c6 100644
> > > --- a/drivers/iio/light/tsl2772.c
> > > +++ b/drivers/iio/light/tsl2772.c
> > > @@ -1274,7 +1274,7 @@ static int tsl2772_read_raw(struct iio_dev *indio_dev,
> > >  		}
> > >  		break;
> > >  	case IIO_CHAN_INFO_CALIBSCALE:
> > > -		if (chan->type == IIO_LIGHT)
> > > +		if (chan->type == IIO_INTENSITY)
> > >  			*val = tsl2772_als_gain[chip->settings.als_gain];
> > >  		else
> > >  			*val = tsl2772_prox_gain[chip->settings.prox_gain];
> > > 
> > > ---
> > > base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
> > > change-id: 20260724-tsl2772-calibscale-fix-0cc42518d5fc
> > > 
> > > Best regards,
> > > --  
> > > Yuanshen Cao <alex.caoys@gmail.com>
> > >   
> >   
> 

