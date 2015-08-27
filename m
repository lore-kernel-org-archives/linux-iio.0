Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <A4AD71F9-277A-4483-A656-CFBC482F0AF6@jic23.retrosnub.co.uk>
References: <CAKzfze8Qt99iUDyamy9bhxGHN3tJpMPVi6yMwe7zUfeF2YFO7Q@mail.gmail.com>
	<A4AD71F9-277A-4483-A656-CFBC482F0AF6@jic23.retrosnub.co.uk>
Date: Wed, 26 Aug 2015 23:31:26 -0700
Message-ID: <CAKzfze_RxUYWrqFNgo3boQ_u1tBZYgXpGaC9SkqHVMqYCujcvA@mail.gmail.com>
Subject: Re: [RFC] Air quality sensor channel type
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Aug 26, 2015 at 10:41 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
>
> On 27 August 2015 05:55:39 BST, Matt Ranostay <mranostay@gmail.com> wrote:
>>Jonathan et all,
>>
>>Shortly going to be working an i2c air quality sensor and noticed
>>there is no current IIO_* channel attribute for anything VOC (volatile
>>organic compound) or CO2 readings. The data that this sensor would
>>report back is the parts per million of particles, so my first thought
>>is something like IIO_VOCPPM.
> Sounds sensible. Maybe throw together ABI docs in advance of driver.

Second thought a more generic IIO_PPM or IIO_PARTSPERMILLION makes
more sense since it couldn't always be VOC reported back. Like in this
sensor case it reports CO2 and VOC data differently.

I'll submit a RFC patch either tonight or tomorrow  to the list.

>
>>
>>Also which subdirectory would make sense in? Or a new one like
>>drivers/iio/voc ?
>
> New directory. Are there other forms of air quality sensor? Perhaps even
>  something general like IIO/chemical?
>
>
>
>>
>>MICS-VZ-89T I2C Datasheet:
>>* http://sgx.cdistore.com/datasheets/sgx/VZ-89-I2C-Specs.pdf
>>
>>
>>Thoughts? Comments?
>>
>>Thanks,
>>
>>Matt
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
