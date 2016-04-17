Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52661 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbcDQJbe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 05:31:34 -0400
Subject: Re: [PATCH] iio: frequency: ad9523: use unsigned int rather then bare
 unsigned
To: Slawomir Stepien <sst@poczta.fm>, lars@metafoo.de,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net
References: <20160414154024.GA16253@x220.localdomain>
Cc: linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <571357F4.8060401@kernel.org>
Date: Sun, 17 Apr 2016 10:31:32 +0100
MIME-Version: 1.0
In-Reply-To: <20160414154024.GA16253@x220.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/16 16:40, Slawomir Stepien wrote:
> This fix checkpatch warnings:
> 
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/frequency/ad9523.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index 44a30f2..99eba52 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -284,7 +284,7 @@ struct ad9523_state {
>  	} data[2] ____cacheline_aligned;
>  };
>  
> -static int ad9523_read(struct iio_dev *indio_dev, unsigned addr)
> +static int ad9523_read(struct iio_dev *indio_dev, unsigned int addr)
>  {
>  	struct ad9523_state *st = iio_priv(indio_dev);
>  	int ret;
> @@ -318,7 +318,8 @@ static int ad9523_read(struct iio_dev *indio_dev, unsigned addr)
>  	return ret;
>  };
>  
> -static int ad9523_write(struct iio_dev *indio_dev, unsigned addr, unsigned val)
> +static int ad9523_write(struct iio_dev *indio_dev,
> +		unsigned int addr, unsigned int val)
>  {
>  	struct ad9523_state *st = iio_priv(indio_dev);
>  	int ret;
> @@ -351,11 +352,11 @@ static int ad9523_io_update(struct iio_dev *indio_dev)
>  }
>  
>  static int ad9523_vco_out_map(struct iio_dev *indio_dev,
> -			      unsigned ch, unsigned out)
> +			      unsigned int ch, unsigned int out)
>  {
>  	struct ad9523_state *st = iio_priv(indio_dev);
>  	int ret;
> -	unsigned mask;
> +	unsigned int mask;
>  
>  	switch (ch) {
>  	case 0 ... 3:
> @@ -405,7 +406,7 @@ static int ad9523_vco_out_map(struct iio_dev *indio_dev,
>  }
>  
>  static int ad9523_set_clock_provider(struct iio_dev *indio_dev,
> -			      unsigned ch, unsigned long freq)
> +			      unsigned int ch, unsigned long freq)
>  {
>  	struct ad9523_state *st = iio_priv(indio_dev);
>  	long tmp1, tmp2;
> @@ -619,7 +620,7 @@ static int ad9523_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad9523_state *st = iio_priv(indio_dev);
> -	unsigned code;
> +	unsigned int code;
>  	int ret;
>  
>  	mutex_lock(&indio_dev->mlock);
> @@ -655,7 +656,7 @@ static int ad9523_write_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct ad9523_state *st = iio_priv(indio_dev);
> -	unsigned reg;
> +	unsigned int reg;
>  	int ret, tmp, code;
>  
>  	mutex_lock(&indio_dev->mlock);
> @@ -709,8 +710,8 @@ out:
>  }
>  
>  static int ad9523_reg_access(struct iio_dev *indio_dev,
> -			      unsigned reg, unsigned writeval,
> -			      unsigned *readval)
> +			      unsigned int reg, unsigned int writeval,
> +			      unsigned int *readval)
>  {
>  	int ret;
>  
> 

