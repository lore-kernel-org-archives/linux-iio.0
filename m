Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CF04611D7;
	Wed,  6 May 2026 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086097; cv=none; b=GQO0qSbfHZrL4wpZhXL7ta3bCV99UgtaV/0Qk1FW2dC0fwHMIiG/2lqZFiba6YsO18Hx98jNqYH9EfQOIQuWsWly/VFqECZP7i3lHDfGCDIIKdrUL6694fTV+v8FCegmesTmFfJ4fOmCV1iLpuqwA1WSM6D8lQgipuXjlDw/Q1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086097; c=relaxed/simple;
	bh=Bes257Bo2NinPFfbB/IF1971qX4GftiwOxGVrsnVxDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvZor+sZyBFEAXStivYJ0qf2xc8963K5zEaG6H3xla1n1GFIbGPlZQDXb0R11DfP7zaO+yJ+fuoTqSp++BRQlWeuqIAjI4siJ87xxzIxYq5UUJ+UhVXznBnHM1KvUjkrA8eQ92SQIVsQwvnUgH3GIJZcTkERJL+yHHXhRHxjrdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU7Qfc08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU7Qfc08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823C8C2BCB0;
	Wed,  6 May 2026 16:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778086096;
	bh=Bes257Bo2NinPFfbB/IF1971qX4GftiwOxGVrsnVxDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CU7Qfc08pwieH0mC4m+iw1NpkM4xZ1HciJ4uuo37YHWfpQjG5C7cnszKkTLkfu+g6
	 +q7H8lgf26Y5xQw2bISmnOsa1MhEHGKel6jwOlpZmgOK5Y4CvdwQtwkUjHUStxmV4G
	 UMkEuUPQVX+NwUGNafabpqx9oHYbNGECsmGnPjcrVulbQezOZuieimpwVXovecA8rK
	 oqUvsG1jYzDt1lTOmKw6GhDLenxVsieCGIwv/Hqh89sozvh3p1u7Sl1xtyuXGDObdv
	 DFErC6iU5Ng2TfRGexN0wL+oi9vnPxY8n0zIHbMVKtAGfXnOKBBdmHCHXoP0LYjDWY
	 usV2kRv6LVE7A==
Date: Wed, 6 May 2026 17:48:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Maxwell Doose <m32285159@gmail.com>, Joshua Crofts via B4 Relay
 <devnull+joshua.crofts1.gmail.com@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
Message-ID: <20260506174808.06c3c1c0@jic23-huawei>
In-Reply-To: <CALoEA-xjRYTHT51_nh=jL4AOEu7Y9w+6hx=fFq_ZaMdcLfG7eg@mail.gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com>
	<DIB6Y4HLH5R6.XIP49B2XPVNC@gmail.com>
	<CALoEA-xjRYTHT51_nh=jL4AOEu7Y9w+6hx=fFq_ZaMdcLfG7eg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 09:05:39 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed, 6 May 2026 at 03:09, Maxwell Doose <m32285159@gmail.com> wrote:
> >
> > On Tue May 5, 2026 at 6:46 AM CDT, Joshua Crofts via B4 Relay wrote:  
> > > From: Joshua Crofts <joshua.crofts1@gmail.com>
> > >
> > > Add a check that ensures that valid data has been read from GPIOD. If
> > > not, log an error and return the negative read value.
> > >
> > > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > > ---
> > >  drivers/iio/magnetometer/ak8975.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> > > index 129c98c97071b4cf8efa3abf2364a3abbde129ba..b3caf5f3ebf29bf701bb214aa480fa7afb2651c6 100644
> > > --- a/drivers/iio/magnetometer/ak8975.c
> > > +++ b/drivers/iio/magnetometer/ak8975.c
> > > @@ -658,6 +658,10 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data,
> > >                                timeout_ms * USEC_PER_MSEC);
> > >       if (ret)
> > >               return ret;
> > > +     if (val < 0) {
> > > +             dev_err(&client->dev, "Error in reading GPIOD\n");
> > > +             return val;
> > > +     }
> > >
> > >       ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
> > >       if (ret < 0)  
> >
> > Small nit but I wonder if we can change:
> >
> >         if (val < 0) {
> >                 dev_err(&client->dev, "Error in reading GPIOD\n");
> >                 return val;
> >         }
> >
> > to something like:
> >
> >         if (val < 0)
> >                 return dev_err_probe(&client->dev, val, "Error in reading GPIOD\n");  
> 
> Sure, but it would go as a separate patch. Given this series is
> 18 parts long, I'd rather get the existing patches merged and
> work on this in another series. This driver still has a few shortcomings
> that should be ironed out.
> 

This doesn't look to only be called from probe.
dev_err_probe() is only meant for stuff that is.  Arguably
you could use it elsewhere but then it should have a different name.

Thanks,

Jonathan

