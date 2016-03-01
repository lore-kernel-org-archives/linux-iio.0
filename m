Return-Path: <mwelling79@gmail.com>
Sender: Michael Welling <mwelling79@gmail.com>
Date: Mon, 29 Feb 2016 18:50:32 -0600
From: Michael Welling <mwelling@ieee.org>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	lucas.demarchi@intel.com, linux@roeck-us.net, eibach@gdsys.de
Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
Message-ID: <20160301005032.GA15476@deathstar>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Feb 05, 2016 at 03:17:18PM +0200, Daniel Baluta wrote:
> The driver has sysfs readings with runtime PM support for power saving.
> It also offers buffer support that can be used together with IIO software
> triggers.
>

Daniel,

So I noticed something yesterday while testing new boards.
The channels are occassionally swapping when accessing data from multiple channels.

I wrote a simple bash script to demonstrate.

root@dragonboard-410c:~# cat test-analog.sh 
while [ 1 ]; do
voltage0=`cat /sys/bus/iio/devices/iio\:device0/in_voltage0_raw`
voltage1=`cat /sys/bus/iio/devices/iio\:device0/in_voltage1_raw`
voltage2=`cat /sys/bus/iio/devices/iio\:device0/in_voltage2_raw`
voltage3=`cat /sys/bus/iio/devices/iio\:device0/in_voltage3_raw`
echo ain0 = $voltage0 ain1 = $voltage1 ain2 = $voltage2 ain3 = $voltage3
done
root@dragonboard-410c:~# ./test-analog.sh 
ain0 = 266 ain1 = 291 ain2 = 268 ain3 = 291
ain0 = 287 ain1 = 294 ain2 = 289 ain3 = 292
ain0 = 284 ain1 = 294 ain2 = 286 ain3 = 0
ain0 = 285 ain1 = 288 ain2 = 287 ain3 = 0
ain0 = 287 ain1 = 286 ain2 = 287 ain3 = 0
ain0 = 285 ain1 = 287 ain2 = 293 ain3 = 0
ain0 = 0 ain1 = 289 ain2 = 293 ain3 = 0
ain0 = 0 ain1 = 289 ain2 = 290 ain3 = 291
ain0 = 287 ain1 = 289 ain2 = 289 ain3 = 0
ain0 = 0 ain1 = 285 ain2 = 288 ain3 = 0
ain0 = 285 ain1 = 286 ain2 = 288 ain3 = 0
ain0 = 286 ain1 = 288 ain2 = 285 ain3 = 0
ain0 = 287 ain1 = 293 ain2 = 289 ain3 = 292
ain0 = 288 ain1 = 292 ain2 = 287 ain3 = 293
ain0 = 286 ain1 = 287 ain2 = 289 ain3 = 0
ain0 = 283 ain1 = 289 ain2 = 289 ain3 = 0
ain0 = 0 ain1 = 287 ain2 = 287 ain3 = 0
ain0 = 0 ain1 = 286 ain2 = 288 ain3 = 0
ain0 = 286 ain1 = 288 ain2 = 289 ain3 = 0
ain0 = 287 ain1 = 286 ain2 = 290 ain3 = 0
ain0 = 289 ain1 = 291 ain2 = 287 ain3 = 0
ain0 = 284 ain1 = 286 ain2 = 292 ain3 = 0
ain0 = 286 ain1 = 291 ain2 = 289 ain3 = 292
ain0 = 284 ain1 = 292 ain2 = 291 ain3 = 291
ain0 = 285 ain1 = 287 ain2 = 287 ain3 = 0
ain0 = 0 ain1 = 289 ain2 = 291 ain3 = 0
ain0 = 0 ain1 = 288 ain2 = 291 ain3 = 0
ain0 = 0 ain1 = 286 ain2 = 288 ain3 = 0
ain0 = 286 ain1 = 287 ain2 = 290 ain3 = 0
ain0 = 286 ain1 = 286 ain2 = 288 ain3 = 0
ain0 = 286 ain1 = 286 ain2 = 287 ain3 = 0
ain0 = 285 ain1 = 289 ain2 = 288 ain3 = 288
ain0 = 289 ain1 = 292 ain2 = 289 ain3 = 293
ain0 = 287 ain1 = 292 ain2 = 290 ain3 = 0
ain0 = 286 ain1 = 286 ain2 = 291 ain3 = 0
ain0 = 0 ain1 = 287 ain2 = 290 ain3 = 0
ain0 = 0 ain1 = 286 ain2 = 289 ain3 = 0
ain0 = 284 ain1 = 285 ain2 = 292 ain3 = 0
ain0 = 285 ain1 = 289 ain2 = 289 ain3 = 0
ain0 = 287 ain1 = 287 ain2 = 287 ain3 = 0
ain0 = 287 ain1 = 291 ain2 = 287 ain3 = 291
ain0 = 288 ain1 = 291 ain2 = 290 ain3 = 293
ain0 = 285 ain1 = 290 ain2 = 287 ain3 = 292
ain0 = 285 ain1 = 289 ain2 = 289 ain3 = 292
ain0 = 286 ain1 = 289 ain2 = 288 ain3 = 0
ain0 = 0 ain1 = 286 ain2 = 291 ain3 = 0
ain0 = 0 ain1 = 287 ain2 = 291 ain3 = 0
ain0 = 287 ain1 = 286 ain2 = 291 ain3 = 0
ain0 = 288 ain1 = 286 ain2 = 289 ain3 = 0
ain0 = 284 ain1 = 289 ain2 = 288 ain3 = 0
ain0 = 287 ain1 = 290 ain2 = 287 ain3 = 292
ain0 = 285 ain1 = 292 ain2 = 289 ain3 = 292
ain0 = 289 ain1 = 292 ain2 = 290 ain3 = 0
.
.

The in_voltage3_raw channel is connected to GND the rest are left floating.
This does not happen if only one channels is accessed at a time.

I have not yet found the solution. Please left me know if this can be
duplicated on your end.

Regards,

Michael
