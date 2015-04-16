Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38878 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444AbbDPI0U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 16 Apr 2015 04:26:20 -0400
Message-ID: <552F7295.7000602@intel.com>
Date: Thu, 16 Apr 2015 11:28:05 +0300
From: Daniel Baluta <daniel.baluta@intel.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
CC: jic23@kernel.org
Subject: Re: [PATCH] iio:tcs4531: Fix leftover TCS3472_ prefix in tsl4531
 driver
References: <1429130378-19941-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1429130378-19941-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 04/15/2015 11:39 PM, Peter Meerwald wrote:
> just cleanup, no functional change

Commit message tag should be now "iio: tsl4531: ". Other than that
it looks good to me.


>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>   drivers/iio/light/tsl4531.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
> index 0763b86..63c26e2 100644
> --- a/drivers/iio/light/tsl4531.c
> +++ b/drivers/iio/light/tsl4531.c
> @@ -24,12 +24,12 @@
>
>   #define TSL4531_DRV_NAME "tsl4531"
>
> -#define TCS3472_COMMAND BIT(7)
> +#define TSL4531_COMMAND BIT(7)
>
> -#define TSL4531_CONTROL (TCS3472_COMMAND | 0x00)
> -#define TSL4531_CONFIG (TCS3472_COMMAND | 0x01)
> -#define TSL4531_DATA (TCS3472_COMMAND | 0x04)
> -#define TSL4531_ID (TCS3472_COMMAND | 0x0a)
> +#define TSL4531_CONTROL (TSL4531_COMMAND | 0x00)
> +#define TSL4531_CONFIG (TSL4531_COMMAND | 0x01)
> +#define TSL4531_DATA (TSL4531_COMMAND | 0x04)
> +#define TSL4531_ID (TSL4531_COMMAND | 0x0a)
>
>   /* operating modes in control register */
>   #define TSL4531_MODE_POWERDOWN 0x00
>
