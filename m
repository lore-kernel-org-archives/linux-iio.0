Return-Path: <guillaume@morinfr.org>
Date: Sat, 28 Jun 2014 05:10:46 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guillaume Morin <guillaume@morinfr.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] staging: iio: ad9850.c: fix checkpatch.pl error
Message-ID: <20140628031045.GA13985@bender.morinfr.org>
References: <4d0e6b74dcc10ef5d60c9cab4f2df886782fb3c3.1403919775.git.guillaume@morinfr.org>
 <20140628020935.GA14333@kroah.com>
 <20140628023009.GA13273@bender.morinfr.org>
 <20140628023718.GB3579@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140628023718.GB3579@kroah.com>
List-ID: <linux-iio@vger.kernel.org>

On 27 Jun 22:37, Greg Kroah-Hartman wrote:
> Put that below the --- line.

Will do.

> > > And what checkpatch error did you fix?  And are you sure it needs to be
> > > fixed?
> > 
> > That's what I changed:
> > 
> > $ scripts/checkpatch.pl -f drivers/staging/iio/frequency/ad9850.c
> > ERROR: Macros with complex values should be enclosed in parenthesis
> 
> Then why didn't you say that :)

Well it was not totally clear to me if that was obvious or not.  Anyway,
I'll mention it in the future.

> 
> > I assumed that if it was reported as an error, it needed to be fixed...
> 
> Use your judgement, checkpatch is a tool, it isn't always correct.

Right, I guess it's borderline.  Should I resend the patch or just drop
it?

Guillaume.

-- 
Guillaume Morin <guillaume@morinfr.org>
