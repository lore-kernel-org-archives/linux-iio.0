Return-Path: <SRS0=zDw+=7L=linux-mips.org=ladis@kernel.org>
Date: Wed, 9 Aug 2017 18:44:26 +0200
Sender: Ladislav Michl <ladis@linux-mips.org>
From: Ladislav Michl <ladis@linux-mips.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>,
        Matt Ranostay <matt.ranostay@intel.com>
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1015: use dynamically generated
 attributes
Message-ID: <20170809164426.4zpihixosqlg2jtc@lenoch>
References: <20170801082521.namcrs4wyufwqyuh@lenoch>
 <20170801082646.yfkcdfrchsdagw4m@lenoch>
 <20170809151100.592dab5e@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170809151100.592dab5e@archlinux>
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

On Wed, Aug 09, 2017 at 03:11:00PM +0100, Jonathan Cameron wrote:
> On Tue, 1 Aug 2017 10:26:46 +0200
> Ladislav Michl <ladis@linux-mips.org> wrote:
> 
> > Generate attributes dynamically based on actual values used
> > by driver - leads to slightly smaller code (on ARM and X64)
> > Scale and sampling frequency definitions are at one place now.
> > 
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Sorry, for the small gain I am unconvinced.  If this was a new
> driver and it had been submitted this way I wouldn't be asking
> for it to be changed, but I'm also not interested in the churn and
> additional code for what must be a pretty small chance.

As stated in cover letter I was not really considering it to be
a huge improvement and in fact did it as excercise to better
uderstand iio, so I'm not afraid it doesn't go in.

> Also if you really want to do tinification patches, please post
> the actual sizes of the various regions.  In particular you need
> to generally have a fairly large saving to justify replacing
> stuff that is constant with code.

I'll see if something better can be done based on fixes-togreg branch.

Thank you,
	ladis
