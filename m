Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52158 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbcFKQHn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2016 12:07:43 -0400
Subject: Re: [PATCH] iio: light: tcs3414: use iio helper function to guarantee
 direct mode
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Alison Schofield <amsfield22@gmail.com>
References: <20160607050913.GA26916@d830.WORKGROUP>
 <alpine.DEB.2.02.1606070723120.10952@pmeerw.net>
 <25540d4e-4803-f1be-7dcc-086eb7708233@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <26a354c9-094d-c164-747b-71baf11eea81@kernel.org>
Date: Sat, 11 Jun 2016 17:07:41 +0100
MIME-Version: 1.0
In-Reply-To: <25540d4e-4803-f1be-7dcc-086eb7708233@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/06/16 16:56, Jonathan Cameron wrote:
> On 07/06/16 06:23, Peter Meerwald-Stadler wrote:
>>
>>> Replace the code that guarantees the device stays in direct mode
>>> with iio_device_claim_direct_mode() which does same.  This allows
>>> removal of an unused lock in the device private global data.
>>
>> Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Applied, thanks.
Backed out - see the tcs3472 comment.  This lock isn't there to
protect against mode changes...


> 
> Joanthan
>>  
>>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>>> ---
>>>  drivers/iio/light/tcs3414.c | 12 +++++-------
>>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
>>> index f90f8c5..8a15fb5 100644
>>> --- a/drivers/iio/light/tcs3414.c
>>> +++ b/drivers/iio/light/tcs3414.c
>>> @@ -53,7 +53,6 @@
>>>  
>>>  struct tcs3414_data {
>>>  	struct i2c_client *client;
>>> -	struct mutex lock;
>>>  	u8 control;
>>>  	u8 gain;
>>>  	u8 timing;
>>> @@ -134,16 +133,16 @@ static int tcs3414_read_raw(struct iio_dev *indio_dev,
>>>  
>>>  	switch (mask) {
>>>  	case IIO_CHAN_INFO_RAW:
>>> -		if (iio_buffer_enabled(indio_dev))
>>> -			return -EBUSY;
>>> -		mutex_lock(&data->lock);
>>> +		ret = iio_device_claim_direct_mode(indio_dev);
>>> +		if (ret)
>>> +			return ret;
>>>  		ret = tcs3414_req_data(data);
>>>  		if (ret < 0) {
>>> -			mutex_unlock(&data->lock);
>>> +			iio_device_release_direct_mode(indio_dev);
>>>  			return ret;
>>>  		}
>>>  		ret = i2c_smbus_read_word_data(data->client, chan->address);
>>> -		mutex_unlock(&data->lock);
>>> +		iio_device_release_direct_mode(indio_dev);
>>>  		if (ret < 0)
>>>  			return ret;
>>>  		*val = ret;
>>> @@ -288,7 +287,6 @@ static int tcs3414_probe(struct i2c_client *client,
>>>  	data = iio_priv(indio_dev);
>>>  	i2c_set_clientdata(client, indio_dev);
>>>  	data->client = client;
>>> -	mutex_init(&data->lock);
>>>  
>>>  	indio_dev->dev.parent = &client->dev;
>>>  	indio_dev->info = &tcs3414_info;
>>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

