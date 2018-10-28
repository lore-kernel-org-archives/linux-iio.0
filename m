Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeJ2Dnk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 23:43:40 -0400
Date: Sun, 28 Oct 2018 18:58:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Renato Lui Geh <renatogeh@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        alexandru.Ardelean@analog.com, stefan.popa@analog.com,
        giuliano.belinassi@usp.br, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: update voltage on read
Message-ID: <20181028185803.6dc8bb57@archlinux>
In-Reply-To: <20181028165231.2det3cq3u7r6qoxj@renatolg>
References: <cover.1540506298.git.renatogeh@gmail.com>
        <1f7b2c6ee0e18b1c43a8b27f482b08313c52d4e9.1540506298.git.renatogeh@gmail.com>
        <20181028155611.67abeafb@archlinux>
        <20181028165231.2det3cq3u7r6qoxj@renatolg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 28 Oct 2018 13:52:32 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> Hi Jonathan,
> 
> Thank you for the review.
> 
> >> +		voltage_uv = regulator_get_voltage(st->reg);
> >> +		if (voltage_uv)
> >> +			st->int_vref_mv = voltage_uv/1000;
> >>  		*val = st->int_vref_mv * st->gain;  
> >Is there actually a reason (now) to have the stashed value
> >of int_vref_mv in the state structure?  
> 
> From probe:
> 
> if (voltage_uv)
> 	st->int_vref_mv = voltage_uv / 1000;
> else
> 	dev_warn(&spi->dev, "Reference voltage unspecified\n");
> 
> So the idea was to, when voltage_uv = 0, return the previous voltage.
> Should I instead handle this as an error the same way as in probe?
> 
I would return it as an error.  I can't really see how we would get
this to occur if the bindings are all correct and appropriate driver
support is there for the regulator to actually let us use it.

If we wanted to handle the case of no regulator having been provided
cleanly then we should it using an optional regulator get, and
not provide the scale attribute at all if we can't know what it will
read.  This is a weird enough corner case though that I just wouldn't 
bother handling it as anything other than an error.

> Thanks,
> Renato
Thanks,

Jonathan
