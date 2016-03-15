Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:62570 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932842AbcCOJ2d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 15 Mar 2016 05:28:33 -0400
Message-ID: <56E7D5E8.2050003@parrot.com>
Date: Tue, 15 Mar 2016 10:29:12 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: <linux-iio@vger.kernel.org>
Subject: iio and regulator api usage
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

After Jonathan's ms5611 review, I digged a bit deeper into regulator API.
I must confess it looks rather confusing to me, especially with regard to
optional regulator support.

Most often, IIO drivers implement the following scheme at probing time to
enable an optional regulator:
</code>
/* At probing time */
void mydriver_power_enable(struct iio_dev *indio_dev)
{
     struct mydriver_priv *priv = iio_priv(indio_dev);

     /* Regulators not mandatory, but if requested we should enable them. */
     priv->vdd = devm_regulator_get_optional(indio_dev->dev.parent, "vdd");
     if (!IS_ERR(priv->vdd)) {
         int err = regulator_enable(priv->vdd);
         if (err != 0)
             dev_warn(&indio_dev->dev,
                  "Failed to enable specified Vdd supply\n");
     }

     /* Keep going */
     ...
}

/* At removal time */
void mydriver_power_disable(struct iio_dev *indio_dev)
{
     struct mydriver_priv *priv = iio_priv(indio_dev);

     ...
     if (!IS_ERR(priv->vdd))
         regulator_disable(priv->vdd);
     ...
}
<code/>

A problem may arise with this piece of code: when 
devm_regulator_get_optional
returns -EPROBE_DEFER, driver will go on initializing with no regulator 
instead
of deferring their probing operations at a later time as it should (to wait
regulator initialization completion).
Although related to real troubles, other error codes are also ignored 
(EPERM,
EBUSY, ENOMEM...), which is even worse.
 From my understanding, optional regulator usage should be enforced when 
present
and ignored if not there. The only error code which may be ignored should be
ENODEV when the regulator is optional.
This is clearly not implemented this way in the above example.

You can see such code in:
drivers/adc/max1363.c
drivers/common/st_sensors/st_sensors_core.c
drivers/dac/ad5686.c

The same seems to happen when using the alternate devm_regulator_get for 
optional
usage purposes as in:
drivers/iio/amplifiers/ad8366.c
drivers/iio/dac/ad5624r_spi.c
and others...

So here is my simple question: how should I implement optional regulator 
support ?

Thanks for sharing your time and knowledge. Regards,
Grégor.
