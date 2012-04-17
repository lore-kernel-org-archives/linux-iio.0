Return-Path: <bfreed@google.com>
MIME-Version: 1.0
Sender: bfreed@google.com
In-Reply-To: <4F8D5B09.8080309@nvidia.com>
References: <1334652631-21032-1-git-send-email-ldewangan@nvidia.com>
	<4F8D5506.6070105@cam.ac.uk>
	<4F8D5B09.8080309@nvidia.com>
Date: Tue, 17 Apr 2012 10:56:37 -0700
Message-ID: <CAEYUcX3TbXFmKYCvfz00tpJ3K0bSExnQxV1R==dP=+vsK54KPQ@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: light: isl29018: use regmap for register access
From: Bryan Freed <bfreed@chromium.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "max@stro.at" <max@stro.at>,
	"jbrenner@taosinc.com" <jbrenner@taosinc.com>, "lars@metafoo.de" <lars@metafoo.de>,
	"grundler@chromium.org" <grundler@chromium.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hey Laxman, Jonathan.

The regmap is pretty new to me.  In looking at it, I see
_regmap_write() will regcache_write() before attempting to write to
the device.
This effectively updates the cached value even when the device write
fails, which is the opposite of the current isl29018 cache policy.

It looks like we tried to change the policy back in August and got
this response:
  > I did change one basic behavior that I think was also broken: cache
  > the value regardless of if the transaction completed successfully or
  > not.
  Don't do that.  That means userspace will get an invalid value if it read=
s
  in the meantime. If you have an error on a hardware bus - tell userspace =
about
  it and don't 'guess' what is in the register.
See http://driverdev.linuxdriverproject.org/pipermail/devel/2011-August/020=
256.html
for details.

The result is likely to be that after a failed write to one field of a
register, the next successful write to another field of that register
will update them both.

bryan.

On Tue, Apr 17, 2012 at 4:59 AM, Laxman Dewangan <ldewangan@nvidia.com> wro=
te:
>
> HI Jonathan,
>
> Thanks for fast review.
>
>
> On Tuesday 17 April 2012 05:03 PM, Jonathan Cameron wrote:
>>
>> On 4/17/2012 9:50 AM, Laxman Dewangan wrote:
>>>
>>> Using regmap for accessing register through i2c bus. This will
>>> remove the code for caching registers, read-modify-write logics.
>>> Also it will provide the debugfs feature to dump register
>>> through regmap debugfs.
>>
>> I'd prefer the intial tab fixup for the kconfig file as a separate
>> patch, but other than that
>> all looks good.
>>
>
> Yes, this make sense. I will create fist patch for fixing this and then n=
ext
> patch for actual my change.
>
>
>> This will probably cause issues alongside the series I sent to Greg the
>> other day though
>> so you may want to sit on it for a day or two and rebase.
>
>
> I will wait for your change to be in linux-next and then I will create ne=
xt
> patches.
>
>
>>> Signed-off-by: Laxman Dewangan<ldewangan@nvidia.com>
>>
>> Acked-by: Jonathan Cameron<jic23@kernel.org>
>>>
>>> ---
>>> =A0 drivers/staging/iio/light/Kconfig =A0 =A0| =A0 19 ++--
>>> =A0 drivers/staging/iio/light/isl29018.c | =A0176
>>> +++++++++++++++++-----------------
>>> =A0 2 files changed, 99 insertions(+), 96 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/light/Kconfig
>>> b/drivers/staging/iio/light/Kconfig
>>> index 53b49f7..fd39f72 100644
>>> --- a/drivers/staging/iio/light/Kconfig
>>> +++ b/drivers/staging/iio/light/Kconfig
>>> @@ -4,15 +4,16 @@
>>> =A0 menu "Light sensors"
>>>
>>> =A0 config SENSORS_ISL29018
>>> - =A0 =A0 =A0 =A0tristate "ISL 29018 light and proximity sensor"
>>> - =A0 =A0 =A0 =A0depends on I2C
>>> - =A0 =A0 =A0 =A0default n
>>> - =A0 =A0 =A0 =A0help
>>> - =A0 =A0 =A0 =A0 If you say yes here you get support for ambient light=
 sensing
>>> and
>>> - =A0 =A0 =A0 =A0 proximity infrared sensing from Intersil ISL29018.
>>> - =A0 =A0 =A0 =A0 This driver will provide the measurements of ambient =
light
>>> intensity
>>> - =A0 =A0 =A0 =A0 in lux, proximity infrared sensing and normal infrare=
d sensing.
>>> - =A0 =A0 =A0 =A0 Data from sensor is accessible via sysfs.
>>> + =A0 =A0 tristate "ISL 29018 light and proximity sensor"
>>> + =A0 =A0 depends on I2C
>>> + =A0 =A0 select REGMAP_I2C
>>> + =A0 =A0 default n
>>> + =A0 =A0 help
>>> + =A0 =A0 =A0If you say yes here you get support for ambient light sens=
ing and
>>> + =A0 =A0 =A0proximity infrared sensing from Intersil ISL29018.
>>> + =A0 =A0 =A0This driver will provide the measurements of ambient light
>>> intensity
>>> + =A0 =A0 =A0in lux, proximity infrared sensing and normal infrared sen=
sing.
>>> + =A0 =A0 =A0Data from sensor is accessible via sysfs.
>>
>> Down to here is a valid but unconnected change. =A0Can you break this ou=
t
>> to a separate patch?
>
>
> Sure, I will do.
