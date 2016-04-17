Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52735 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbcDQJsG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 05:48:06 -0400
Subject: Re: [PATCH 2/2] iio: adc: set INPUT_PROP_DIRECT
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <cover.1460316098.git.ksenija.stanojevic@gmail.com>
 <7838d255676f6f778bf9710454f632cd68a35185.1460316098.git.ksenija.stanojevic@gmail.com>
 <571291F8.1010804@kernel.org> <20160417093345.GA23092@dtor-ws>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57135BD4.9070801@kernel.org>
Date: Sun, 17 Apr 2016 10:48:04 +0100
MIME-Version: 1.0
In-Reply-To: <20160417093345.GA23092@dtor-ws>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/04/16 10:33, Dmitry Torokhov wrote:
> On Sat, Apr 16, 2016 at 08:26:48PM +0100, Jonathan Cameron wrote:
>> On 10/04/16 20:22, Ksenija Stanojevic wrote:
>>> Set INPUT_PROP_DIRECT to indicate that it is a touchscreen on the
>>> device to help userspace classify it.
>>>
>>> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
>> Sounds correct to me.  Dmitry?
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to mess with it.

Thanks,

Jonathan
> 
>>> ---
>>>  drivers/iio/adc/mxs-lradc.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
>>> index 07287af..e4c4c5c 100644
>>> --- a/drivers/iio/adc/mxs-lradc.c
>>> +++ b/drivers/iio/adc/mxs-lradc.c
>>> @@ -1127,6 +1127,7 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>>>  	__set_bit(EV_ABS, input->evbit);
>>>  	__set_bit(EV_KEY, input->evbit);
>>>  	__set_bit(BTN_TOUCH, input->keybit);
>>> +	__set_bit(INPUT_PROP_DIRECT, input->propbit);
>>>  	input_set_abs_params(input, ABS_X, 0, LRADC_SINGLE_SAMPLE_MASK, 0, 0);
>>>  	input_set_abs_params(input, ABS_Y, 0, LRADC_SINGLE_SAMPLE_MASK, 0, 0);
>>>  	input_set_abs_params(input, ABS_PRESSURE, 0, LRADC_SINGLE_SAMPLE_MASK,
>>>
>>
> 

