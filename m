Return-Path: <SRS0=Gaj0=DA=redhat.com=hdegoede@kernel.org>
Subject: Re: [PATCH 0/2] iio: accel: bmc150: Check for a second i2c resource
To: Lars Kellogg-Stedman <lars@oddbit.com>, Jeremy Cline <jeremy@jcline.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Steven Presser <steve@pressers.name>, linux-iio@vger.kernel.org
References: <0100016009e7c075-ae3eb98f-22d0-4fae-bcff-93102508b227-000000@email.amazonses.com>
 <CA+Q+rdwpgoiHVqvkF-gTb8g1BsVRqQucNRm0nWcmtJvzeeyqHQ@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <1d29bcd0-5af9-1c99-0a55-3eb676866f73@redhat.com>
Date: Mon, 4 Dec 2017 11:22:11 +0100
MIME-Version: 1.0
In-Reply-To: <CA+Q+rdwpgoiHVqvkF-gTb8g1BsVRqQucNRm0nWcmtJvzeeyqHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 30-11-17 22:19, Lars Kellogg-Stedman wrote:
> On Wed, Nov 29, 2017 at 5:31 PM, Jeremy Cline <jeremy@jcline.org <mailto:jeremy@jcline.org>> wrote:
> 
>     Some BOSC0200 ACPI devices, like the one in the Yoga 11e, have two i2c
>     accelerometers listed under a single ACPI device. This checks to see if
>     there is an ACPI companion and if so handles a second i2c client.
> 
> 
> I am going to try this out (on a yoga 11e) over the weekend.
> 
> Will this require an additional patch to iio-sensor-proxy in order to provide the appropriate input events to enter/exit tablet mode? I believe these need to be generated based on the relative position indicated by the two accelerometers.

So the tablet-switch stuff is separate from the accelerometers and
fully handled in ACPI, proper tablet-switch reporting is fixed by
this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=dda3ec0aa631d15b12a42438d23336354037e108

But iio-sensor-proxy may need some changes so that it only uses
the accelerometer in the screen, not the one in the base to
provide information for screen rotation.

Regards,

Hans
