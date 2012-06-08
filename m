Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4FD1A89C.3050607@analog.com>
Date: Fri, 8 Jun 2012 09:24:12 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: Re: [patch 2/2 -next] iio: frequency: adf4350: fix an initialization
References: <20120608065537.GD26673@elgon.mountain>
In-Reply-To: <20120608065537.GD26673@elgon.mountain>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/08/2012 08:55 AM, Dan Carpenter wrote:
> Sparse complains about this:
> drivers/iio/frequency/adf4350.c:58:29: warning: Initializer entry defined twice
> drivers/iio/frequency/adf4350.c:59:10:   also defined here
>
> It looks like '|' was intended here instead of ','.
>
> Signed-off-by: Dan Carpenter<dan.carpenter@oracle.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
> Guess work on my part.
>
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 4729bba..59fbb3ae 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -54,7 +54,7 @@ struct adf4350_state {
>   static struct adf4350_platform_data default_pdata = {
>   	.clkin = 122880000,
>   	.channel_spacing = 10000,
> -	.r2_user_settings = ADF4350_REG2_PD_POLARITY_POS,
> +	.r2_user_settings = ADF4350_REG2_PD_POLARITY_POS |
>   			    ADF4350_REG2_CHARGE_PUMP_CURR_uA(2500),
>   	.r3_user_settings = ADF4350_REG3_12BIT_CLKDIV_MODE(0),
>   	.r4_user_settings = ADF4350_REG4_OUTPUT_PWR(3) |
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
