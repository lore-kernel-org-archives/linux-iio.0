Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47968 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdDBKby (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 06:31:54 -0400
Subject: Re: [PATCH] staging:iio:accel:adis16029 fixed checkpatch issue - drop
 braces around single if statement
To: Andrea della Porta <sfaragnaus@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20170329083624.GA3281@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <66958d0b-58ef-98fc-c8f2-e4b1cfd81c41@kernel.org>
Date: Sun, 2 Apr 2017 11:31:51 +0100
MIME-Version: 1.0
In-Reply-To: <20170329083624.GA3281@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

See patch title. Check the part number...

On 29/03/17 09:36, Andrea della Porta wrote:
> Fixed the followinf checkpatch warning:
> WARNING: braces {} are not necessary for single statement blocks
> #258: FILE: drivers/staging/iio/accel/adis16209.c:258:
> +		if (ret) {
> +			return ret;
> +		}
> 
> Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
Was fixed about a week ago by Mark Stenglein.

Patch has made it through the IIO tree to staging yet though.
Should be heading that way this afternoon (depending on how
long Greg's backlog of emails still is ;)

Jonathan
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

