Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from [178.18.118.26] ([178.18.118.26]:60471 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751350Ab2DRIqA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 04:46:00 -0400
Message-ID: <4F8E7F3E.5080406@kernel.org>
Date: Wed, 18 Apr 2012 09:45:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Belisko <marek.belisko@open-nandra.com>
CC: linux-iio@vger.kernel.org
Subject: Re: adding hmc5883 driver
References: <CAAfyv35jTq6eSM4gEarUiZQRQy0pOBKev-LzohvQe40k2TuXMQ@mail.gmail.com>
In-Reply-To: <CAAfyv35jTq6eSM4gEarUiZQRQy0pOBKev-LzohvQe40k2TuXMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/17/2012 9:51 PM, Marek Belisko wrote:
> Hi,
>
> I'm owner gta04 board which have hmc5883 compass.
> I'm currently using hmc5843 iio staging driver with some hacks
> (difference is only
> for range and rate values) which is working fine. I would like ask for
> opinion how to properly
> add new device.
>
> IMO options are:
> 1. add hmc5883 to DEVICE_TABLE with some flags and then use proper values for
> one or another device (possibly rename driver to hmc58x3)
Don't rename the driver.  Convention is the driver is named after the 
first device it supports.
Nothing stops it supporting lots more.  See the adc/max1363 for a big 
example.
Wild card naming goes horribly wrong from time to time as marketting 
departments like
to name their products in illogical ways.

Otherwise, this is probably the best option given they sound pretty similar.
>
> 2. separate common functions from existing driver and use custom setup
> for hmc5843
> and hmc5883.
One driver sounds more sensible in this case.
>
> Is there another way which I overlooked?
>
> Thanks,
>
> marek
>

