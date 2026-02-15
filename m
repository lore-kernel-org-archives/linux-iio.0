Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFD22424C;
	Sun, 15 Feb 2026 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771171247; cv=none; b=NuoMxgMPIReQyluK6SjiaAHLq1LtjozEeMy1/rU3K62E7j8eD5HiUQuPnA8q4cn6WFb9jLGVxU/48AvNL/fhuWXpizIk1/auEib4Jzkys/VLDSgmm7vJ7048P4rQ7WOfkLwwg/irLD694Ckn81MhER9egynp+LzRIsWFvwA+cjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771171247; c=relaxed/simple;
	bh=hyEyIbObCiR2khXNIZhUj0EyGgpdZcMflaxCDh4CgaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cn5+oC6MJ+oo50GZGQLdAZB60msBN0arlzwwRV5fS5/KqR7WCge9LCQLnEdCIkZjTIPJJYD6tgUD85PN3MrGMvmgdcbGGAsOi+V1nL1yeeixoe3/FSpNXQ+tQ4d7NxCLo3K9eUtxgYjZpIGyz5yvrlgjw3fXVwRraqkqJmF8mnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjOzalwd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjOzalwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B742C4CEF7;
	Sun, 15 Feb 2026 16:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771171247;
	bh=hyEyIbObCiR2khXNIZhUj0EyGgpdZcMflaxCDh4CgaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JjOzalwdGSo0nvqHJr4xacv86kLY1fivI2Dcevcf8c9HlEQ15uM1Qy3woEyaGEWbr
	 yfIxgtI5lrv9+XPIym6NqZEtK3LKN1CGUYdZFLkDzyrhBSN4YahiX/O+ak0lCcXhYk
	 JXbhFrkg0bvb1hz4rFe047ZTwkUSY6eHQp8n9PjarkAHmmCpSSzpnF5zOo4E0yrSnt
	 8qBjYxTsbhS3fHHcT0X9UQBK4ODpo0pWj22vbs9YW/PEKSbhJrOjMe88BLxXlIk5sI
	 gxcdBefn5ChRouwC6YFCb0AWSVuxfy1fPd3TKu0zGtiauLr6GosCwzoE3/uPcwImG5
	 uh/WmXf7KxV5w==
Date: Sun, 15 Feb 2026 16:00:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: max5522: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <20260215160039.13632367@jic23-huawei>
In-Reply-To: <aZF7ZCA2wQeD7iCs@smile.fi.intel.com>
References: <20260210175137.44178-1-antoniu.miclaus@analog.com>
	<aYuIftCDo5O0IF9F@smile.fi.intel.com>
	<20260214182052.14c6f8ee@jic23-huawei>
	<aZC_ab454PTqFPsO@smile.fi.intel.com>
	<ea759fc8-6664-4838-872b-c393424e4cf4@baylibre.com>
	<aZF7ZCA2wQeD7iCs@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Feb 2026 09:53:08 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Feb 14, 2026 at 12:36:12PM -0600, David Lechner wrote:
> > On 2/14/26 12:31 PM, Andy Shevchenko wrote:  
> > > On Sat, Feb 14, 2026 at 06:20:52PM +0000, Jonathan Cameron wrote:  
> > >> On Tue, 10 Feb 2026 21:35:26 +0200
> > >> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > >>> On Tue, Feb 10, 2026 at 07:51:27PM +0200, Antoniu Miclaus wrote:  
> 
> ...
> 
> > >>>> +	state->vref_mv = ret / 1000;    
> > >>>
> > >>> "1000" --> "(MICRO / MILLI)" ?
> > >>> (yes, this way with the parentheses).  
> > >>
> > >> I know I've argued against proliferation of the X_PER_Y macros
> > >> but this one does seem to be very common. Maybe it's time to bring in
> > >>
> > >> MICROVOLTS_PER_MILLIVOLT even if it's longer than the open coded version?
> > >>
> > >> Andy, what do you think?  I do worry that people will see it as fine
> > >> to add many many others if we start with this one though. So maybe not.  
> > > 
> > > IIRC (sorry, if I am wrong) it was you who objected in the first place
> > > and I proposed that from day 1 discussing the "(MICRO / MILLI)" approach
> > > a year (?) or so ago. Answering to the Q: I am in favour of having that
> > > definition.

Yup. I got convinced over time!  I still a little doubtful but
seemed like it was worth revisiting the question.

> > >   
> > >> Anyhow, doesn't need to be in this series.  
> > > 
> > > True.  
> > 
> > How about MICRO_PER_MILLI? Then we won't have to add a new one
> > for every different type of unit.  

I think it only commonly occurs for voltage because of the whole
mismatch between the regulators framework and both IIO and HWMON
in units.  That's based on gut feel though rather actually checking
the code.

Jonathan




> 
> Dunno, as a physicist, I prefer the way with units.
> 

