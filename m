Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78EB385D96;
	Mon,  6 Jul 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353221; cv=none; b=qfRKZEDC1x9JXvfWtP85+eE1vdVv6Pee81tjn2HDhC1zLMRmi4uju4BG/MRA52mvwoJaMfKoRasMlEzrjk/pMrFuTi9rXs4BcSURWbj8ZCh0keglBb3QaA94ijs8DgcJIjW5VlRMJsxBozMP3SgSUJXMvQpuyWv2Scai25kLs+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353221; c=relaxed/simple;
	bh=m8pAczPqZzLzV5qUOrBMC0I4+j3GrtcTDWm0wv/0yq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHNQFAT+UgD25NmG8UcpnlgKrhwtoZ9zTeAOzIUgwbl+dn7nWZGR+RZMgQXUGdTzMX8iNoplrbpL9XO5nCS/+Vbj3IXzZTXY0FZ2XcoFS9hqbU5dR5Ws+yl6zWNt9FFOXpZISv25wLIdtczVQg2qmrhoPhL+JTzVm5eWuSlwq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjhbMNjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjhbMNjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C221F000E9;
	Mon,  6 Jul 2026 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783353219;
	bh=fYHgoHNpxfmjqy4JzVdhf4+6aRkfpDpDVf4d+O7L9y0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MjhbMNjPQCrtH8R74tCnuIix5z4mt5NeP24+nLgHyWvzXKc5YpU7O4IrpCxx3cbk0
	 JVyXxpk/k4JAHvik70j9jte92FGZAUtI0ia5VuMYlyqKtCP7H2m1xwteZCkqxsOPFo
	 BFPVubiOr7vzBZZwi/kcDdbwJoSyP7iTrAX2jBohrSd4hkz6rz+C0qjgPQ7oPLz48X
	 VozzBmz+8H8rCS+mweyv+P071Sq4dj6iUrHDTfEEDjh1/PLD5OEmA2joa41bRHDuH3
	 xjdw5zPYo9Uxs0xO88JOqVjn1zu279mbfs2tPI4rQHqnKcYMD6Fje2DG1zga+TgY+8
	 dX1uJLoBF65jg==
Date: Mon, 6 Jul 2026 16:53:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM
 AND DRIVERS), devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: temperature: Add STS30 temperature sensor
 driver
Message-ID: <20260706165334.69846485@jic23-huawei>
In-Reply-To: <20260704205717.137c506e@linuxescape>
References: <20260621004626.66629-1-m32285159@gmail.com>
	<20260621004626.66629-3-m32285159@gmail.com>
	<20260703010532.4fc0f46b@jic23-huawei>
	<20260704144503.2347331b@linuxescape>
	<20260705000053.6e8fc3f0@jic23-huawei>
	<20260704205717.137c506e@linuxescape>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Jul 2026 20:57:17 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Sun, 5 Jul 2026 00:00:53 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sat, 4 Jul 2026 14:45:03 -0500
> > Maxwell Doose <m32285159@gmail.com> wrote:
> >   
> > > Hi Jonathan,
> > > 
> > > On Fri, 3 Jul 2026 01:05:32 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >     
> > > > On Sat, 20 Jun 2026 19:46:24 -0500
> > > > Maxwell Doose <m32285159@gmail.com> wrote:
> > > >       
> > > > > Add a driver for the Sensirion STS30 family of temperature sensor
> > > > > drivers over I2C. The STS30 family of sensors includes the STS30, STS31,
> > > > > and STS35, all of which are supported by this driver, since they all
> > > > > share the same commands, etc. and only differ in accuracy and tolerance.
> > > > > 
> > > > > The driver currently supports single-shot non-clock stretched readings,
> > > > > by using a specified delay based on the repeatability/delay specified
> > > > > by the user. The repeatability/delay can be changed at any time through
> > > > > sysfs.
> > > > > 
> > > > > Additionally add Kconfig and Makefile entries for the driver as well as
> > > > > a MAINTAINERS entry.
> > > > > 
> > > > > Signed-off-by: Maxwell Doose <m32285159@gmail.com>        
> > > > 
> > > > Big question first.  Why IIO? These are fairly basic temperature sensors
> > > > which typically means hwmon is more appropriate.  What does it need
> > > > that hwmon doesn't provide?
> > > >       
> > > 
> > > The datasheet says that the STS30 supports continuous reads which means
> > > that we can read it into a triggered buffer (which hwmon doesn't
> > > support) and at some point I'd like to implement that.    
> > 
> > Hmm. For a temperature chip that is often more about the monitors running
> > continuously than the ability to gather signals fast.  Temperature changes
> > tend to be fairly slow when it's a physical sensor - gets less obvious when
> > infrared remote sensors are involved.
> > 
> > Even more relevant - there is an existing driver I think.
> > See drivers/hwmon/sht3x.c which supports things under the wildcard sts3x as well.
> > Check if that covers this part.
> >   
> 
> I think the last time I checked the sts30 series wasn't listed in the
> dt-bindings but it may have changed since then. Oh well. I'll still go
> check it out. If it's (very very) similar I would probably consider
> dropping this one, otherwise I'll improve this one and resubmit once I
> get the hardware.
> 


Unless that other driver is for a very different part, then it is a non
starter to have a driver in IIO.  Perhaps there are features missing in
the hwmon driver though. +CC Guenter and hwmon so they are aware of
this discussion.

thanks,

Jonathan
