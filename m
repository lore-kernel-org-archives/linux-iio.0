Return-Path: <SRS0=JiSV=B6=gmail.com=joel.stan@kernel.org>
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <CA+gwMcdVpq1P5kWAWzkg2A+Ah-fKyTk0adhGdg4465gkOY3EKA@mail.gmail.com>
References: <20171031021203.18248-1-joel@jms.id.au> <CA+gwMcdVpq1P5kWAWzkg2A+Ah-fKyTk0adhGdg4465gkOY3EKA@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Nov 2017 10:15:32 +1030
Message-ID: <CACPK8Xc1d89MXBjSJw7Jz0oqkCcoxKbymaVDmJq-kHFK6qG0Sw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: aspeed: Deassert reset in probe
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rick Altherr <raltherr@google.com>,
	Rob Herring <robh+dt@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Oct 31, 2017 at 10:28 PM, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> On Tue, Oct 31, 2017 at 3:12 AM, Joel Stanley <joel@jms.id.au> wrote:
>> The ASPEED SoC must deassert a reset in order to use the ADC peripheral.
>>
>> The device tree bindings are updated to document the resets phandle, and
>> the example is updated to match what is expected for both the reset and
>> clock phandle. Note that the bindings should have always had the reset
>> controller, as the hardware is unusable without it.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> It is unfortunate that this has to break DT (theoretical) backwards
> compatibility, but given that the old bindings never worked,
> this is better than to pretend a required reset is optional.
>
> Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>

Thanks. I agree that it's unfortunate; this has been my first time
working on an ARM SoC and there were few things we could have done
better in hindsight.

I've got similar patches for the ASPEED hwmon pwm/tach driver, and the
i2c driver that I'll send out now.

Thanks for the review.

Cheers,

Joel
