Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D76309DDB;
	Mon,  2 Feb 2026 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065423; cv=none; b=Ks++ZRcaXISij0aruVwrfbvQxbGo9KghGYVBPH0zSk0grScUGIWLpK3v6th6lVZnrrVFRDYpkduvkscbgEXzfzZF2g6ICq2kE+nWeYhHwc+v3YG/uDF0Sg2n57FqjbBv2xsUp8NWzm1vk2owHmz/8+6bxUD8xze3KxHCYHdHPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065423; c=relaxed/simple;
	bh=1K9FI4E1ObwdqxpHx7LiEIwfiSyDWa5czwseb70lxOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLiw3ARmbC/0h10G8RQmVQBF6gYubRgEaS97cfpjMO1+t1VdHKFBtHAgF23hyODvzV0ljQv6CIj98Ru5GxbZugz6NoVKo0b7MEGyYbtTJUQpHnayi4clbG97X+hl0xtlJfYm/gREmciRoqczzH22iV0FnurTtbeXLa0uai1rJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWMEuYN6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWMEuYN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D151C19421;
	Mon,  2 Feb 2026 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770065422;
	bh=1K9FI4E1ObwdqxpHx7LiEIwfiSyDWa5czwseb70lxOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DWMEuYN6LL7+Xs4vqeMZxI1nmYb0GyD4q6+L9W5e152Id1qWy63DEzAhJZuKhPqPB
	 14kn5L3XUXD50ZrsbuoalJeVt7b3qcQvcpb+Ovsdtid5wj++N8dusDPJ4efTiYK917
	 fT0GmdZz9JXtyCvh47fBGAPYWeWIFZq02V+joLduvLhk8ttgteWqsD51nZKsjyMn4y
	 YEXpsBuuqpn0wKmcJkl8Zc1wTlUhjqq1MBr3K4sKsSKXhkK81MhRC5OCg7T7blNihd
	 L5kCcDiS/9oDKFguV9i75Q3rh2cCoYg+O2v43QB/vZTSuKfECGsA9Gd200GEpW0Cdj
	 8UwRgABQXbE1A==
Date: Mon, 2 Feb 2026 20:50:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@kernel.org>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Frank Li <Frank.Li@nxp.com>, Adrian Fluturel
 <fluturel.adrian@gmail.com>, Carlos Song <carlos.song@nxp.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jean Delvare
 <jdelvare@suse.de>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] [v2] i3c, iio: fix i3c driver dependencies
Message-ID: <20260202205011.221c1359@jic23-huawei>
In-Reply-To: <a8f8ee55-3c87-4e9c-a5a9-12929855b86f@roeck-us.net>
References: <20260202160543.3654499-1-arnd@kernel.org>
	<a8f8ee55-3c87-4e9c-a5a9-12929855b86f@roeck-us.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Feb 2026 09:50:58 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On 2/2/26 08:04, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > All combined i2c/i3c drivers appear to suffer from the same link
> > time problem when CONFIG_I3C is set to 'm':
> > 
> > arm-linux-gnueabi-ld: drivers/iio/magnetometer/mmc5633.o: in function `mmc5633_i3c_driver_init':
> > mmc5633.c:(.init.text+0x30): undefined reference to `i3c_driver_register_with_owner'
> > 
> > This was previously fixed several times by marking individual
> > drivers as 'depends on I2C; depends on I3C || !I3C', but this gets
> > tedious and is somewhat confusing.
> > 
> > Add a Kconfig symbol 'I3C_OR_I2C' to help replace those dependencies,
> > and use this in all the existing drivers that had already fixed it
> > as well as the new mmc5633 driver.
> > 
> > Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v2: restore accidentally deleted lines
> > ---
> >   drivers/hwmon/Kconfig            |  6 ++----  
> 
> For hwmon:
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
Hi Arnd / All,

I applied a less good fix and the pull request has gone to Greg for
the IIO bug. I copied the hwmon config you have below.

So I'm absolutely in favour of this improvement but it's
probably a case of rebase after rc1 and it goes in next cycle.
Or maybe Greg could pick a rebased version up on top of char-misc-next?

So with it rebased,
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


Jonathan

> >   drivers/i3c/Kconfig              | 12 ++++++++++++
> >   drivers/iio/magnetometer/Kconfig |  2 +-
> >   drivers/misc/amd-sbi/Kconfig     |  3 +--
> >   4 files changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 41c381764c2b..ecfba861f66d 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1493,8 +1493,7 @@ config SENSORS_LM73
> >   
> >   config SENSORS_LM75
> >   	tristate "National Semiconductor LM75 and compatibles"
> > -	depends on I2C
> > -	depends on I3C || !I3C
> > +	depends on I3C_OR_I2C
> >   	select REGMAP_I2C
> >   	select REGMAP_I3C if I3C
> >   	help
> > @@ -2392,8 +2391,7 @@ config SENSORS_TMP103
> >   
> >   config SENSORS_TMP108
> >   	tristate "Texas Instruments TMP108"
> > -	depends on I2C
> > -	depends on I3C || !I3C
> > +	depends on I3C_OR_I2C
> >   	select REGMAP_I2C
> >   	select REGMAP_I3C if I3C
> >   	help
> > diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> > index 30a441506f61..626c54b386d5 100644
> > --- a/drivers/i3c/Kconfig
> > +++ b/drivers/i3c/Kconfig
> > @@ -22,3 +22,15 @@ menuconfig I3C
> >   if I3C
> >   source "drivers/i3c/master/Kconfig"
> >   endif # I3C
> > +
> > +config I3C_OR_I2C
> > +	tristate
> > +	default m if I3C=m
> > +	default I2C
> > +	help
> > +	  Device drivers using module_i3c_i2c_driver() can use either
> > +	  i2c or i3c hosts, but cannot be built-in for the kernel when
> > +	  CONFIG_I3C=m.
> > +
> > +	  Add 'depends on I2C_OR_I3C' in Kconfig for those drivers to
> > +	  get the correct dependencies.
> > diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> > index 2b81b22c9550..448fef4e5716 100644
> > --- a/drivers/iio/magnetometer/Kconfig
> > +++ b/drivers/iio/magnetometer/Kconfig
> > @@ -143,7 +143,7 @@ config MMC5633
> >   	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
> >   	select REGMAP_I2C if I2C
> >   	select REGMAP_I3C if I3C
> > -	depends on I2C || I3C
> > +	depends on I3C_OR_I2C
> >   	help
> >   	  Say yes here to build support for the MEMSIC MMC5633 3-axis
> >   	  magnetic sensor.
> > diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
> > index be022c71a90c..30e7fad7356c 100644
> > --- a/drivers/misc/amd-sbi/Kconfig
> > +++ b/drivers/misc/amd-sbi/Kconfig
> > @@ -1,10 +1,9 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> >   config AMD_SBRMI_I2C
> >   	tristate "AMD side band RMI support"
> > -	depends on I2C
> > +	depends on I3C_OR_I2C
> >   	depends on ARM || ARM64 || COMPILE_TEST
> >   	select REGMAP_I2C
> > -	depends on I3C || !I3C
> >   	select REGMAP_I3C if I3C
> >   	help
> >   	  Side band RMI over I2C/I3C support for AMD out of band management.  
> 

