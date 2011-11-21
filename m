Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-123.synserver.de ([212.40.185.123]:1513 "HELO
	smtp-out-120.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1755805Ab1KUKqX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Nov 2011 05:46:23 -0500
Message-ID: <4ECA2C13.6080901@metafoo.de>
Date: Mon, 21 Nov 2011 11:46:43 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] staging:iio:dac: Add AD5764 driver
References: <1321865615-16681-1-git-send-email-lars@metafoo.de> <CAM=Q2cv2kbpLxtgmJ=zSGRnmd6MyxuqRb3ErMjKmLbUitm4+bg@mail.gmail.com>
In-Reply-To: <CAM=Q2cv2kbpLxtgmJ=zSGRnmd6MyxuqRb3ErMjKmLbUitm4+bg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/21/2011 10:04 AM, Shubhrajyoti Datta wrote:

>> +static int ad5764_chan_info_to_reg(struct iio_chan_spec const *chan, long info)
>> +{
>> +       switch (info) {
>> +       case 0:
>> +               return AD5764_REG_DATA(chan->address);
>> +       case IIO_CHAN_INFO_CALIBBIAS:
>> +               return AD5764_REG_OFFSET(chan->address);
>> +       case IIO_CHAN_INFO_CALIBSCALE:
>> +               return AD5764_REG_FINE_GAIN(chan->address);
>> +       default:
>> +               BUG();
> Should we BUG here?
> Is it that severe  because it will halt the whole system?

given that this should only trigger if something went wrong really bad I
think it is OK to BUG here. As far as I can see the compiler will even
remove it, since it is in a dead code path.

- Lars
