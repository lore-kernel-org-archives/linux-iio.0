Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64153932F4;
	Mon,  1 Jun 2026 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306713; cv=none; b=kz9Seg0sfe++s6XVIYJp2m8s6TnTDZXuH1nh3sFnbv2b7Qxq1zP5i+zSN9jzLl4mI4UMNqWEHq3HEfTKKMu3Piab9KyDOLeorxzpEu3qKS9klwL14pxRG3wKM2zOSvRlJYb7h74wB8gf1czC0e0GTDtUycGNEIGood6lHcu48rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306713; c=relaxed/simple;
	bh=F/toVsP7gp4nfChaOdJQ2soXBodt8kT0usueH2bsmiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jnl8FNWYUODWAm6G6EIzlcvGa8mMo7t536GOrbeJmHcJXR1yYHzNE9D0i8zHaLoooObnTrtiO9Ak3LICvZVeIzplkZS0wIEgItCK9iUEJDNgGcOPQ3+fcsBIAj11Cru0C1Ty2s4ne4hQnI4cUu8veUI/si/HR7cBve3SJNHLIhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfNFiOdA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfNFiOdA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6DE1F00893;
	Mon,  1 Jun 2026 09:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780306708;
	bh=wS4lU7IDK2htdAq9OV06LqI+CHr+l3AEk9EYZX2ETdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gfNFiOdAhB3dm6uXShfjXxaMQ7fITfaT506vsoFBbmV5GoFL2M8ZLnfjuNH5rpGHv
	 K5KUKORmRL5oSRDQq7hrvS300bcK9UirrfVFbJY+0R2f8LAGiN3cVcv94RL5/wJ0CI
	 snVX9wgbDDyC2Gl31hqYHHLv6KmaUW4vNa0FEIUZxsTvLOIb3wp2dIhR565xDXIaE3
	 H/HhnrrooBY1Arfc0CEzfL1SueUIzADEprIfVx3JYmqSitQfFpuHtKKMrmgO0tTolB
	 EYCU1z7nj64rJLOHnxqRy8myT62+iCJ9kTM16A8XM9WRV7AwxjDx2RuaCVPNImcn1g
	 uo9VC4VSso/Tg==
Date: Mon, 1 Jun 2026 10:38:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Wadim Mueller <wafgo01@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: flow: add Sensirion SLF3S liquid flow
 sensor driver
Message-ID: <20260601103818.69139362@jic23-huawei>
In-Reply-To: <20260531185931.1bcda47c@linuxescape>
References: <20260530205435.37326-1-wafgo01@gmail.com>
	<20260530205435.37326-4-wafgo01@gmail.com>
	<20260531185931.1bcda47c@linuxescape>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 18:59:31 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Hi Wadim,
> 
> On Sat, 30 May 2026 22:54:32 +0200
> Wadim Mueller <wafgo01@gmail.com> wrote:
> 
> > Add a driver for the Sensirion SLF3S family of digital
> > liquid-flow sensors on I2C.  Currently supported variants are
> > SLF3S-0600F, SLF3S-1300F and SLF3S-4000B; they share the same
> > register map and differ only in flow-scale factor and calibrated
> > measurement range.  The variant (and therefore the scale) is
> > auto-detected from the product-information register at probe time.
> > 
> > Each measurement frame returns a 16-bit signed flow value, a
> > 16-bit signed temperature reading and a status word, each
> > protected by a CRC-8 byte.  The driver exposes the flow rate as
> > IIO_VOLUMEFLOW and the temperature as IIO_TEMP via the standard
> > IIO read_raw / read_scale interface.
> > 
> > The active calibration medium can be switched at runtime between
> > the factory-calibrated water and isopropyl-alcohol modes via the
> > in_volumeflow_medium sysfs attribute; the sensor starts in water
> > mode after probe.
> > 
> > This driver also creates the drivers/iio/flow/ subdirectory and
> > the corresponding Kconfig/Makefile glue.
> > 
> > Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> > ---
> >  drivers/iio/Kconfig       |   1 +
> >  drivers/iio/Makefile      |   1 +
> >  drivers/iio/flow/Kconfig  |  27 +++
> >  drivers/iio/flow/Makefile |   7 +
> >  drivers/iio/flow/slf3s.c  | 406 ++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 442 insertions(+)
> >  create mode 100644 drivers/iio/flow/Kconfig
> >  create mode 100644 drivers/iio/flow/Makefile
> >  create mode 100644 drivers/iio/flow/slf3s.c
> >  
> 
> Nice code. Just have a couple of questions (+sashiko has some concerns
> as well).
> 
> [snip]
> > +/*
> > + * Read the product-info block and pick the matching variant.  The
> > + * sub-type byte returned by the sensor is the source of truth; a
> > + * DT-supplied compatible only seeds an initial guess and is overridden
> > + * on mismatch (with an informational message so misconfigured device
> > + * trees are easy to spot).
> > + *
> > + * Bus / CRC failures are real errors and fail probe.  An unknown
> > + * sub-type byte fails probe too: we cannot publish a meaningful scale
> > + * without a matching entry in slf3s_variants[].
> > + */
> > +static int slf3s_detect_variant(struct slf3s_data *sf)
> > +{
> > +	struct i2c_client *client = sf->client;
> > +	u8 buf[SLF3S_PRODUCT_ID_LEN];
> > +	int ret;
> > +
> > +	ret = slf3s_send_cmd(client, slf3s_cmd_prep_pid);
> > +	if (ret)
> > +		return ret;  
> 
> Here sashiko said:
> 
> "If the system goes through a warm reboot or kexec, won't the sensor
> still be running in continuous measurement mode since there is no
> .shutdown callback? If the sensor is actively measuring, will it NACK
> the 'read product ID' command sent here and cause the probe to
> unconditionally fail? Should a stop measurement command be sent before
> trying to read the product ID?"
> 
> Was looking and didn't find a shutdown callback, so you'll probably
> want to add that.

It's a fair question from sashiko as seems a stop command or reset is
needed to break out of that mode and let other commands function.

There is the option of a soft reset which might make sense to implement
in probe() but it's an odd one as it's a general call (so may affect
other devices on the same bus).

Given we can never know what silly mode some other software has left
the device in, we'd normally reset (but here probably can't due
to the reset addressing all devices on the bus), we can however
just issue a stop command in probe()  I think I'd prefer that to
shutdown()  Note I couldn't find a statement that says stop can
be issued when not running continuous mode.  So test that and see.
Hopefully it's a no-op!




