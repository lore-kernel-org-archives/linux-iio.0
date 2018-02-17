Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbeBQM0y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Feb 2018 07:26:54 -0500
Date: Sat, 17 Feb 2018 12:26:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, 21cnbao@gmail.com,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of
 staging
Message-ID: <20180217122649.1b476787@archlinux>
In-Reply-To: <20180212144542.qievoq76rvjigwm4@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
        <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
        <20180212131826.ebazvmp6iv7i5fav@mwanda>
        <20180212144157.GC12142@himanshu-Vostro-3559>
        <20180212144542.qievoq76rvjigwm4@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Feb 2018 17:45:42 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Mon, Feb 12, 2018 at 08:11:57PM +0530, Himanshu Jha wrote:
> > On Mon, Feb 12, 2018 at 04:18:26PM +0300, Dan Carpenter wrote:  
> > > I think -M is prefered for these types of diffs?  Not sure.  
> > 
> > I wrote about that in the cover letter if you missed. :)
> >   
> 
> Yeah.  I seldom read cover letters.

For anyone else (like me) who also doesn't often read them...

This was a specific request from me to not use move detection.

The reason is that it presents an opportunity for staging graduation patches
for people to have the whole code in front of them allowing them to do a full
review as if it were a new driver.

I personally find this very helpful in this one case. For any other
code move I'm as in favour of short emails as the next person ;)

Jonathan
> 
> > > > +	ret = adis_init(st, indio_dev, spi, &adis16201_data);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> > > > +	if (ret)
> > > > +		return ret;  
> > > 
> > > We should clean up the IRQ which we enabled in adis_init() instead of
> > > returning directly.  
> > 
> > I'm not sure about how to do that.
> >   
> 
> I believe in you that you can figure it out.  :)
> 
> regards,
> dan carpenter
> 
> 

