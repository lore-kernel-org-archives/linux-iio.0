Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57704 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdAOQ3l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2017 11:29:41 -0500
Date: Sun, 15 Jan 2017 16:28:59 +0000
In-Reply-To: <0e0398c2-a858-efe8-230f-c454145ec7bc@gmail.com>
References: <20170115001437.30478-1-marek.vasut@gmail.com> <d91d43b8-1e78-ca8a-9848-ff664e588559@kernel.org> <0e0398c2-a858-efe8-230f-c454145ec7bc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH V5] iio: adc: Add Renesas GyroADC driver
To: Marek Vasut <marek.vasut@gmail.com>, linux-iio@vger.kernel.org
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <EE493617-D579-4439-B64C-337F887BB7BD@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 15 January 2017 15:47:31 GMT+00:00, Marek Vasut <marek.vasut@gmail.com> wrote:
>On 01/15/2017 03:05 PM, Jonathan Cameron wrote:
>> On 15/01/17 00:14, Marek Vasut wrote:
>>> Add IIO driver for the Renesas RCar GyroADC block. This block is a
>>> simple 4/8-channel ADC which samples 12/15/24 bits of data every
>>> cycle from all channels.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>> Cc: Jonathan Cameron <jic23@kernel.org>
>>> Cc: linux-renesas-soc@vger.kernel.org
>> One question about the name attribute and what it gives you. Looks
>like another
>> case of what Lars has been pointing out this morning.
>> 
>> We had a load of these sneak in.  Changing them would break userspace
>code
>> so we can't fix them, but that attribute ought to give you something
>> related to the part number.
>> 
>> Here it might even be cute to give an indication of what is connected
>> to it as part of the name.
>
>You can extract that information from the of_node, so I don't think
>that
>is a good idea, it'd only bring in duplication:
>
>~ # cat /sys/bus/iio/devices/iio\:device0/of_node/adc@*/compatible
>maxim,max11100
>
Fair enough
>> J
>
>[...]
>
>>> +	ret = rcar_gyroadc_parse_subdevs(indio_dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = rcar_gyroadc_init_supplies(indio_dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	priv->model = (enum rcar_gyroadc_model)of_id->data;
>>> +
>>> +	platform_set_drvdata(pdev, indio_dev);
>>> +
>>> +	indio_dev->name = dev_name(dev);
>> What do you then get when you read /sys/bus/iio/iio\:deviceX/name?
>
>e6e54000.adc
>
>> Should be something like the part number, rather than the id of the
>> parent device (I'm not 100% sure what that even is in this case!)
>
>You mean like "rcar-gyroadc" ? That works for me, sure.
Yes, that will do nicely.
>
>[...]

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
