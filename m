Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56405 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266Ab1KVVBj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Nov 2011 16:01:39 -0500
Message-ID: <4ECC0DB9.9040401@kernel.org>
Date: Tue, 22 Nov 2011 21:01:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: RFC: Rename iio_{allocate,free}_device to iio_device_{alloc,free}
References: <4ECB9D6F.4070303@metafoo.de>
In-Reply-To: <4ECB9D6F.4070303@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/22/2011 01:02 PM, Lars-Peter Clausen wrote:
> Currently we have two pairs of functions which respectively are used to
> allocate/register and unregister/free a iio devices. The first pair is
> iio_allocate_device, iio_device_register and the second pair is
> iio_device_unregister, iio_free_device. So what can be seen is, that there
> is a bit of inconsistency here as to where to put the "device" in the
> function name.
> 
> So in order to streamline the API I propose to rename iio_free_device to
> iio_device_free and iio_allocate_device to iio_device_alloc (alloc instead
> of allocate to be more in sync with other in kernel APIs e.g.
> platform_device_alloc).
> 
> If nobody sees any problems or has any objections I'll send a patch.
Other than the allocate->alloc change I've already done the equivalent
for the outofstaging tree (having noted the same thing whilst cleaning
that up!).  The alloc change makes sense so I'll drive it it there as
well at some point.  Will obviously have to update the namespace move
patches but that's fine.  I can't do those namespace patches until
staging-next gets updated anyway so can easily make them dependent
on what you do.

Jonathan
> 
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

