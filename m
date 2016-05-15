Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40737 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbcEORz2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2016 13:55:28 -0400
Subject: Re: [RFC] Make the devm_iio_device_alloc call set iio_dev.dev.parent.
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Matt Ranostay <mranostay@gmail.com>
References: <f71d4bfe-fd29-7f00-d770-f62221118000@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8349aadb-c655-95c5-9399-960331b047ca@kernel.org>
Date: Sun, 15 May 2016 18:55:23 +0100
MIME-Version: 1.0
In-Reply-To: <f71d4bfe-fd29-7f00-d770-f62221118000@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/05/16 11:56, Jonathan Cameron wrote:
> Hi All,
> 
> One thing that I discovered via a recent input device review is that
> the equivalent of our devm_iio_device_alloc there also sets the
> dev.parent.
> 
> Should we do the same in IIO?
> 
> I'm a bit in too minds as it feels like it is only sort of 'part of the
> allocation'.
> 
> Still it drops one line from nearly every IIO driver.
> Could do the same for dev_iio_trigger_alloc as well I guess for double
> savings.
> 
> Anyhow, a little cleanup that seemed like a moderately good idea to
> me so I thought I'd see what the general view was.
> 
> Jonathan

I'm gong ahead with this - just for reference purposes the oddities so far
are:
stx104 which never set the parent.
max30100 which never sets the parent.
apds9960 which never sets the parent.
ms5611_i2c never sets the parent.
pulsed_light lidar never sets the parent.

lm3533 which sets the iio device parent to the mfd device parent, but allocates
on the devm against the mfd. I'm not certain this is how it should have been done
but now it is abi so we have to cope with it.
We can handle this just fine by letting it override the default.

Each patch is simple enough I'll probably just do this in one or two mega patches
rather than one per driver...

Same trick applies for the devm_iio_trigger_alloc though that is used rather less.

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

