Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdHLLNo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Aug 2017 07:13:44 -0400
Date: Sat, 12 Aug 2017 12:10:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>,
        Matt Ranostay <matt.ranostay@intel.com>
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1015: use dynamically generated
 attributes
Message-ID: <20170812121044.034e2c38@archlinux>
In-Reply-To: <20170809164426.4zpihixosqlg2jtc@lenoch>
References: <20170801082521.namcrs4wyufwqyuh@lenoch>
        <20170801082646.yfkcdfrchsdagw4m@lenoch>
        <20170809151100.592dab5e@archlinux>
        <20170809164426.4zpihixosqlg2jtc@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 9 Aug 2017 18:44:26 +0200
Ladislav Michl <ladis@linux-mips.org> wrote:

> Hello Jonathan,
> 
> On Wed, Aug 09, 2017 at 03:11:00PM +0100, Jonathan Cameron wrote:
> > On Tue, 1 Aug 2017 10:26:46 +0200
> > Ladislav Michl <ladis@linux-mips.org> wrote:
> >   
> > > Generate attributes dynamically based on actual values used
> > > by driver - leads to slightly smaller code (on ARM and X64)
> > > Scale and sampling frequency definitions are at one place now.
> > > 
> > > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>  
> > Sorry, for the small gain I am unconvinced.  If this was a new
> > driver and it had been submitted this way I wouldn't be asking
> > for it to be changed, but I'm also not interested in the churn and
> > additional code for what must be a pretty small chance.  
> 
> As stated in cover letter I was not really considering it to be
> a huge improvement and in fact did it as excercise to better
> uderstand iio, so I'm not afraid it doesn't go in.
Ooops. The fact I don't always read cover letters becomes apparent ;)

Reviewers are lazy, put comments about a particular patch in that
patch then there is a slightly larger chance that people will notice
it.
> 
> > Also if you really want to do tinification patches, please post
> > the actual sizes of the various regions.  In particular you need
> > to generally have a fairly large saving to justify replacing
> > stuff that is constant with code.  
> 
> I'll see if something better can be done based on fixes-togreg branch.
Cool.
> 
> Thank you,
> 	ladis

