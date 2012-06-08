Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4FD1A873.4070406@analog.com>
Date: Fri, 8 Jun 2012 09:23:31 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: Re: [patch -next] iio: frequency: ad9523: unlock on error in ad9523_reg_access()
References: <20120608065403.GB26673@elgon.mountain>
In-Reply-To: <20120608065403.GB26673@elgon.mountain>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/08/2012 08:54 AM, Dan Carpenter wrote:
> There was a return path which got missed accidentally.
>
> Signed-off-by: Dan Carpenter<dan.carpenter@oracle.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index 7272924..832e6ab 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -731,10 +731,12 @@ static int ad9523_reg_access(struct iio_dev *indio_dev,
>   	} else {
>   		ret = ad9523_read(indio_dev, reg | AD9523_R1B);
>   		if (ret<  0)
> -			return ret;
> +			goto out_unlock;
>   		*readval = ret;
>   		ret = 0;
>   	}
> +
> +out_unlock:
>   	mutex_unlock(&indio_dev->mlock);
>
>   	return ret;
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