> 
> > +     ret = slf3s_send_cmd(client, slf3s_cmd_read_pid);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = i2c_master_recv(client, buf, sizeof(buf));
> > +     if (ret < 0)
> > +             return ret;
> > +     if (ret != sizeof(buf))
> > +             return -EIO;
> > +
> > +     for (unsigned int i = 0; i < SLF3S_PRODUCT_ID_LEN; i += 3) {
> > +             if (!slf3s_crc_valid(sf, &buf[i]))
> > +                     return -EIO;
> > +     }
> > +
> > +     if (buf[SLF3S_PRODUCT_FAMILY_BYTE] != SLF3S_PRODUCT_FAMILY_ID)
> > +             dev_info(&client->dev,
> > +                      "unexpected family byte 0x%02x (expected 0x%02x)\n",
> > +                      buf[SLF3S_PRODUCT_FAMILY_BYTE],
> > +                      SLF3S_PRODUCT_FAMILY_ID);  
> 
> This feels like something that could be dev_warn() to me (if it's
> unexpected then it means it probably shouldn't happen!)

This is about fallback compatibles - it is absolutely expected to
happen in the future (assuming this company doesn't feel the need
to keep inventing new control schemes for every device released!)
dev_info() is fine.

> 
> > +
> > +     for (unsigned int i = 0; i < ARRAY_SIZE(slf3s_variants); i++) {
> > +             if (buf[SLF3S_PRODUCT_SUBTYPE_BYTE] !=
> > +                 slf3s_variants[i].sub_type)
> > +                     continue;
> > +
> > +             if (sf->variant && sf->variant != &slf3s_variants[i])
> > +                     dev_info(&client->dev,
> > +                              "DT compatible says %s but sensor reports %s; using %s\n",
> > +                              sf->variant->name,
> > +                              slf3s_variants[i].name,
> > +                              slf3s_variants[i].name);  
> 
> Same here, if the DT says it should be x and we get y, then that also
> feels like something that shouldn't have happened.

Agree on this one.

> 
> > +
> > +             sf->variant = &slf3s_variants[i];
> > +
> > +             return 0;
> > +     }
> > +
> > +     dev_err(&client->dev, "unknown SLF3S sub-type 0x%02x\n",
> > +             buf[SLF3S_PRODUCT_SUBTYPE_BYTE]);
> > +
> > +     return -ENODEV;
> > +}  
> 
> [snip]
> 
> > +
> > +static struct i2c_driver slf3s_driver = {
> > +	.driver = {
> > +		.name		= "slf3s",
> > +		.of_match_table	= slf3s_of_match,
> > +	},
> > +	.probe		= slf3s_probe,
> > +	.id_table	= slf3s_id,
> > +};  
> 
> Sashiko said:
> 
> "Since the driver lacks power management operations, what happens when
> the system suspends and resumes?
> If power is cut to the sensor during suspend, won't it reset to the IDLE
> state and cause subsequent IIO reads to fail because the driver never
> re-issues the start command? Or if power isn't cut, will leaving it
> actively measuring waste power?"
> 
> Which it has some good points, you'll just have to issue a start
> command once the system is back from suspend.

For IIO drivers, we normally consider power management a 'feature'
that can be added later. Sure kooky things can happen if it's not
there and the 'feature' is used. That might mean you have to rebind
the driver.  If a platform cuts the power to a device with a driver
that doesn't know it can happen, then it is broken at a higher level.

> 
> I'd say it's very close, but please address those comments from
> sashiko (also you don't have to take my advice on the dev_warn()
> stuff, I'll be honest I haven't written a driver from scratch yet!)

> 

