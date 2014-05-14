Return-Path: <reyad.attiyat@gmail.com>
MIME-Version: 1.0
From: Reyad Attiyat <reyad.attiyat@gmail.com>
Date: Tue, 13 May 2014 21:14:06 -0500
Message-ID: <CA+BWVUShz2_Xd8EBWE+igjYk6Bc+K=LbjCr6EH7hNhvVodka6A@mail.gmail.com>
Subject: HID Sensor support for True/Magnetic North usage attributes
To: jic23@kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Dear IIO/HID maintainers,

I have a device, Surface Pro, that has the hid-sensor-hub and many
sensors attached. With the help of Srinivas I was able to get them all
working except for the magnometer. It uses the hid-magn-3d driver as
it should but it does not contain an axis (X, Y, Z) usage attributes.
Instead it only has a True North usage attribute. I see two solutions
to this problem and was inquiring which one would work best?

1) Modify the hid-magn-3d driver to handle True North attribute. I
realize there might not be many devices that have this so not sure if
appropriate. I think this could be done; by passing a variable amount
of IIO Channels when setting up the hid-magn-3d driver, depending on
how many axis and/or if it find True/Magnetic North usage attribute.

2) Create a whole new driver that handles True/Magnetic North. This
would not work on my device as it is set to Compass 3D Usage
Attribute. This could be resolved by adding another quirk for the
Surface to ensure it used the new driver.

For both options I think we'd need a new IIO_MOD_NORTH for the
iio_chan_spec, as the current ones don't really apply. I like the
first solution as it could allow for handling of devices with only one
or two axis present. I do realize if the hid-mangn-3d driver was
changed it's name would not make sense anymore and the pattern I'm
notcing is a driver for each HID Usage.

Here's a link to the hid report description with some labels for my device:
Bug 73321 Comment 7
https://bugzilla.kernel.org/show_bug.cgi?id=73321#c7

I'd be willing to work on this. Just wanted to know what would work best

Thank You,
Reyad Attiyat
