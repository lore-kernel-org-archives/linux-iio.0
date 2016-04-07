Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp+Ok2WBnRnwbHVLiV7K2kpsDqzjcEUWrL1JFa0vxxQHQ@mail.gmail.com>
References: <1459947832-23004-1-git-send-email-linus.walleij@linaro.org>
	<CAPDyKFp+Ok2WBnRnwbHVLiV7K2kpsDqzjcEUWrL1JFa0vxxQHQ@mail.gmail.com>
Date: Thu, 7 Apr 2016 12:18:12 +0200
Message-ID: <CACRpkdZCB4oytr3DtRXiH7Nj=CUoTTFvPPDT357gFev2aK3ZVg@mail.gmail.com>
Subject: Re: [PATCH v4] iio: light: new driver for the ROHM BH1780
From: Linus Walleij <linus.walleij@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@caiaq.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

(Looping in Daniel Baluta so he can tell me if I get the Android bits
wrong.)

On Wed, Apr 6, 2016 at 3:32 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

>> +       /*
>> +        * As the device takes 250 ms to even come up with a fresh
>> +        * measurement after power-on, do not shut it down unnecessarily.
>> +        * Set autosuspend to a five seconds.
>> +        */
>> +       pm_runtime_set_autosuspend_delay(&client->dev, 5000);
>
> I assume the parent device is the i2c controller for the sensor device!?

Yup.

> In the ux500 case, this i2c controller device resides in the VAPE PM
> domain, thus when you keep the sensor device runtime resumed, it means
> the VAPE PM domain will stay active.

After investigating: nope!

The I2C bus is not an issue in this context: the I2C host
will aggressively pm_runtime_suspend()/resume() even
between I2C transactions. With drivers/i2c/busses/i2c-nomadik.c
I get these debug prints:

cat in_illuminance_raw
[   83.656036] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_resume()
[   83.663543] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_suspend()
[   83.937103] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_resume()
[   83.945465] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_suspend()
[   83.952178] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_resume()
[   83.960540] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_suspend()
324

Then some time passes and the light sensor autosuspens leading to some
more i2c traffic:

[   89.137084] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtim)
[   89.143951] nmk-i2c 80128000.i2c: 80128000.i2c nmk_i2c_runtime_suspend()

Nice, the bus is actually clocked off, hardware can even power down
and the power domain is released. So your concern is addressed.

The reason it works so nicely I think is because the I2C driver
does this in probe():
pm_suspend_ignore_children(&adev->dev, true);

Which is what every i2c and spi driver should be doing, as there is
no need for the I2c/spi etc hardware to be clocked between
transactions. (I think some of them could be better off using
autosuspend though, aggressively hammering down the hardware
between every transaction seems a bit over the top.)

Let's look at the big picture though, as this driver can be
used on any I2C bus.

What do you think about auditing all i2c, spi and other external
bus drivers and send RFT patches to add a
pm_suspend_ignore_children() call to all of those missing it?
It seems to be a common mistake, these I2C drivers are
using runtime PM but not setting pm_suspend_ignore_children():
i2c-at91.c
i2c-cadence.c
i2c-designware-core.c
i2c-imx.c
i2c-omap.c
i2c-qup.c
i2c-rcar.c
i2c-s3c2410.c
i2c-xiic.c

Only Nomadik, hisilicon and SH seems to do it right :(

> Therefore, I am a bit concerned about the 5 s autosuspend delay here.
> Do you have an idea of how a regular use case would be for the sensor?
> In other words, at what frequency would you expect a new sensor value
> to be read?

Even if the I2C bus is not the issue (as described above) there
is still the question about a reasonable timeout.

For a suitable timeout value, let's see what Android does.
The framework lets you read values from the sensor at any
time of course.

Then the framework has a way for applications to register to
SENSOR_LIGHT events like this:

sensorManager.registerListener(sensorEventListener,
        sensorManager.getDefaultSensor(Sensor.TYPE_LIGHT),
        SensorManager.SENSOR_DELAY_FASTEST);

Possible delays are SENSOR_DELAY_NORMAL,
SENSOR_DELAY_GAME, SENSOR_DELAY_UI and
SENSOR_DELAY_FASTEST.

This is then translated deep in the Android framework
android/platform/frameworks/base in the file
core/java/android/hardware/SensorManager.java
to some chosen microsecond constants (how these were
chosen I have no clue about) here is the essence, the
delays are in microseconds:

SENSOR_DELAY_FASTEST: delay = 0;
SENSOR_DELAY_GAME: delay = 20000;
SENSOR_DELAY_UI: delay = 66667;
SENSOR_DELAY_NORMAL: delay = 200000;

So the delay between readings unless we're constantly
polling the sensor (this is wrong by the way: when using
Intels IIO android HAL, the fastest delay should be capped
to what the sensor reports in its sysfs file *_integration_time
but yeah, sigh) the delay will vary between 20 and 200 ms.

So in theory, Android would ask the sensor for a new value
every 200 ms for the normal usecase. Which is faster than
what the sensor can deliver, so it would report the same
value twice at times.

However I think there is execution overhead in Android,
so it's not really going to happen at that speed. I would have
to run a test rig to get a more reasonable value out.

I don't know if I can choose a better timeout value after
investigating (2)... I feel I know a lot more but to no avail.
Android will just hammer the device with requests when using
the above API, so we could set the timeout to 1 second for
example. Does that sound good?

I guess the algorithm that goes out to read the ambient light
to dim the backlight of the screen is just doing an odd
measurement every now and then. I haven't found this code,
but I strongly suspect it does not subscribe to events like
this, it just calls the raw API to get a sensor value at its
own interval.

> Moreover, what are the resume latency requirement of reading a new
> sensor value? Is it a problem to have a 250 ms latency for each new
> value?

We cannot do very much about that as it is a hardware property.
What you can do if you want lower latency is choose a different
component :)

In Android the sensor has methods like .getMinDelay() and
.getMaxDelay() and the application can adjust its behaviour.
It seems that its event manager doesn't care though, it just
goes and reads the sensor anyway. Maybe it's up to the
Android hardware layer to sleep and wait for a new value.

Yours,
Linus Walleij
