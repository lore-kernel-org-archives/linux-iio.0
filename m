Return-Path: <bgolaszewski@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com> <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 29 Nov 2016 16:35:00 +0100
Message-ID: <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>,
	Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2016-11-29 16:30 GMT+01:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 11/29/2016 04:22 PM, Bartosz Golaszewski wrote:
> [...]
>> diff --git a/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt b/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt
>> new file mode 100644
>> index 0000000..147458f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt
>> @@ -0,0 +1,18 @@
>> +Industrial IO regulator device driver
>> +-------------------------------------
>> +
>> +This document describes the bindings for the iio-regulator - a dummy device
>> +driver representing a physical regulator within the iio framework.
>
> No bindings for drivers, only for hardware. So this wont work.
>

What about exporting regulator attributes analogous to the one in this
patch from the iio-core when a *-supply property is specified for a
node?

Thanks,
Bartosz
