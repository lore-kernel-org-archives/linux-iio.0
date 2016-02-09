Return-Path: <gregor.boirie@parrot.com>
Message-ID: <56B9F570.1050108@parrot.com>
Date: Tue, 9 Feb 2016 15:19:28 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Lars-Peter Clausen
	<lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: using monotonic clok for timstamping
References: <56B1DCA4.9050903@parrot.com> <56B1E2D8.90308@metafoo.de> <56B63C8E.3020309@kernel.org> <56B865FC.7020106@metafoo.de> <EDC91D66-140E-4BC1-BA2C-06689BB8FC02@jic23.retrosnub.co.uk> <56B9C826.1090309@parrot.com>
In-Reply-To: <56B9C826.1090309@parrot.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/09/2016 12:06 PM, Gregor Boirie wrote:
> One remaining question is : how do we ensure sample and event timestamps
> consistency with respect to clock changes ? 2 suggestions:
> * reject the ability to select a new clock as long as an events 
> chardev is opened
>   or a buffered samples channel is enabled ;
Actually, this may be the only viable solution since some drivers save 
timestamps for
futur usage (see drivers/iio/accel/bmc150-accel-core.c). Changing 
reference clock
between 2 timestamping operations would lead to inconsistencies.

> * clock may be changed at any time since it could be implemented in an 
> atomic
>   way (a simple atomic_t can hold an int / clockid_t if I'm no wrong).
