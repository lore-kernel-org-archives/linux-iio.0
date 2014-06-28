Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:51127 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbaF1IrD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 28 Jun 2014 04:47:03 -0400
Message-ID: <53AE8186.8040707@kernel.org>
Date: Sat, 28 Jun 2014 09:49:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] raw read performance improvement
References: <1403829626-17660-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1403829626-17660-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/14 01:40, Srinivas Pandruvada wrote:
> We see several performance issues reading individual axis, when
> raw read is the only option. Since most of the time user space reads x, y
> and z, one after other, this results in three sysfs reads, and based on
> chipset we have to power up or set up measurement mode and wait for
> response.
That's probably a case for a change in the driver to schedule the power
down for a little period after the read rather than immediately...
> For example reading x,y and z takes 160ms for ak8975, it is true for
> other too. But reading together takes only 80ms.
>
> IIO types already defined a modifier for X_AND_Y_AND_Z, which is used
> by one driver to send event code. This modifier has no value assigned
> so (null) appears in sysfs. If this is not correct then we may need
> another modifier.
>
> Since we have now raw_read with capability to read multiple values,
> we can use this callback to return values to iio core.
>
I've actually argued fairly strongly against this sort of multiple
channel simply because it means there are multiple ways of presenting the
same data in the ABI. The big difference with the Quaternion case is that
the elements of that have no meaning whatsoever if you don't have them
all.

Previously any indication that people wanted higher performance reads
would mean that I'd just tell them that is what the chardev interface
is for.  Here a simple sysfs trigger and a couple of extra lines in the
driver and you'd have what you want with considerably less overhead.

Hence my initial thought to this patch is that I'm not keen.  However,
lets let it sit for a while and see what other comments people have.
Perhaps if there is enough demand I might rethink my position.

Jonathan
> Srinivas Pandruvada (2):
>    iio: core: add xyz modifier value
>    iio: magnetometer: ak8975: Improve performance of raw reads
>
>   drivers/iio/industrialio-core.c   |  1 +
>   drivers/iio/magnetometer/ak8975.c | 58 ++++++++++++++++++++++++++-------------
>   2 files changed, 40 insertions(+), 19 deletions(-)
>

