Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41621 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbeCFUVo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Mar 2018 15:21:44 -0500
Date: Tue, 6 Mar 2018 17:21:38 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        daniel.baluta@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging:iio:meter: Aligns open parenthesis
Message-ID: <20180306202138.dquhxpfiwq6matbe@smtp.gmail.com>
References: <cover.1520338980.git.rodrigosiqueiramelo@gmail.com>
 <284b70f83bac86ec5f0048b957ec2f679ca8ab99.1520338980.git.rodrigosiqueiramelo@gmail.com>
 <20180306135314.vxngtgj6yxomasm2@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180306135314.vxngtgj6yxomasm2@mwanda>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi

On 03/06, Dan Carpenter wrote:
> On Tue, Mar 06, 2018 at 09:26:07AM -0300, Rodrigo Siqueira wrote:
> > @@ -63,7 +63,7 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
> >  	int ret;
> >  
> >  	st->trig = iio_trigger_alloc("%s-dev%d",
> > -					spi_get_device_id(st->us)->name,
> > +				     spi_get_device_id(st->us)->name,
> >  					indio_dev->id);
>                                         ^^^^^^^^^^^^^
> The "indio_dev->id" needs to be aligned as well.

I will fix it and send a v2.

Thanks for the review!
 
> >  	if (!st->trig) {
> >  		ret = -ENOMEM;
> 
> regards,
> dan carpenter
> 
