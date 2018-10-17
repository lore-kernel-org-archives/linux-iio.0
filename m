Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35215 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeJQWjS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Oct 2018 18:39:18 -0400
Date: Wed, 17 Oct 2018 20:13:09 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad7816: Switch to the gpio descriptor
 interface
Message-ID: <20181017144307.GA11244@nishad>
References: <20181016144623.GA9890@nishad>
 <929c42b8-34e7-60bb-5bd4-31faf53d62c2@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <929c42b8-34e7-60bb-5bd4-31faf53d62c2@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Oct 16, 2018 at 05:10:14PM +0200, Lars-Peter Clausen wrote:
> On 10/16/2018 04:46 PM, Nishad Kamdar wrote:
> > Use the gpiod interface for rdwr_pin, convert_pin and busy_pin
> > instead of the deprecated old non-descriptor interface.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> 
> Hi,
> 
> Thanks for the patch, this looks good.
> 
> One thing about the error messages though.
> 
> > +	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
> > +	if (IS_ERR(chip->rdwr_pin)) {
> > +		ret = PTR_ERR(chip->rdwr_pin);
> >  		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
> > -			chip->rdwr_pin);
> > +			ret);
> 
> This previously showed the pin number which has now been replaced with the
> error code. The message doesn't make that much sense semantically anymore.
> Maybe replace it with something like
> 
> 	"Failed to request rdwr GPIO: %d\n", ret
> 
> >  		return ret;

Hello,

Ok, I'll do that.

Thanks for the review.

regards,
Nishad
