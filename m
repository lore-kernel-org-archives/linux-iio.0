Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <551C030E.1090309@metafoo.de>
References: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
	<212b45fac712e84a3cf0bc5955def7d1b683a6bd.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
	<CAEnQRZC=GtB7r=QG7DkDJOFz8bBQ-V+VD-DNkVG50-LubLMr8w@mail.gmail.com>
	<551C030E.1090309@metafoo.de>
Date: Wed, 1 Apr 2015 18:02:27 +0300
Message-ID: <CAEnQRZCsUiH_+GGxqPpLUDHVh_iu6O1QNTH5xdZuKojG11QZFQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] iio: ltr501: Add interrupt rate control support
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 1, 2015 at 5:39 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 04/01/2015 04:04 PM, Daniel Baluta wrote:
> [...]
>>
>>
>>> +static const struct iio_chan_spec_ext_info ltr501_ext_info[] = {
>>> +       {
>>> +               .name = "intr_persist",
>>> +               .read = ltr501_read_intr_prst,
>>> +               .write = ltr501_write_intr_prst,
>>> +               .shared = IIO_SHARED_BY_TYPE,
>>> +       },
>>> +       {},
>>> +};
>>> +
>>
>> Would be nice to standardize persistence attribute
>> (IIO_CHAN_INFO_PERSISTENCE).
>
>
> If I understand the behavior correctly it causes that the event needs to be
> triggered at least n times before the event is reported by the chip. In my
> opinion 'persistence' is not a good term for that. I'm not sure what a
> better term is but I think it should go more in the direction of ratelimit
> or something.

I've seen this term used for many devices:

*  TSL25911 ambient light sensor [1]

[ One set of thresholds can be configured to trigger an interrupt only when
 the ambient light exceeds them for a configurable amount of time (persistence)
]

* TAOS TCS34725 ambient light sensor [2]
[
The interrupt persistence filter allows the user to define the number
of consecutive
 out-of-threshold events necessary before generating an interrupt.
]

* Avago SAPDS-9950, Sensortek STK3310

I think the TSL25911 datasheet best describes this parameter, as the
amount of time
that ambient light should exceed a threshold until an interrupt is generated.

thanks,
Daniel.

[1] http://www.adafruit.com/datasheets/TSL25911_Datasheet_EN_v1.pdf
[2] http://www.adafruit.com/datasheets/TCS34725.pdf
