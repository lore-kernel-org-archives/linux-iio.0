Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52660 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab3JAI5o (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:57:44 -0400
Message-ID: <524A9CB3.2050400@kernel.org>
Date: Tue, 01 Oct 2013 10:58:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 06/15] staging:iio:hmc5843: Introduce helper functions
 to show/check list of int pairs
References: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net> <1379619360-8150-7-git-send-email-pmeerw@pmeerw.net> <524A9C24.5090805@kernel.org>
In-Reply-To: <524A9C24.5090805@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/13 10:55, Jonathan Cameron wrote:
> On 09/19/13 20:35, Peter Meerwald wrote:
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Applied, thanks
Little premature.  I had slightly different alignment of some
code in one of the patches I had merged, so this needed a bit of hand
editting as well.  Result is the same after both those patches are applied
though!


>> ---
>>  drivers/staging/iio/magnetometer/hmc5843.c | 56 ++++++++++++++++++------------
>>  1 file changed, 34 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
>> index 2d89549..71f26de 100644
>> --- a/drivers/staging/iio/magnetometer/hmc5843.c
>> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
>> @@ -356,24 +356,42 @@ static IIO_DEVICE_ATTR(meas_conf,
>>  			hmc5843_set_measurement_configuration,
>>  			0);
>>  
>> -static ssize_t hmc5843_show_samp_freq_avail(struct device *dev,
>> -				struct device_attribute *attr, char *buf)
>> +static ssize_t hmc5843_show_int_plus_micros(char *buf,
>> +	const int (*vals)[2], int n)
>>  {
>> -	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
>> -	ssize_t total_n = 0;
>> +	size_t len = 0;
>>  	int i;
>>  
>> -	for (i = 0; i < HMC5843_RATE_NOT_USED; i++) {
>> -		ssize_t n = sprintf(buf, "%d.%d ",
>> -			data->variant->regval_to_samp_freq[i][0],
>> -			data->variant->regval_to_samp_freq[i][1]);
>> -		buf += n;
>> -		total_n += n;
>> -	}
>> +	for (i = 0; i < n; i++)
>> +		len += scnprintf(buf + len, PAGE_SIZE - len,
>> +			"%d.%d ", vals[i][0], vals[i][1]);
>> +
>>  	/* replace trailing space by newline */
>> -	buf[-1] = '\n';
>> +	buf[len - 1] = '\n';
>> +
>> +	return len;
>> +}
>>  
>> -	return total_n;
>> +static int hmc5843_check_int_plus_micros(const int (*vals)[2], int n,
>> +					int val, int val2)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < n; i++) {
>> +		if (val == vals[i][0] && val2 == vals[i][1])
>> +			return i;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static ssize_t hmc5843_show_samp_freq_avail(struct device *dev,
>> +				struct device_attribute *attr, char *buf)
>> +{
>> +	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
>> +
>> +	return hmc5843_show_int_plus_micros(buf,
>> +		data->variant->regval_to_samp_freq, HMC5843_RATE_NOT_USED);
>>  }
>>  
>>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hmc5843_show_samp_freq_avail);
>> @@ -389,15 +407,9 @@ static s32 hmc5843_set_rate(struct hmc5843_data *data, u8 rate)
>>  static int hmc5843_check_samp_freq(struct hmc5843_data *data,
>>  	int val, int val2)
>>  {
>> -	int i;
>> -
>> -	for (i = 0; i < HMC5843_RATE_NOT_USED; i++) {
>> -		if (val == data->variant->regval_to_samp_freq[i][0] &&
>> -			val2 == data->variant->regval_to_samp_freq[i][1])
>> -			return i;
>> -	}
>> -
>> -	return -EINVAL;
>> +	return hmc5843_check_int_plus_micros(
>> +		data->variant->regval_to_samp_freq, HMC5843_RATE_NOT_USED,
>> +		val, val2);
>>  }
>>  
>>  static ssize_t hmc5843_show_range_gain(struct device *dev,
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
