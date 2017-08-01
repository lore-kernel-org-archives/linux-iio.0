Return-Path: <SRS0=NVyf=7D=gmail.com=daniel.baluta@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170801095929.avlqhcqv6eq2zll6@lenoch>
References: <20170801082521.namcrs4wyufwqyuh@lenoch> <20170801082605.kxzqtnrbt6glplmu@lenoch>
 <CAEnQRZDKd1aWyX+2WvZ=acQGqDOMt22xWp0VCyVPfufFut86vg@mail.gmail.com> <20170801095929.avlqhcqv6eq2zll6@lenoch>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 1 Aug 2017 19:25:14 +0300
Message-ID: <CAEnQRZDz5hYXpLRH2gXrxAcLLd0FCXSec8oe855vr_ApdujszA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ti-ads1015: fix conversion time
To: Ladislav Michl <ladis@linux-mips.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 1, 2017 at 12:59 PM, Ladislav Michl <ladis@linux-mips.org> wrote:
> On Tue, Aug 01, 2017 at 12:09:34PM +0300, Daniel Baluta wrote:
>> On Tue, Aug 1, 2017 at 11:26 AM, Ladislav Michl <ladis@linux-mips.org> wrote:
>> > When reading diffrent channel value than device is currently processing
>> > wait time of conversion period is applied, which is not enough as device
>> > might be already in the middle of conversion and therefore previously
>> > converted value is returned - the one belonging to another channel.
>> > Fix it by waiting for two sampling periods.
>> >
>> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
>>
>> Did you actually experienced this in practice? I guess you are right,
>> if you change the channel during a conversion, this change will be applied
>> to the next conversion *but* reading will still return old value because the
>> current conversion hasn't finished yet.
>
> Yes, that's what actually happens without patch and could be easily
> demonstrated from command line:
>
> $ cat in_voltage0_raw
> 847
> $ cat in_voltage1_raw
> 846
> $ cat in_voltage1_raw
> 195
> $ cat in_voltage0_raw
> 196
> $ cat in_voltage0_raw
> 846
>
> Btw, driver is using continuous conversion mode, but I was unable to
> make iio_generic_buffer work with it. And for reading values one by
> one single shot mode is enough. Any hints?

Haven't looked at this sensor for long time. Can you tell us what have you
tried and what doesn't work?

Daniel.
