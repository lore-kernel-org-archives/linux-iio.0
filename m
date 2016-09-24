Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:51088 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755304AbcIXS0M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 14:26:12 -0400
Subject: Re: [PATCH 4/5] input: touchscreen: support Allwinner SoCs'
 touchscreen
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160720172532.GE25655@dtor-ws>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, maxime.ripard@free-electrons.com, wens@csie.org,
        lee.jones@linaro.org, antoine.tenart@free-electrons.com,
        thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <ca39a2e7-6116-6f6e-3f61-78abfdefcbb7@free-electrons.com>
Date: Sat, 24 Sep 2016 20:26:08 +0200
MIME-Version: 1.0
In-Reply-To: <20160720172532.GE25655@dtor-ws>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Dimitry,

Sorry for the (long) delay, I did not have time to work on it. I'll
mainly work in my free time now.

On 20/07/2016 19:25, Dmitry Torokhov wrote:
> Hi Quentin,
> 
> On Wed, Jul 20, 2016 at 10:29:10AM +0200, Quentin Schulz wrote:
>> This adds support for Allwinner SoCs' (A10, A13 and A31) resistive
>> touchscreen. This driver is probed by the MFD sunxi-gpadc-mfd.
>>
>> This driver uses ADC channels exposed through the IIO framework by
>> sunxi-gpadc-iio to get its data. When opening this input device, it will
>> start buffering in the ADC driver and enable a TP_UP_PENDING irq. The ADC
>> driver will fill in a buffer with all data and call the callback the input
>> device associated with this buffer. The input device will then read the
>> buffer two by two and send X and Y coordinates to the input framework based
>> on what it received from the ADC's buffer. When closing this input device,
>> the buffering is stopped.
>>
>> Note that locations in the first received buffer after an TP_UP_PENDING irq
>> occurred are unreliable, thus dropped.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
[...]
>> +	info->buffer = iio_channel_get_all_cb(&pdev->dev,
>> +					      &sunxi_gpadc_ts_callback,
>> +					      (void *)info);
> 
> Any chance we could introduce devm-variant here? If you do not want to
> wait for IIO to add it you can temporarily add call
> devm_add_action_or_reset() after getting channels and remove it when IIO
> API catches up.
> 

Something like:

release_iio_channels(void* data)
{
	struct sunxi_gpadc_ts *info = data;
	iio_channel_release_all_cb(info->buffer);
}

[...]
	info->buffer = iio_channel_get_all_cb(&pdev->dev,
					      &sunxi_gpadc_ts_callback,
					      (void *)info);
	ret = devm_add_action_or_reset(&pdev->dev,
				       release_iio_channels,
				       (void *)info);
	if (ret)
		return ret;

?

May I know why you prefer that way instead of explicit removing in
remove function of the platform device? I understand for devm-variant
already in the framework but I am curious for this one.

[...]
>> +static int sunxi_gpadc_ts_remove(struct platform_device *pdev)
>> +{
>> +	struct sunxi_gpadc_ts *info = platform_get_drvdata(pdev);
>> +
>> +	iio_channel_stop_all_cb(info->buffer);
>> +	iio_channel_release_all_cb(info->buffer);
>> +
>> +	disable_irq(info->tp_up_irq);
> 
> You are mixing devm and non-devm so your unwind order is completely out
> of wack. If input device is opened while you are unloading (or
> unbinding) the dirver, then you'll release channels, then input device's
> close() will be called, which will try to stop the IIO channels again
> and disable IRQ yet again.
> 

Do you mean that I should be using exclusively devm or non-devm functions?
Do you mean input device's close will always be called when
unloading/unbinding the driver?

[...]
Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
