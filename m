Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781CF3955CD;
	Sat,  1 Aug 2026 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785625167; cv=none; b=b0arrDGzBc38QHwSzQWc2KfMdhQa06StBOJxR12uYuQ2kj8ZSU2ER2MDIZSHiHxvhIPYVo0t955uBOJA4F6IeZqm6OyoM25AxM07/ZyEKtznpSaT0uJL+Z24w4Uk57zwjgk9gxCZDJH/+plhP2CrSvtBwEK4QtSBjTB5ovq6hVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785625167; c=relaxed/simple;
	bh=0f0pkrHWiPweb5toMwM6IBYpqlC6hYwhLuFVhFuoA10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRD17y0u6tHnirV/KXhEZm4roX53XjsSXk6Dpr4uUu/cRb9jV9Pvk2mg4+/Cpj44d5P5/We3ud1wHre8GQDQLyD5M3wUfFX3taF7yvRWZEsvL4kbVRWmazM5Wy93qVeUZl/TnnPwaAUMPP6LZpi36e/P8LbXK0YzYvevCVjPFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiDLXEpX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiDLXEpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2861C1F00AC4;
	Sat,  1 Aug 2026 22:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785625166;
	bh=fGy18zbKRi3eAH+597kqk2neCAK1RDfK4wBtBEZ7IL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XiDLXEpXxHqLxMaCyv4SZrOlXEVNRauMAMzWub0VKRncWhITG8gdJxmr3BqapfjHw
	 YRC0I8MsENFJAZJoG0JIvRuLQji2izCGKpT07mxyfOD0s53aqLyP8oiUsA9IGvdwce
	 qxWGhMQcmlm1ABAVaCbQvqzOA0pmHkO2nmoa7J5evXNde/zHe5LorTlw6NuR2UCdOZ
	 CQIT8hgPTVktas1RUX3uUT2pPtnNZBtCv7WOD126YVr6D0Oq6h2gSiDTYCWACJ9Iep
	 XLb59fi2nTbLkM9i68taHCg7pt2Mhq0ZV6Y9LV3PBWkULjRH0C+v+T27fj1F9Py141
	 mEQxtcFF68Kjw==
Date: Sat, 1 Aug 2026 23:59:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Kyle Hsieh <kylehsieh1995@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
Message-ID: <20260801235920.434c7cf9@jic23-huawei>
In-Reply-To: <20260731112750.00002c37@gmail.com>
References: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
	<20260731-ti-ads112c04-driver-v2-2-aab0168c3c01@gmail.com>
	<20260731112750.00002c37@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 11:27:50 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 31 Jul 2026 10:58:25 +0800
> Kyle Hsieh <kylehsieh1995@gmail.com> wrote:
> > diff --git a/drivers/iio/adc/ti-ads112c04.c b/drivers/iio/adc/ti-ads112c04.c
> > new file mode 100644
> > index 000000000000..28d3be81934f
> > --- /dev/null
> > +++ b/drivers/iio/adc/ti-ads112c04.c  
> 
> Hi Kyle, quick review from me, comments inline. Additionally, please
> check Sashiko's review as there are some move severe issues (mostly
> I2C stuff), see it here:
> https://sashiko.dev/#/patchset/20260731-ti-ads112c04-driver-v2-0-aab0168c3c01%40gmail.com
Be careful with these.   Some may be misleading or the correct
response may be in a very different place to sashiko suggests.
For example we wouldn't typically bother to defend against nonsense
interrupt types from DT, so if level isn't a plausible type then
state what is as a comment in the DT.

Also, multi master doesn't seems like something we should worry
too much about.  That's not to say there isn't a better way to handle that
transaction.

> > +static int ads112c04_read_reg(struct i2c_client *client, u8 reg, u8 *val)
> > +{
> > +	u8 cmd = ADS112C04_CMD_RREG(reg);
> > +	int ret;
> > +
> > +	ret = i2c_master_send(client, &cmd, 1);  
> 
> i2c_master_send returns either the amount of bytes sent or an error
> code. If the device NACKs, the function will return 0 (zero bytes sent)
> but this will be interpreted as success.

This one is fun and not necessarily that simple. (I used to assume it was!)
Mostly nacks will result in error codes, but there are other obscure
reasons it might return 0.  

Anyhow, whatever the reason, agreed we annoyingly have to check these to see if
they are not 0.

Or, better, as per David's comment use the smbus command if that is possible.
> 
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = i2c_master_recv(client, val, 1);
> > +	return ret < 0 ? ret : 0;
> > +}
