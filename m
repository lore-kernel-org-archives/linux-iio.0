Return-Path: <lars@metafoo.de>
Message-ID: <557DA18F.5090805@metafoo.de>
Date: Sun, 14 Jun 2015 17:45:19 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Gergely Imreh <imrehg@gmail.com>, Jonathan Cameron <jic23@kernel.org>
CC: michal.simek@xilinx.com, linux-iio@vger.kernel.org,
 Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel@vger.kernel.org, ola@adapteva.com
Subject: Re: [PATCH 1/1] iio:adc: XADC: Set offset explicitly to zero on voltage
 channels
References: <1434010946-8118-1-git-send-email-imrehg@gmail.com> <557C76D2.7030306@kernel.org> <CAJ3iQcoKPi7vCO5c==DcwwNY6LEKJ+xPueELDC85XPVus0qf0A@mail.gmail.com>
In-Reply-To: <CAJ3iQcoKPi7vCO5c==DcwwNY6LEKJ+xPueELDC85XPVus0qf0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/14/2015 05:15 AM, Gergely Imreh wrote:
> On 14 June 2015 at 02:30, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 11/06/15 09:22, Gergely Imreh wrote:
>>> The Xilinx XADC driver has both a temperature channel and 8 voltage
>>> channels. The voltage channels have no offset, but actually were still
>>> set the same offset as the temperature channel. This did not cause
>>> problems in /sys/bus/iio/ but can cause problems with other drivers
>>> using iio data. For example iio-hwmon did return wrong voltage values
>>> because of the offset.
>>>
>>> Change tested with the Parallella board.
>>>
>>> Signed-off-by: Gergely Imreh <imrehg@gmail.com>
>> Well spotted on the bug, but I think we are better off fixing this at the
>> true source of the problem which is in drivers/iio/inkern.c
>> iio_convert_raw_to_processed_unlocked which does a call to
>> iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET) then uses
>> the error return to check if the offset parameter is available. It should
>> be checking that before making this call with a call to iio_channel_has_info.
>>
>> I don't suppose you could prepare a patch fixing that as you found the problem?
>
> I'll check it out, and send an updated patch! Thanks for the pointers
> to the core of the issue.

The issue was already fixed a while ago, see this patch:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=65de7654d39c70c2b942f801cea01590cf7e3458

Starting with that commit iio_channel_read() returns an error when the 
attribute is not available, which causes 
iio_convert_raw_to_processed_unlocked() to skip the offset if it is not 
available.

- Lars
