Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609369;
	b=jMA080xK8u07HbVUCgWXQio/pVB5+7d41uwhjPVfDrIOb19NuV01v4RsuFLhvCALwOXR
	 fZAsEueQPf/0LdxGgF39dt/56igN1c79ee4iB8DSxRkFOWrdFrmxwLmOwKvIM17yC7sAJ
	 YTTki3pBlPFuX+2cltk4fd2BkvxnD2TiuATHT0WmD9o3nsgx/dZcXsCUGRSB1NSfTnKp/
	 uzQsQRavBCb5K/fxhwErZfNjCWBTmPzlaUPldDJV4zCdYRof02Qb8JP0WbcIPfSp7d9Tb
	 WDTYGocJTuZBf/duT0wflqWXgP1Eru6kM/SuA1V98XDwT+etwoZXTz+Db88g6Zq7Gqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609369;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hPLAdvaWalGY0U9v8mXM3Qqe7MtUNRmdQjypi/WQugs=;
	b=OQEOUB/t7azYvtLbsx3XmbGFa2QD0M6Eu4quTwdII+did/0ENezDwfqm36SQfZqTqXNn
	 V2s4AAmMUx1FLe+ADeyyS7Ui/xj6H/oTBz8LofS35r2FJplAimDm8Nez2UxQzPRwDN9sU
	 aWQyaMgHQXhL72gZ63TntB+a2pmnMaPb+bVaw5qT857vjsHiYhsDg4xjUfEiebiY+vEYf
	 RtFRHfkWobo+pV936kTgRzZ30y/FeiITwadyVRofVsg85IYB1xDHLnKu6lI50gL7KrjVV
	 Tirsv7432w6vX3ot6WB10BhbmsK3gVbC/t+7t/oGmU4KYxScv78wkV+8YAmY0wQO9Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPq3zoFC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E00606A31B;
	Wed, 21 Oct 2026 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPq3zoFC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56221F000C1;
	Wed, 21 Oct 2026 19:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792609368;
	bh=hPLAdvaWalGY0U9v8mXM3Qqe7MtUNRmdQjypi/WQugs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gPq3zoFChF2SXhDhy5VXX5jOvuRBEJuKWKTS3eyog23Y3xM2wyHfTEMqZmcJULCA2
	 HxVU3GUDPpYQXAuFLpCIvgykcWwq0YZ/TppHiC0DLxN1rEo3PXhMO0OKOAGtMeGv1L
	 wjgLpgWBU2sIeT/Fxh7z1q/oRfDJs+sbvChh5O5PGzQb4WgBulFdhU3sqg824xo4ku
	 hGfqiJ8Zskc/EP1qp0wcqGna7+tOY2lPePR1en3zROoWGvlQYzSD4Xs5VpI6pADLSe
	 hofbadcH4Q8PJBkBQiyhOyETdONNUJYfbfdOuT7tgD6CzuCALdLILQ7az/+ya+7BuM
	 XLH0HUfBwsdCQ==
Date: Wed, 21 Oct 2026 20:02:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Joe Sandom
 <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin.triska@mycroftmind.com, Jan Remes
 <jan.remes@mycroftmind.com>
Subject: Re: [PATCH v2 0/4] iio: light: tsl2591: fix lux calculation and
 precision, add I2C ID table, report saturation
Message-ID: <20261021200240.774e3108@jic23-hlaptop>
In-Reply-To: <ati8u6-OUEi7KOHw@ashevche-desk.local>
References: <20261014141650.259929-1-ciakval@gmail.com>
	<atEdM6wi_FAGFjrr@ashevche-desk.local>
	<20261017031411.05dee323@jic23-hlaptop>
	<atXSBHbOPYYltHUW@mm-ntb-00805>
	<atXZwm5DzCK8S0_K@ashevche-desk.local>
	<atdRJ3JqAyGWOnxf@mm-ntb-00805>
	<athxOKkugAYL62F9@ashevche-desk.local>
	<ati5lzd2KotvmMC6@mm-ntb-00805>
	<ati8u6-OUEi7KOHw@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 16:23:07 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Oct 21, 2026 at 03:09:43PM +0200, Jan Remes wrote:
> > On Wed, 21 Oct 2026 11:00:56 +0300, Andy Shevchenko wrote:  
> > > On Tue, Oct 20, 2026 at 01:31:51PM +0200, Jan Remes wrote:  
> > > > On Mon, 19 Oct 2026 11:50:10 +0300, Andy Shevchenko wrote:  
> > > > > On Mon, Oct 19, 2026 at 10:17:08AM +0200, Jan Remes wrote:  
> > > > > > On Sat, 17 Oct 2026 03:14:11 +0100, Jonathan Cameron wrote:  
> 
> ...
> 
> > > > > > FWIW, I don't think it to be very urgent, as people probably don't use
> > > > > > it on x86-64 (seeing both as it had only DT probe support and that
> > > > > > impacted users are likely to have noticed the oops).  
> > > > >
> > > > > What do you mean by the second part of the sentence? It's as easy to use on
> > > > > ACPI platforms as on DT, we have so nice trick called PRP0001, which allows to
> > > > > enumerate "OF-only" drivers on ACPI platforms via SSDT overlays (or other means
> > > > > of DSDT/SSDT provisioning).  
> > >  
> > > > I did not know about the PRP0001 (thanks), so please disregard that
> > > > argument. Still, I believe x86 users to be few if any, since the oops is
> > > > quite easy to trigger  
> > >
> > > True.
> > >  
> > > > and AFAIK most x86 distro kernels ship without CONFIG_OF.  
> > >
> > > How is this relevant? This driver doesn't use any #ifdef CONFIG_OF or alike,
> > > so most likely the driver is available for x86 as well.  
> > 
> > I thought that CONFIG_OF was needed in order to be able to probe a
> > device using the driver's OF table. TIL that missing CONFIG_OF prevents
> > only manual probing (`echo "tsl2519 0x29" > .../new_device`) but not the
> > ACPI mechanism.  
> 
> Actually not really. The manual binding relies on i2c ID table and
> the OF ID table is a fallback.
> 
> > So:
> >   1. Please ignore that argument
> >   2. The wording of my Patch 2 commit message is not correct ("cannot
> >      be probed on a kernel with CONFIG_OF disabled"), I can send a v3
> >      if that's preferable.  
> 
> Yes, better to send a new version with better wording in the commit message.

Given we are in merge window and my base tree will be rebased shortly anyway
I don't mind the noise of dropping these.

Hence done so and will wait for v3.

Thanks,

Jonathan

> 
> > Thanks for getting me to learn a bit more.  
> 
> You're welcome!
> 

