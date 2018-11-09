Return-Path: <SRS0=VjvJ=NU=poczta.fm=sst@kernel.org>
Date: Fri, 9 Nov 2018 17:59:04 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Himanshu Jha <himanshujha199640@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v5 1/1] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181109165904.GB25135@x220.localdomain>
References: <20181104104900.13997-1-sst@poczta.fm>
 <20181104145456.GA13773@himanshu-Vostro-3559>
 <20181104163347.2e953bad@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181104163347.2e953bad@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On lis 04, 2018 16:33, Jonathan Cameron wrote:
> The odd bit here is that I'm not entirely sure what 'power up' action
> this power down is undoing, so not sure where exactly it should be.
> 
> It may just be a catch all for the device being left powered up after
> a read sometime earlier.  If that's the case I would suggest a comment
> making that clear and do it only just before the devm_iio_device_register
> (as we don't power up anywhere in probe that I can see and this is the
> point at which a power up 'might' occur as the interfaces are exposed.

Inside the ad7280_chain_setup(), the first write to the device(s) is with
AD7280A_CTRL_LB_SWRST bit. The next write is de-asserting this bit. Based on
datasheet, such two writes will reset the upper part of the control register to
its default state, that means, the device will left the software power down
state.

So inside ad7280_chain_setup() we have the power up you are talking about.
That is why I think that action that will put the device into software power
down should be after spi_setup(), but before ad7280_chain_setup() - and this is
the current form (of course I will use the ...or_reset() variant as Jha pointed
out in next patch's version).

What do you think?

-- 
Slawomir Stepien
