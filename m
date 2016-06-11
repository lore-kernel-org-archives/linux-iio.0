Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52141 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbcFKQFS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2016 12:05:18 -0400
Subject: Re: [PATCH] iio: light: isl29125: use iio helper function to
 guarantee direct mode
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Alison Schofield <amsfield22@gmail.com>
References: <20160607050823.GA26908@d830.WORKGROUP>
 <alpine.DEB.2.02.1606070722140.10952@pmeerw.net>
 <af8c4f98-9f48-def2-2753-755a11af4979@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fbc33957-2e7e-eac5-eaf7-b089d9c83163@kernel.org>
Date: Sat, 11 Jun 2016 17:05:16 +0100
MIME-Version: 1.0
In-Reply-To: <af8c4f98-9f48-def2-2753-755a11af4979@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/06/16 16:57, Jonathan Cameron wrote:
> On 07/06/16 06:23, Peter Meerwald-Stadler wrote:
>>
>>> Replace the code that guarantees the device stays in direct mode
>>> with iio_device_claim_direct_mode() which does same.  This allows
>>> removal of an unused lock in the device private global data.
>>
>> nice!
>> Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Applied and pushed out as testing for the autobuilders to play with it.
Actually hold that - see the tcs3472 response.  This lock isn't actually
here to prevent the buffer running at the same time as the raw call...

Backed out for now.

Jonathan
> 
> Thanks,
> 
> Jonathan
>>
>>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>>> ---
>>>  drivers/iio/light/isl29125.c | 10 ++++------
>>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
>>> index e2945a2..a6b9d66 100644
>>> --- a/drivers/iio/light/isl29125.c
>>> +++ b/drivers/iio/light/isl29125.c
>>> @@ -50,7 +50,6 @@
>>>  
>>>  struct isl29125_data {
>>>  	struct i2c_client *client;
>>> -	struct mutex lock;
>>>  	u8 conf1;
>>>  	u16 buffer[8]; /* 3x 16-bit, padding, 8 bytes timestamp */
>>>  };
>>> @@ -128,11 +127,11 @@ static int isl29125_read_raw(struct iio_dev *indio_dev,
>>>  
>>>  	switch (mask) {
>>>  	case IIO_CHAN_INFO_RAW:
>>> -		if (iio_buffer_enabled(indio_dev))
>>> -			return -EBUSY;
>>> -		mutex_lock(&data->lock);
>>> +		ret = iio_device_claim_direct_mode(indio_dev);
>>> +		if (ret)
>>> +			return ret;
>>>  		ret = isl29125_read_data(data, chan->scan_index);
>>> -		mutex_unlock(&data->lock);
>>> +		iio_device_release_direct_mode(indio_dev);
>>>  		if (ret < 0)
>>>  			return ret;
>>>  		*val = ret;
>>> @@ -259,7 +258,6 @@ static int isl29125_probe(struct i2c_client *client,
>>>  	data = iio_priv(indio_dev);
>>>  	i2c_set_clientdata(client, indio_dev);
>>>  	data->client = client;
>>> -	mutex_init(&data->lock);
>>>  
>>>  	indio_dev->dev.parent = &client->dev;
>>>  	indio_dev->info = &isl29125_info;
>>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

