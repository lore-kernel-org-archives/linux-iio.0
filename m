Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFD346FB3;
	Sat, 17 Oct 2026 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792280072; cv=none; b=ScE1MMjk/ijUGHVtJfvrSrjgj1sKrNXHG7bD7x5U7ps9f5HkAfp0a7cLt+IuglNzzRoSrxQfbdY8nTZubHd3wgpbBA8dle+FJC3LD8LEW5BNc/MA4nm3dkzdx8QVd+tsXGdsGyKH7GXQojnXhsJYlpaMhRFObhiwmr8sLrbLLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792280072; c=relaxed/simple;
	bh=b1BZXEy087/CoN0JXUauz7i00W8Fip7xOOSQ9dI3L/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rV1V+Qiaej54VemrYATA2qxFrrkON3VqBEII9IysH4Zu68FKhVuZzfG/8jypx1Q5aX/EL3KEdyYuFLIcXIPOGrcgyQSLEYvhPMOdXFh+7f/M/7ez/sr0dwGp+z8Lmc6FkVmOvF4lts5zYlbqwte7aEdIKPagBICtoSwWN6cQ4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARkikgv8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARkikgv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251DA1F000C4;
	Sat, 17 Oct 2026 23:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792280070;
	bh=HCs018pfV8pqZ/nSvaU0N/utrGR6OnsZDN8vjSf5xeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ARkikgv8LD55a7v3+ldb+VQihtedQYUJ3mF0iSLYRZk4SDT4IS/A499TCrZh5cGVs
	 EjVvfcbbuRNQvIK9sYp+O9lkgd5Nl9xzKpBwK8uz+CqUROyUVbhQA0szNqsaNbIZhg
	 0xo1gqywbv08FaA/yu/yeSKimoAfn2L2GBB6cgevveKeHnZnybiwkKPrSaiNIuozxb
	 UeyVZN9eh4TzxPEyQpQF9ZY47ld3Dzq9fLqiOnKXKQh5L5C+KgpLXmUlK5TGtnIwCF
	 Ic4teAA5B7/m6Gb4SIuzz2s+b2Ylr/vQVL7U1b8eUDIVrsMD4vFOlFNBEHHcJKcVOh
	 Y0x2K03F/tcVw==
Date: Sun, 18 Oct 2026 00:34:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Matt Ranostay
 <matt@ranostay.sg>
Subject: Re: [PATCH 1/1] iio: atlas-ezo: Fix humidity channel read support
Message-ID: <20261018003424.5fc050a8@jic23-hlaptop>
In-Reply-To: <20261018003129.533effef@jic23-hlaptop>
References: <20261012114553.3327-1-nikhilgtr@gmail.com>
	<20261012114553.3327-2-nikhilgtr@gmail.com>
	<as1G0yGQ5wKhd-dh@ashevche-desk.local>
	<ab328578-08a6-455d-a9bf-411aeb561c8c@gmail.com>
	<20261018003129.533effef@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 00:31:29 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 13 Oct 2026 22:15:23 +0530
> Nikhil Gautam <nikhilgtr@gmail.com> wrote:
> 
> > Hi Joshua, Andy,
> > 
> > Thanks for the review and feedback.
> > 
> > I checked the Git history and found that the channel type check was 
> > already present
> > in commit dc3ebfc ("iio: chemical: atlas-ezo-sensor: add humidity sensor 
> > support").
> > It was not removed when humidity sensor support was introduced, and
> > I couldn't find any commit message explaining the original intent of the 
> > check.
> > 
> > Regarding the potential I2C read issue reported by Sashiko,
> > I'll investigate it and address it in a separate patch series.
> > 
> > I'll also omit the cover letter for future single-patch submissions.  
> 
> Matt normally gets back reasonably quickly so +CC but I'll
> assume this is just one of those last minute editing errors and
> apply the fix in the meantime.
> 
> So applied to the fxies-togreg branch of iio.git and marked for stable.
fixes-togreg that is.

I also added the missing fixes tag to point to the introduction of
the humidity sensor.

J
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Thanks,
> > Nikhil
> > 
> > On 13-10-2026 02:15 am, Andy Shevchenko wrote:  
> > > On Mon, Oct 12, 2026 at 05:15:53PM +0530, Nikhil Gautam wrote:    
> > >> The atlas_ezo_read_raw() function rejects channels that are not of
> > >> type IIO_CONCENTRATION, preventing the relative humidity channel
> > >> from reading raw and scale values.
> > >>
> > >> Remove the early channel type check to allow both concentration
> > >> and relative humidity channels to reach the mask-specific handling.    
> > > Have you checked the Git history on this change? Anything interesting there?
> > >    
> >   
> 
> 

