Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58721 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbbCGTTY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2015 14:19:24 -0500
Message-ID: <54FB4F3B.7000107@kernel.org>
Date: Sat, 07 Mar 2015 19:19:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Masanari Iida <standby24x7@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:adc: Fix typo in MODULE_DESCRIPTION in ad7793.c
References: <1425440673-12400-1-git-send-email-standby24x7@gmail.com>
In-Reply-To: <1425440673-12400-1-git-send-email-standby24x7@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/03/15 03:44, Masanari Iida wrote:
> This patch fix spelling typo in MODULE_DESCRIPTION
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Applied to the togreg branch of iio.git  Thanks.
Jonathan
> ---
>  drivers/iio/adc/ad7793.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 4dddeab..b84922a 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -861,5 +861,5 @@ static struct spi_driver ad7793_driver = {
>  module_spi_driver(ad7793_driver);
>  
>  MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> -MODULE_DESCRIPTION("Analog Devices AD7793 and simialr ADCs");
> +MODULE_DESCRIPTION("Analog Devices AD7793 and similar ADCs");
>  MODULE_LICENSE("GPL v2");
> 

