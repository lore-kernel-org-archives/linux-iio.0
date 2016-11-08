Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47590 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbcKHP63 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 10:58:29 -0500
Date: Tue, 8 Nov 2016 10:58:27 -0500
From: Brian Masney <masneyb@onstation.org>
To: Joe Perches <joe@perches.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: Re: [PATCH v2 09/23] staging: iio: tsl2583: cleaned up logging
Message-ID: <20161108155827.GB29879@basecamp.onstation.org>
References: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
 <1478600208-21153-10-git-send-email-masneyb@onstation.org>
 <1478600960.22008.10.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478600960.22008.10.camel@perches.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 08, 2016 at 02:29:20AM -0800, Joe Perches wrote:
> On Tue, 2016-11-08 at 05:16 -0500, Brian Masney wrote:
> > There are several places in the code where the function name is
> > hardcoded in the log message. Use the __func__ constant string to build
> > the log message. This also clarifies some of the error messages to match
> > the code and ensures that the correct priority is used since the message
> > is already being changed.
> []
> > diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> []
> > @@ -170,13 +170,15 @@ static int taos_get_lux(struct iio_dev *indio_dev)
> >  
> >  	ret = i2c_smbus_read_byte_data(chip->client, TSL258X_CMD_REG);
> >  	if (ret < 0) {
> > -		dev_err(&chip->client->dev, "taos_get_lux failed to read CMD_REG\n");
> > +		dev_err(&chip->client->dev, "%s failed to read CMD_REG register\n",
> > +			__func__);
> 
> Please use "%s: <message>", __func__ consistently
> 
> > @@ -545,12 +549,15 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
> >  	 * and the last table entry is all 0.
> >  	 */
> >  	n = value[0];
> > -	if ((n % 3) || n < 6 || n > ((ARRAY_SIZE(taos_device_lux) - 1) * 3)) {
> > -		dev_info(dev, "LUX TABLE INPUT ERROR 1 Value[0]=%d\n", n);
> > +	if ((n % 3) || n < 6 || n > TSL2583_MAX_LUX_INTS) {
> > +		dev_err(dev,
> > +			"%s: The number of entries in the lux table must be a multiple of 3 and within the range [6, %zu]",
> > +			__func__, TSL2583_MAX_LUX_INTS);
> 
> Missing terminating '\n"

Thanks for the feedback Joe. I'll send out an updated patch series on
Friday.

Brian
