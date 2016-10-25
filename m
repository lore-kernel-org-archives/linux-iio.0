Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41894 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965105AbcJYQ1K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 12:27:10 -0400
Subject: Re: [PATCH] staging: iio: cdc/ad7746: fix missing return value
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20161025155646.64112-1-arnd@arndb.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b19d0f7a-03c4-c4e6-dd8c-188012402530@kernel.org>
Date: Tue, 25 Oct 2016 17:27:07 +0100
MIME-Version: 1.0
In-Reply-To: <20161025155646.64112-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/10/16 16:56, Arnd Bergmann wrote:
> As found by "gcc -Wmaybe-uninitialized", the latest change to the
> driver lacked an initalization for the return code in one of the
> added cases:
> 
> drivers/staging/iio/cdc/ad7746.c: In function ‘ad7746_read_raw’:
> drivers/staging/iio/cdc/ad7746.c:655:2: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This sets it to IIO_VAL_INT, which I think is what we want here.
> 
> Fixes: 2296c0623eb7 ("staging: iio: cdc: ad7746: implement IIO_CHAN_INFO_SAMP_FREQ")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Gah, not a good bit of reviewing from me. Should have caught that one.  Thanks Arnd.

Applied to the togreg branch of iio.git - initially pushed out as testing for the
autobuilders to play with it.  Will probably be a little while before I send
another pull to Greg (most likely the weekend)

Thanks again,

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7746.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index f41251ceeacd..a5828f9aa437 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -642,6 +642,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		case IIO_VOLTAGE:
>  			*val = ad7746_vt_filter_rate_table[
>  					(chip->config >> 6) & 0x3][0];
> +			ret = IIO_VAL_INT;
>  			break;
>  		default:
>  			ret = -EINVAL;
> 

