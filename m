Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:35622 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S944606AbcJSPRd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 Oct 2016 11:17:33 -0400
Date: Wed, 19 Oct 2016 08:48:32 -0400
From: Brian Masney <masneyb@onstation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: jic23@kernel.org, devel@driverdev.osuosl.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 5/7] iio: light: tsl2583: check return values from
 taos_chip_{on, off}
Message-ID: <20161019124832.GB6741@basecamp.onstation.org>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
 <1476873130-24926-5-git-send-email-masneyb@onstation.org>
 <20161019112249.GH4469@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161019112249.GH4469@mwanda>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 19, 2016 at 02:22:49PM +0300, Dan Carpenter wrote:
> On Wed, Oct 19, 2016 at 06:32:08AM -0400, Brian Masney wrote:
> > @@ -775,14 +778,20 @@ static ssize_t illuminance0_lux_table_store(struct device *dev,
> >  		goto luxable_store_done;
> >  	}
> >  
> > -	if (chip->taos_chip_status == TSL258X_CHIP_WORKING)
> > -		taos_chip_off(indio_dev);
> > +	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
> > +		ret = taos_chip_off(indio_dev);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> >  
> >  	/* Zero out the table */
> >  	memset(taos_device_lux, 0, sizeof(taos_device_lux));
> >  	memcpy(taos_device_lux, &value[1], (value[0] * 4));
> >  
> > -	taos_chip_on(indio_dev);
> > +	ret = taos_chip_on(indio_dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	ret = len;
> >  
> >  luxable_store_done:
> 
> 
> See, here you are adding direct returns in the middle of a single return
> function, and you promised yourself that you would never do that and it
> would mean that you never ever forgot to add error handling.  But we're
> not even outside of the patchset yet and your complicated future
> proofing has already failed.
> 
> You know you just want direct returns because that is the simplest way
> to program.  "goto luxable_store_done;"  What does that even mean?  But
> "return -EINVAL;" is simple.  It does one thing and it does it well.
> 
> Go with your heart.  My research says that the complicated single return
> functions are going to be buggier in the long run anyway so your heart
> is leading you on the right path.

Ok, I'll rework my patch series to stick with the direct returns. I
personally prefer that approach. I was using the gotos since I thought
that was standard convention in the kernel.

Brian

