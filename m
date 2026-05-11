Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8373A1CE6;
	Mon, 11 May 2026 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505684; cv=none; b=DoSWvQFbc1dd6zUt73hnHeVO7Ag3C0w3m+wMUyaIDOWmQiTfZIx1uwpYNZ1wLUuS8e3BR8otrJKWzm+EQwfcdLxOjwbvLmJwcs3Vab2qlUek1O6uUFz77wzsimp8r8W9A8eFN3WfTndsfMxoHWGmI8HUZZDG5/xNVfYjV98Jlp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505684; c=relaxed/simple;
	bh=47HX0ptTsUWtVwckljXwt+gRftCw3NqYKA/9vkXfWBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+X2I9jE26A9U69DAm7wIbp6lAppNP6GzQkdVttHdmdzhbPy8w3YXAXeDUglKrZF/lqXocAsTeqVobYHSStMGXMRhO14m6GP222HG/q6oqGdyQHRB8bvDlq+I9yt6epIM8oSc9xnDVQ1qNh7w2uMU817sLhp5JRQuDhNudh90qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIjAis4w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIjAis4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595B4C2BCB0;
	Mon, 11 May 2026 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778505684;
	bh=47HX0ptTsUWtVwckljXwt+gRftCw3NqYKA/9vkXfWBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PIjAis4wHVd6IIuaabBYfH7+so530EZmLJ0oz/+LNC3fBnrbr8kYc19nCIIcJfWJj
	 Q+08OWABTiZukTaqYT2VGjFvrEtt9hrHiP28T1KYcWF4cM4TkkQEHW7oGMavZ9xI7q
	 BfzVO6qJKd+baMzgqs+1oZmEdJmGXgYvAFIg+qBJjUCKISW4gyILtld6TBmmjhP0GX
	 D+jNbdp9HTJ2DjkW/gMcEusi87aObkTJnzO7GNJQe6ZuaWioRrhjY38KvgOdWDKqtU
	 JBclFkA7d53f6zoQKxF9f9lviB1cT2iMwBtTZzFZT7HhwBA1yr4vV+d3OQTAbAsNBs
	 fHIzDB9nr/KmQ==
Date: Mon, 11 May 2026 14:21:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] iio: light: opt3001: use macros from bits.h header
Message-ID: <20260511142116.7340f8c4@jic23-huawei>
In-Reply-To: <CALoEA-xNyS0Osnk2sEcdos0HHjOzKmeTZ82ivqYiz4J4RHA5ew@mail.gmail.com>
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
	<20260511-opt3001-cleanup-v1-2-f7879dc3455c@gmail.com>
	<agG3EdSotUAyHeI9@ashevche-desk.local>
	<CALoEA-xNyS0Osnk2sEcdos0HHjOzKmeTZ82ivqYiz4J4RHA5ew@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 13:07:29 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 11 May 2026 at 13:01, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Mon, May 11, 2026 at 12:04:07PM +0200, Joshua Crofts via B4 Relay wrote:
> >  
> > > Use GENMASK() and BIT() macros from bits.h header where it makes
> > > sense. While at it, remove unused macro.  
> >
> > ...
> >  
> > >  #define OPT3001_CONFIGURATION_M_SHUTDOWN (0 << 9)
> > > -#define OPT3001_CONFIGURATION_M_SINGLE       (1 << 9)
> > > +#define OPT3001_CONFIGURATION_M_SINGLE       BIT(9)
> > >  #define OPT3001_CONFIGURATION_M_CONTINUOUS (2 << 9) /* also 3 << 9 */  
> >
> > No to this and similar changes. It's clear that this is a shifted plain value,
> > it's not a bitfield. If in doubt, always consult with datasheet, if there is
> > no such publicly available, ask driver author/maintainers of the subsystem.  
> 
> Yeah, I knew this was a bit of a gamble, will fix in the next iteration.

Bigger change but you could move to defining all these field values
without the shift and using FIELD_PREP() / FIELD_GET() with the mask (that is
one line above these).

That is how we'd do it in a modern driver.

J
> 

