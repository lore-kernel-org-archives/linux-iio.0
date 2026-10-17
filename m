Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF1213CA92;
	Sat, 17 Oct 2026 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792279895; cv=none; b=QKYdgtErejMPItDJmz0HAB4VSY3pa9BCbOYeRkwLceR//qUeLHyCw9V0kS1Zb9Hs7NwkzUWsbRqS7DFeGi+A17Y59N+CUYQzrhjs+YGsVRH7m6CB2Y1CKWfXooy0Moe0x731NNmprzvOJLcfXozJ0dtoEUs4mBEH/h4SMvzwqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792279895; c=relaxed/simple;
	bh=p6QCZwFg51ej8x2rFYr0vVanelbz4FHVnYAlx9b83fg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQOJ++IEeTeQHS0/Uw2UnwOh7OAiRErDJgEMDRP/TtnOBqp787SqIWPN+3pdr00zsizPm6sacQKrRn9u1KLmtqWN2l4REsIARZNozHwEh6/I4fdMcf6ZPEaR7Iq/rRD99vk/peZ+gz7q6MPa26kOgHhz+un50LUJatqu2MnwV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDw4PMwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDw4PMwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317ED1F000C4;
	Sat, 17 Oct 2026 23:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792279894;
	bh=1W6axb7DItKPbOddrGUsux7Hds5fbgvG5hmJUZYVLWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EDw4PMwHeGE1GmS03/ohK7VZ8/qtD0OfrP3MRB0tq93f8nUjufsuvv3VKVQhlJMxO
	 d8NfaZjVlHjuRUAt10S5q24AxMmlblfin8MU8DDCCNv7iY7KLbY/8dqzqGQAvRAVCK
	 plnWUjXk4E8AkmE5aW01W8PvRuKKDDg2bB9bbUhJKfLlNAfani4ggviRwC86uo4Z1Z
	 ot8jzo/mWHCagPjNmYjT5eROu8E6qjvgfRp3yIaFWLSh/hGfuLIBhqVj2Vztap1zF+
	 7GZtw72chN0MGnqTsy3NKtsxTetMZCf1FuWDxlsTyNngnSh5nR0D9hyxvK319dd7+D
	 Po5yPMFg9Albg==
Date: Sun, 18 Oct 2026 00:31:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Matt Ranostay
 <matt@ranostay.sg>
Subject: Re: [PATCH 1/1] iio: atlas-ezo: Fix humidity channel read support
Message-ID: <20261018003129.533effef@jic23-hlaptop>
In-Reply-To: <ab328578-08a6-455d-a9bf-411aeb561c8c@gmail.com>
References: <20261012114553.3327-1-nikhilgtr@gmail.com>
	<20261012114553.3327-2-nikhilgtr@gmail.com>
	<as1G0yGQ5wKhd-dh@ashevche-desk.local>
	<ab328578-08a6-455d-a9bf-411aeb561c8c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 22:15:23 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Hi Joshua, Andy,
> 
> Thanks for the review and feedback.
> 
> I checked the Git history and found that the channel type check was 
> already present
> in commit dc3ebfc ("iio: chemical: atlas-ezo-sensor: add humidity sensor 
> support").
> It was not removed when humidity sensor support was introduced, and
> I couldn't find any commit message explaining the original intent of the 
> check.
> 
> Regarding the potential I2C read issue reported by Sashiko,
> I'll investigate it and address it in a separate patch series.
> 
> I'll also omit the cover letter for future single-patch submissions.

Matt normally gets back reasonably quickly so +CC but I'll
assume this is just one of those last minute editing errors and
apply the fix in the meantime.

So applied to the fxies-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> Thanks,
> Nikhil
> 
> On 13-10-2026 02:15 am, Andy Shevchenko wrote:
> > On Mon, Oct 12, 2026 at 05:15:53PM +0530, Nikhil Gautam wrote:  
> >> The atlas_ezo_read_raw() function rejects channels that are not of
> >> type IIO_CONCENTRATION, preventing the relative humidity channel
> >> from reading raw and scale values.
> >>
> >> Remove the early channel type check to allow both concentration
> >> and relative humidity channels to reach the mask-specific handling.  
> > Have you checked the Git history on this change? Anything interesting there?
> >  
> 

