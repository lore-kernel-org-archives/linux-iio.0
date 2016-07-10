Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38876 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757136AbcGJNbo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 09:31:44 -0400
Subject: Re: [PATCH 2/4] iio: light: vcnl4000: Use BIT() macro
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1467714201-11429-1-git-send-email-pmeerw@pmeerw.net>
 <1467714201-11429-3-git-send-email-pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <30145dd6-b0f1-bd44-6969-740af643b230@kernel.org>
Date: Sun, 10 Jul 2016 14:31:42 +0100
MIME-Version: 1.0
In-Reply-To: <1467714201-11429-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/07/16 11:23, Peter Meerwald-Stadler wrote:
> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Applied.  

J
> ---
>  drivers/iio/light/vcnl4000.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 071ff97..7f247ed 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -41,10 +41,10 @@
>  #define VCNL4000_PS_MOD_ADJ	0x8a /* Proximity modulator timing adjustment */
>  
>  /* Bit masks for COMMAND register */
> -#define VCNL4000_AL_RDY		0x40 /* ALS data ready? */
> -#define VCNL4000_PS_RDY		0x20 /* proximity data ready? */
> -#define VCNL4000_AL_OD		0x10 /* start on-demand ALS measurement */
> -#define VCNL4000_PS_OD		0x08 /* start on-demand proximity measurement */
> +#define VCNL4000_AL_RDY		BIT(6) /* ALS data ready? */
> +#define VCNL4000_PS_RDY		BIT(5) /* proximity data ready? */
> +#define VCNL4000_AL_OD		BIT(4) /* start on-demand ALS measurement */
> +#define VCNL4000_PS_OD		BIT(3) /* start on-demand proximity measurement */
>  
>  struct vcnl4000_data {
>  	struct i2c_client *client;
> 

