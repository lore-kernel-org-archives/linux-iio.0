Return-Path: <SRS0=DFrw=XZ=pmeerw.net=pmeerw@kernel.org>
Date: Sat, 10 Dec 2016 08:04:43 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
cc: linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org,
    jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH v8 3/3] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <b985dc64-fa14-1930-e73d-1d197b29ba53@free-electrons.com>
Message-ID: <alpine.DEB.2.02.1612100801450.30369@pmeerw.net>
References: <20161209102236.17655-1-quentin.schulz@free-electrons.com> <20161209102236.17655-4-quentin.schulz@free-electrons.com> <alpine.DEB.2.02.1612091657540.16360@pmeerw.net> <b985dc64-fa14-1930-e73d-1d197b29ba53@free-electrons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> [...]
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		if (chan->type == IIO_VOLTAGE) {
> >> +			/* 3000mV / 4096 * raw */
> >> +			*val = 0;
> >> +			*val2 = 732421875;
> > 
> > this looks more like INT_PLUS_NANO, beyond range of micro?
> > 
> >> +			return IIO_VAL_INT_PLUS_MICRO;
> 
> No, this is rather a mistake.
> 
> The scale to convert to mV is 0.732421875 (3000mV / 4096). The scale to

correct

> convert to uV is thus 732.421875.

yes, but we want millivolt in IIO (ABI/testing/see sysfs-bus-iio)

I think you should change _PLUS_MICRO to _PLUS_NANO

> The above code better is:
> 
> *val = 732;
> *val2 = 421875;
> return IIO_VAL_INT_PLUS_MICRO;

regards, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
