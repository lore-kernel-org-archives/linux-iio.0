Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35221 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752845AbcKLOY7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 09:24:59 -0500
Subject: Re: [PATCH 1/2] staging: iio: ad7606: replace range/range_available
 with corresponding scale
To: Lars-Peter Clausen <lars@metafoo.de>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1478846078-22207-1-git-send-email-eraretuya@gmail.com>
 <1478846078-22207-2-git-send-email-eraretuya@gmail.com>
 <eef1f86d-a0bf-9c22-4391-aca2680972d5@metafoo.de>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org,
        Linus Walleij <linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c9a4b2b3-6c4b-4c3c-da79-eba8398a5a0d@kernel.org>
Date: Sat, 12 Nov 2016 14:24:57 +0000
MIME-Version: 1.0
In-Reply-To: <eef1f86d-a0bf-9c22-4391-aca2680972d5@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/11/16 14:18, Lars-Peter Clausen wrote:
> On 11/11/2016 07:34 AM, Eva Rachel Retuya wrote:
>> Eliminate the non-standard attribute in_voltage_range and move its
>> functionality under the scale attribute. read_raw() has been taken care
>> of previously so only write_raw() is handled here.
>>
>> Additionally, rename the attribute in_voltage_range_available into
>> in_voltage_scale_available.
>>
>> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> 
> Hi,
> 
> Thanks for the patch. Unfortunately this is not quite this straight forward.
> 
> The scale is what you multiply the raw with to get the value in the standard
> IIO unit. Range as implemented in this driver is the maximum output voltage.
> 
> To get the scale we need to look at the transfer function of the ADC [1].
> The transfer function tells us that 1 LSB is 305uV for the 10V range and
> 152uV for the 5V range.
> 
> More specifically this is $RANGE*2/2**16 (times two since the ADC is bipolar).
> 
> Since the default unit for IIO is mV for voltages we need to multiply this
> by 1000.
> 
> The other thing we need to handle is the case where the RANGE pin is not
> connected to a GPIO but either hardwired to 1 or 0. Which we need to handle
> somehow.
Is it just me who thought, we need a fixed GPI like a fixed regulator?
Would allow this sort of fixed wiring to be simply defined.

Linus, worth exploring?

I doubt this will be the last case of this particular problem
(not exactly unusual to hard wire control lines like these as which range
makes sense is often a feature of the device).

Would be a pain to have to add code to every driver to cover the fixed
case.
> 
> [1]
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD7606_7606-6_7606-4.pdf#page=23
> (right bottom)
> 
>> ---
>>  drivers/staging/iio/adc/ad7606.c | 56 ++++++++++++----------------------------
>>  1 file changed, 16 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
>> index 4531908..cceb18c 100644
>> --- a/drivers/staging/iio/adc/ad7606.c
>> +++ b/drivers/staging/iio/adc/ad7606.c
>> @@ -161,42 +161,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>>  	return -EINVAL;
>>  }
>>  
>> -static ssize_t ad7606_show_range(struct device *dev,
>> -				 struct device_attribute *attr, char *buf)
>> -{
>> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> -	struct ad7606_state *st = iio_priv(indio_dev);
>> -
>> -	return sprintf(buf, "%u\n", st->range);
>> -}
>> -
>> -static ssize_t ad7606_store_range(struct device *dev,
>> -				  struct device_attribute *attr,
>> -				  const char *buf, size_t count)
>> -{
>> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> -	struct ad7606_state *st = iio_priv(indio_dev);
>> -	unsigned long lval;
>> -	int ret;
>> -
>> -	ret = kstrtoul(buf, 10, &lval);
>> -	if (ret)
>> -		return ret;
>> -
>> -	if (!(lval == 5000 || lval == 10000))
>> -		return -EINVAL;
>> -
>> -	mutex_lock(&indio_dev->mlock);
>> -	gpiod_set_value(st->gpio_range, lval == 10000);
>> -	st->range = lval;
>> -	mutex_unlock(&indio_dev->mlock);
>> -
>> -	return count;
>> -}
>> -
>> -static IIO_DEVICE_ATTR(in_voltage_range, S_IRUGO | S_IWUSR,
>> -		       ad7606_show_range, ad7606_store_range, 0);
>> -static IIO_CONST_ATTR(in_voltage_range_available, "5000 10000");
>> +static IIO_CONST_ATTR(in_voltage_scale_available, "5000 10000");
>>  
>>  static int ad7606_oversampling_get_index(unsigned int val)
>>  {
>> @@ -221,6 +186,19 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>>  	int ret;
>>  
>>  	switch (mask) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		if (val2)
>> +			return -EINVAL;
>> +
>> +		if (!(val == 5000 || val == 10000))
>> +			return -EINVAL;
>> +
>> +		mutex_lock(&indio_dev->mlock);
>> +		gpiod_set_value(st->gpio_range, val == 10000);
>> +		st->range = val;
>> +		mutex_unlock(&indio_dev->mlock);
>> +
>> +		return 0;
>>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>>  		if (val2)
>>  			return -EINVAL;
>> @@ -247,8 +225,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>>  static IIO_CONST_ATTR(oversampling_ratio_available, "1 2 4 8 16 32 64");
>>  
>>  static struct attribute *ad7606_attributes_os_and_range[] = {
>> -	&iio_dev_attr_in_voltage_range.dev_attr.attr,
>> -	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
>> +	&iio_const_attr_in_voltage_scale_available.dev_attr.attr,
>>  	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
>>  	NULL,
>>  };
>> @@ -267,8 +244,7 @@ static const struct attribute_group ad7606_attribute_group_os = {
>>  };
>>  
>>  static struct attribute *ad7606_attributes_range[] = {
>> -	&iio_dev_attr_in_voltage_range.dev_attr.attr,
>> -	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
>> +	&iio_const_attr_in_voltage_scale_available.dev_attr.attr,
>>  	NULL,
>>  };
>>  
>>
> 

