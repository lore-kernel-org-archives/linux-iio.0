Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45693 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189AbcAXQ6o (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2016 11:58:44 -0500
Subject: Re: [PATCHv2 1/3] iio: dht11: Improve reliability - be more tolerant
 about missing start bits
To: Harald Geyer <harald@ccbib.org>, linux-iio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.org>
References: <1453047211-16661-1-git-send-email-harald@ccbib.org>
Cc: Richard Weinberger <richard@nod.at>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56A502C2.1000908@kernel.org>
Date: Sun, 24 Jan 2016 16:58:42 +0000
MIME-Version: 1.0
In-Reply-To: <1453047211-16661-1-git-send-email-harald@ccbib.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/16 16:13, Harald Geyer wrote:
> Instead of guessing where the data starts, we now just try to decode from
> every possible start position. This causes no additional overhead if we
> properly received the full preamble and only costs a few extra CPU cycles
> in the case where the preamble is corrupted. This is much more efficient
> than to return an error to userspace and start over again.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
As there are no signs of other testing going on and you have clearly
hammered this reasonably hard, I'm applying it now. It'll be in my
tree until next weekend at the earliest if anyone has anything to add.

Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> No changes since V1, but compile tested the entire series patch by patch
> additionally to test the whole series with DHT11 and DHT22 on an
> imx233-olinuxino board.
> 
>  drivers/iio/humidity/dht11.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index 1165b1c..1ca284a 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -161,7 +161,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  			int *val, int *val2, long m)
>  {
>  	struct dht11 *dht11 = iio_priv(iio_dev);
> -	int ret, timeres;
> +	int ret, timeres, offset;
>  
>  	mutex_lock(&dht11->lock);
>  	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_real_ns()) {
> @@ -208,11 +208,14 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  		if (ret < 0)
>  			goto err;
>  
> -		ret = dht11_decode(dht11,
> -				   dht11->num_edges == DHT11_EDGES_PER_READ ?
> -					DHT11_EDGES_PREAMBLE :
> -					DHT11_EDGES_PREAMBLE - 2,
> -				timeres);
> +		offset = DHT11_EDGES_PREAMBLE +
> +				dht11->num_edges - DHT11_EDGES_PER_READ;
> +		for (; offset >= 0; --offset) {
> +			ret = dht11_decode(dht11, offset, timeres);
> +			if (!ret)
> +				break;
> +		}
> +
>  		if (ret)
>  			goto err;
>  	}
> 

