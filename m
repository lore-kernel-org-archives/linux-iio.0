Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4FD1A891.3090508@analog.com>
Date: Fri, 8 Jun 2012 09:24:01 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: Re: [patch 1/2 -next] iio: frequency: adf4350: using an uninitialized
 variable
References: <20120608065432.GC26673@elgon.mountain>
In-Reply-To: <20120608065432.GC26673@elgon.mountain>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/08/2012 08:54 AM, Dan Carpenter wrote:
> GCC complains that we use an uninitialized variable if the user passes
> an invalid parameter to adf4350_read().  I decided that we should return
> -EINVAL instead in that case.
>
> However, when I looked up at adf4350_write() it returned -ENODEV for
> that condition.  In the end, I decided the -EINVAL was the right thing
> and I change adf4350_write() to match.
Agreed.
>
> Signed-off-by: Dan Carpenter<dan.carpenter@oracle.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index fd4c850..4729bba 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -272,7 +272,7 @@ static ssize_t adf4350_write(struct iio_dev *indio_dev,
>   		adf4350_sync_config(st);
>   		break;
>   	default:
> -		ret = -ENODEV;
> +		ret = -EINVAL;
>   	}
>   	mutex_unlock(&indio_dev->mlock);
>
> @@ -310,6 +310,8 @@ static ssize_t adf4350_read(struct iio_dev *indio_dev,
>   	case ADF4350_PWRDOWN:
>   		val = !!(st->regs[ADF4350_REG2]&  ADF4350_REG2_POWER_DOWN_EN);
>   		break;
> +	default:
> +		ret = -EINVAL;
>   	}
>   	mutex_unlock(&indio_dev->mlock);
>
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
