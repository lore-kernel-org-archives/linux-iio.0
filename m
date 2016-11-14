Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:49155 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbcKNKZ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2016 05:25:28 -0500
Subject: Re: [PATCH 1/2] staging: iio: ad7606: replace range/range_available
 with corresponding scale
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
References: <1478846078-22207-1-git-send-email-eraretuya@gmail.com>
 <1478846078-22207-2-git-send-email-eraretuya@gmail.com>
 <eef1f86d-a0bf-9c22-4391-aca2680972d5@metafoo.de>
 <20161112142245.GA2214@Socrates-DK>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <42b352e0-ea7a-677f-f683-ab370ad47dd5@metafoo.de>
Date: Mon, 14 Nov 2016 11:25:22 +0100
MIME-Version: 1.0
In-Reply-To: <20161112142245.GA2214@Socrates-DK>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/12/2016 03:22 PM, Eva Rachel Retuya wrote:
> Hello, 
> 
> Thanks for explaining it. Now I understand better why read_raw is
> formatted in that manner. I have some questions in-line:
> 
> On Fri, Nov 11, 2016 at 03:18:37PM +0100, Lars-Peter Clausen wrote:
>> On 11/11/2016 07:34 AM, Eva Rachel Retuya wrote:
>>> Eliminate the non-standard attribute in_voltage_range and move its
>>> functionality under the scale attribute. read_raw() has been taken care
>>> of previously so only write_raw() is handled here.
>>>
>>> Additionally, rename the attribute in_voltage_range_available into
>>> in_voltage_scale_available.
>>>
>>> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
>>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
>>
>> Hi,
>>
>> Thanks for the patch. Unfortunately this is not quite this straight forward.
>>
>> The scale is what you multiply the raw with to get the value in the standard
>> IIO unit. Range as implemented in this driver is the maximum output voltage.
>>
>> To get the scale we need to look at the transfer function of the ADC [1].
>> The transfer function tells us that 1 LSB is 305uV for the 10V range and
>> 152uV for the 5V range.
> 
> Instead of 10000 and 5000, these will be the values for the
> scale_available attribute?

Yes. But these are slightly truncated values, we should try to minimize the
rounding error introduced by those scales by making them as accurate as
possible. The exact values are 5/2**16 and 2.5/2**16. Neither of which we
can express accurately. But we should use at least 6 digits and also round
to the closest rather than truncating.

> 
>>
>> More specifically this is $RANGE*2/2**16 (times two since the ADC is bipolar).
>>
>> Since the default unit for IIO is mV for voltages we need to multiply this
>> by 1000.
>>
>> The other thing we need to handle is the case where the RANGE pin is not
>> connected to a GPIO but either hardwired to 1 or 0. Which we need to handle
>> somehow.
> 
> Will this be on the same patch or a separate one? Can you please give a
> hint on how to check if it is hardwired?

The current driver checks if the GPIO is set and if it is not it does not
register the range attribute. As a first step we could mimic this behavior,
but long term we should find a way to discover the setting of the hardwired
pin and report the scale accordingly.

