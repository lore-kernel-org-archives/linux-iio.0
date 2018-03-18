Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbeCRIes (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Mar 2018 04:34:48 -0400
Date: Sun, 18 Mar 2018 08:34:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        daniel.baluta@gmail.com, 21cnbao@gmail.com
Subject: Re: [PATCH v2 7/9] Staging: iio: accel: adis16201: Prefer reverse
 christmas tree ordering
Message-ID: <20180318083442.15544cc9@archlinux>
In-Reply-To: <1521230786-18155-8-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
        <1521230786-18155-8-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Mar 2018 01:36:24 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Prefer reverse christmas tree ordering of declarations to improve
> readability.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
As ever, this sort of change is only worth doing if you are working on the
relevant code anyway.  You are, so good to tidy up! (I put that here to
avoid getting lots of people feeling they 'have' to make this sort of
change).

Applied

Thanks,

Jonathan
> ---
> v2:
>    -no change in this patch.
> 
>  drivers/staging/iio/accel/adis16201.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 298bf90..00e944e 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -259,9 +259,9 @@ static const struct adis_data adis16201_data = {
>  
>  static int adis16201_probe(struct spi_device *spi)
>  {
> -	int ret;
> -	struct adis *st;
>  	struct iio_dev *indio_dev;
> +	struct adis *st;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)

