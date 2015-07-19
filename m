Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47217 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbGSNEt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 09:04:49 -0400
Message-ID: <55ABA06F.1040008@kernel.org>
Date: Sun, 19 Jul 2015 14:04:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Harald Geyer <harald@ccbib.org>
CC: linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Jonathan Bell <jonathan@raspberrypi.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCHv3 1/4] iio: dht11: whitespace changes to make checkpatch.pl
 --strict happy
References: <55991FEA.50703@kernel.org> <1436276371-7480-1-git-send-email-harald@ccbib.org>
In-Reply-To: <1436276371-7480-1-git-send-email-harald@ccbib.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/15 14:39, Harald Geyer wrote:
> * add spaces around binary operators in cases where it reduces readability
> * align multiline statements around opening parenthesis
> 
> Reported-by: Hartmut Knaack <knaack.h@gmx.de>
> 	in Message-ID: <55919E72.3010807@gmx.de>
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/humidity/dht11.c |   25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index 7d79a1a..343d26a 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -46,7 +46,8 @@
>   * Note that when reading the sensor actually 84 edges are detected, but
>   * since the last edge is not significant, we only store 83:
>   */
> -#define DHT11_EDGES_PER_READ (2*DHT11_BITS_PER_READ + DHT11_EDGES_PREAMBLE + 1)
> +#define DHT11_EDGES_PER_READ (2 * DHT11_BITS_PER_READ + \
> +			      DHT11_EDGES_PREAMBLE + 1)
>  
>  /* Data transmission timing (nano seconds) */
>  #define DHT11_START_TRANSMISSION	18  /* ms */
> @@ -95,24 +96,24 @@ static int dht11_decode(struct dht11 *dht11, int offset)
>  
>  	/* Calculate timestamp resolution */
>  	for (i = 1; i < dht11->num_edges; ++i) {
> -		t = dht11->edges[i].ts - dht11->edges[i-1].ts;
> +		t = dht11->edges[i].ts - dht11->edges[i - 1].ts;
>  		if (t > 0 && t < timeres)
>  			timeres = t;
>  	}
> -	if (2*timeres > DHT11_DATA_BIT_HIGH) {
> +	if (2 * timeres > DHT11_DATA_BIT_HIGH) {
>  		pr_err("dht11: timeresolution %d too bad for decoding\n",
> -			timeres);
> +		       timeres);
>  		return -EIO;
>  	}
>  	threshold = DHT11_DATA_BIT_HIGH / timeres;
> -	if (DHT11_DATA_BIT_LOW/timeres + 1 >= threshold)
> +	if (DHT11_DATA_BIT_LOW / timeres + 1 >= threshold)
>  		pr_err("dht11: WARNING: decoding ambiguous\n");
>  
>  	/* scale down with timeres and check validity */
>  	for (i = 0; i < DHT11_BITS_PER_READ; ++i) {
> -		t = dht11->edges[offset + 2*i + 2].ts -
> -			dht11->edges[offset + 2*i + 1].ts;
> -		if (!dht11->edges[offset + 2*i + 1].value)
> +		t = dht11->edges[offset + 2 * i + 2].ts -
> +			dht11->edges[offset + 2 * i + 1].ts;
> +		if (!dht11->edges[offset + 2 * i + 1].value)
>  			return -EIO;  /* lost synchronisation */
>  		timing[i] = t / timeres;
>  	}
> @@ -166,7 +167,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
>  }
>  
>  static int dht11_read_raw(struct iio_dev *iio_dev,
> -			const struct iio_chan_spec *chan,
> +			  const struct iio_chan_spec *chan,
>  			int *val, int *val2, long m)
>  {
>  	struct dht11 *dht11 = iio_priv(iio_dev);
> @@ -192,13 +193,13 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  			goto err;
>  
>  		ret = wait_for_completion_killable_timeout(&dht11->completion,
> -								 HZ);
> +							   HZ);
>  
>  		free_irq(dht11->irq, iio_dev);
>  
>  		if (ret == 0 && dht11->num_edges < DHT11_EDGES_PER_READ - 1) {
>  			dev_err(&iio_dev->dev,
> -					"Only %d signal edges detected\n",
> +				"Only %d signal edges detected\n",
>  					dht11->num_edges);
>  			ret = -ETIMEDOUT;
>  		}
> @@ -206,7 +207,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  			goto err;
>  
>  		ret = dht11_decode(dht11,
> -				dht11->num_edges == DHT11_EDGES_PER_READ ?
> +				   dht11->num_edges == DHT11_EDGES_PER_READ ?
>  					DHT11_EDGES_PREAMBLE :
>  					DHT11_EDGES_PREAMBLE - 2);
>  		if (ret)
> 

