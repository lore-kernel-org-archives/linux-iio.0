Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48202 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbaHBQfy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Aug 2014 12:35:54 -0400
Message-ID: <53DD1368.8080008@kernel.org>
Date: Sat, 02 Aug 2014 17:35:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Teodora Baluta <teodora.baluta@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/5] staging: iio: isl29018: fix sparse warning regarding
 incorrect type (different signedness)
References: <1406546313-23031-1-git-send-email-teodora.baluta@intel.com> <1406546313-23031-5-git-send-email-teodora.baluta@intel.com>
In-Reply-To: <1406546313-23031-5-git-send-email-teodora.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/07/14 12:18, Teodora Baluta wrote:
> Fix the following sparse warning:
> 
> drivers/staging/iio/light/isl29018.c:508:50: warning: incorrect type in
> argument 3 (different signedness)
> drivers/staging/iio/light/isl29018.c:508:50:    expected unsigned int
> *conf_adc_bit
> drivers/staging/iio/light/isl29018.c:508:50:    got int *<noident>
> 
> Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
Applied to the togreg branch of iio.git initially pushed out as testing
for the autobuilders to play.

J
> ---
>  drivers/staging/iio/light/isl29018.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 3660a43..86cc8f9 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -454,7 +454,7 @@ static const struct attribute_group isl29108_group = {
>  static int isl29018_chip_init(struct isl29018_chip *chip)
>  {
>  	int status;
> -	int new_adc_bit;
> +	unsigned int new_adc_bit;
>  	unsigned int new_range;
>  
>  	/* Code added per Intersil Application Note 1534:
> 
