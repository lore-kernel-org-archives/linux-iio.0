Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D552AD10;
	Sat, 31 Jan 2026 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769884935; cv=none; b=Hj4aPWbs/lcJ2aaXJ4EA/wIXjUyvW5vJvRhL9bEuv35N7Hu8v6QYaTtUAPbymSp3dN7f3X37n4Kvyob8mtCvT9MJyiWneFgSulS/S82WFENA2EXMbcBAq7euUlofC3niK3B+GbLb62XCmCGs7bHoZdb+7En5E5WvX6rKJbaqzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769884935; c=relaxed/simple;
	bh=BE+UCtllBURcItgvbm5qGeSUzv0wlY5b4O/ZU8RrWxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdFNPgp2o+lmjqfWjGVyxaijEJXhXLI9IQtoueIHJtZIYIDZ/UqyCWlC3RM7RJ2Z5EqAvgl9lqKkVxYoMgPkPXI8+PdQd5mgD5UuqbVdLuz606U20XOy56l7q3FgSXO7pIpsPEeCQCyFyzjoBsNKArm4Xg005oqaX+cJaI9PyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W07r1tpB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W07r1tpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918F4C4CEF1;
	Sat, 31 Jan 2026 18:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769884935;
	bh=BE+UCtllBURcItgvbm5qGeSUzv0wlY5b4O/ZU8RrWxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W07r1tpBvYJi2UPgFil6AgCExRIfr0g9kkMsoR2+SZgGmcHlSwGG61F8vU3Yb/AzV
	 eV1TalYF/f6FgDeiOJcsFHGrheaUOqe2VEktctpQzit6rkk7i6jaeaZbJCLs+rfGcn
	 t2m7Na2yHnYJkPkek2EdHgsqS2HFiHTq9iaVhKMzDsyeQjNlmIf5jJcg1yAnSwbDAD
	 MOaO1zfmcXXwRFnF3r7UAbl/aZ1wlcVmLvWB05V05A7AtXwNkvSJtBM7VQQHgoIr73
	 ypx15Qb66HHD45uHnr8xRAzu8xA/dmIrio++UYV8Y5KbvoaxtW0z6lNV+mdWwM0Cwh
	 trlt32deNguDA==
Date: Sat, 31 Jan 2026 18:42:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
 jdelvare@suse.com, lgirdwood@gmail.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alistair Francis <alistair@alistair23.me>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: In-kernel hwmon read: (was: Re: [PATCH RFC 1/2] hwmon:
 (sy7636a) fix races during probe of mfd subdevices)
Message-ID: <20260131184206.5859cb03@jic23-huawei>
In-Reply-To: <20260122152306.6211995e@kemnade.info>
References: <20250920114311.291450-1-andreas@kemnade.info>
	<20250920114311.291450-2-andreas@kemnade.info>
	<79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
	<20250920233307.0c425863@kemnade.info>
	<473e217a-c6b3-4ebc-895d-85beab50267c@sirena.org.uk>
	<20250924090023.282ae450@kemnade.info>
	<b68d40d9-6ea9-49a9-8a2e-8b899f33340d@roeck-us.net>
	<20250924195358.16bbd90c@kemnade.info>
	<e6c8f022-ebfc-459c-806b-f75618f65916@roeck-us.net>
	<20260122152306.6211995e@kemnade.info>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 15:23:06 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> On Wed, 24 Sep 2025 12:16:14 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > > But what is the hwmon equivalent for
> > > devm_fwnode_iio_channel_get_by_name() + iio_read_channel_processed()?
> > >     
> > 
> > Assuming you refer to the exported functions for in-kernel use, so far no one has
> > expressed a need for it. The best solution would probably be a hwmon->iio bridge,
> > or equivalent functions could be implemented and exported.  
> 
> So first analyzing the need of such an interface. I think
> there is a need for such interface. The need just gets masked by some hacks
> to be able to divert to other interfaces.
> 
> There is out-of-tree waiting to be upstreamed:
> - rockchip_ebc driver: Display on PineNote, uses iio_read_chanel_processed()
>                        in combination with an out-of-tree iio temperature
> 		       driver
> - mxc_epdc_drm driver: Display on Kobo/Tolino ebook readers, uses
>                        thermal_zone_get_temp() now.
> 
> In tree, there is:
> - drivers/gpu/drm/tiny/repaper.c
>   in combination with
>   Documentation/devicetree/bindings/display/repaper.txt
> 
>   Code excerpt:
>         if (!device_property_read_string(dev, "pervasive,thermal-zone",
>                                          &thermal_zone)) {
>                 epd->thermal = thermal_zone_get_zone_by_name(thermal_zone);
> 
>   and thermal_zone_get_temp() to tune refreshes according to panel temperature.
> 
> 
> 
> The example in the binding is:
>         display_temp: lm75@48 {
>                 compatible = "lm75b";
>                 reg = <0x48>;
>                 #thermal-sensor-cells = <0>;
>         };
> 
>         thermal-zones {
>                 display {
>                         polling-delay-passive = <0>;
>                         polling-delay = <0>;
>                         thermal-sensors = <&display_temp>;
>                 };
>         };
> 
> [...]
>                     pervasive,thermal-zone = "display";
> 
> 
> I would prefer to be able to use e.g. pervasive,temperature-sensor = <&display_temp>;
> or maybe <&display_temp 0> if there are multiple sensors in the same chip.
> so that dtc will tell me when there is a typo and avoid the thermal
> zone layer
> 
> So what are the options:
> a) provide similar logic like iio/inkern.c for hwmon usage.
> b) automatically add iio channels during hwmon registration.
> 
> looking at the iio_hwmon bridge we already have, it depends on
> iio/inkern.c so for a  hwmon_iio bridge we need a) or b) anyways,
> so I think a separate bridge device/driver has no advantages.
> And having a devicetree node for the bridge would be bad because
> we are then describing linux implementation details instead of
> the actual hardware in the devicetree.

That's always been a little controversial for the iio-hwmon
but I had quite a few discussions of the years of how to describe
this and no one ever came up with anything that worked other than
maybe pushing it to configfs and making it a usespace script problem.

Jonathan

> 
> Regards,
> Andreas
> 

