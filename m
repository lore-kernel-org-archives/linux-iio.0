Return-Path: <broonie@sirena.org.uk>
Date: Thu, 13 Oct 2011 21:44:10 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	zdevai@gmail.com, linus.walleij@linaro.org
Subject: Re: [PATCH] staging:iio:proof of concept in kernel interface.
Message-ID: <20111013204410.GA17160@sirena.org.uk>
References: <1318333383-17663-1-git-send-email-jic23@cam.ac.uk>
 <1318333383-17663-2-git-send-email-jic23@cam.ac.uk>
 <20111013143224.GO1098@sirena.org.uk>
 <4E96F9AC.9000001@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E96F9AC.9000001@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 13, 2011 at 03:46:04PM +0100, Jonathan Cameron wrote:

> > I guess an actual implementation would have wrappers for doing the
> > indirections rather than having users peer into the ops table directly?

> Yup, for some reason the cover letter seems to have detached from this.
> It suggested exactly that.  There may be weird cases where peering this
> deep into the ops makes sense, but not for something like this one.

Oh, right.  As a general rule I don't read cover letters for single
patches until after I've read the patch, generally they're either
completely content free (if only by virtue of repeating the changelog)
or there's a problem with the changelog in the actual patch not
explaining what's going on.
