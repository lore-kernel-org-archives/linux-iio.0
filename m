Return-Path: <jic23@cam.ac.uk>
Message-ID: <5003FAA7.4070602@cam.ac.uk>
Date: Mon, 16 Jul 2012 12:27:35 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Michael Hennerich <michael.hennerich@analog.com>,
 "jic23@kernel.org" <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>,
 "fengguang.wu@intel.com" <fengguang.wu@intel.com>
Subject: Re: [PATCH] iio: staging: ad7298_ring: Fix maybe-uninitialized warning
References: <1342428125-31577-1-git-send-email-michael.hennerich@analog.com> <alpine.DEB.2.01.1207161124570.18056@pmeerw.net> <5003E3B1.909@analog.com> <alpine.DEB.2.01.1207161155350.18056@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1207161155350.18056@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 7/16/2012 11:02 AM, Peter Meerwald wrote:
>
>> Well - calling a function to initialize a variable which isn't being used
>> anywhere doesn't make more sense.
>
>> IMHO a more adequate fix would be to remove the timestamp argument from
>> store_to(),
>> since it isn't used anywhere.
>
> so
> indio_dev->buffer->access->store_to(ring, (u8 *)buf, time_ns);
> should become
> iio_push_to_buffer(buffer, (u8 *)data->buffer, time_ns);
> and you suggest to drop the last argument?
>
> I wasn't aware that timestamp is not used; at least iio_store_to_kfifo()
> and iio_store_to_sw_ring() just ignore it
>
Yes. Been meaning to clean that up for a while, but as one of the
multiple buffer patches removes all those calls anyway I'll
kill it whilst doing that.
