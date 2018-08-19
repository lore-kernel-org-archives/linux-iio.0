Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbeHSTGT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 15:06:19 -0400
Date: Sun, 19 Aug 2018 16:54:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: David Frey <dpfrey@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/7] iio: chemical: bme680: cleanup bme680_read_calib
 formatting
Message-ID: <20180819165421.77b693ed@archlinux>
In-Reply-To: <20180818110655.GC24920@himanshu-Vostro-3559>
References: <20180817190319.13119-1-dpfrey@gmail.com>
        <20180817190319.13119-3-dpfrey@gmail.com>
        <20180818110655.GC24920@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 18 Aug 2018 16:36:55 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Fri, Aug 17, 2018 at 12:03:14PM -0700, David Frey wrote:
> > Signed-off-by: David Frey <dpfrey@gmail.com>  
> 
> Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
> Tested-by: Himanshu Jha <himanshujha199640@gmail.com>
> 
> Also, 0-day tested with build success!
> 
> Thanks
> 
> One minor comment below.
> 
> Maybe Jonathan would fix while applying, so don't need a
> new version for this.
I've fixed them up.

I would have liked to see a little more detail in the description of what
was being changed and why though...

Jonathan
> 
> > ---
> >  drivers/iio/chemical/bme680_core.c | 36 ++++++++++++------------------------
> >  1 file changed, 12 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> > index 35cbcb16c9f9..cde08d57e7d5 100644
> > --- a/drivers/iio/chemical/bme680_core.c
> > +++ b/drivers/iio/chemical/bme680_core.c
> > @@ -102,16 +102,14 @@ static int bme680_read_calib(struct bme680_data *data,
> >  	__le16 buf;
> >  
> >  	/* Temperature related coefficients */
> > -	ret = regmap_bulk_read(data->regmap, BME680_T1_LSB_REG,
> > -			       (u8 *) &buf, 2);
> > +	ret = regmap_bulk_read(data->regmap, BME680_T1_LSB_REG, (u8 *) &buf, 2);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read BME680_T1_LSB_REG\n");
> >  		return ret;
> >  	}
> >  	calib->par_t1 = le16_to_cpu(buf);
> >  
> > -	ret = regmap_bulk_read(data->regmap, BME680_T2_LSB_REG,
> > -			       (u8 *) &buf, 2);
> > +	ret = regmap_bulk_read(data->regmap, BME680_T2_LSB_REG, (u8 *) &buf, 2);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read BME680_T2_LSB_REG\n");
> >  		return ret;
> > @@ -126,16 +124,14 @@ static int bme680_read_calib(struct bme680_data *data,
> >  	calib->par_t3 = tmp;
> >  
> >  	/* Pressure related coefficients */
> > -	ret = regmap_bulk_read(data->regmap, BME680_P1_LSB_REG,
> > -			       (u8 *) &buf, 2);
> > +	ret = regmap_bulk_read(data->regmap, BME680_P1_LSB_REG, (u8 *) &buf, 2);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read BME680_P1_LSB_REG\n");
> >  		return ret;
> >  	}
> >  	calib->par_p1 = le16_to_cpu(buf);
> >  
> > -	ret = regmap_bulk_read(data->regmap, BME680_P2_LSB_REG,
> > -			       (u8 *) &buf, 2);
> > +	ret = regmap_bulk_read(data->regmap, BME680_P2_LSB_REG, (u8 *) &buf, 2);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read BME680_P2_LSB_REG\n");
> >  		return ret;
> > @@ -149,16 +145,14 @@ static int bme680_read_calib(struct bme680_data *data,
> >  	}
> >  	calib->par_p3 = tmp;
> >  
> > -	ret = regmap_bulk_read(data->regmap, BME680_P4_LSB_REG,
> > -			       (u8 *) &buf, 2);
> > +	ret = regmap_bulk_read(data->regmap, BME680_P4_LSB_REG, (u8 *) &buf, 2);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read BME680_P4_LSB_REG\n");
> >  		return ret;
> >  	}
> >  	calib->par_p4 = le16_to_cpu(buf);
> >  
> > -	ret = regmap_bulk_read(data->regmap, BME680_P5_LSB_REG,
> > -			       (u8 *) &buf, 2);
> > +	ret = regmap_bulk_read(data->regmap, BME680_P5_LSB_REG, (u8 *) &buf, 2);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read BME680_P5_LSB_REG\n");
> >  		return ret;
> > @@ -179,16 +173,14 @@ static int bme680_read_calib(struct bme680_data *data,
> >  	}
> >  	calib->par_p7 = tmp;
> >  
> > -	ret = regmap_bulk_read(data->regmap, BME680_P8_LSB_REG,
> > -			       (u8 *) &buf, 2);
> > +	ret = regmap_bulk_read(data->regmap, BME680_P8_LSB_REG, (u8 *) &buf, 2);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read BME680_P8_LSB_REG\n");
> >  		return ret;
> >  	}
> >  	calib->par_p8 = le16_to_cpu(buf);
> >  
> > -	ret = regmap_bulk_read(data->regmap, BME680_P9_LSB_REG,
> > -			       (u8 *) &buf, 2);
> > +	ret = regmap_bulk_read(data->regmap, BME680_P9_LSB_REG, (u8 *) &buf, 2);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read BME680_P9_LSB_REG\n");
> >  		return ret;
> > @@ -208,30 +200,26 @@ static int bme680_read_calib(struct bme680_data *data,
> >  		dev_err(dev, "failed to read BME680_H1_MSB_REG\n");
> >  		return ret;
> >  	}
> > -
> >  	ret = regmap_read(data->regmap, BME680_H1_LSB_REG, &tmp_lsb);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read BME680_H1_LSB_REG\n");
> >  		return ret;
> >  	}
> > -
> >  	calib->par_h1 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
> > -				(tmp_lsb & BME680_BIT_H1_DATA_MSK);
> > +	                (tmp_lsb & BME680_BIT_H1_DATA_MSK);  
> 
> Prefer tabs instead of spaces!
> Please run checkpatch on the patch to get those warnings.
> 
> >  	ret = regmap_read(data->regmap, BME680_H2_MSB_REG, &tmp_msb);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read BME680_H2_MSB_REG\n");
> >  		return ret;
> >  	}
> > -
> >  	ret = regmap_read(data->regmap, BME680_H2_LSB_REG, &tmp_lsb);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read BME680_H2_LSB_REG\n");
> >  		return ret;
> >  	}
> > -
> >  	calib->par_h2 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
> > -				(tmp_lsb >> BME680_HUM_REG_SHIFT_VAL);
> > +	                (tmp_lsb >> BME680_HUM_REG_SHIFT_VAL);  
> 
> Same here.
> 
