Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753049AbdICPt5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 11:49:57 -0400
Date: Sun, 3 Sep 2017 16:49:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix missing break in switch
Message-ID: <20170903164953.68459334@archlinux>
In-Reply-To: <alpine.DEB.2.20.1708230841050.6913@vps.pmeerw.net>
References: <20170822191324.GA15477@embeddedgus>
        <alpine.DEB.2.20.1708230841050.6913@vps.pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 23 Aug 2017 08:41:43 +0200 (CEST)
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> > Add missing break statement to prevent the code for case
> > IIO_CHAN_INFO_CALIBBIAS falling through to the default case.
> > 
> > Also, add a break to the default case for the switch within
> > case IIO_CHAN_INFO_CALIBBIAS.  
> 
> fix seems to be cosmetic only...
> 
> > Addresses-Coverity-ID: 1357377
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Indeed only cosmetic, but if it makes static analysis more productive
by removing a trivial case, it is worth having.

Applied to the togreg branch of iio.git - will be pushed out as testing
just as soon as I catch up with my backlog.

Jonathan

> > ---
> > This issue was reported by Coverity and it was tested by compilation only.
> > Please, verify if this is an actual bug.
> > 
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > index 44830bc..6d2268a 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -542,7 +542,9 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
> >  			break;
> >  		default:
> >  			result = -EINVAL;
> > +			break;
> >  		}
> > +		break;
> >  	default:
> >  		result = -EINVAL;
> >  		break;
> >   
> 

