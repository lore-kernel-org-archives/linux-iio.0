Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366403976BE;
	Sat, 17 Oct 2026 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792203259; cv=none; b=YAJU/UeMlgl5vjo/mOJbvxP7gQpMao12FIaG0gJQEK8VxPH6wrNxRh/S+uQ0VXKZSmDAqIROoFs52ZCujoD1fcMVaeS0w38k63HgE53aC+SpVEbjc4FTYrVgti4OOiFc+2vD22evozPX+IwgHsv/0dNd35JFHcdG8c13o0YajZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792203259; c=relaxed/simple;
	bh=8oG0xRxhnozYLwuAuQ77gXRnFasZA3ACSga8Y6pHrJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gyqqu5z2kfrr1iQSuQw5HwXTSC+9CXuf2dAfw7/6Jby5ykKneomVAhPtj+34XIN2Qav0n77AaNAvEnGsd9OHb5p5cvG03iqNlZw99IS6Dy/Z8oc38PJM3t2y1sfKQhLJjPY2WHqKeOMYddgY2sCeG8HC7myQQ5v5J1dPM5AIwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imlOGIl9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imlOGIl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4B51F000C4;
	Sat, 17 Oct 2026 02:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792203257;
	bh=yyh91KDx32xQbuyOeBLWhJ3b8Ku5eGQR/+SQQba/Bj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=imlOGIl9Mv4BN+6sTW0sNHVu/Jq+TiuYEk9KjruVXrIzCs5vCozvpF7FI/KCWb3W1
	 6VUvmT+WgIxSga9HYYm7ryDEeKew08hlQQwb2SeS3jeMqmXjeF0MZcOzPZ2zl80Mnc
	 EztVkhaHJhtztTtQM5HzNqp/eMlb1s1n9HDPcUcAOXvV5PD10OgXv9C+UToY0g77m3
	 W+ThmzBWGAGSx93sdlXggCwFdaBfTqaMXZ84uCXrtFE8W/Xl9L4nQHeWUU6099MC9w
	 nAM4XpcKJeO1mXuFG79Wv0526ES/AqRJke3DxLSmiB0k0wnr6k1M3Xj8HrFQwC6G9T
	 9Ob8ZCnUVMPnw==
Date: Sat, 17 Oct 2026 03:14:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jan Remes <ciakval@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Joe Sandom <joe.g.sandom@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 martin.triska@mycroftmind.com, Jan Remes <jan.remes@mycroftmind.com>
Subject: Re: [PATCH v2 0/4] iio: light: tsl2591: fix lux calculation and
 precision, add I2C ID table, report saturation
Message-ID: <20261017031411.05dee323@jic23-hlaptop>
In-Reply-To: <atEdM6wi_FAGFjrr@ashevche-desk.local>
References: <20261014141650.259929-1-ciakval@gmail.com>
	<atEdM6wi_FAGFjrr@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 21:36:35 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Oct 14, 2026 at 04:16:46PM +0200, Jan Remes wrote:
> 
> > This series fixes several issues found while using the TSL2591 in
> > company products (Raspberry Pi CM5) and when testing (x86_64 laptops
> > with MCP2221 USB-I2C bridge).
> > 
> > The original field report found that the illumination value has always
> > been 0.0 (caused by division by zero on ARM).
> > 
> > Patch 1 fixes divisions by zero in the lux calculation, which occur with
> > LOW gain and short integration times, or in darkness when CH0 = 0.
> > 
> > Patch 2 adds an i2c_device_id table so the driver can be probed on systems
> > without CONFIG_OF.
> > 
> > Patch 3 makes the driver return an error instead of a bogus value when the
> > sensor is saturated.
> > 
> > Patch 4 improves the formula for calculating lux values to make the
> > returned value more accurate.
> > 
> > Patches 3 and 4 change existing behavior, I am OK with splitting the
> > series into two, if that makes things better.
> > 
> > AI assistance: Claude Code (Claude Opus 5.5) was used for research on
> > sensor behavior, datasheets and Adafruit library, to compare results
> > produced by old and new formula, to draft some code for patches 1 and 4.
> > I reviewed all of it and tested it on x86_64.  
> 
> From my view (haven't checked the calculations, though) this looks good,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
I'm guessing not huge urgency on patch 1, so to keep things simple I've
applied the lot to the testing branch of iio.git. That will get rebased
on rc1 once available in a couple of weeks.

If you want the fix to go in faster, shout and I'll do that at risk
of slowing down the rest.

Thanks,

Jonathan


