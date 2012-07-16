Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 16 Jul 2012 12:02:48 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Michael Hennerich <michael.hennerich@analog.com>
cc: "jic23@kernel.org" <jic23@kernel.org>,
    "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
    "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>,
    "fengguang.wu@intel.com" <fengguang.wu@intel.com>
Subject: Re: [PATCH] iio: staging: ad7298_ring: Fix maybe-uninitialized
 warning
In-Reply-To: <5003E3B1.909@analog.com>
Message-ID: <alpine.DEB.2.01.1207161155350.18056@pmeerw.net>
References: <1342428125-31577-1-git-send-email-michael.hennerich@analog.com> <alpine.DEB.2.01.1207161124570.18056@pmeerw.net> <5003E3B1.909@analog.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Well - calling a function to initialize a variable which isn't being used
> anywhere doesn't make more sense.
 
> IMHO a more adequate fix would be to remove the timestamp argument from
> store_to(),
> since it isn't used anywhere.

so
indio_dev->buffer->access->store_to(ring, (u8 *)buf, time_ns);
should become
iio_push_to_buffer(buffer, (u8 *)data->buffer, time_ns);
and you suggest to drop the last argument?

I wasn't aware that timestamp is not used; at least iio_store_to_kfifo() 
and iio_store_to_sw_ring() just ignore it

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
