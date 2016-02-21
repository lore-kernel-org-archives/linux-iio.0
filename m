Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:33546 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751373AbcBUU7t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2016 15:59:49 -0500
Message-ID: <1456088384.31061.2.camel@perches.com>
Subject: Re: [RFC PATCH 7/9] iio: imu: inv_mpu6050: Fix alignment with open
 parenthesis
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	wsa@the-dreams.de, linux-i2c@vger.kernel.org,
	lucas.demarchi@intel.com, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, adi.reus@gmail.com, cmo@melexis.com,
	mwelling@ieee.org
Date: Sun, 21 Feb 2016 12:59:44 -0800
In-Reply-To: <56CA2101.8050805@kernel.org>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
	 <1455810794-3188-8-git-send-email-daniel.baluta@intel.com>
	 <56CA2101.8050805@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 2016-02-21 at 20:41 +0000, Jonathan Cameron wrote:
> On 18/02/16 15:53, Daniel Baluta wrote:
> > This makes code consistent around inv_mpu6050 driver and
> > fixes the following checkpatch.pl warning:
> > CHECK: Alignment should match open parenthesis
> > 
> > Note that there were few cases were it was not possible to
> > fix this due to making the line too long, but we can live with that.
> > 
> > Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> Applied
[]
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
[]
> > @@ -217,11 +217,10 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
> >  	return IIO_VAL_INT;
> >  }
> >  
> > -static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
> > -			      struct iio_chan_spec const *chan,
> > -			      int *val,
> > -			      int *val2,
> > -			      long mask) {
> > +static int
> > +inv_mpu6050_read_raw(struct iio_dev *indio_dev,
> > +		     struct iio_chan_spec const *chan,
> > +		     int *val, int *val2, long mask) {

Ideally, you'd also convert this form to use
the open brace on a new line like:

static int
inv_mpu6050_read_raw(struct iio_dev *indio_dev,
		     struct iio_chan_spec const *chan,
		     int *val, int *val2, long mask)
{

