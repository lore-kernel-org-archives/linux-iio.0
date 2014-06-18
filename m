Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <53A224AB.9090305@linux.intel.com>
Date: Wed, 18 Jun 2014 16:45:47 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Reyad Attiyat <reyad.attiyat@gmail.com>
CC: Bastien Nocera <hadess@hadess.net>, linux-iio@vger.kernel.org,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>
Subject: Re: User-space API for accelerometer(s)?
References: <1403100542.30918.29.camel@nuvo> <CA+BWVUSqrJhFwKXHL5q=mwcxmasfkpNB6EqEXC6jPfg0ytOVzA@mail.gmail.com>
In-Reply-To: <CA+BWVUSqrJhFwKXHL5q=mwcxmasfkpNB6EqEXC6jPfg0ytOVzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/18/2014 04:31 PM, Reyad Attiyat wrote:
> Hello Bastien Nocera,
>
> I'm not the best person to answer your questions but I will try and
> help. The best people to talk to would be Jonathan Cameron, the IIO
> maintainer, and Srinivas Pandruvada, the author of the hid-sensor-hub
> device drivers. I have CC'ed them for you to hopefully get a better
> response than what I can offer.
>
> Your device uses the same sensor hub, over usb, as my device does. I
> have a Microsoft Surface and it also uses many of the sensors found on
> the Lenovo Yoga.
>
>> So, my question regarding the IIO user-space API is:
>> is it possible to make the IIO accelerometer send out a kevent when the
>> orientation changes in a major way (using triggers?) or does user-space
>> need to poll the device instead?

You can check a program called generic_buffer.c in 
"drivers/staging/iio/Documentation". I have used this as a reference to 
port to Android.
You don't need to poll, you can also check 
"https://github.com/pfps/yoga-laptop/sensors " developed by Peter F. 
Patel-Schneider.

Thanks,
Srinivas

>
> Of course it's possible but this does not occur in the current hid
> sensor hub drivers, from my understanding of the code. You should
> probably check out the current documentation on the IIO sysfs user
> interface:
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio
>
> These outline the possible attributes sysfs offers. As of now the only
> ones that are found on the hid sensor hub devices is _raw as of 3.16
> and _scale, _offset, _sampling_frequency, _hysteresis. The raw
> attribute lets you read the data that is at the top of the iio buffer.
> As you can see in the documentation there are many events support by
> other drivers that could possible be implemented by the hid-sensor-hub
> devices.
>
> IIO devices use a buffer that have a fixed size. It can be enabled
> with the sysfs interface. An example of this can be found in the
> kernel (drivers/staging/iio/iio_simple_dummy_buffer.c) there is also
> additional documentation there as well as dummy drivers.
>
> To use these interfaces in user space, or in the context of GNOME
> desktop, I think you would need to poll the iio buffer for new data
> and calculate the changes that way. The iio subsystem does support
> events but you would need to add these to the hid-sensor-hub devices
> and do the calculations for each event. This would allow you to poll
> for these iio events instead of polling the buffer.
>
> Hope this helps,
> Reyad Attiyat
>
