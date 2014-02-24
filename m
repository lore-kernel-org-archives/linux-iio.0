Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60821 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbaBXWDl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Feb 2014 17:03:41 -0500
Message-ID: <530BC1E5.40906@kernel.org>
Date: Mon, 24 Feb 2014 22:04:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Juergen Beisert <jbe@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	devel@driverdev.osuosl.org, marex@denx.de,
	fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH] staging/iio/adc/MXS/LRADC: fix touchscreen statemachine
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <201402241416.24270.jbe@pengutronix.de> <20140224133316.GI26722@mwanda> <201402241539.53707.jbe@pengutronix.de> <20140224164817.GE4436@piout.net> <530BB63D.4050200@kernel.org>
In-Reply-To: <530BB63D.4050200@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/02/14 21:14, Jonathan Cameron wrote:
> On 24/02/14 16:48, Alexandre Belloni wrote:
>> On 24/02/2014 at 15:39:53 +0100, Juergen Beisert wrote :
>>> Releasing the touchscreen lets the internal statemachine left in a wrong state.
>>> Due to this the release coordinate will be reported again by accident when the next
>>> touchscreen event happens. This change sets up the correct state when waiting
>>> for the next touchscreen event.
>>>
>>> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
>>>
>>
>> Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Applied to the fixes-togreg branch of iio.git  Thanks
I just forced an update to the tree having realised that I'd not
marked it for stable (the change went into the 3.13 tree) and that
a few more details were needed to explain the effects of the problem
and where it came from. Will let it sit overnight then send on to
Greg sometime in the next few days.  Good to have this one cleared up.

Jonathan
>
> Jonathan
>>
>>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
>>> index 7fc66a6..514844e 100644
>>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>>> @@ -757,6 +757,7 @@ static void mxs_lradc_finish_touch_event(struct mxs_lradc *lradc, bool valid)
>>>       }
>>>
>>>       /* if it is released, wait for the next touch via IRQ */
>>> +    lradc->cur_plate = LRADC_TOUCH;
>>>       mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
>>>       mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
>>>   }
>>>
>>> --
>>> Pengutronix e.K.                              | Juergen Beisert             |
>>> Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

