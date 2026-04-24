Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1B739479F;
	Fri, 24 Apr 2026 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027707; cv=none; b=ZZ1mCV2+b5k4Ia/kzJPdWqJeO66RtU4r2wTsTZ8/WUSh+OsF5EHvz0Dw5jbgPUFzB2Xqu3nNzZuNMqvyhVwkWTBOTb7xTB6dwCaPFbjNwuhgzr/CSQzJcpLbCkU+/tkUSem1zRk46kpEUcIOhA8mEpOlHnUKAz/Pwi3puFWdPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027707; c=relaxed/simple;
	bh=JbsmQJpTP1XB4NCn8OA1QTwmEvFOtCz56TLousGotXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbBb1NDB4ZEuwbVTiIKK6BaZQJupP9JinmvDOSo7mQZlYB34vMFsYE6g+XPUKj2wIV1GXAgv+k2yxBmUUh2U0sY702N+MRP8qLYYT9wS87o572LddzNc2zeDw3J/41p53dMU4ZfUsUk+yDjzhboQjNbWVjo/EYoNf5+O4BMY460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiNeU8Nx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiNeU8Nx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C177EC19425;
	Fri, 24 Apr 2026 10:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027706;
	bh=JbsmQJpTP1XB4NCn8OA1QTwmEvFOtCz56TLousGotXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IiNeU8NxId15wJnBgj/7CThQklrPg9nrEtWEh/Ef4KB7KlGoRiOxJivxP33SbhT3g
	 WFFzep9QhDXMgQHTvHqlmz+6+01RiILtYZ5Rz5gqV8hCeX+qvEzSd02xVqblzMsRbO
	 +qXHiCgV9mkYdkXVCQZMybvKEHcq4NeNGNZgoTfzn2cHrY2CIwyWTjpSXmM9OOdmRb
	 p+T50rCqvCpScdZ04IWzXRA7VHEwJZoVQ/H2Z+rCJcnpMgNoigtkKAVPBKL1u/p/fx
	 cVkOA4+ABbsUJ/sf8QQcZG6i/tMme8bq3vBEuucHz2mQ2EppcPmYUrzIWmdN8faq4w
	 yyRdCfZo+5bYQ==
Date: Fri, 24 Apr 2026 11:48:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC] iio: magnetometer: mlx90393 - regmap vs command-based
 access
Message-ID: <20260424114818.1290b029@jic23-huawei>
In-Reply-To: <aepaWzVfgRFlau6L@ashevche-desk.local>
References: <20260423121834.4244-1-nikhilgtr@gmail.com>
	<20260423122535.4334-1-nikhilgtr@gmail.com>
	<aepaWzVfgRFlau6L@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Apr 2026 20:43:55 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Apr 23, 2026 at 05:55:35PM +0530, Nikhil Gautam wrote:
> > 
> > Apologies for missing a few details in the previous mail.
> > 
> > The MLX90393 supports both I2C and SPI interfaces.
> > 
> > Commands include, for example:
> > - SM (Start Measurement)
> > - RM (Read Measurement)
> > - RR (Read Register)
> > 
> > Given this command-oriented interface over both I2C and SPI,
> > I wanted to confirm whether a custom command abstraction layer
> > would still be the preferred approach instead of regmap.  
> 
> I found only 4 drivers for this vendor in the kernel and they seem
> either register based or eeprom based. Perhaps the latter is the
> case here? Have you checked existing implementations?
> 

If it doesn't match up with an existing case.

I took a look at the datasheet and this is a weird mix
of a register driven and command driven device.  As such you could
do regmap for the registers, buy you'd need to bypass that for
the command only stuff.  I don't think it's worth the mess of
creating some virtual registers to deal with the commands.

Hence I think in this particular case regmap doesn't look suitable
and a custom bus abstraction layer makes sense.  Some of that is going
to look regmap like, but with some other callbacks as well.

Jonathan
