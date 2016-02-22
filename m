Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH v1 2/2] iio:iio-interrupt-trigger: sysfs poll support
To: Gregor Boirie <gregor.boirie@parrot.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1455908065.git.gregor.boirie@parrot.com>
 <87bbff0671c93b998547114d7f595a0bee57e817.1455908065.git.gregor.boirie@parrot.com>
 <56CA195B.9010200@kernel.org> <56CAF1DD.8070807@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56CAF312.1040200@metafoo.de>
Date: Mon, 22 Feb 2016 12:37:54 +0100
MIME-Version: 1.0
In-Reply-To: <56CAF1DD.8070807@parrot.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 02/22/2016 12:32 PM, Gregor Boirie wrote:
> On 02/21/2016 09:08 PM, Jonathan Cameron wrote:
>> On 19/02/16 19:18, Gregor Boirie wrote:
>>> From: Grégor Boirie <gregor.boirie@parrot.com>
>>>
>> Hi Gregor.
>>
>> You certainly have some unusual requirements  - or perhaps you are
>> simply the first person to show up with them here!
> I would give preference to 2nd option :)
>>> Add a sysfs file entry for each interrupt trigger instance allowing
>>> userspace to :
>>> * poll for interrupt events ;
>> Why?
> On our platform, several sensors are driven by a dedicated "real-time"
> CPU (bare-metal context). This CPU interrupts Linux in a periodic manner
> which in turn wakes a user process up to perform sensor fusion.
> This sysfs poll support allows the user process to explictly wait for
> this dedicated CPU interrupt to fetch data located in RAM then process
> them.

So you are only using the IIO trigger in this setup, but no buffers or
devices? If you just want to forward the interrupt to userspace UIO might be
the better solution in this case:
https://www.kernel.org/doc/htmldocs/uio-howto/about.html

- Lars
