Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5A3D9DC7;
	Tue,  2 Jun 2026 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402721; cv=none; b=s5TdRAKiK9PAh53iP19YnsOxUQOoEkb2XtfZeVia0UeDSX9KDHQMXnxvGBOyKGNnYlBCqgBeW7Fdd7RELAOnqcu7kPCP0+Hb6CQ4Md+f+WLcOjU2IxnkwDs1GVoX5hIhkvfrtt/d9CToXUHyuy3xP8eXGo5PwZ1smvbKxq0htP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402721; c=relaxed/simple;
	bh=z7JOGxH+HnsSBaqYX1QWBrmBLuqirw2iDXE3bDXzFuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iStXOkVbmLbBAavSBSLlZZIb16J3HZjEurUm1tLgpbTB2tRf0jqQXxll1kl5+TOBjnAXEJkthr6AgBUf9KlfkzH7Pi7EIh/a/+gGHUKAKoFJpgGcWRXnZBrDnhi7B4YeCEQrJLMZ30XWQP/0GvuvGPPP6VSNsxwFbQCcc99fCcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH257MTD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH257MTD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220E21F00893;
	Tue,  2 Jun 2026 12:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402719;
	bh=Ss7ojY/nLgTQfI5mOUTQBO8O5dUcKHmNe7UXFbpE0lE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lH257MTDFI6DryJ8fj8OaVA3qjmRDorOJ+bisaieFGCHqR/vDZCKcIRwLp128EY/b
	 KhdzIPUtyB0sgKGSr0A6OFsU7wUxdRUcFLEl+/oTn7A4cdNokaBHxid4CVgDcn4VPC
	 ifQ9MAnBM+9aboyuLUdZRbH54+JREtrwLO7ugWAE44tgJxUBKPdsCQc1Fx87s2FlDC
	 86oZplAZsbpP+l2sLMGR4FsL2ze7zmqAXFxbhPDt9hinIfYItwYR5hnEhT4XiG5Len
	 qt6RelxK6UFhEI8I21CPGQBd15KH/s8IKThtSRxocAtWP4nXr5zFDhveqRokBgGeGe
	 sKX08EaX3LRjQ==
Date: Tue, 2 Jun 2026 13:18:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi
 Gupta <gupt21@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: veml3328: add support for new device
Message-ID: <20260602131834.2fe5677e@jic23-huawei>
In-Reply-To: <CALoEA-xDSVOj0qkr6fYnQt0s1Xqh6acsVs7c7QKemWRaRh1i6A@mail.gmail.com>
References: <20260530-veml3328-v3-0-dd562eaee8d9@gmail.com>
	<20260530-veml3328-v3-2-dd562eaee8d9@gmail.com>
	<20260531101940.037d1d7a@jic23-huawei>
	<CALoEA-yEA5KcvXqZCCg76qFAgyNq8BQ5+gop442mju-9PiKaxg@mail.gmail.com>
	<20260601101726.203f56cd@jic23-huawei>
	<CALoEA-w8zX+bzpEfvGoafDaOr6Kd-USgsyZ6SRpV08Yw6MaVrg@mail.gmail.com>
	<CALoEA-xDSVOj0qkr6fYnQt0s1Xqh6acsVs7c7QKemWRaRh1i6A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 10:14:59 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 1 Jun 2026 at 16:43, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >
> > On Mon, 1 Jun 2026 at 11:17, Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > If you have time to figure out the path that causes that, it would be excellent
> > > to have it recorded. I spent a few minutes the other day on this and couldn't
> > > find it.  Maybe ask AI to figure it out :)  
> 
> Briefly analyzing this with AI (Gemini 3.1 Pro, just like Sashiko). I
> noticed that
> in drivers/base/dd.c the specific driver probe function is called and then
> pm_request_idle() is called after it in _driver_probe_device(), which
> is probably
> the reason the sensor is suspended after probe even though I didn't
> explicitly call
> pm_runtime_put_autosuspend() (odd that this behaviour in the actual
> driver base).

It kind of makes sense as it's basically a now you are finished, should this
be going to sleep call.  I never thought of looking there.
I did some archaeology and via 3 refactors / bug fixes that call goes all the
way back to the introduction of runtime PM 17 years ago.


> 
> To err on the side of caution, I'd add a pm_runtime_get_noresume() call before
> setting up autosuspend and a
> pm_runtime_mark_last_busy()/pm_runtime_get_autosupend()
> combo before registering the device. Technically Sashiko is correct, this isn't
> explicitly done in the driver, nevertheless the driver base actually
> handles this
> if pm_runtime is correctly set up and callbacks are defined.
> 
> Jonathan - up to you if you want to fix up the driver since it's
> already committed
> or if I should send a patch (I guess it isn't that critical, but it
> keeps Sashiko quiet
> in future patches).
It is fine as it stands - lets just keep replying to tell sashiko it is wrong
until it learns :)

Arguably we should be ripping out some of the dance that is going on in current
drivers so as to remove unnecessary complexity.  I'm nervous to do that on anything
we can't test.

Thanks for looking into this!


Jonathan

> 

