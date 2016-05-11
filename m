Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCY-_eYiJoOVzySh2U-JQNcdtOqQTGt0YUHQohr0AuFgQ@mail.gmail.com>
References: <1459947832-23004-1-git-send-email-linus.walleij@linaro.org>
	<CAPDyKFp+Ok2WBnRnwbHVLiV7K2kpsDqzjcEUWrL1JFa0vxxQHQ@mail.gmail.com>
	<CACRpkdZCB4oytr3DtRXiH7Nj=CUoTTFvPPDT357gFev2aK3ZVg@mail.gmail.com>
	<CAEnQRZCY-_eYiJoOVzySh2U-JQNcdtOqQTGt0YUHQohr0AuFgQ@mail.gmail.com>
Date: Wed, 11 May 2016 11:08:46 +0200
Message-ID: <CACRpkdao0wJh4qMYRn5ONK74rbohyrvWncUSA-_-ttNEyO_OLw@mail.gmail.com>
Subject: Re: [PATCH v4] iio: light: new driver for the ROHM BH1780
From: Linus Walleij <linus.walleij@linaro.org>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@caiaq.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, viorel.suman@intel.com,
	Adriana Reus <adi.reus@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 11, 2016 at 10:44 AM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> On Thu, Apr 7, 2016 at 1:18 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> (Looping in Daniel Baluta so he can tell me if I get the Android bits
>> wrong.)
>>
>> On Wed, Apr 6, 2016 at 3:32 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>>>> +       /*
>>>> +        * As the device takes 250 ms to even come up with a fresh
>>>> +        * measurement after power-on, do not shut it down unnecessarily.
>>>> +        * Set autosuspend to a five seconds.
>>>> +        */
>>>> +       pm_runtime_set_autosuspend_delay(&client->dev, 5000);
>
>
> Is the device powered off on suspend?

Yes, because:

static const struct dev_pm_ops bh1780_dev_pm_ops = {
        SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
                                pm_runtime_force_resume)
        SET_RUNTIME_PM_OPS(bh1780_runtime_suspend,
                           bh1780_runtime_resume, NULL)
};

> misleading regarding
> the 5 seconds timeout. Because this will only happen at probe, in the
> rest of the time the device will take a measurement much faster.

It will take up to 250ms before a new measurement is taken also
after runtime resume.

>>> Therefore, I am a bit concerned about the 5 s autosuspend delay here.
>>> Do you have an idea of how a regular use case would be for the sensor?
>>> In other words, at what frequency would you expect a new sensor value
>>> to be read?
>
> Android CDD doesn't say much about light sensor sampling frequency requirements
> [1] (chapter 7.3.7).
>
> Anyhow, reporting mode for Sensor.TYPE_LIGHT is OnChange [2] and for this
> Intel IIO sensors HAL defines:
>
> MIN_ON_CHANGE_SAMPLING_PERIOD_US   200000
> MAX_ON_CHANGE_SAMPLING_PERIOD_US 10000000
>
> that is supported sampling frequency is between 0.1 and 5 Hz (pretty relaxed!)

OK thanks it seems we are in compliance :)

>> Then the framework has a way for applications to register to
>> SENSOR_LIGHT events like this:
>>
>> sensorManager.registerListener(sensorEventListener,
>>         sensorManager.getDefaultSensor(Sensor.TYPE_LIGHT),
>>         SensorManager.SENSOR_DELAY_FASTEST);
>>
>> Possible delays are SENSOR_DELAY_NORMAL,
>> SENSOR_DELAY_GAME, SENSOR_DELAY_UI and
>> SENSOR_DELAY_FASTEST.
>
> Sure, with the comment that on the newest versions of Android spec
> last parameter can by any delay in microseconds. [3]

Yeah I saw some references to that in the code too.
It looked quite hackish ... but nice that they fixed it.
OK people can ask for arbitrary delays.

>> SENSOR_DELAY_FASTEST: delay = 0;
>> SENSOR_DELAY_GAME: delay = 20000;
>> SENSOR_DELAY_UI: delay = 66667;
>> SENSOR_DELAY_NORMAL: delay = 200000;
>>
>> So the delay between readings unless we're constantly
>> polling the sensor (this is wrong by the way: when using
>> Intels IIO android HAL, the fastest delay should be capped
>> to what the sensor reports in its sysfs file *_integration_time
>> but yeah, sigh) the delay will vary between 20 and 200 ms.
>
> Intel IIO sensors HAL does this, see call trace going to [4]
> but it looks at *_sampling_frequency.

OK good, thanks!

>> I don't know if I can choose a better timeout value after
>> investigating (2)... I feel I know a lot more but to no avail.
>> Android will just hammer the device with requests when using
>> the above API, so we could set the timeout to 1 second for
>> example. Does that sound good?
>
> Looking at timeouts chosen by IIO drivers there are all between
> 2 and 5 seconds.
>
> If Android would ask a new value every 200ms then it wouldn't
> make any difference if the timeout is 1s or 5s, we would never
> get into suspend.

True. I'm thinking about implementing autosuspend for
the ST Micro sensors too, I guess I will just use some
blanket value like 5s.

Yours,
Linus Walleij
