Return-Path: <SRS0=uViO=OF=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 26 Nov 2018 16:26:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Lars-Peter Clausen <lars@metafoo.de>,
        devel@driverdev.osuosl.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging: iio: adc: ad7280a: check for devm_kasprint()
 failure
Message-ID: <20181126132612.GJ2970@unbuntlaptop>
References: <1543225144-27468-1-git-send-email-hofrat@osadl.org>
 <20181126130032.GJ3088@unbuntlaptop>
 <20181126131009.GA19931@osadl.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181126131009.GA19931@osadl.at>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Nov 26, 2018 at 02:10:09PM +0100, Nicholas Mc Guire wrote:
> On Mon, Nov 26, 2018 at 04:00:32PM +0300, Dan Carpenter wrote:
> > On Mon, Nov 26, 2018 at 10:39:04AM +0100, Nicholas Mc Guire wrote:
> > > devm_kasprintf() may return NULL on failure of internal allocation thus
> > > the assignments to  attr.name  are not safe if not checked. On error
> > > ad7280_attr_init() returns a negative return so -ENOMEM should be
> > > OK here (passed on as return value of the probe function).
> > > 
> > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > Fixes: 2051f25d2a26 ("iio: adc: New driver for AD7280A Lithium Ion Battery Monitoring System2")
> > > ---
> > > 
> > > Problem located with an experimental coccinelle script
> > > 
> > > As using   if(!st->iio_attr[cnt].dev_attr.attr.name)  seamed quite
> > > unreadable in this case the  (var  == NULL)  variant was used. Not
> >                                    ^^
> > Why two spaces?
> 
> just a typo 
> 
> > 
> > > sure if there are objections against this (checkpatch.pl issues
> > > a CHECK on this).
> > > 
> > 
> > You should just follow checkpatch rules here.  If you don't, someone
> > else will just send a patch to make it checkpatch compliant.  One thing
> > you could do is at the start of the loop do:
> > 
> > 	struct iio_dev_attr *attr = &st->iio_attr[cnt];
> > 
> > Then it becomes:
> > 
> > 	if (!attr->dev_attr.attr.name)
> > 
> > It's slightly more readable that way.  Keep in mind that we increment
> > cnt++ in the middle of the loop so you'll have to update attr as well.
> >
> My understanding was that CHECK: notes are not strict rules but
> those that may vary from case to case.

Checkpatch is just a script.  It's not a genius or the king of the
world.  Sometimes checkpatch compliant code is clearly worse than
breaking the rules.  But fighting against checkpatch is a huge hassle so
you should avoid it if you can.

I actually agree with checkpatch on this one but it's a minor thing.
Sometimes a maintainer will get obsessed with minor things.  You have to
be a bit obsessed to be a good kernel maintainer.  Anyway, they have
their fights with checkpatch and it creates a small thread every time a
newbie sends a patch.  And everyone on the CC list has to endure it as
well.

Btw, when I get annoyed with checkpatch, I feel like it's pretty obvious
I am correct.  I'm not like other kernel developers who have debatable
style preferences...  ;)

regards,
dan carpenter
