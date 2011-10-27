Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-226.synserver.de ([212.40.185.226]:1430 "HELO
	smtp-out-225.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1750943Ab1J0HY5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Oct 2011 03:24:57 -0400
Message-ID: <4EA90765.6040705@metafoo.de>
Date: Thu, 27 Oct 2011 09:25:25 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 2/2] staging:iio:dac: Add AD5421 driver
References: <1319630467-6924-1-git-send-email-lars@metafoo.de> <1319630467-6924-2-git-send-email-lars@metafoo.de> <4EA83DB1.60606@cam.ac.uk>
In-Reply-To: <4EA83DB1.60606@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/26/2011 07:04 PM, Jonathan Cameron wrote:
> On 10/26/11 13:01, Lars-Peter Clausen wrote:
>> [...]
>> +
>> +static const struct iio_chan_spec ad5421_channels[] = {
>> +	{
>> +		.type = IIO_CURRENT,
>> +		.indexed = 1,
>> +		.output = 1,
>> +		.channel = 0,
>> +		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
>> +			IIO_CHAN_INFO_OFFSET_SHARED_BIT |
>> +			IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
>> +			IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
>> +		.scan_type = IIO_ST('u', 16, 16, 0),
>> +		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
>> +			IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
>> +	},
>> +	{
> Wasn't the plan to have this set to channel -1 to avoid it appearing?
> If that doesn't work we should probably make it do so.  At a quick glance
> I can't see why it wouldn't...

hehe, that was what the hunk at bottom was about. If the binary
representation of channel is greater than 0xffff it will overwrite other
fields. I'll resend with a proper fix included in the series.

>> +		.type = IIO_TEMP,
>> +		.channel = 1,
>> +		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
>> +	},
>> +};
>> +


