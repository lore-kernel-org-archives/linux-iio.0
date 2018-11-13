Return-Path: <SRS0=s+WZ=NY=hadess.net=hadess@kernel.org>
Message-ID: <4990a4a867c57493e5ed525a8df5142281958393.camel@hadess.net>
Subject: Re: [PATCH v2] iio/hid-sensors: Fix IIO_CHAN_INFO_RAW returning
 wrong values for signed numbers
From: Bastien Nocera <hadess@hadess.net>
To: Hans de Goede <hdegoede@redhat.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>,
  Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org
Date: Tue, 13 Nov 2018 14:09:02 +0100
In-Reply-To: <20181031142005.15802-1-hdegoede@redhat.com>
References: <20181031142005.15802-1-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2018-10-31 at 15:20 +0100, Hans de Goede wrote:
> Before this commit sensor_hub_input_attr_get_raw_value() failed to
> take
> the signedness of 16 and 8 bit values into account, returning e.g.
> 65436 instead of -100 for the z-axis reading of an accelerometer.

Anything I need to change in iio-sensor-proxy for this?
