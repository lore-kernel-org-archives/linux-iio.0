Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCAD3002B3;
	Wed, 29 Apr 2026 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475415; cv=none; b=UqoRpZnpBIJfl/gRVwvbuscz92HVceYUa1jqmm/fBAxZPPV5sN8SgoMaIW/fbxPjLLGMebKEMZMG9Rgi4vwkc5yi2YhDSOuFcUp/Ell6LPQd+Ux4qPX0b7EQsni+1w2pdlmHgq3XU5hTswsD4yYYulgQKy/jKJIGUAXCW9v8fDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475415; c=relaxed/simple;
	bh=P93FiFW6VZyCKViqSToebMo/KKH/uuQXANhXnHFUhUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6Mt9mwfUysWNVtvdsQPdIu5RYw7X55iKy0q2+FJcevSq1cFOcChXolRinp4c+eeHgssTIfEFj62eVmiTtwRd1l8s9714hQl8hwq+9WD805oF+lybYewiJUrhZd4FAe8nY85Fo5aFtUYw0hkb9YMDptFSvTLhJEcmQq8tRlk7cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFuWlFW/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFuWlFW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370F7C19425;
	Wed, 29 Apr 2026 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475415;
	bh=P93FiFW6VZyCKViqSToebMo/KKH/uuQXANhXnHFUhUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TFuWlFW/bfY+3Ecf3xV9l+6z6JfDh5HK0E87vsgrEvMekb8Pqtpmu6jEPnuuDGQve
	 acA/A1AjyIsl/GcuxzIlBjYgGT/YnksJquUEgAtTM775c5DUQiNwPgOuYaa1C1ylXC
	 8jnxJqtSQ62qkJe6e/ADOqEwPqr93RzJ+jjVNJ/NV2gAZTcwSk2cplVxfQayaENXYo
	 HxCV08PAvdUBK3/5nsaN3rVNTUQgd3ij3zZO/uD9ReZBGAtKlomLBY3M5JGO5QN1y2
	 ORJGbFcAmvbC/HGJDG4a+QrdrREwEgS9p5NTpCS4WNJvoXy5TF+SK5zLTzABc7F1S0
	 Xq9+GiRf1adpQ==
Date: Wed, 29 Apr 2026 16:10:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH v0 10/14] iio: magnetometer: ak8975: switch to using
 managed resources
Message-ID: <20260429161007.59d9436a@jic23-huawei>
In-Reply-To: <afIW3HuMVrmh6Jhm@ashevche-desk.local>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
	<20260427201412.3067235-11-andriy.shevchenko@linux.intel.com>
	<20260428173256.25a64370@jic23-huawei>
	<CALoEA-x5aQNs74QDRV6iQjRWQ==wVAtVGikNyCGKQMD=hkiejA@mail.gmail.com>
	<afIW3HuMVrmh6Jhm@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 17:34:04 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Apr 29, 2026 at 03:48:52PM +0200, Joshua Crofts wrote:
> > On Tue, 28 Apr 2026 at 18:33, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > On Mon, 27 Apr 2026 22:09:55 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> 
> This is combined reply to both of you.
> 
> ...
> 
> > > One day I'll have time to write up some notes on patterns that work
> > > for runtime pm + devm. I don't think think this one does - note original
> > > code didn't work either as would underflow on regulators in some paths
> > > and hence print warnings.  
> 
> > > > +static void devm_ak8975_power_off(void *data)
> > > > +{
> > > > +     ak8975_set_mode(data, POWER_DOWN);  
> > >
> > > Add a comment somewhere appropriate on what we are undoing with this.
> > >
> > > It's a 'might not be runtime suspended' at time of remove I think
> > > rather than the mode being set at that point in probe.
> > >
> > > If it is suspended, we shouldn't call the regulator disables
> > > in power_off.  So maybe gate this whole thing on
> > > whether runtime suspended.  If you do that be careful with what
> > > state we are in until runtime PM is enabled.  Maybe you already have that
> > > covered elsewhere.  
> > 
> > Okay, I'll add a pm_runtime_status_suspended() check here.  
> 
> Also check for the DPM_FLAG_SMART_SUSPEND and others first.  They might
> be helpful.
> 
> > > > +     ak8975_power_off(data);
> > > > +}  
> 
> Hmm... I thought that we have the device is on (unless SMART_SUSPEND is
> provided) during removal stage. But I think you are referring to the case
> when we call this one on the already suspended device (which is probably
> happens before managed resource tear down) and hence regulators will go
> into unbalanced state. Yeah, it would be nice to read some howto:s on
> the topic...

Exactly that - it doesn't come out of runtime suspend on unbind hence
any regulators disabled for that don't come back on line and we underflow.
My mental model of this stuff was wrong until recently as I assumed
we exited runtime suspend before entering remove, but in general that's not
the case.

> 
> > > If following comments above and below you'd need to set the state
> > > to active here.  If you go that way, make sure to add a comment to
> > > say why it is up here (and hopefully prevent someone thinking they can
> > > move it down).  
> > 
> > I'll make sure to write a comment warning others about moving the function call.
> >   
> > > > +     ret = devm_add_action_or_reset(dev, devm_ak8975_power_off, data);
> > > > +     if (ret)
> > > > +             return ret;  
> 
> Oh, true. Before accessing the device we should know what is the state of PM.
> 
> 
> > > >       /* Enable runtime PM */
> > > > -     pm_runtime_get_noresume(&client->dev);
> > > > -     pm_runtime_set_active(&client->dev);
> > > > -     pm_runtime_enable(&client->dev);
> > > > +     ret = devm_pm_runtime_set_active_enabled(dev);  
> > >
> > > This hits the race with whether we can query if the device is disabled mentioned
> > > above. Dance where we need to be able to check that before we turn runtime pm on
> > > so that we can correctly do regulator disables if we error out before here.  
> > 
> > So just do a devm_pm_runtime_enable() instead?  
> 
> This needs to be thought through...
> 
> Jonathan, do we have already examples in IIO which do something similar
> in the correct way?
We've had a few 'fixes' around this recently rather than people generally getting
it right first time.

Sean (+CC) fixed a similar case deep in this patch:

https://lore.kernel.org/all/20250909-icm42pmreg-v4-1-2bf763662c5c@geanix.com/
> 

