Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
Date: Thu, 8 Jan 2015 17:19:23 +0200
Message-ID: <CAEnQRZAY82eKVK6B0-s1c1UWbZthML9gNvk2-+_hyb-VnTO-jw@mail.gmail.com>
Subject: IIO_LIGHT vs IIO_INTENSITY
From: Daniel Baluta <daniel.baluta@intel.com>
To: Peter Meerwald <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi,

I'm not sure I understand the difference between
IIO_LIGHT vs IIO_INTENSITY as seen by the IIO.

As far as i know:

* IIO_LIGHT channels are used to measure illuminance
  [1] and the units after application of scale and offset
  are lux.
* IIO_INTENSITY channels are used to measure luminous
intensity [2]? I guess that units after application of scale (?)
are candela (although, not documented in the ABI file [3]).

Anyhow, reading the code for drivers with IIO_INTENSITY channels
it is not very clear what is the unit for in_intensityY_input or
in_intensityY_raw
after application of scale.

e.g for isl29125 the unit is lux [4]

thanks,
Daniel.

[1] http://en.wikipedia.org/wiki/Illuminance
[2] http://en.wikipedia.org/wiki/Luminous_intensity
[3] http://lxr.free-electrons.com/source/Documentation/ABI/testing/sysfs-bus-iio#L992
[4] http://lxr.free-electrons.com/source/drivers/iio/light/isl29125.c#L122
