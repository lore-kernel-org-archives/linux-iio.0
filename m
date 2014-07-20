Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:41799 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbaGTQgq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Jul 2014 12:36:46 -0400
Message-ID: <53CBF0AA.2090003@kernel.org>
Date: Sun, 20 Jul 2014 17:39:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
CC: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH 01/13] iio:bma180: Fix scale factors to report correct
 acceleration units
References: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net> <1405535576-26482-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405535576-26482-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/07/14 19:32, Peter Meerwald wrote:
> The userspace interface for acceleration sensors is documented as using
> m/s^2 units [Documentation/ABI/testing/sysfs-bus-iio]
>
> The fullscale raw values for the BMA80 corresponds to -/+ 1, 1.5, 2, etc G
> depending on the selected mode.
>
> The scale table was converting to G rather than m/s^2.
> Change the scaling table to match the documented interface.
>
> See commit 71702e6e, iio: mma8452: Use correct acceleration units,
> for a related fix.
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

> ---
>   drivers/iio/accel/bma180.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index a7e68c8..28388bb 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -68,13 +68,13 @@
>   /* Defaults values */
>   #define BMA180_DEF_PMODE	0
>   #define BMA180_DEF_BW		20
> -#define BMA180_DEF_SCALE	250
> +#define BMA180_DEF_SCALE	2452
>
>   /* Available values for sysfs */
>   #define BMA180_FLP_FREQ_AVAILABLE \
>   	"10 20 40 75 150 300"
>   #define BMA180_SCALE_AVAILABLE \
> -	"0.000130 0.000190 0.000250 0.000380 0.000500 0.000990 0.001980"
> +	"0.001275 0.001863 0.002452 0.003727 0.004903 0.009709 0.019417"
>
>   struct bma180_data {
>   	struct i2c_client *client;
> @@ -94,7 +94,7 @@ enum bma180_axis {
>   };
>
>   static int bw_table[] = { 10, 20, 40, 75, 150, 300 }; /* Hz */
> -static int scale_table[] = { 130, 190, 250, 380, 500, 990, 1980 };
> +static int scale_table[] = { 1275, 1863, 2452, 3727, 4903, 9709, 19417 };
>
>   static int bma180_get_acc_reg(struct bma180_data *data, enum bma180_axis axis)
>   {
>

