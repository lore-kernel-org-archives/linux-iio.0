Return-Path: <lars@metafoo.de>
Message-ID: <529498C7.80408@metafoo.de>
Date: Tue, 26 Nov 2013 13:49:11 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Fugang Duan <B38611@freescale.com>, jic23@kernel.org,
 shawn.guo@linaro.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc driver
References: <1385463394-11157-1-git-send-email-B38611@freescale.com> <1385463394-11157-3-git-send-email-B38611@freescale.com> <alpine.DEB.2.01.1311261302560.18875@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1311261302560.18875@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/26/2013 01:24 PM, Peter Meerwald wrote:
>> +static inline void vf610_adc_cfg_set(struct vf610_adc *info)
>> +{
> 
> why are some functions marked inline and others not?
> this function does not seem time critical

And the compiler knows much better which functions to (partially) inline and
which not, I think inline is mostly ignored by the compiler anyway, so yes,
it should be removed here.

>> +static int vf610_adc_reg_access(struct iio_dev *indio_dev,
>> +			unsigned reg, unsigned writeval,
>> +			unsigned *readval)
>> +{
>> +	struct vf610_adc *info = iio_priv(indio_dev);
>> +
>> +	if (readval == NULL)
>> +		return -EINVAL;
> 
> can this ever happen?
> 
> I'd rather check the value of reg

It is NULL when writing to a register.
