Return-Path: <gregor.boirie@parrot.com>
Message-ID: <56CB324C.2060602@parrot.com>
Date: Mon, 22 Feb 2016 17:07:40 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 2/2] iio:iio-interrupt-trigger: sysfs poll support
References: <cover.1455908065.git.gregor.boirie@parrot.com> <87bbff0671c93b998547114d7f595a0bee57e817.1455908065.git.gregor.boirie@parrot.com> <56CA195B.9010200@kernel.org> <56CAF1DD.8070807@parrot.com> <56CAF312.1040200@metafoo.de> <56CB0814.9040604@parrot.com> <56CB13E3.8010305@metafoo.de>
In-Reply-To: <56CB13E3.8010305@metafoo.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/22/2016 02:57 PM, Lars-Peter Clausen wrote:
> On 02/22/2016 02:07 PM, Gregor Boirie wrote:
>> On 02/22/2016 12:37 PM, Lars-Peter Clausen wrote:
>>> Add a sysfs file entry for each interrupt trigger instance allowing
>>> userspace to :
>>> * poll for interrupt events ;
>>>>> Why?
>>>> On our platform, several sensors are driven by a dedicated "real-time"
>>>> CPU (bare-metal context). This CPU interrupts Linux in a periodic manner
>>>> which in turn wakes a user process up to perform sensor fusion.
>>>> This sysfs poll support allows the user process to explictly wait for
>>>> this dedicated CPU interrupt to fetch data located in RAM then process
>>>> them.
>>> So you are only using the IIO trigger in this setup, but no buffers or
>>> devices? If you just want to forward the interrupt to userspace UIO might be
>>> the better solution in this case:
>>> https://www.kernel.org/doc/htmldocs/uio-howto/about.html
>>>
>>> - Lars
>> I forgot to mention I also need the trigger to initiate in-kernel sampling
>> for other IIO devices. These samples are also retrieved by the process
>> performing
>> fusion.
> You should still be able to export the interrupt using UIO by sharing the IRQ.
I did not think this UIO framework was as flexible as it is.
It makes the iio-trigger-interrupt patch serie quite useless once UIO is 
considered as
a real alternative.
Many thanks for the proposal.

Grégor.
>
> - Lars
>
