Return-Path: <lars@metafoo.de>
Message-ID: <551C030E.1090309@metafoo.de>
Date: Wed, 01 Apr 2015 16:39:10 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 2/3] iio: ltr501: Add interrupt rate control support
References: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>	<212b45fac712e84a3cf0bc5955def7d1b683a6bd.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com> <CAEnQRZC=GtB7r=QG7DkDJOFz8bBQ-V+VD-DNkVG50-LubLMr8w@mail.gmail.com>
In-Reply-To: <CAEnQRZC=GtB7r=QG7DkDJOFz8bBQ-V+VD-DNkVG50-LubLMr8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 04/01/2015 04:04 PM, Daniel Baluta wrote:
[...]
>
>> +static const struct iio_chan_spec_ext_info ltr501_ext_info[] = {
>> +       {
>> +               .name = "intr_persist",
>> +               .read = ltr501_read_intr_prst,
>> +               .write = ltr501_write_intr_prst,
>> +               .shared = IIO_SHARED_BY_TYPE,
>> +       },
>> +       {},
>> +};
>> +
> Would be nice to standardize persistence attribute (IIO_CHAN_INFO_PERSISTENCE).

If I understand the behavior correctly it causes that the event needs to be 
triggered at least n times before the event is reported by the chip. In my 
opinion 'persistence' is not a good term for that. I'm not sure what a 
better term is but I think it should go more in the direction of ratelimit 
or something.
