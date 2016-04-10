Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44090 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbcDJOFm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 10:05:42 -0400
Subject: Re: [PATCH 1/3] iio: core: Add devm_ APIs for
 iio_channel_{get,release}
To: Laxman Dewangan <ldewangan@nvidia.com>,
	Daniel Baluta <daniel.baluta@gmail.com>
References: <1459938668-9180-1-git-send-email-ldewangan@nvidia.com>
 <CAEnQRZBtqDQjydDKywYy9oLecFtjntfWhgOtd2xekVyFrYkH3w@mail.gmail.com>
 <57052432.8070700@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-doc@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A5DB3.3080805@kernel.org>
Date: Sun, 10 Apr 2016 15:05:39 +0100
MIME-Version: 1.0
In-Reply-To: <57052432.8070700@nvidia.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/16 15:58, Laxman Dewangan wrote:
> Hi Daniel,
> 
> 
> On Wednesday 06 April 2016 07:19 PM, Daniel Baluta wrote:
>> On Wed, Apr 6, 2016 at 1:31 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>>> Some of kernel driver uses the IIO framework to get the sensor
>>> value via ADC or IIO HW driver. The client driver get iio channel
>>> by iio_channel_get() and release it by calling iio_channel_release().
>>>
>>> Add resource managed version (devm_*) of these APIs so that if client
>>> calls the devm_iio_channel_get() then it need not to release it explicitly,
>>> it can be done by managed device framework when driver get un-binded.
>>>
>>> This reduces the code in error path and also need of .remove callback in
>>> some cases.
>>>
>> Please provide at least one example of code that uses this API.
> 
> Most of client for this APIs are in other subsystem.
> When I was working on the patch
> [PATCH 2/2] thermal: generic-adc: Add ADC based thermal sensor driver
> 
> if I have devm_iio_channel_get() then I can get .remove callback at all.
> 
> I did not use this new APIs in my patch because they are in different subsystem.
It's actually worse than that having taken a quick look at the generic-adc thermal patch
you reference above.
(perhaps worth cc'ing linux-iio for next version of that).

Without this devm function set you have a race in remove in which I think you can
get attempts to access the channels after they have been released...

> +
> +	gti->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
> +				gti, &gadc_thermal_ops);
> +	if (IS_ERR(gti->tz_dev)) {
> +		ret = PTR_ERR(gti->tz_dev);
> +		dev_err(&pdev->dev, "Thermal zone sensor register failed: %d\n",
> +			ret);
> +		goto sensor_fail;
> +	}
This will get cleaned up in remove 'after' the iio_channels are released.
Hence you have a race in which they can probably be accessed after release
(unless some magic is going on that I've missed).
> +
> +	return 0;
> +
> +sensor_fail:
> +	iio_channel_release(gti->channel);
> +	return ret;
> +}
> +
> +static int gadc_thermal_remove(struct platform_device *pdev)
> +{
> +	struct gadc_thermal_info *gti = platform_get_drvdata(pdev);
> +
> +	iio_channel_release(gti->channel);
> +
> +	return 0;
> +}
> +


> 
> 
> 

