Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbeKEBtZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Nov 2018 20:49:25 -0500
Date: Sun, 4 Nov 2018 16:33:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Slawomir Stepien <sst@poczta.fm>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v5 1/1] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181104163347.2e953bad@archlinux>
In-Reply-To: <20181104145456.GA13773@himanshu-Vostro-3559>
References: <20181104104900.13997-1-sst@poczta.fm>
        <20181104145456.GA13773@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 4 Nov 2018 20:24:56 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Sun, Nov 04, 2018 at 11:49:00AM +0100, Slawomir Stepien wrote:
> > devm_* APIs are device managed and make code simpler.
> > 
> > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> > ---  
> 
> []
> 
> > Since v4:
> > * on devm_add_action fail, call the action on error handling  
> 
> For such a use case, `devm_add_action_or_reset()` seems like a better
> candidate.
Cool.  Somehow I'd missed the existence of that.  Always thought
such a function would be handy but never actually checked if there
was one ;)  

Doh and thanks for the pointer.  Easy task for anyone who wants it
is to see where else this is directly applicable in IIO drivers.

The odd bit here is that I'm not entirely sure what 'power up' action
this power down is undoing, so not sure where exactly it should be.

It may just be a catch all for the device being left powered up after
a read sometime earlier.  If that's the case I would suggest a comment
making that clear and do it only just before the devm_iio_device_register
(as we don't power up anywhere in probe that I can see and this is the
point at which a power up 'might' occur as the interfaces are exposed.

Jonathan

Jonathan

> 
> > +	ret = devm_add_action(&spi->dev, ad7280_sw_power_down, st);
> > +	if (ret) {
> > +		ad7280_sw_power_down(st);
> > +		return ret;
> > +	}  
> 
> Also, you can suppress the `1/1` in sunject [PATCH v5 1/1] by passing
> `-N` flag to `git format-patch`.
> 
> 
