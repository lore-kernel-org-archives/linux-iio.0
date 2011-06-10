Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:34539 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245Ab1FJNsx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2011 09:48:53 -0400
Message-ID: <4DF222AA.7020809@cam.ac.uk>
Date: Fri, 10 Jun 2011 14:56:58 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH 2/2] iio: dac: New driver for AD5686R, AD5685R, AD5684R
 Digital to analog converters
References: <1307706541-4750-1-git-send-email-michael.hennerich@analog.com> <1307706541-4750-2-git-send-email-michael.hennerich@analog.com> <4DF218F1.3090602@cam.ac.uk> <4DF21D1A.8010703@analog.com>
In-Reply-To: <4DF21D1A.8010703@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

...
>>> +}
>>> +
>>> +static ssize_t ad5686_write_dac_powerdown(struct device *dev,
>>> +                                         struct device_attribute *attr,
>>> +                                         const char *buf, size_t len)
>>> +{
>>> +     long readin;
>>> +     int ret;
>>> +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>> +     struct ad5686_state *st = iio_priv(indio_dev);
>>> +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>>> +
>> strtobool perhaps? Seems reasonable to write Y to power down the device as well
>> for example.
> That must be a new function. I never saw it before.
> Good match here.

Yup, I added it ;) Got fed up with replicating that functionality all over the place.
As they say, 'scratching an itch...'

>>> +/**
>>> + * struct ad5686_chip_info - chip specific information
>>> + * @int_vref_mv:     AD5620/40/60: the internal reference voltage
>> silly question, but do you have chips to add where this actually varies?
> There might be ones in future.
Then I'd argue for adding it in the future!
>>> +#endif /* SPI_AD5684_H_ */
> Thanks for the review!
You are welcome.  Keep sending me nice drivers like this an I'll be very
happy ;)
