Return-Path: <lars@metafoo.de>
Subject: Re: [RFC PATCH 1/2] iio: hmc5843 Add channel attribute for bias
 configuration
To: Cristina Moraru <cristina.moraru09@gmail.com>, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 cristina.opriceana@gmail.com, marek@goldelico.com, sdliyong@gmail.com,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, octavian.purdila@intel.com,
 daniel.baluta@intel.com
References: <1454597413-5298-1-git-send-email-cristina.moraru09@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56B38E29.8040300@metafoo.de>
Date: Thu, 4 Feb 2016 18:45:13 +0100
MIME-Version: 1.0
In-Reply-To: <1454597413-5298-1-git-send-email-cristina.moraru09@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 02/04/2016 03:50 PM, Cristina Moraru wrote:
> Replace non standard meas_conf attribute with the standard IIO
> calibbias attribute.
> 
> API for setting bias measurement configuration:
> 
> 0 - Normal measurement configuration (default): In normal measurement
>     configuration the device follows normal measurement flow. Pins BP
>     and BN are left floating and high impedance.
> 
> 1 - Positive bias configuration: In positive bias configuration, a
>     positive current is forced across the resistive load on pins BP
>     and BN.
> 
> 2 - Negative bias configuration. In negative bias configuration, a
>     negative current is forced across the resistive load on pins BP
>     and BN.
> 
> 3 - Only available on HMC5983. Magnetic sensor is disabled.
>     Temperature sensor is enabled.
> 
> With this in place, we can think of moving this driver out of staging.

Using a standard attribute, but overloading it with custom semantics doesn't
do any good either. calibbias is supposed to be a integer that gets added to
measurements internally in the device (unit is device specific though).

This attribute seems to do something else. In that case it might be better
to stay with a custom attribute (as long as it is documented) or come up
with a better way to map the device configuration onto standard attributes.
