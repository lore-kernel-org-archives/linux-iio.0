Return-Path: <amsfield22@gmail.com>
Date: Fri, 2 Sep 2016 11:01:11 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Pavel Andrianov <andrianov@ispras.ru>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vaishali Thakkar <vaishali.thakkar@oracle.com>,
	ldv-project@linuxtesting.org
Subject: Re: A potential race in drivers/iio/adc/vf610_adc.ko
Message-ID: <20160902180110.GA12748@d830.WORKGROUP>
References: <8ad6537e-718a-4c5d-4f51-958e585b3727@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8ad6537e-718a-4c5d-4f51-958e585b3727@ispras.ru>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Sep 02, 2016 at 11:05:09AM +0300, Pavel Andrianov wrote:
> 
> Hi!
> 
> There is a potential race in drivers/iio/adc/vf610_adc.ko.
> Handlers vf610_set_conversion_mode and vf610_write_raw are called via
> device_attibute interface, but they are related to different attributes, so
> may be executed in parallel. vf610_set_conversion_mode acquires the mutex
> indio_dev->mlock, and vf610_write_raw does not. Thus updating the structure
> 'info' may be performed simultaneously.
> 
> Should vf610_write_raw also acquire the same mutex indio_dev->mlock?
> 
Hi Pavel,
I'm not familiar with the conversion_mode interface, so I'll leave your
specific question for someone with that knowledge.

Just wanted to point out that if you're going to update the locking
in the driver, there are 2 things to consider:
1) Use iio_device_claim_direct_mode() helper functions instead of
checking iio_buffer_enabled and grabbing mlock.
2) Any other uses of indio_dev->mlock are best moved to a private data
lock.  We want to return that mlock to an INTERNAL (core) use only.

alisons





> -- 
> Pavel Andrianov
> Linux Verification Center, ISPRAS
> web: http://linuxtesting.org
> e-mail: andrianov@ispras.ru
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
