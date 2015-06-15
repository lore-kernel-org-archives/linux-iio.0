Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:33813 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbbFOCHo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2015 22:07:44 -0400
MIME-Version: 1.0
In-Reply-To: <557DA3FA.4050300@kernel.org>
References: <1434010946-8118-1-git-send-email-imrehg@gmail.com>
 <557C76D2.7030306@kernel.org> <CAJ3iQcoKPi7vCO5c==DcwwNY6LEKJ+xPueELDC85XPVus0qf0A@mail.gmail.com>
 <557DA18F.5090805@metafoo.de> <557DA3FA.4050300@kernel.org>
From: Gergely Imreh <imrehg@gmail.com>
Date: Mon, 15 Jun 2015 10:07:23 +0800
Message-ID: <CAJ3iQcp0pOd6wMfkjWsBuj+EhCO0ig5xsyb8O3+qtKdUbnvOzQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio:adc: XADC: Set offset explicitly to zero on
 voltage channels
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, michal.simek@xilinx.com,
	linux-iio@vger.kernel.org,
	Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org, ola@adapteva.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14 June 2015 at 23:55, Jonathan Cameron <jic23@kernel.org> wrote:
> On 14/06/15 16:45, Lars-Peter Clausen wrote:
>> On 06/14/2015 05:15 AM, Gergely Imreh wrote:
>>> On 14 June 2015 at 02:30, Jonathan Cameron <jic23@kernel.org> wrote:
>>>> On 11/06/15 09:22, Gergely Imreh wrote:
>>>>> The Xilinx XADC driver has both a temperature channel and 8 voltage
>>>>> channels. The voltage channels have no offset, but actually were still
>>>>> set the same offset as the temperature channel. This did not cause
>>>>> problems in /sys/bus/iio/ but can cause problems with other drivers
>>>>> using iio data. For example iio-hwmon did return wrong voltage values
>>>>> because of the offset.
>>>>>
>>>>> Change tested with the Parallella board.
>>>>>
>>>>> Signed-off-by: Gergely Imreh <imrehg@gmail.com>
>>>> Well spotted on the bug, but I think we are better off fixing this at the
>>>> true source of the problem which is in drivers/iio/inkern.c
>>>> iio_convert_raw_to_processed_unlocked which does a call to
>>>> iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET) then uses
>>>> the error return to check if the offset parameter is available. It should
>>>> be checking that before making this call with a call to iio_channel_has_info.
>>>>
>>>> I don't suppose you could prepare a patch fixing that as you found the problem?
>>>
>>> I'll check it out, and send an updated patch! Thanks for the pointers
>>> to the core of the issue.
>>
>> The issue was already fixed a while ago, see this patch:
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=65de7654d39c70c2b942f801cea01590cf7e3458
>>
>>  Starting with that commit iio_channel_read() returns an error when
>> the attribute is not available, which causes
>> iio_convert_raw_to_processed_unlocked() to skip the offset if it is
>> not available.
>>
> oops.  Good spot. I'd completely forgotten about that and failed to spot
> the check when looking at the code yesterday.
>
> Glad you were keeping an eagle eye on things ;)

Okay, thanks, then it's all good, scrub this patch!
That linked change was not backported to the Parallella yet, and
missed it. Looks like it's going to be included now.

Thanks for the feedback!
   Greg

>
> J
>> - Lars
