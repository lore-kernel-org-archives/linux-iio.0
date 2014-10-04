Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57812 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbaJDLvb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 07:51:31 -0400
Message-ID: <542FDF41.2040106@kernel.org>
Date: Sat, 04 Oct 2014 12:51:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>
CC: lars <lars@metafoo.de>, sachin.kamat@linaro.org,
	srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: vadc: Qualcomm SPMI PMIC voltage ADC driver
References: <1411563415-11933-1-git-send-email-svarbanov@mm-sol.com>	 <1411563415-11933-2-git-send-email-svarbanov@mm-sol.com>	 <542D1B11.8070600@mm-sol.com> <1412251686.1027.15.camel@iivanov-dev>
In-Reply-To: <1412251686.1027.15.camel@iivanov-dev>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/10/14 13:08, Ivan T. Ivanov wrote:
> +iio maintainers
> 
> On Thu, 2014-10-02 at 12:29 +0300, Ivan T. Ivanov wrote:
>> Hi Stan,
>>
>> On 09/24/2014 03:56 PM, Stanimir Varbanov wrote:
>>
>> <snip>
>>
>>> +static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
>>> +{
>>> +	struct iio_chan_spec *iio_chan = vadc->iio_chans;
>>> +	const struct vadc_channels *vadc_chan;
>>> +	struct vadc_channel_prop prop;
>>> +	struct device_node *child;
>>> +	int ret, index = 0;
>>> +
>>> +	for_each_available_child_of_node(node, child) {
>>> +		ret = vadc_get_dt_channel_data(vadc->dev, &prop, child);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		vadc->chan_props[index] = prop;
>>> +
>>> +		vadc_chan = &vadc_chans[prop.channel];
>>> +
>>> +		iio_chan->channel = prop.channel;
>>> +		iio_chan->datasheet_name = vadc_chan->datasheet_name;
>>> +		iio_chan->info_mask_separate = vadc_chan->info_mask;
>>> +		iio_chan->type = vadc_chan->type;
>>> +		iio_chan->indexed = 1;
>>> +		iio_chan->scan_type.sign = 's';
>>> +		iio_chan->scan_type.realbits = 15;
>>> +		iio_chan->scan_type.storagebits = 16;
>>> +		iio_chan->address = index++;
>>> +
>>> +		iio_chan++;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>
>> <snip>
>>
>>> +static int vadc_probe(struct platform_device *pdev)
>>> +{
>>
>> <snip>
>>
>>> +
>>> +	indio_dev->dev.parent = dev;
>>> +	indio_dev->dev.of_node = node;
>>> +	indio_dev->name = pdev->name;
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +	indio_dev->info = &vadc_info;
>>> +	indio_dev->channels = vadc->iio_chans;
>>> +	indio_dev->num_channels = vadc->nchannels;
>>
>> This will not work as we thought. Registration will be fine and entries
>> in sysfs are created as expected, but this is breaking numbering scheme
>> for client drivers. For us the problem is that iio framework expect channels
>> numbering to be linear and channel number should not be greater than
>> channel count. For example even if die temperature channel is always 8, if
>> I describe only 5 channels in DTS files (4 for reference points measurement)
>> and 1 for die temperature, clients could not get OF reference to 
>> temperature
>> channel using io-channels = <&pm8941_vadc 8>;
>>
>> Jonathan, please, could you advise us.
I'd like to let the solution you proposed sit on the list a little longer.
It seems fairly sensible, but lets see what others suggest.

Jonathan
>>
>> Regards,
>> Ivan
>>
>>> +
>>> +	return devm_iio_device_register(dev, indio_dev);
>>> +}
>>> +
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
