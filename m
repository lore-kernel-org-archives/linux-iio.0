Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF431990C7;
	Thu, 22 Jan 2026 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769091802; cv=none; b=BQwDcEhe91e6/00QcHmi4apefZerce1WQG0lUvsVQlZ5eBWjWaZ0LIULS2YFRzWHF2ABAgdOf75W/8kJ3+Rlss373bDMjBVgJOGfvDPbyI+Sy0mL+fHUavaER5X6Td2CzwYHQrK40QS1ZUiOK+af+UkGJ3puBtKyEVwQ3nT5jKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769091802; c=relaxed/simple;
	bh=ln7IA6At36MujTqs6Tf+Pr0cH8C/0oMPTb/NCVMcpis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgID9kzYvKAEkq7LxRnG0sHpkNs+jFZk1I+cFB+y+GNS4kM3pS6rkD9hUwA4Eo3P9uUftaIirsxMu12lHm0WWd6sCBOqBEbxFOZNKLJfNuXnmTt3M52uVU1Zdt3XpDErawGJHy2lqvmIKPA4UVH0bpv+X/4wTHmSFlAIHGmZNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=MqTPzCq1; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="MqTPzCq1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=l4OWvZD0QdYckL8UcRFTatggDXwenvoPYXyQIXMKnYE=; b=MqTPzCq1vbw3teNvmYQOGUg7qy
	dWtC24626u+zjv0l0aaFdfVU4vd7q7FTlyVGu8zG76KalstrgcAKGqRVurztsBfW8YyOEkvBseEnF
	kldSSiaHpkcxbvhXgKliDvnmt8LMlbEej7PU6XKihl4srCdwm2Cd+wVNhQi2k1cIyCyz88mrTOkNH
	ViuveA2GZYZnPLqk1xL7B5Kxomf1qTPfOyDRFBxn0Wb+Fs7+0DEZbTdxgBcE1Eb21KmDVyGNrXinO
	5y58miOOEAMqv0qckS4ErEKuaCLTEOInl0YkMl/wJH0Sxg+u3G9wIG0gao/xFaJN4I/7aj5dIjSjK
	xCHz5+Gw==;
Date: Thu, 22 Jan 2026 15:23:06 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>, jdelvare@suse.com, lgirdwood@gmail.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Alistair Francis
 <alistair@alistair23.me>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Subject: In-kernel hwmon read: (was: Re: [PATCH RFC 1/2] hwmon: (sy7636a)
 fix races during probe of mfd subdevices)
Message-ID: <20260122152306.6211995e@kemnade.info>
In-Reply-To: <e6c8f022-ebfc-459c-806b-f75618f65916@roeck-us.net>
References: <20250920114311.291450-1-andreas@kemnade.info>
	<20250920114311.291450-2-andreas@kemnade.info>
	<79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
	<20250920233307.0c425863@kemnade.info>
	<473e217a-c6b3-4ebc-895d-85beab50267c@sirena.org.uk>
	<20250924090023.282ae450@kemnade.info>
	<b68d40d9-6ea9-49a9-8a2e-8b899f33340d@roeck-us.net>
	<20250924195358.16bbd90c@kemnade.info>
	<e6c8f022-ebfc-459c-806b-f75618f65916@roeck-us.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 12:16:14 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > But what is the hwmon equivalent for
> > devm_fwnode_iio_channel_get_by_name() + iio_read_channel_processed()?
> >   
> 
> Assuming you refer to the exported functions for in-kernel use, so far no one has
> expressed a need for it. The best solution would probably be a hwmon->iio bridge,
> or equivalent functions could be implemented and exported.

So first analyzing the need of such an interface. I think
there is a need for such interface. The need just gets masked by some hacks
to be able to divert to other interfaces.

There is out-of-tree waiting to be upstreamed:
- rockchip_ebc driver: Display on PineNote, uses iio_read_chanel_processed()
                       in combination with an out-of-tree iio temperature
		       driver
- mxc_epdc_drm driver: Display on Kobo/Tolino ebook readers, uses
                       thermal_zone_get_temp() now.

In tree, there is:
- drivers/gpu/drm/tiny/repaper.c
  in combination with
  Documentation/devicetree/bindings/display/repaper.txt

  Code excerpt:
        if (!device_property_read_string(dev, "pervasive,thermal-zone",
                                         &thermal_zone)) {
                epd->thermal = thermal_zone_get_zone_by_name(thermal_zone);

  and thermal_zone_get_temp() to tune refreshes according to panel temperature.



The example in the binding is:
        display_temp: lm75@48 {
                compatible = "lm75b";
                reg = <0x48>;
                #thermal-sensor-cells = <0>;
        };

        thermal-zones {
                display {
                        polling-delay-passive = <0>;
                        polling-delay = <0>;
                        thermal-sensors = <&display_temp>;
                };
        };

[...]
                    pervasive,thermal-zone = "display";


I would prefer to be able to use e.g. pervasive,temperature-sensor = <&display_temp>;
or maybe <&display_temp 0> if there are multiple sensors in the same chip.
so that dtc will tell me when there is a typo and avoid the thermal
zone layer

So what are the options:
a) provide similar logic like iio/inkern.c for hwmon usage.
b) automatically add iio channels during hwmon registration.

looking at the iio_hwmon bridge we already have, it depends on
iio/inkern.c so for a  hwmon_iio bridge we need a) or b) anyways,
so I think a separate bridge device/driver has no advantages.
And having a devicetree node for the bridge would be bad because
we are then describing linux implementation details instead of
the actual hardware in the devicetree.

Regards,
Andreas
