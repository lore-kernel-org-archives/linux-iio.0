Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C042425CF4;
	Wed,  4 Feb 2026 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222373; cv=none; b=ZWdiDw0ZBwLHPBFXwvqkbNPwL2+n/EOWF4Y3XFmjqTExcreKc0V7IWN7Fv08zSxd81mJ+IFb3C5Bzl+d44c3deSJgd9GYkZ32oYfkRI6MhrRdcdtL5IIJZrE6NmUvmndJu9HptKsJuwJqdF5vheSlwHbtRTmrhFEA7pw5BGf7Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222373; c=relaxed/simple;
	bh=fTrWVT9pxbZtXgfXRygMXbs72ofDi2/xJK4XjMBVyEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+YpKmkSq1Zlc+SpEEEs4qwv5AGczeg5a5Zs4ti073B+GBQ3GNpjDvjaZs+H3mNKuSvi63G2c29qJSvBFklFXkd8M04LE7SBtHPt+ea8Hpj/9uhvKGsq5eoTXjmSccmys+veWu6MVFJXSu5o2esl4igIfELHJxkCYqi0CpqOT+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jnRg/+VR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jnRg/+VR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C37B31A2BEA;
	Wed,  4 Feb 2026 16:26:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90D9960705;
	Wed,  4 Feb 2026 16:26:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EB73119A865B;
	Wed,  4 Feb 2026 17:26:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770222369; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zO7oO5YPmurdh89afOzZxvMCrA7qucpLwNWj2f6vSpc=;
	b=jnRg/+VRRxbmTQybzDcNAcR6hcQBW7sniRRadB9jMBTXd+uYf6SFKmgdM9R89jQ3D0aTOV
	SWCNYqsTpBt92GnXuv7eN0HdJcLJKx+2agJvuQs5kwe1GCBUeox5Y5fhGELZNNWSu037cK
	AOI1PTRpLkclBxAhhxyukyS8N3lhjAdrgy9iL48aNDAqEmznLz4s6EVcLJr6FlNW4PuoPp
	mEzXbbNZE7URuQS7c9IG5zTUoZvIT7uAp0EDsBwMGzi/H40ZlTk/ZRuGdRMyuR6et7stLN
	dOqqZoye1FHsika1ULclHifTFi/0YgCU98T+4gTvi0L34AbnHm7apc3eEDRYWA==
Date: Wed, 4 Feb 2026 17:26:04 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>,
	Carlos Song <carlos.song@nxp.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jean Delvare <jdelvare@suse.de>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] [v2] i3c, iio: fix i3c driver dependencies
Message-ID: <20260204162604f55a84b5@mail.local>
References: <20260202160543.3654499-1-arnd@kernel.org>
 <a8f8ee55-3c87-4e9c-a5a9-12929855b86f@roeck-us.net>
 <20260202205011.221c1359@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202205011.221c1359@jic23-huawei>
X-Last-TLS-Session-Version: TLSv1.3

On 02/02/2026 20:50:11+0000, Jonathan Cameron wrote:
> On Mon, 2 Feb 2026 09:50:58 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On 2/2/26 08:04, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > All combined i2c/i3c drivers appear to suffer from the same link
> > > time problem when CONFIG_I3C is set to 'm':
> > > 
> > > arm-linux-gnueabi-ld: drivers/iio/magnetometer/mmc5633.o: in function `mmc5633_i3c_driver_init':
> > > mmc5633.c:(.init.text+0x30): undefined reference to `i3c_driver_register_with_owner'
> > > 
> > > This was previously fixed several times by marking individual
> > > drivers as 'depends on I2C; depends on I3C || !I3C', but this gets
> > > tedious and is somewhat confusing.
> > > 
> > > Add a Kconfig symbol 'I3C_OR_I2C' to help replace those dependencies,
> > > and use this in all the existing drivers that had already fixed it
> > > as well as the new mmc5633 driver.
> > > 
> > > Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > v2: restore accidentally deleted lines
> > > ---
> > >   drivers/hwmon/Kconfig            |  6 ++----  
> > 
> > For hwmon:
> > 
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > 
> Hi Arnd / All,
> 
> I applied a less good fix and the pull request has gone to Greg for
> the IIO bug. I copied the hwmon config you have below.
> 
> So I'm absolutely in favour of this improvement but it's
> probably a case of rebase after rc1 and it goes in next cycle.
> Or maybe Greg could pick a rebased version up on top of char-misc-next?
> 
> So with it rebased,
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

I guess I can pick this up after rc1.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
