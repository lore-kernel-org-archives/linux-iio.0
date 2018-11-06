Return-Path: <SRS0=1eYy=NR=poczta.fm=sst@kernel.org>
Date: Tue, 6 Nov 2018 19:50:03 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v5 1/1] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181106185003.GB1600@x220.localdomain>
References: <20181104104900.13997-1-sst@poczta.fm>
 <20181104145456.GA13773@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181104145456.GA13773@himanshu-Vostro-3559>
List-ID: <linux-iio@vger.kernel.org>

On lis 04, 2018 20:24, Himanshu Jha wrote:
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

Thank you for that.

> > +	ret = devm_add_action(&spi->dev, ad7280_sw_power_down, st);
> > +	if (ret) {
> > +		ad7280_sw_power_down(st);
> > +		return ret;
> > +	}
> 
> Also, you can suppress the `1/1` in sunject [PATCH v5 1/1] by passing
> `-N` flag to `git format-patch`.

I haven't even notice that 1/1. I will use -N when sending only one patch.
Thanks!

-- 
Slawomir Stepien
