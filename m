Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49323 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755670AbcIRKIb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 06:08:31 -0400
Subject: Re: [PATCH 03/15 v2] iio: accel: kxsd9: split out a common remove()
 function
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
 <1472723089-25113-3-git-send-email-linus.walleij@linaro.org>
 <e4f8fd50-8674-10f7-80f6-df2a972e07b0@kernel.org>
 <2e4032eb-bd06-48ab-5bc2-a7c52b46b27d@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9a979377-dc89-4c82-3c6b-155cf073189e@kernel.org>
Date: Sun, 18 Sep 2016 11:08:30 +0100
MIME-Version: 1.0
In-Reply-To: <2e4032eb-bd06-48ab-5bc2-a7c52b46b27d@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/09/16 20:29, Jonathan Cameron wrote:
> On 03/09/16 18:38, Jonathan Cameron wrote:
>> On 01/09/16 10:44, Linus Walleij wrote:
>>> This makes it possible to later split the transport mechanism
>>> using a generic probe() and a generic remove().
>>>
>>> Use dev_set_drvdata() and dev_get_drvdata() as a paired
>>> accessor to operate on the abstract struct device * regardless
>>> of the transport mechanism in use.
>>>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> Applied to the togreg branch of iio.git.
> Backed out due to later mess against the fixes.
Applied again :)

Will be pushed out as testing etc etc...

Jonathan
>>
>> Thanks,
>>
>> Jonathan
>>> ---
>>> ChangeLog v1->v2:
>>> - New patch replacing "iio: accel: kxsd: use devm_iio_device_register"
>>>   which didn't work out in practice: also later patches anyways
>>>   reintroduced the common remove() function so we may just as well
>>>   keep it around.
>>> ---
>>>  drivers/iio/accel/kxsd9.c | 24 ++++++++++++++----------
>>>  1 file changed, 14 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
>>> index df8a31e84c7d..1f9e9a867f34 100644
>>> --- a/drivers/iio/accel/kxsd9.c
>>> +++ b/drivers/iio/accel/kxsd9.c
>>> @@ -220,8 +220,7 @@ static const struct iio_info kxsd9_info = {
>>>  
>>>  static int kxsd9_common_probe(struct device *parent,
>>>  			      struct kxsd9_transport *transport,
>>> -			      const char *name,
>>> -			      struct iio_dev **retdev)
>>> +			      const char *name)
>>>  {
>>>  	struct iio_dev *indio_dev;
>>>  	struct kxsd9_state *st;
>>> @@ -248,7 +247,17 @@ static int kxsd9_common_probe(struct device *parent,
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> -	*retdev = indio_dev;
>>> +	dev_set_drvdata(parent, indio_dev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int kxsd9_common_remove(struct device *parent)
>>> +{
>>> +	struct iio_dev *indio_dev = dev_get_drvdata(parent);
>>> +
>>> +	iio_device_unregister(indio_dev);
>>> +
>>>  	return 0;
>>>  }
>>>  
>>> @@ -295,7 +304,6 @@ static int kxsd9_spi_readval(struct kxsd9_transport *tr, u8 address)
>>>  static int kxsd9_spi_probe(struct spi_device *spi)
>>>  {
>>>  	struct kxsd9_transport *transport;
>>> -	struct iio_dev *indio_dev;
>>>  	int ret;
>>>  
>>>  	transport = devm_kzalloc(&spi->dev, sizeof(*transport), GFP_KERNEL);
>>> @@ -311,20 +319,16 @@ static int kxsd9_spi_probe(struct spi_device *spi)
>>>  
>>>  	ret = kxsd9_common_probe(&spi->dev,
>>>  				 transport,
>>> -				 spi_get_device_id(spi)->name,
>>> -				 &indio_dev);
>>> +				 spi_get_device_id(spi)->name);
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> -	spi_set_drvdata(spi, indio_dev);
>>>  	return 0;
>>>  }
>>>  
>>>  static int kxsd9_spi_remove(struct spi_device *spi)
>>>  {
>>> -	iio_device_unregister(spi_get_drvdata(spi));
>>> -
>>> -	return 0;
>>> +	return kxsd9_common_remove(&spi->dev);
>>>  }
>>>  
>>>  static const struct spi_device_id kxsd9_spi_id[] = {
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

