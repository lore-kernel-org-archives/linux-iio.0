Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <f26e218318cd07bdb857f67b1357f36e@jic23.retrosnub.co.uk>
References: <1465708397-19649-1-git-send-email-mranostay@gmail.com>
 <20160613222502.GA4376@d830.WORKGROUP> <CAKzfze_=URjXxePW4+P_Y8OUrgoMiC90Nzr=3ey+G=ZHKsRxCA@mail.gmail.com>
 <f26e218318cd07bdb857f67b1357f36e@jic23.retrosnub.co.uk>
From: Matt Ranostay <mranostay@gmail.com>
Date: Tue, 14 Jun 2016 12:01:06 -0700
Message-ID: <CAKzfze_LfWnorv-SagS8+0HbUiTprDFfXdAWCcTzC61TeFriYw@mail.gmail.com>
Subject: Re: [PATCH 0/2] iio: humidity: sht31: add Sensirion SHT31 support
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org, david.frey@sensirion.com
Cc: Alison Schofield <amsfield22@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hello Guenter et al,

So seems I wrote an iio driver for the SHT31 chipset about the same
David Frey had his merged into hwmon tree. So was wondering per
Jonathan's comments what your input on this would be.

>From what I can see the additional functionality of the hrtimer
trigger + rather fast update/integration time that a case could be
made because of the triggered buffer.

Now there is some functionality missing from my iio driver than exists
in the hwmon.. like the thermal and humidity trip points (but that can
be handled in a userspace HAL anyway), and the non-clock skewing
read/write functionality (this can be easily added).

Thanks,

Matt



On Tue, Jun 14, 2016 at 12:44 AM,  <jic23@jic23.retrosnub.co.uk> wrote:
> On 14.06.2016 00:23, Matt Ranostay wrote:
>>
>> Didn't notice that will till now, and looking at the timestamp I see why
>> :).
>> However this is more for the sw triggered buffer support which hwmon
>> lacks... there is a few examples of this already in the tree.
>>
>> Maybe Jonathan and Peter will have some input on this.
>>
> Thanks for highlighting this Alison.  Not the first time we have had
> simultaneous driver postings under review for both IIO and
> HWMON unfortunately.
>
> The hwmon guys are fairly flexible iff there is a good reason to want stuff
> that is in IIO.  The original hwmon humidity driver was actually my fault
> as it slipped in when hwmon was effectively not maintained (Andrew Morton
> was
> babysitting).  People on their side have always been a bit split on humidity
> drivers and whether they are within their scope.
>
> Anyhow, best bet is to email their list (perhaps reply to the driver thread)
> to make sure everyone knows this is going on (cc linux-iio as well).
> Then we can work out how to move forward.
>
> Two drivers, one in each place is a non starter for new parts.  We have
> ended up with a few instances, but it's mostly been a case of a driver
> with much wider scope ending up covering parts that were already in hwmon.
> Also a very small number of devices have moved across from hwmon to IIO.
>
> In this particular case the sensor is reasonably fast so there is at
> least some argument for IIO support. Note I tend to stay out of these
> and let the driver author work on convincing Guenter / Jean
> (they are very reasonable and responsive!) Only thing I'll say is that
> I'm more than happy to have this in IIO if the hwmon guys don't mind.
>
> Jonathan
>
>> On Mon, Jun 13, 2016 at 3:25 PM, Alison Schofield <amsfield22@gmail.com>
>> wrote:
>>>
>>> On Sat, Jun 11, 2016 at 10:13:15PM -0700, Matt Ranostay wrote:
>>>>
>>>> Add support for the humidity and temperature functionally for the SHT31
>>>> chipset. In addition add support for using using software triggers.
>>>
>>>
>>> Now that I'm hwmon-aware ;)  I see this same driver under review in
>>> hwmon.
>>> Can support exist in 2 places?
>>>
>>> alisons
>>>
>>>>
>>>> Matt Ranostay (2):
>>>>   devicetree: add Sensirion AG vendor id
>>>>   iio: humidity: sht31: add Sensirion SHT31 support
>>>>
>>>>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>>>>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>>>>  drivers/iio/humidity/Kconfig                       |  11 +
>>>>  drivers/iio/humidity/Makefile                      |   1 +
>>>>  drivers/iio/humidity/sht31.c                       | 416
>>>> +++++++++++++++++++++
>>>>  5 files changed, 430 insertions(+)
>>>>  create mode 100644 drivers/iio/humidity/sht31.c
>>>>
>>>> --
>>>> 2.7.4
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
