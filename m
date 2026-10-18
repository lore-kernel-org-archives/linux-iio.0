Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684503FE65F;
	Sun, 18 Oct 2026 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792307119; cv=none; b=VE/mRzJEjuSUPb/vb0LMgvn3dekXfduCveZc64VRAjYlsnHIkFIAhNgCYaT0GvowZ8Fk/MhfQ1XRHrtHXDOzOwpekbJx4MltVZuGIM1i78NaG7LCn1aNyVG64bnBjZye5AxweHvdY/hNSaTMNCGJtK/PDm53q7L+LCNPgTBFzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792307119; c=relaxed/simple;
	bh=zXeCUgzcgR4qsPSydby+zrufcPBOT82Ize1Bm32RGh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS0ExcsnGaMQ0QbVzlQUVNJc5hSZIwQgOYMLTf30bHh3Os/Bcoeb32aOIszOCe6hAAuazeSVXlpDJY2FLIcU2YWOYy0NFF7AJf6QE+INxueFpO2RbkG8g28ftcj8dSwnTXfXsMLy7W5HI+NnflOGtNfl8G46OQ21oi3zZNQhDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNqFhFlX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNqFhFlX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39BF1F000C4;
	Sun, 18 Oct 2026 07:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792307115;
	bh=8U/HEpnOLtFQ6/ozb6bsm7OTEQo691HeSeDJ2ZzT5iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LNqFhFlXZcP3KN3JrARuKumRORMO5V3SzFULKHMcEB8sOOFCyjORz18uRUmPsn0pN
	 wnVsE4Z78S69kjBo0KlzhgRpGj5ELA00i3fdUvDiOvyXK+OSf3WHa9baJriiRbDXgo
	 1K3BiwatKfegGtrHgpD0AnvDUTNuZq1WG3EETELxMpv0pzP5+oKnIhWIQw6wcdUOB6
	 FPrMLebwbbQAmML5+pyn2qnZg1pbCTGGWav8yyJg378/nHLtJgDTdEzesKoHYdql/I
	 2l0Bf3yuSYJPqbs2KZtFO+FPCtbUQQgKlTPpov0ocpEP+cMxzuN30jymb7O4sd2jHQ
	 ftmzYAquGUeOw==
Date: Sun, 18 Oct 2026 07:05:12 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Arnav Kapoor <kapoorarnav43@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: common: cros_ec_sensors: use sensor_scale union
 member for CALIBSCALE
Message-ID: <atRvqJiiAjjfbDcE@google.com>
References: <20261011045410.356156-1-kapoorarnav43@gmail.com>
 <20261011191641.4e9e2ac4@systembl0wer>
 <20261012211733.575305-1-kapoorarnav43@gmail.com>
 <as6Mr7BSbJeJRlBq@ashevche-desk.local>
 <20261018000206.55b279de@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018000206.55b279de@jic23-hlaptop>

On Sun, Oct 18, 2026 at 12:02:06AM +0100, Jonathan Cameron wrote:
> On Tue, 13 Oct 2026 22:55:27 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Tue, Oct 13, 2026 at 02:47:30AM +0530, Arnav Kapoor wrote:
> > > On Sun, 11 Oct 2026 19:16:41 +0200, Joshua Crofts wrote:  
> > > > Please add a Fixes tag. Otherwise looks good to me!
> > > >
> > > > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>  
> > > 
> > > Thanks for the review. The mismatch was introduced when CALIBSCALE
> > > support was added:
> > > 
> > > Fixes: ed1f2e85da79 ("iio: cros_ec: Add calibscale for 3d MEMS")
> > > 
> > > Jonathan, could you pick this up when applying, or would you prefer a v2?  
> > 
> > No need to resend, `b4` will scan the whole email thread for the tags.
> If it could put them in the right order for 'late' fixes tags it would
> be perfect (easy fix though so don't resend!)
> > 
> 
> This driver tends to be well maintained so whilst I'm fine
> with the change I'll wait a bit for a tag from one of the maintainers.

Sorry for the delay, I somehow missed this in my inbox.

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
