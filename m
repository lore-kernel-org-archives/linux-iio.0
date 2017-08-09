Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752901AbdHIOir (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 10:38:47 -0400
Date: Wed, 9 Aug 2017 15:38:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dragos Bogdan <dragos.bogdan@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis16480: Fix acceleration scale factor for
 adis16480
Message-ID: <20170809153834.7f9cf637@archlinux>
In-Reply-To: <e34f87db-694c-e83e-5ee8-ff93d4f63e39@metafoo.de>
References: <20170803223727.14472-1-dragos.bogdan@analog.com>
        <e34f87db-694c-e83e-5ee8-ff93d4f63e39@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 4 Aug 2017 05:49:32 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 08/04/2017 12:37 AM, Dragos Bogdan wrote:
> > According to the datasheet, the range of the acceleration is [-10 g, + 10 g],
> > so the scale factor should be 10 instead of 5.
> > 
> > Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>  
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Thanks.
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> 
> > ---
> >  drivers/iio/imu/adis16480.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> > index 8cf84d3488b2..12898424d838 100644
> > --- a/drivers/iio/imu/adis16480.c
> > +++ b/drivers/iio/imu/adis16480.c
> > @@ -696,7 +696,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
> >  		.gyro_max_val = IIO_RAD_TO_DEGREE(22500),
> >  		.gyro_max_scale = 450,
> >  		.accel_max_val = IIO_M_S_2_TO_G(12500),
> > -		.accel_max_scale = 5,
> > +		.accel_max_scale = 10,
> >  	},
> >  	[ADIS16485] = {
> >  		.channels = adis16485_channels,
> >   
> 

