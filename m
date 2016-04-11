Return-Path: <leonard.crestez@intel.com>
Subject: Re: [PATCH 5/5] max44000: Initial triggered buffer support
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <cover.1460045763.git.leonard.crestez@intel.com>
 <dc82c7c28df002717a2668708cc96732a0856fac.1460045763.git.leonard.crestez@intel.com>
 <alpine.DEB.2.02.1604072152010.26969@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Daniel Baluta <daniel.baluta@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <570BCCA5.7020004@intel.com>
Date: Mon, 11 Apr 2016 19:11:17 +0300
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1604072152010.26969@pmeerw.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 04/07/2016 10:59 PM, Peter Meerwald-Stadler wrote:
>>   static int max44000_probe(struct i2c_client *client,
>>   			  const struct i2c_device_id *id)
>>   {
>> @@ -513,6 +569,12 @@ static int max44000_probe(struct i2c_client *client,
>>   		return ret;
>>   	}
>>
>> +	ret = iio_triggered_buffer_setup(indio_dev, NULL, max44000_trigger_handler, NULL);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "iio triggered buffer setup failed\n");
>> +		return ret;
>> +	}
>> +
>>   	return iio_device_register(indio_dev);
>
> no devm_ possible anymore :-)

It's not clear to me why explicit calls to iio_triggered_buffer_cleanup 
are done in every driver. Wouldn't it be possible for iio_dev_release to 
call iio_triggered_buffer_cleanup? That would require 
triggered_buffer_cleanup to explictly NULL the fields it deallocates so 
that duplicate cleanups don't crash.

--
Regards,
Leonard
