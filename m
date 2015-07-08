Return-Path: <dannenberg@ti.com>
Message-ID: <559D5366.8030003@ti.com>
Date: Wed, 8 Jul 2015 11:44:22 -0500
From: Andreas Dannenberg <dannenberg@ti.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 1/2] iio: light: add support for TI's opt3001 light
 sensor
References: <1435876079-26287-1-git-send-email-dannenberg@ti.com> <1435876079-26287-2-git-send-email-dannenberg@ti.com> <55993A4C.10105@kernel.org>
In-Reply-To: <55993A4C.10105@kernel.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 07/05/2015 09:08 AM, Jonathan Cameron wrote:
<snip>
> Looking pretty good to me, though I'd like to give Peter time to take
> another look and give his reviewed-by etc.
> 
> One really minor suggestion from me...
> <snip>
>> +
>> +static int opt3001_probe(struct i2c_client *client,
>> +		const struct i2c_device_id *id)
>> +{
>> +	struct device *dev = &client->dev;
>> +
>> +	struct iio_dev *iio;
>> +	struct opt3001 *opt;
>> +	int irq = client->irq;
>> +	int ret = -ENOMEM;
>> +
>> +	iio = devm_iio_device_alloc(dev, sizeof(*opt));
>> +	if (!iio)
> return -ENOMEM; would be cleaner, then there is no need to initialize
> ret either.

Hi Jonathan,
thanks for looking at my code. While we are waiting for additional feedback would you
like me to go ahead and re-spin/re-test the patch with your latest suggestion?

Regards,

-- 
Andreas Dannenberg
Texas Instruments Inc.
