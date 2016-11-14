Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47454 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754938AbcKNR0Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2016 12:26:24 -0500
In-Reply-To: <9765154f-78df-eb0e-9723-28e1057149bf@metafoo.de>
References: <1478846078-22207-1-git-send-email-eraretuya@gmail.com> <1478846078-22207-2-git-send-email-eraretuya@gmail.com> <eef1f86d-a0bf-9c22-4391-aca2680972d5@metafoo.de> <c9a4b2b3-6c4b-4c3c-da79-eba8398a5a0d@kernel.org> <9765154f-78df-eb0e-9723-28e1057149bf@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/2] staging: iio: ad7606: replace range/range_available with corresponding scale
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 14 Nov 2016 17:26:12 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
CC: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org,
        Linus Walleij <linus.walleij@linaro.org>
Message-ID: <AF5FA2E0-9956-4B35-986A-6A2D014AE3EB@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 14 November 2016 10:30:50 GMT+00:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 11/12/2016 03:24 PM, Jonathan Cameron wrote:
>> On 11/11/16 14:18, Lars-Peter Clausen wrote:
>>> On 11/11/2016 07:34 AM, Eva Rachel Retuya wrote:
>>>> Eliminate the non-standard attribute in_voltage_range and move its
>>>> functionality under the scale attribute. read_raw() has been taken
>care
>>>> of previously so only write_raw() is handled here.
>>>>
>>>> Additionally, rename the attribute in_voltage_range_available into
>>>> in_voltage_scale_available.
>>>>
>>>> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
>>>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
>>>
>>> Hi,
>>>
>>> Thanks for the patch. Unfortunately this is not quite this straight
>forward.
>>>
>>> The scale is what you multiply the raw with to get the value in the
>standard
>>> IIO unit. Range as implemented in this driver is the maximum output
>voltage.
>>>
>>> To get the scale we need to look at the transfer function of the ADC
>[1].
>>> The transfer function tells us that 1 LSB is 305uV for the 10V range
>and
>>> 152uV for the 5V range.
>>>
>>> More specifically this is $RANGE*2/2**16 (times two since the ADC is
>bipolar).
>>>
>>> Since the default unit for IIO is mV for voltages we need to
>multiply this
>>> by 1000.
>>>
>>> The other thing we need to handle is the case where the RANGE pin is
>not
>>> connected to a GPIO but either hardwired to 1 or 0. Which we need to
>handle
>>> somehow.
>> Is it just me who thought, we need a fixed GPI like a fixed
>regulator?
>> Would allow this sort of fixed wiring to be simply defined.
>> 
>> Linus, worth exploring?
>> 
>> I doubt this will be the last case of this particular problem
>> (not exactly unusual to hard wire control lines like these as which
>range
>> makes sense is often a feature of the device).
>> 
>> Would be a pain to have to add code to every driver to cover the
>fixed
>> case.
>
>We still have to add code to every driver to cover the fixed case since
>the
>mode of operation is inherently different. But it would be nice to have
>a
>coherent way of doing so with a standardized interface rather than
>having
>every device come up with its own code and bindings.
Agreed. Not totally obvious how to do it but definitely don't want to work around it by custom bindings all over the place.

A simple is_gpo_fixed or similar would get the driver the info it needs. Could do it with errors 
but that would perhaps be ugly!
The other flags related to type of input/output can be emulated so there doesn't seem to be anything similar...
>
>This could either be handled directly by the GPIO API or by a small set
>of
>helper functions on top of it.
>
>I think the most important part for now is to agree on a standard
>binding to
>describe hardwired GPIOs. We can still rework the kernel API later on,
>but
>the DT bindings will be set in stone.
Agreed. Some magic gpio description or a fake gpio chip similar to fixed regs?

Jonathan
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
