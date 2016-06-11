Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52188 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbcFKQNR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2016 12:13:17 -0400
Subject: Re: [PATCH] iio: light: tcs3472: use iio helper function to guarantee
 direct mode
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Alison Schofield <amsfield22@gmail.com>
References: <20160607051015.GA26924@d830.WORKGROUP>
 <alpine.DEB.2.02.1606070723230.10952@pmeerw.net>
 <69bc7ae4-218c-3952-0105-e16c665e3d6f@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f21803fc-8cfd-7873-6cb0-a99c7c62b9d1@kernel.org>
Date: Sat, 11 Jun 2016 17:13:15 +0100
MIME-Version: 1.0
In-Reply-To: <69bc7ae4-218c-3952-0105-e16c665e3d6f@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/06/16 17:03, Jonathan Cameron wrote:
> On 07/06/16 06:23, Peter Meerwald-Stadler wrote:
>> On Mon, 6 Jun 2016, Alison Schofield wrote:
>>
>>> Replace the code that guarantees the device stays in direct mode
>>> with iio_device_claim_direct_mode() which does same.  This allows
>>> removal of an unused lock in the device private global data.
>>
>> Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>>  
>>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> There is an ever so slightly difference in how these all work after
> the change.  They will return -EBUSY rather than holding then returning
> a valid value under the circumstances of two reads coming through
> sysfs at the same time.  This is a pretty obscure case so
> I think we are OK with this.
> 
> Actually pending responses to this, I'm going to back out the other
> two similar patches.  Just goes to show, that if you show someone
> something 3 times they might finally notice the issue!
Looking at this more carefully the lack of locking around the buffer
in use check was clearly broken and your new code fixes both that
and allows the lock removal.

I was overthinking this...

Applied
> 
> 
>>> ---
>>>  drivers/iio/light/tcs3472.c | 13 +++++--------
>>>  1 file changed, 5 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
>>> index 1b530bf..b29312f 100644
>>> --- a/drivers/iio/light/tcs3472.c
>>> +++ b/drivers/iio/light/tcs3472.c
>>> @@ -52,7 +52,6 @@
>>>  
>>>  struct tcs3472_data {
>>>  	struct i2c_client *client;
>>> -	struct mutex lock;
>>>  	u8 enable;
>>>  	u8 control;
>>>  	u8 atime;
>>> @@ -117,17 +116,16 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
>>>  
>>>  	switch (mask) {
>>>  	case IIO_CHAN_INFO_RAW:
>>> -		if (iio_buffer_enabled(indio_dev))
>>> -			return -EBUSY;
>>> -
>>> -		mutex_lock(&data->lock);
>>> +		ret = iio_device_claim_direct_mode(indio_dev);
>>> +		if (ret)
>>> +			return ret;
>>>  		ret = tcs3472_req_data(data);
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
>>> @@ -263,7 +261,6 @@ static int tcs3472_probe(struct i2c_client *client,
>>>  	data = iio_priv(indio_dev);
>>>  	i2c_set_clientdata(client, indio_dev);
>>>  	data->client = client;
>>> -	mutex_init(&data->lock);
>>>  
>>>  	indio_dev->dev.parent = &client->dev;
>>>  	indio_dev->info = &tcs3472_info;
>>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

