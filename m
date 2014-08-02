Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46449 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbaHBL56 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Aug 2014 07:57:58 -0400
Message-ID: <53DCD244.4070801@kernel.org>
Date: Sat, 02 Aug 2014 12:57:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Teodora Baluta <teodora.baluta@intel.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/5] staging: iio: ad5933: fix sparse warning cast to
 restricted __be16
References: <1406546313-23031-1-git-send-email-teodora.baluta@intel.com> <1406546313-23031-3-git-send-email-teodora.baluta@intel.com>
In-Reply-To: <1406546313-23031-3-git-send-email-teodora.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/07/14 12:18, Teodora Baluta wrote:
> Fix the following sparse endianness warnings:
> 
>   CHECK   drivers/staging/iio/impedance-analyzer/ad5933.c
> drivers/staging/iio/impedance-analyzer/ad5933.c:674:34: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:674:34: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:674:34: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:674:34: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:675:34: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:675:34: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:675:34: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:675:34: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:677:34: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:677:34: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:677:34: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:677:34: warning: cast to
> restricted __be16
> 
> Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
Again, I'd prefer the introduction of a specific be16 variable to
make it very clear what is going on rather that what we have
here which is papering over the warning.

J
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 2cef4b9..87ce844 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -647,7 +647,7 @@ static void ad5933_work(struct work_struct *work)
>  	struct ad5933_state *st = container_of(work,
>  		struct ad5933_state, work.work);
>  	struct iio_dev *indio_dev = i2c_get_clientdata(st->client);
> -	signed short buf[2];
> +	u16 buf[2];
>  	unsigned char status;
>  
>  	mutex_lock(&indio_dev->mlock);
> @@ -671,10 +671,10 @@ static void ad5933_work(struct work_struct *work)
>  				scan_count * 2, (u8 *)buf);
>  
>  		if (scan_count == 2) {
> -			buf[0] = be16_to_cpu(buf[0]);
> -			buf[1] = be16_to_cpu(buf[1]);
> +			be16_to_cpus(&buf[0]);
> +			be16_to_cpus(&buf[1]);
>  		} else {
> -			buf[0] = be16_to_cpu(buf[0]);
> +			be16_to_cpus(&buf[0]);
>  		}
>  		iio_push_to_buffers(indio_dev, buf);
>  	} else {
> 
