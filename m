Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1450399868.5427.11.camel@linux.intel.com>
Subject: Re: iio/hid-sensor-accel-3d: no output from /dev/iio:device*?
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>, Jiri Kosina
 <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen
	 <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, Crt Mori <cmo@melexis.com>
Date: Thu, 17 Dec 2015 16:51:08 -0800
In-Reply-To: <CAOhV88ODTazDA2jmn9DP5idMmXXQa9jKB9Ur_aWTD_3WYZM1fw@mail.gmail.com>
References: 
	<CAOhV88ODTazDA2jmn9DP5idMmXXQa9jKB9Ur_aWTD_3WYZM1fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2015-12-17 at 15:38 -0800, Nish Aravamudan wrote:
> [Starting a new thread from https://lkml.org/lkml/2015/12/15/663, as
> now my laptop is displaying values in the sysfs *raw* files.]
> 
> So I'm trying to understand exactly how the hid-sensor-accel-3d
> driver works.
> 
> If I turn up debugging, when I `cat
> /sys/bus/iio/devices/device*/*raw*`, I see "iio iio:device3:
> accel_3d_proc_event" and I think that means that
> hid_sensor_push_data() is getting called.
> 
> But read()'s on /dev/iio:device3 never produces anything, which is
> what iio-sensor-proxy uses to translate events to dbus.
> 
> Is it expected that the dev-node is "silent"? Just trying to
> understand if an extension to the driver to support a chardev based
> output is appropriate, or if iio-sensor-proxy needs to be changed to
> handle this device.

You are saying there is some regression. This used to work and now it
doesn't work. Is raw values are displayed correctly, when you do "cat"?
If cat of raw values is working then power on of sensors is working.

Turn on HID debug prints. If it is regression we can do git bisect.
Any ACPI or PM changes can break this. Usually there will be GPIOs
which will be involved in power on, where ACPI comes into play. This
will be done by i2c-hid. There are some prints in i2c-hid which can be
enabled also.

Thanks,
Srinivas

> 
> -Nish
