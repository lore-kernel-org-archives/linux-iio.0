Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35996 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbcEKIox (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2016 04:44:53 -0400
Received: by mail-lf0-f68.google.com with SMTP id y84so4261219lfc.3
        for <linux-iio@vger.kernel.org>; Wed, 11 May 2016 01:44:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACRpkdZCB4oytr3DtRXiH7Nj=CUoTTFvPPDT357gFev2aK3ZVg@mail.gmail.com>
References: <1459947832-23004-1-git-send-email-linus.walleij@linaro.org>
	<CAPDyKFp+Ok2WBnRnwbHVLiV7K2kpsDqzjcEUWrL1JFa0vxxQHQ@mail.gmail.com>
	<CACRpkdZCB4oytr3DtRXiH7Nj=CUoTTFvPPDT357gFev2aK3ZVg@mail.gmail.com>
Date: Wed, 11 May 2016 11:44:45 +0300
Message-ID: <CAEnQRZCY-_eYiJoOVzySh2U-JQNcdtOqQTGt0YUHQohr0AuFgQ@mail.gmail.com>
Subject: Re: [PATCH v4] iio: light: new driver for the ROHM BH1780
From: Daniel Baluta <daniel.baluta@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@caiaq.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	viorel.suman@intel.com, Adriana Reus <adi.reus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Apr 7, 2016 at 1:18 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> (Looping in Daniel Baluta so he can tell me if I get the Android bits
> wrong.)
>
> On Wed, Apr 6, 2016 at 3:32 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>>> +       /*
>>> +        * As the device takes 250 ms to even come up with a fresh
>>> +        * measurement after power-on, do not shut it down unnecessarily.
>>> +        * Set autosuspend to a five seconds.
>>> +        */
>>> +       pm_runtime_set_autosuspend_delay(&client->dev, 5000);


Is the device powered off on suspend? If no, this comment is
misleading regarding
the 5 seconds timeout. Because this will only happen at probe, in the
rest of the time
the device will take a measurement much faster.

>>
>> I assume the parent device is the i2c controller for the sensor device!?
>
> Yup.
>
>> In the ux500 case, this i2c controller device resides in the VAPE PM
>> domain, thus when you keep the sensor device runtime resumed, it means
>> the VAPE PM domain will stay active.
>
> After investigating: nope!
>
> The I2C bus is not an issue in this context: the I2C host
> will aggressively pm_runtime_suspend()/resume() even
> between I2C transactions. With drivers/i2c/busses/i2c-nomadik.c
> I get these debug prints:
>
> cat in_illuminance_raw
> [   83.656036] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_resume()
> [   83.663543] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_suspend()
> [   83.937103] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_resume()
> [   83.945465] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_suspend()
> [   83.952178] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_resume()
> [   83.960540] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_suspend()
> 324
>
> Then some time passes and the light sensor autosuspens leading to some
> more i2c traffic:
>
> [   89.137084] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtim)
> [   89.143951] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_suspend()
>
> Nice, the bus is actually clocked off, hardware can even power down
> and the power domain is released. So your concern is addressed.
>
> The reason it works so nicely I think is because the I2C driver
> does this in probe():
> pm_suspend_ignore_children(&adev->dev, true);
>
> Which is what every i2c and spi driver should be doing, as there is
> no need for the I2c/spi etc hardware to be clocked between
> transactions. (I think some of them could be better off using
> autosuspend though, aggressively hammering down the hardware
> between every transaction seems a bit over the top.)
>
> Let's look at the big picture though, as this driver can be
> used on any I2C bus.
>
> What do you think about auditing all i2c, spi and other external
> bus drivers and send RFT patches to add a
> pm_suspend_ignore_children() call to all of those missing it?
> It seems to be a common mistake, these I2C drivers are
> using runtime PM but not setting pm_suspend_ignore_children():
> i2c-at91.c
> i2c-cadence.c
> i2c-designware-core.c
> i2c-imx.c
> i2c-omap.c
> i2c-qup.c
> i2c-rcar.c
> i2c-s3c2410.c
> i2c-xiic.c
>
> Only Nomadik, hisilicon and SH seems to do it right :(
>
>> Therefore, I am a bit concerned about the 5 s autosuspend delay here.
>> Do you have an idea of how a regular use case would be for the sensor?
>> In other words, at what frequency would you expect a new sensor value
>> to be read?
>
Android CDD doesn't say much about light sensor sampling frequency requirements
[1] (chapter 7.3.7).

Anyhow, reporting mode for Sensor.TYPE_LIGHT is OnChange [2] and for this
Intel IIO sensors HAL defines:

MIN_ON_CHANGE_SAMPLING_PERIOD_US   200000
MAX_ON_CHANGE_SAMPLING_PERIOD_US 10000000

that is supported sampling frequency is between 0.1 and 5 Hz (pretty relaxed!)

Adding Viorel, perhaps he can add more details on this.

> Even if the I2C bus is not the issue (as described above) there
> is still the question about a reasonable timeout.
>
> For a suitable timeout value, let's see what Android does.
> The framework lets you read values from the sensor at any
> time of course.
>
> Then the framework has a way for applications to register to
> SENSOR_LIGHT events like this:
>
> sensorManager.registerListener(sensorEventListener,
>         sensorManager.getDefaultSensor(Sensor.TYPE_LIGHT),
>         SensorManager.SENSOR_DELAY_FASTEST);
>
> Possible delays are SENSOR_DELAY_NORMAL,
> SENSOR_DELAY_GAME, SENSOR_DELAY_UI and
> SENSOR_DELAY_FASTEST.

Sure, with the comment that on the newest versions of Android spec
last parameter can by any delay in microseconds. [3]
>
> This is then translated deep in the Android framework
> android/platform/frameworks/base in the file
> core/java/android/hardware/SensorManager.java
> to some chosen microsecond constants (how these were
> chosen I have no clue about) here is the essence, the
> delays are in microseconds:
>
> SENSOR_DELAY_FASTEST: delay = 0;
> SENSOR_DELAY_GAME: delay = 20000;
> SENSOR_DELAY_UI: delay = 66667;
> SENSOR_DELAY_NORMAL: delay = 200000;
>
> So the delay between readings unless we're constantly
> polling the sensor (this is wrong by the way: when using
> Intels IIO android HAL, the fastest delay should be capped
> to what the sensor reports in its sysfs file *_integration_time
> but yeah, sigh) the delay will vary between 20 and 200 ms.

Intel IIO sensors HAL does this, see call trace going to [4]
but it looks at *_sampling_frequency.

>
> So in theory, Android would ask the sensor for a new value
> every 200 ms for the normal usecase. Which is faster than
> what the sensor can deliver, so it would report the same
> value twice at times.
>
> However I think there is execution overhead in Android,
> so it's not really going to happen at that speed. I would have
> to run a test rig to get a more reasonable value out.
>
> I don't know if I can choose a better timeout value after
> investigating (2)... I feel I know a lot more but to no avail.
> Android will just hammer the device with requests when using
> the above API, so we could set the timeout to 1 second for
> example. Does that sound good?

Looking at timeouts chosen by IIO drivers there are all between
2 and 5 seconds.

If Android would ask a new value every 200ms then it wouldn't
make any difference if the timeout is 1s or 5s, we would never
get into suspend.

>
> I guess the algorithm that goes out to read the ambient light
> to dim the backlight of the screen is just doing an odd
> measurement every now and then. I haven't found this code,
> but I strongly suspect it does not subscribe to events like
> this, it just calls the raw API to get a sensor value at its
> own interval.
>
>> Moreover, what are the resume latency requirement of reading a new
>> sensor value? Is it a problem to have a 250 ms latency for each new
>> value?
>
> We cannot do very much about that as it is a hardware property.
> What you can do if you want lower latency is choose a different
> component :)
>
> In Android the sensor has methods like .getMinDelay() and
> .getMaxDelay() and the application can adjust its behaviour.
> It seems that its event manager doesn't care though, it just
> goes and reads the sensor anyway. Maybe it's up to the
> Android hardware layer to sleep and wait for a new value.

Sorry for the late answer.

thanks,
Daniel.

[1] http://static.googleusercontent.com/media/source.android.com/en//compatibility/android-cdd.pdf
[2] https://source.android.com/devices/sensors/sensor-types.html#light
[3] http://developer.android.com/reference/android/hardware/SensorManager.html#registerListener(android.hardware.SensorEventListener,
android.hardware.Sensor, int, int)
[4] https://github.com/01org/android-iio-sensors-hal/blob/master/control.c#L753
