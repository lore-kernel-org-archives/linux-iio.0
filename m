Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpauth-dc2.online.net ([62.210.16.40]:50080 "EHLO
        smtpauth-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754481AbdCTKvk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 06:51:40 -0400
Date: Mon, 20 Mar 2017 11:51:31 +0100
From: Miguel Robles <miguel.robles@farole.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: cdc: use octal permissions instead of
 symbolic
Message-ID: <20170320105130.GA2538@miguel-Z170X-UD5-TH>
References: <1489669339-6412-1-git-send-email-miguel.robles@farole.net>
 <e1a6a3a2-3246-7ac3-81d7-6fff42947584@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1a6a3a2-3246-7ac3-81d7-6fff42947584@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 19, 2017 at 11:06:17AM +0000, Jonathan Cameron wrote:
> On 16/03/17 13:02, Miguel Robles wrote:
> > Fix checkpatch warnings:
> > Symbolic permissions 'S_IWUSR' are not preferred.
> > 
> > Signed-off-by: Miguel Robles <miguel.robles@farole.net>
> Fine, with the exception that I'd like to see the name of the driver in the
> description.
>
Thank you, I have taken note of your return for the next patchs.

Miguel

> Applied with that added to the togreg branch of iio.git and pushed out as
> testing for the autobuilders to play with it.
> 
> Thanks,
> 
> Jonathan
> > ---
> >  drivers/staging/iio/cdc/ad7746.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> > index 81f8b9e..6c688bd 100644
> > --- a/drivers/staging/iio/cdc/ad7746.c
> > +++ b/drivers/staging/iio/cdc/ad7746.c
> > @@ -351,15 +351,15 @@ static ssize_t ad7746_start_gain_calib(struct device *dev,
> >  }
> >  
> >  static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
> > -		       S_IWUSR, NULL, ad7746_start_offset_calib, CIN1);
> > +		       0200, NULL, ad7746_start_offset_calib, CIN1);
> >  static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
> > -		       S_IWUSR, NULL, ad7746_start_offset_calib, CIN2);
> > +		       0200, NULL, ad7746_start_offset_calib, CIN2);
> >  static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
> > -		       S_IWUSR, NULL, ad7746_start_gain_calib, CIN1);
> > +		       0200, NULL, ad7746_start_gain_calib, CIN1);
> >  static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
> > -		       S_IWUSR, NULL, ad7746_start_gain_calib, CIN2);
> > +		       0200, NULL, ad7746_start_gain_calib, CIN2);
> >  static IIO_DEVICE_ATTR(in_voltage0_calibscale_calibration,
> > -		       S_IWUSR, NULL, ad7746_start_gain_calib, VIN);
> > +		       0200, NULL, ad7746_start_gain_calib, VIN);
> >  
> >  static int ad7746_store_cap_filter_rate_setup(struct ad7746_chip_info *chip,
> >  					      int val)
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
