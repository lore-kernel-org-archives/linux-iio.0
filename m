Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50298 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932727AbdC2VSW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 17:18:22 -0400
Subject: Re: [PATCH] coding style issue resolved
To: Andrea della Porta <sfaragnaus@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20170328120148.GA2332@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <00ec16cf-d667-0152-0454-0bf57c5ab837@kernel.org>
Date: Wed, 29 Mar 2017 22:18:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170328120148.GA2332@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/17 13:01, Andrea della Porta wrote:
> Coding style issue resolved.
> 
> Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
Please include the driver name in the title. Subsystem also good.
staging:iio:accel:adis16029 drop braces around single element if block

or something along those lines would be good.
> ---
>  drivers/staging/iio/accel/adis16209.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 52fa2e0..159a687 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -255,9 +255,9 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  		}
>  		addr = adis16209_addresses[chan->scan_index][0];
>  		ret = adis_read_reg_16(st, addr, &val16);
> -		if (ret) {
> +		if (ret)
>  			return ret;
> -		}
> +
>  		val16 &= (1 << bits) - 1;
>  		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>  		*val = val16;
> 

