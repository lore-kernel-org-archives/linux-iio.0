Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:46413 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbcJGKnm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Oct 2016 06:43:42 -0400
Subject: Re: [PATCH] staging: iio: ad7606: implement
 IIO_CHAN_INFO_OVERSAMPLING_RATIO
To: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
References: <1475764920-7770-1-git-send-email-eraretuya@gmail.com>
 <baef9fc5-c3de-3b47-4e17-de559027e0b4@metafoo.de>
 <20161007060246.GA7872@Socrates-DK>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c68ee3c5-60f8-a50f-629c-31b1aee3ba02@metafoo.de>
Date: Fri, 7 Oct 2016 12:43:35 +0200
MIME-Version: 1.0
In-Reply-To: <20161007060246.GA7872@Socrates-DK>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/2016 08:02 AM, Eva Rachel Retuya wrote:
> On Thu, Oct 06, 2016 at 05:43:36PM +0200, Lars-Peter Clausen wrote:
>> On 10/06/2016 04:42 PM, Eva Rachel Retuya wrote:
>>> This driver predates the availability of IIO_CHAN_INFO_OVERSAMPLING_RATIO
>>> attribute wherein usage has some advantages like it can be accessed by
>>> in-kernel consumers as well as reduces the code size.
>>>
>>> Therefore, use IIO_CHAN_INFO_OVERSAMPLING_RATIO to implement the
>>> oversampling_ratio attribute instead of using IIO_DEVICE_ATTR() macro.
>>>
>>> Move code from the functions associated with IIO_DEVICE_ATTR() into
>>> the read_raw hook as well as add the write_raw hook with both masks set
>>> to IIO_CHAN_INFO_OVERSAMPLING_RATIO.
>>>
>>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
>>
>> Looks good, thanks.
>>
>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>>
> 
> Thank you for the feedback!
> 
>> I did some cleanup on this driver last week (not yet submitted), this was
>> the last bit I hadn't gotten to yet that needs to be done before the driver
>> can be moved out of staging.
> 
> Anything else about this driver that needs to be addressed? I'll be glad
> to help submit patches for those (and in the process learn something new).

One thing I haven't addressed yet is the regulator handling. Currently the
driver ignores all errors regulator_get(). This is incorrect and among other
things breaks probe deferral (EPROBE_DEFER). The correct behavior is to
propagate the error to the upper layers so they can handle it accordingly.
Another reason to do this is that the device can't work without power
enabled, so it needs a regulator connected. If the specific design uses a
static always-on regulator and does not explicitly specify it
regulator_get() will return the dummy regulator.

Another thing regarding regulator handling is that the names passed to
regulator_get() should match the name of the supply as specified in the
device datasheet. In this case the supply is called AVcc, while the driver
passes just "vcc". Since it is custom to use the lower-caps version of the
datasheet name this should be replaced with "avcc".

If you are interested in this type of issue I think you'll be able to find a
few more in the staging IIO tree that also need to be addressed. And
potentially even in the regular IIO tree. The following cocci snippet should
be able to help you identify potential candidates (it's not very
sophisticated, so there will be false positives and false negatives).

@r1@
expression reg;
position p;
@@
reg = \(devm_regulator_get@p\|regulator_get@p\)(...);
if (IS_ERR(reg)) {
	...
	PTR_ERR(reg)
	...
}

@@
position p != r1.p;
@@
*\(devm_regulator_get@p\|regulator_get@p\)(...)


I've pushed my changes to ad7606 driver for reference to
https://github.com/analogdevicesinc/linux/tree/iio-ad7605

I still need to test them with real hardware before I'll submit them and
this has to wait until after ELCE next week.

> 
> By the way, this particular code took my attention (from write_raw of
> this patch):
> 
> 		gpio_set_value(st->pdata->gpio_os0, (ret >> 0) & 1);
> 		gpio_set_value(st->pdata->gpio_os1, (ret >> 1) & 1);
> 		gpio_set_value(st->pdata->gpio_os1, (ret >> 2) & 1);
> 
> The last line, st->pdata->gpio_os1, is that really intended or is it a
> typo? It could have been st->pdata->gpio_os2. I checked the datasheet
> and definition, looks like a typo to me. Just checking with everyone for
> confirmation.

Nice catch, that's most certainly a bug. I didn't even notice this when
refactoring the code. Please send a fix.

