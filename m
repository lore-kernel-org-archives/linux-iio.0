Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34804 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbbCHLDe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 07:03:34 -0400
Message-ID: <54FC2C83.5090802@kernel.org>
Date: Sun, 08 Mar 2015 11:03:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>,
	=?windows-1252?Q?Uwe_Kleine-K=F6?= =?windows-1252?Q?nig?=
	<u.kleine-koenig@pengutronix.de>
CC: Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, kernel@pengutronix.de
Subject: Re: [PATCH] iio: accel: mma9551: Check gpiod_to_irq return value
References: <1425292752-7768-1-git-send-email-roberta.dobrescu@gmail.com> <CAEnQRZCBt++Ebjd6uwu6mpVCrsZyDxX53mOf4c17T1RUGAsQMA@mail.gmail.com> <20150302161503.GE7865@pengutronix.de> <20150303070232.GC27074@vdogaru>
In-Reply-To: <20150303070232.GC27074@vdogaru>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/15 07:02, Vlad Dogaru wrote:
> On Mon, Mar 02, 2015 at 05:15:03PM +0100, Uwe Kleine-König wrote:
>> Hello,
>>
>> On Mon, Mar 02, 2015 at 04:09:52PM +0200, Daniel Baluta wrote:
>>> On Mon, Mar 2, 2015 at 12:39 PM, Roberta Dobrescu
>>> <roberta.dobrescu@gmail.com> wrote:
>>>> The return value of gpiod_to_irq should be checked before giving
>>>> it to devm_request_threaded_irq in order to not pass an error
>>>> code in case it fails.
>> nothing really bad should happen because request_irq with a negative irq
>> parameter just returns an error I think. So it's not urgent, but still a
>> good idea to fix.
>>
>>>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
>>>> Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>
>> It's good habit to point out the commit that introduced the problem. In
>> this case this would be:
>>
>> Fixes: c78b91716340 ("iio: add driver for Freescale MMA9551L")
Vlad, do you want to respin taking the comments into account, or as Uwe
put it, it's worth having as is so should I consider it as it stands?

Jonathan
>>
>>>> ---
>>>> gpiod_to_irq also appears in the following drivers:
>>>>         * drivers/iio/accel/bmc150-accel.c
>>>>         * drivers/iio/accel/kxcjk-1013.c
>>>>         * drivers/iio/accel/mma9553.c
>>>>         * drivers/iio/gyro/bmg160.c
>>>>         * drivers/iio/imu/kmx61.c
>>>>         * drivers/iio/proximity/sx9500.c,
>>>>
>>>> something like this:
>>>>
>>>> <code>
>>>>         ret = gpiod_to_irq(gpio);
>>>>
>>>>         dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
>>>>
>>>>         return ret;
>>>> </code>
>>>>
>>>> The return value of the functions containing the above code is checked,
>>>> so the only problem would be that the debug message would contain a wrong
>>>> value for irq in case gpiod_to_irq fails. So it doesn't affects much.
>> Still worth fixing, isn't it? Also the error isn't handled, but ignored,
>> like:
>>
>> 	if (client->irq <= 0)
>> 		client->irq = sx9500_gpio_probe(client, data);
>>
>> 	if (client->irq > 0) {
>> 		ret = devm_request_threaded_irq(....
>>
>> but if an irq is specified (be it by means of a "normal" irq or by
>> specifying a gpio in the device tree/acpi tables) I expect the driver to
>> fail probing instead of just behaving as if no irq would be available.
> 
> If there is no IRQ available this device would still be able to do raw
> reads, although I admit I have not tested this.
> 
>> I don't know how this was tested, but I wonder further about
>>
>> 	#define SX9500_GPIO_NAME                "sx9500_gpio"
>> 	...
>> 	devm_gpiod_get_index(dev, SX9500_GPIO_NAME, 0, GPIOD_IN);
>>
>> If I understand the code correctly that is supposed to look for
>> "sx9500_gpio-gpio" in the ACPI data. Is this really correct?
> 
> I'm in the process of changing this, will post some patches soon.  This
> should include failing to probe if an IRQ is not found.
> 
> At the time I wrote the driver, I wasn't using Device Tree and ACPI had
> no support for _DSD (or at least I wasn't aware of it), so the name did
> not matter, only the index.
> 
> Thanks for the 
> 
>>>>  drivers/iio/accel/mma9551.c | 6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
>>>> index 46c3835..b6f3041 100644
>>>> --- a/drivers/iio/accel/mma9551.c
>>>> +++ b/drivers/iio/accel/mma9551.c
>>>> @@ -428,7 +428,11 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
>>>>                 if (ret)
>>>>                         return ret;
>>>>
>>>> -               data->irqs[i] = gpiod_to_irq(gpio);
>>>> +               ret = gpiod_to_irq(gpio);
>>>> +               if (ret < 0)
>>>> +                       return ret;
>> I wonder if you should handle 0 as error, too. But even as is:
>>
>> 	Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>
>> Thanks
>> Uwe
>>
>> -- 
>> Pengutronix e.K.                           | Uwe Kleine-König            |
>> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

