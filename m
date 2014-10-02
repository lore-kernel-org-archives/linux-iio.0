Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51062 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbaJBJuF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 2 Oct 2014 05:50:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1XZd1P-0006F4-Ew
	for linux-iio@vger.kernel.org; Thu, 02 Oct 2014 11:50:03 +0200
Received: from 37.157.136.206 ([37.157.136.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2014 11:50:03 +0200
Received: from iivanov by 37.157.136.206 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2014 11:50:03 +0200
To: linux-iio@vger.kernel.org
From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v3 1/2] iio: vadc: Qualcomm SPMI PMIC voltage ADC driver
Date: Thu, 02 Oct 2014 12:29:53 +0300
Message-ID: <542D1B11.8070600@mm-sol.com>
References: <1411563415-11933-1-git-send-email-svarbanov@mm-sol.com> <1411563415-11933-2-git-send-email-svarbanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
In-Reply-To: <1411563415-11933-2-git-send-email-svarbanov@mm-sol.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Hi Stan,

On 09/24/2014 03:56 PM, Stanimir Varbanov wrote:

<snip>

> +static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
> +{
> +	struct iio_chan_spec *iio_chan = vadc->iio_chans;
> +	const struct vadc_channels *vadc_chan;
> +	struct vadc_channel_prop prop;
> +	struct device_node *child;
> +	int ret, index = 0;
> +
> +	for_each_available_child_of_node(node, child) {
> +		ret = vadc_get_dt_channel_data(vadc->dev, &prop, child);
> +		if (ret)
> +			return ret;
> +
> +		vadc->chan_props[index] = prop;
> +
> +		vadc_chan = &vadc_chans[prop.channel];
> +
> +		iio_chan->channel = prop.channel;
> +		iio_chan->datasheet_name = vadc_chan->datasheet_name;
> +		iio_chan->info_mask_separate = vadc_chan->info_mask;
> +		iio_chan->type = vadc_chan->type;
> +		iio_chan->indexed = 1;
> +		iio_chan->scan_type.sign = 's';
> +		iio_chan->scan_type.realbits = 15;
> +		iio_chan->scan_type.storagebits = 16;
> +		iio_chan->address = index++;
> +
> +		iio_chan++;
> +	}
> +
> +	return 0;
> +}
> +

<snip>

> +static int vadc_probe(struct platform_device *pdev)
> +{

<snip>

> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->dev.of_node = node;
> +	indio_dev->name = pdev->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &vadc_info;
> +	indio_dev->channels = vadc->iio_chans;
> +	indio_dev->num_channels = vadc->nchannels;

This will not work as we thought. Registration will be fine and entries
in sysfs are created as expected, but this is breaking numbering scheme
for client drivers. For us the problem is that iio framework expect channels
numbering to be linear and channel number should not be greater than
channel count. For example even if die temperature channel is always 8, if
I describe only 5 channels in DTS files (4 for reference points measurement)
and 1 for die temperature, clients could not get OF reference to 
temperature
channel using io-channels = <&pm8941_vadc 8>;

Jonathan, please, could you advise us.

Regards,
Ivan

> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
>

