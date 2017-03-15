Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bounce-1.online.net ([62.210.16.43]:44242 "EHLO
        bounce-1.online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbdCPAQb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 20:16:31 -0400
Date: Thu, 16 Mar 2017 00:09:23 +0100
From: Miguel Robles <miguel.robles@farole.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] [PATCH] Staging: iio: cdc: ad7152.c, use octal
 permissions instead of symbolic
Message-ID: <20170315230923.GA2068@miguel-Z170X-UD5-TH>
References: <1489506763-11364-1-git-send-email-miguel.robles@farole.net>
 <c9baffbe-d665-465e-1051-216c3a871641@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c9baffbe-d665-465e-1051-216c3a871641@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 15, 2017 at 10:01:58PM +0000, Jonathan Cameron wrote:
> On 14/03/17 15:52, Miguel Robles wrote:
> > Fix checkpatch warnings:
> > Symbolic permissions are not preferred. Consider using octal permissions.
> > 
> > Signed-off-by: Miguel Robles <miguel.robles@farole.net>
> Thanks,
> 
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
> 
> Thanks,

Great, thank you for applying my first patch :)!
Miguel.
> 
> Jonathan
> > ---
> >  drivers/staging/iio/cdc/ad7152.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> > index e8609b8..dd0c24c 100644
> > --- a/drivers/staging/iio/cdc/ad7152.c
> > +++ b/drivers/staging/iio/cdc/ad7152.c
> > @@ -155,13 +155,13 @@ static ssize_t ad7152_start_gain_calib(struct device *dev,
> >  }
> >  
> >  static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
> > -		       S_IWUSR, NULL, ad7152_start_offset_calib, 0);
> > +		       0200, NULL, ad7152_start_offset_calib, 0);
> >  static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
> > -		       S_IWUSR, NULL, ad7152_start_offset_calib, 1);
> > +		       0200, NULL, ad7152_start_offset_calib, 1);
> >  static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
> > -		       S_IWUSR, NULL, ad7152_start_gain_calib, 0);
> > +		       0200, NULL, ad7152_start_gain_calib, 0);
> >  static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
> > -		       S_IWUSR, NULL, ad7152_start_gain_calib, 1);
> > +		       0200, NULL, ad7152_start_gain_calib, 1);
> >  
> >  /* Values are Update Rate (Hz), Conversion Time (ms) + 1*/
> >  static const unsigned char ad7152_filter_rate_table[][2] = {
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
