Return-Path: <SRS0=2D9W=ED=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 8 Jan 2018 15:02:10 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
        George Edward Bulmer <gebulmer@googlemail.com>
Subject: Re: [PATCH] staging: iio: light: Add breaks to lengthy lines
Message-ID: <20180108120210.fqh7of2e5tv5242j@mwanda>
References: <20180107150801.21617-1-gebulmer@googlemail.com>
 <20180107162848.37108f96@archlinux>
 <1515343347.8292.1.camel@perches.com>
 <20180107171742.6b892736@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180107171742.6b892736@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jan 07, 2018 at 05:17:42PM +0000, Jonathan Cameron wrote:
> On Sun, 07 Jan 2018 08:42:27 -0800
> Joe Perches <joe@perches.com> wrote:
> 
> > On Sun, 2018-01-07 at 16:28 +0000, Jonathan Cameron wrote:
> > > On Sun,  7 Jan 2018 15:08:01 +0000
> > > George Edward Bulmer <gebulmer@googlemail.com> wrote:
> > >   
> > > > This fixes three instances of checkpatch warning:
> > > > WARNING: line over 80 characters
> > > > 
> > > > Signed-off-by: George Edward Bulmer <gebulmer@googlemail.com>  
> > > 
> > > Applied, thanks,  
> > 
> > I believe these are examples of long line conversions
> > that should not be applied.
> 
> On this one I disagree. The line breaks don't hurt readability
> so aren't a problem.  The benefit is admittedly small, however
> we are adding churn in a fairly safe place - this stuff rarely
> changes.

They do hurt read
ability.

Checkpatch.pl should maybe have a special case to not complain if the
last variable in the line is over 40 characters long.  I didn't
realize that we had LONG_LINE_COMMENT.  Does that mean we don't complain
if comment goes over 80 characters?

regards,
dan carpenter
