Return-Path: <SRS0=Ogno=GE=gmail.com=arndbergmann@kernel.org>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180314180633.000067dd@huawei.com>
References: <20180314153603.3127932-1-arnd@arndb.de> <20180314153603.3127932-48-arnd@arndb.de>
 <20180314163207.GA4279@kroah.com> <20180314180633.000067dd@huawei.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 21:24:41 +0100
Message-ID: <CAK8P3a3Pg0sbzQeSJfjdCmepRGz9PP7Uusd5UopZT0gTBbL1QQ@mail.gmail.com>
Subject: Re: [PATCH 47/47] staging: iio: remove iio-trig-bfin-timer driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Wed, Mar 14, 2018 at 6:06 PM, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Wed, 14 Mar 2018 17:32:07 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>> On Wed, Mar 14, 2018 at 04:36:00PM +0100, Arnd Bergmann wrote:
>> > I'm not sure about the other staging iio drivers though: almost
>> > all of them are for Analog Devices devices like this one. They
>> > are likely used along with blackfin SoCs, but could easily be
>> > used on any others as well.
>> >
>> > It might be time to consider whether they should be removed, but
>> > it doesn't feel like a decision that I should be making.
>>
>> The IIO driver maintainer/developers are talking about that currently, I
>> think they have a plan for those other drivers.
>
> Some of the drivers are under consideration for removal (particularly most
> of the meter drivers) but it is unconnected to the blackfin removal.
> They are simply other obsolete parts that we don't have test hardware
> for and need sufficient 'surgery' that we wouldn't feel comfortable
> cleaning them up without.  One has been reprieved as a user, who was
> happy to test, came forward when I announced the intent to remove them.

Ok, thanks for the clarification. I'll just drop my comment then, as you
clearly have this under control

>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks,

      Arnd
