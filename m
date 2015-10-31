Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38447 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbbJaKGN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2015 06:06:13 -0400
Subject: Re: [PATCH v3 2/3] iio: light: lm3533-als: Print error message on
 invalid resistance
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Johan Hovold <jhovold@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1446249040-16552-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1446249040-16552-2-git-send-email-bjorn.andersson@sonymobile.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56349293.7030107@kernel.org>
Date: Sat, 31 Oct 2015 10:06:11 +0000
MIME-Version: 1.0
In-Reply-To: <1446249040-16552-2-git-send-email-bjorn.andersson@sonymobile.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/10/15 23:50, Bjorn Andersson wrote:
> Print an error message to indicate that invalid configuration data was
> provided in the platform_data, rather than just aborting initialization.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Seems sensible to me.

Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> 
> This patch can be picked independently of the other 2, but included in the
> series for "completeness".
> 
> No changes since v1 in this patch.
> 
>  drivers/iio/light/lm3533-als.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index 076bc46fad03..e56937c40a18 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -743,8 +743,10 @@ static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
>  {
>  	int ret;
>  
> -	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX)
> +	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
> +		dev_err(&als->pdev->dev, "invalid resistor value\n");
>  		return -EINVAL;
> +	};
>  
>  	ret = lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR_SELECT, val);
>  	if (ret) {
> 

