Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2E399019;
	Mon, 20 Apr 2026 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690232; cv=none; b=JMslb6FtxRD0W2fHL4WQ/xNw3grWZFcNuGD8ZFwIIu7SGCHfu+BlgUGXAQAspl8EuHreKvvU5tf/rbAh9K6hWyEKqDdkHgct83AkSBPbISpcO5jP+Bek1DGI/yawWDw5sJTXBVx955T84/2DM/3xmOiwjIvv42ujnr4abeaE2Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690232; c=relaxed/simple;
	bh=FWYzDiOArELacVGV7TzEmUdoIKAyf3T/LPGLv7hZXEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOpzA0sgg0L6qmXtbRJUCemE7CBCxWY0/kAWg4kTmxfOpnrrFiS/QRZoXN+wTfGzAN/QLfQTyFf3wtPP8SQqEzNlrW9tDFwgE3Jjhr0b6hicl/rXze2SGBUglNEJ5NJpmkvKY2oe9CX3BmshicRpLHZCr2EAbhWp/bWrzyOos5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3tKTdu4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3tKTdu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77191C19425;
	Mon, 20 Apr 2026 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690231;
	bh=FWYzDiOArELacVGV7TzEmUdoIKAyf3T/LPGLv7hZXEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N3tKTdu4Pv+jvOEXJNbSnxP7OO7Ii/79maL5un9RCk4ciAXmHCA5Sni5jvUBRv4Rh
	 WcOMUuCWX6UOvyBt8C3cwSPkyoojbmv5m4vK08jeKx/am6RDyl3tMRIfF1TLWRFg8t
	 WYPlgyn6Vi7oqtPTzPvo/qLpO9P67KsTUgI2c0/n0kFhPsDN+8UB0qFw8TwLIsZ5EB
	 iJECYpFYAv/OokK2+Jr3SSbbkfQd7XZFvROTKaXDiBJzDWUndO9Wh+isSrhLemTvzj
	 +7YXmgeD0eLQwctHMfp6oyZGF8hHZ/+jDvmQwK6rfm847Yia4UAxkWCgztd+FgkN3b
	 VsQJ3NM8UrFhA==
Date: Mon, 20 Apr 2026 14:03:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7950: use spi_optimize_message()
Message-ID: <20260420140344.0f2ae510@jic23-huawei>
In-Reply-To: <03ea65e3-4c34-4a20-b638-966abad78d7d@baylibre.com>
References: <20260411-iio-adc-ti-ads7950-spi-optimize-msg-v1-1-617766ef2e38@baylibre.com>
	<ad4OywqHDC7aYapD@ashevche-desk.local>
	<d14d23df-0fad-4b87-8e57-67241b29fc30@baylibre.com>
	<ad5ry4i6OPOS156E@ashevche-desk.local>
	<03ea65e3-4c34-4a20-b638-966abad78d7d@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 12:52:49 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/14/26 11:31 AM, Andy Shevchenko wrote:
> > On Tue, Apr 14, 2026 at 08:29:29AM -0500, David Lechner wrote:  
> >> On 4/14/26 4:54 AM, Andy Shevchenko wrote:  
> >>> On Sat, Apr 11, 2026 at 05:13:33PM -0500, David Lechner wrote:  
> >>>> Use spi_optimize_message() to reduce CPU usage during buffered reads.
> >>>>
> >>>> On hardware with support for SPI_CS_WORD, this reduced the CPU usage
> >>>> of the threaded interrupt by about 5%. On hardware without support, this
> >>>> should reduce CPU usage even more since it won't have to split the SPI
> >>>> transfers each time the interrupt handler is called.
> >>>>
> >>>> The update_scan_mode callback hand to be moved to the buffer preenable  
> >>
> >> s/hand/had/
> >>  
> >>>> callback since the SPI transfer mode can't be changed after
> >>>> spi_optimize_message() has been called. (The buffer postenable callback
> >>>> can't be used because it happens after the trigger is enabled, so the
> >>>> SPI message needs to be optimized before that.)
> >>>>
> >>>> The indent of ti_ads7950_read_raw is changed since there is no longer
> >>>> anything else in the struct to align with since we removed
> >>>> ti_ads7950_update_scan_mode.  
> >>>
> >>> Some of the func() are mentioned w/o parentheses and I got lost which one is
> >>> which. Also callbacks usually mentioned as .callback() (with a leading dot).  
> >>
> >> I didn't put () in the last paragraph because I was talking about the function
> >> pointer, not the function. I guess I missed update_scan_mode() though.  
> > 
> > Then probably spell it as "pointer to func()" ?
I tweaked this a bit and applied.

J
> >   
> >>> The second paragraph doesn't tell me clearly if there is a behaviour change
> >>> from user perspective.  
> >>
> >> It is not clear that the difference the user can notice is that there are
> >> some CPU cycles freed up for other tasks?  
> > 
> > He-he :-)
> > 
> > I asked more about possible behaviour changes in ABI (note, that [significant]
> > delays moved around might affect ABI if some user's program times out due to
> > that). But I think it's not the case here.
> >   
> 
> No, I don't expect any other changes either.

