Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47184 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbcEUTRL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 May 2016 15:17:11 -0400
Subject: Re: [PATCH] iio: adc: nau7802: Expose possible gains in sysfs
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Quentin Schulz <quentin.schulz@free-electrons.com>
References: <1463584578-16772-1-git-send-email-quentin.schulz@free-electrons.com>
 <20160519100113.GH19408@piout.net>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, maxime.ripard@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <006dfa93-a4ab-7038-02bd-d43872a437d7@kernel.org>
Date: Sat, 21 May 2016 20:17:09 +0100
MIME-Version: 1.0
In-Reply-To: <20160519100113.GH19408@piout.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/16 11:01, Alexandre Belloni wrote:
> On 18/05/2016 at 17:16:18 +0200, Quentin Schulz wrote :
>>
>> The Nuvoton NAU7802 ADC is able to adjust its gain but prior knowledge of
>> its possible values was required to adjust it. Users had to guess the
>> possible gain values based on the ADC datasheet or on this driver's code.
>>
>> This exposes the possible values in the in_voltage_scale_available file of
>> each nau7802 ADC device. The gain is set for the whole ADC and is therefore
>> not configurable by channel. Thus, there exists only one
>> in_voltage_scale_available file for each nau7802 ADC device even if it has
>> two separate channels.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> 
>> ---
>>
>> There exists two files to set the gain: in_voltageX_scale_available and
>> in_voltage-voltage_scale_available. What are the differences between those
>> two? What are the use cases for each? Which one should I have used?
>>
>>  drivers/iio/adc/nau7802.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
>> index e525aa6..57365c5 100644
>> --- a/drivers/iio/adc/nau7802.c
>> +++ b/drivers/iio/adc/nau7802.c
>> @@ -79,10 +79,29 @@ static const struct iio_chan_spec nau7802_chan_array[] = {
>>  static const u16 nau7802_sample_freq_avail[] = {10, 20, 40, 80,
>>  						10, 10, 10, 320};
>>  
>> +static ssize_t nau7802_show_scales(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct nau7802_state *st = iio_priv(dev_to_iio_dev(dev));
>> +	int i, len = 0;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
>> +		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09d ",
>> +				 st->scale_avail[i]);
>> +
>> +	buf[len-1] = '\n';
>> +
>> +	return len;
>> +}
>> +
>>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 40 80 320");
>>  
>> +static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO, nau7802_show_scales,
>> +		       NULL, 0);
>> +
>>  static struct attribute *nau7802_attributes[] = {
>>  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>> +	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
>>  	NULL
>>  };
>>  
>> -- 
>> 2.5.0
>>
> 

