Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] iio:adc: Add support for AD7766/AD7767
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1474384526-22708-1-git-send-email-lars@metafoo.de>
 <alpine.DEB.2.02.1609201728340.19944@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <eb7179b0-12ff-5c10-1e33-9d230009dbd2@metafoo.de>
Date: Tue, 20 Sep 2016 22:27:17 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1609201728340.19944@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 09/20/2016 05:35 PM, Peter Meerwald-Stadler wrote:
> On Tue, 20 Sep 2016, Lars-Peter Clausen wrote:
> 
>> Add support for the AD7766, AD7766-1, AD7766-2, AD7767, AD7767-1, AD7767-2
>> Analog to Digital converters. It's a family of single channel 24-bit SAR
>> ADCs. They are all digital interface compatible and the main difference is
>> the internal decimation rate and analog performance. For communication with
>> the host processor a SPI interface is used.
> 
> looks good, nitpicking below

Thanks for the review.

>> +static const struct iio_chan_spec ad7766_channels[] = {
>> +	{
>> +		.type = IIO_VOLTAGE,
>> +		.indexed = 1,
> 
> have only one channel and still indexed?

To be honest I prefer to make all channels indexed. There is no inherent
value added by using un-indexed channels. The only thing that changes is the
naming scheme of the channel attributes. This makes things more complex and
also adds ambiguity between shared attributes and channel attributes, which
makes it harder to parse by machines (and maybe also some humans).

- Lars
