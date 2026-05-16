Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C1D1E4BE;
	Sat, 16 May 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778937101; cv=none; b=krJJEqAHlwWox4gWvgNbQIQVfCW2zkuYyH3Ln5UMf0YS8LvgxwgfTGqiLEZWiHfpXF1BtRuJ5VdmZ4Wnt15/wxvPta0vDxEMc/an8XRJ47gWX9XEuBKx/fRrzDDWe1gX0fW0IF6RZl8B2rcHDIPW10obiVpCL+9tQBmLiZHyTNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778937101; c=relaxed/simple;
	bh=u9I/5oRja+XFyukkJyue2Vfe1y+CxJ/DhqtdydujKGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvZvz9ZBvsnY4Pf1qZskh7TvKXVrWT6X2q5wFlR5WJUk1cnqzVuUmxEss423FfCsjLVZoWTUqsa5N8PQ4+izKxJ3fImdMYuE2kkzda+zN0RH40V0kRUK24mwIe8Msao2ai3zukmtl5Yk7Btmjyq06yNUO9lRc5JOTsGuTDR07Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll1aO8jb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll1aO8jb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C671CC19425;
	Sat, 16 May 2026 13:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778937100;
	bh=u9I/5oRja+XFyukkJyue2Vfe1y+CxJ/DhqtdydujKGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ll1aO8jbY7y2Gex5zRtMjJHcVJMGluf+EgmJZedqK6Bl/9TaTblrqwRzYYxeE9BtT
	 vFkmkeCU/tESFhzZ/rF7PnDuBagKOZB8tBL9fXmi5GSisUmOk30UmDJNM0tavLS8Ol
	 C1unRBccQEwVRc7DgyuwIJPa1zBhkDB8mJHfRPsQtSb9slr0grB5up9WmzQ95oMQBR
	 4+PhMuXFjH9NdufRgoKAYB46zI1pV002aLFrZY4ZvIIgDUXvi/a4sPyhxUfjeFZMzJ
	 3C+6q+MTNzg/J9ssCmk7O9zqZKVd8KbP84juM7RazbXqLXpAuuuOzbJxcB8d/UXG3N
	 ALtR26Wsg5XrQ==
Date: Sat, 16 May 2026 14:11:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi Gupta
 <gupt21@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260516141131.645e1ae0@jic23-huawei>
In-Reply-To: <agStVi6NXRnQOOOO@ashevche-desk.local>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
	<20260513-veml6031x00-v2-4-4703ca661a1d@gmail.com>
	<agStVi6NXRnQOOOO@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 19:56:54 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, May 13, 2026 at 05:49:44PM +1300, Javier Carrasco wrote:
> > These sensors provide two light channels (ALS and IR), I2C communication
> > and a multiplexed interrupt line to signal data ready and configurable
> > threshold alarms.  
> 
> Can you split this to two or more patches:
> - basic functionality
> - feature 1 (exempli gratia, IR)
> - feature 2 (exempli gratia, multiplexed interrupt)
> - ...
> 
> ?
> 
> But let's wait for Sashiko if it swallows this big slice of the pie
> and not choke on it.
> 
> ...
> 
> > +	{
> > +		.compatible = "vishay,veml6031x01",
> > +		.data = &veml6031x01_chip,
> > +	},
> > +	{
> > +		.compatible = "vishay,veml60311x00",
> > +		.data = &veml60311x00_chip,
> > +	},
> > +	{
> > +		.compatible = "vishay,veml60311x01",
> > +		.data = &veml60311x01_chip,
> > +	},  
> 
> Oh, is 'x' is a real letter in the part number or a wildcard? If the latter,
> please avoid. Choose the base part number instead.
> 
FWIW I wondered this before. It's an actual x not a wildcard.

> ...
> 
> > +static const struct i2c_device_id veml6031x00_id[] = {
> > +	{ "veml6031x00", (kernel_ulong_t)&veml6031x00_chip },
> > +	{ "veml6031x01", (kernel_ulong_t)&veml6031x01_chip },
> > +	{ "veml60311x00", (kernel_ulong_t)&veml60311x00_chip },
> > +	{ "veml60311x01", (kernel_ulong_t)&veml60311x01_chip },
> > +	{ }
> > +};  
> 
> Perhaps use C99 initialisers, as there is an activity to change all drivers to
> follow that. Jonathan, btw, what do you think we should do in the light of Uwe's
> approach? Require C99 initialisers in new code, or something else?

Require them for device_id tables so that Uwe doesn't fight a loosing battle for ever!

> 

