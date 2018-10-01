Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:53794 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729182AbeJAUdG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Oct 2018 16:33:06 -0400
Date: Mon, 1 Oct 2018 14:54:52 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Slawomir Stepien <sst@poczta.fm>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <pmeerw@pmeerw.net>,
        <knaack.h@gmx.de>, <jic23@kernel.org>
Subject: Re: [PATCH] staging: iio: adc: add missing spaces around minus sign
Message-ID: <20181001145452.0000111f@huawei.com>
In-Reply-To: <20181001133533.mkp6qxpuo3yb4m6b@mwanda>
References: <20181001122834.GA13306@x220.localdomain>
        <20181001125216.jdqtcqcnisnea3tf@mwanda>
        <b7ffebee-83ce-2b03-371f-0663d8d7ae04@metafoo.de>
        <20181001133533.mkp6qxpuo3yb4m6b@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 1 Oct 2018 16:35:33 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Mon, Oct 01, 2018 at 02:54:55PM +0200, Lars-Peter Clausen wrote:
> > On 10/01/2018 02:52 PM, Dan Carpenter wrote:  
> > > On Mon, Oct 01, 2018 at 02:28:34PM +0200, Slawomir Stepien wrote:  
> > >> The checkpatch.pl tool detected coding style problem:
> > >>
> > >>     CHECK: spaces preferred around that '-' (ctx:VxV)
> > >>
> > >> in two files inside the adc directory. This patch will remove this
> > >> problem.
> > >>
> > >> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> > >> ---
> > >>  drivers/staging/iio/adc/ad7192.c  | 2 +-
> > >>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
> > >>  2 files changed, 3 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > >> index acdbc07fd259..7c632cf1932b 100644
> > >> --- a/drivers/staging/iio/adc/ad7192.c
> > >> +++ b/drivers/staging/iio/adc/ad7192.c
> > >> @@ -355,7 +355,7 @@ ad7192_show_scale_available(struct device *dev,
> > >>  }
> > >>  
> > >>  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> > >> -			     in_voltage-voltage_scale_available,
> > >> +			     in_voltage - voltage_scale_available,
> > >>  			     0444, ad7192_show_scale_available, NULL, 0);  
> > > 
> > > 
> > > This doesn't work.  That's not arithmatic, it's a string which is passed
> > > to a macro.  It's an ugly macro, but it would take a lot of work to
> > > change it at this point.  
> >   
> > >From a technical perspective it is easy to change this. We already had  
> > patches for that. The difficulty is convincing Greg that this would be a
> > sensible change to pass the string as a string and not a preprocessor token.  
> 
> Oh.  Hm...  I was looking at this wrong.  It would be awkward to make it
> a string because the _show() op names depend on the filename.
> 
> People do keep bumping into this mistake, but there is no chance that
> anyone is going to merge it so it's probably not worth investing any
> more time on it.
> 

Or... Plan b) use the callbacks to generate this automatically and avoid
having to have the macro use at all.

In theory it was on the plan to get rid of all of these _available definitions
in favour of ones that in kernel consumers can actually read easily, we just
haven't made that much progress with it.

Jonathan

p.s. Good learning experience for people to discover that checkpatch isn't
infallible? *ducks*

> regards,
> dan carpenter
