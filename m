Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59314 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755864AbbGEMK2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 08:10:28 -0400
Message-ID: <55991EB2.20208@kernel.org>
Date: Sun, 05 Jul 2015 13:10:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org
CC: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Adriana Reus <adriana.reus@intel.com>
Subject: Re: [PATCH v3 7/8] iio: accel: kxcjk-1013: use available_scan_masks
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com> <1435916017-12859-8-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1435916017-12859-8-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/15 10:33, Irina Tirdea wrote:
> From: Adriana Reus <adriana.reus@intel.com>
> 
> Use available_scan_masks to allow the iio core to select
> the data to send to userspace depending on which axes are
> enabled, instead of doing this in the driver's interrupt
> handler.
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/accel/kxcjk-1013.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 51da369..4960397 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -115,6 +115,7 @@ enum kxcjk1013_axis {
>  	AXIS_X,
>  	AXIS_Y,
>  	AXIS_Z,
> +	AXIS_MAX,
>  };
>  
>  enum kxcjk1013_mode {
> @@ -947,6 +948,8 @@ static const struct iio_info kxcjk1013_info = {
>  	.driver_module		= THIS_MODULE,
>  };
>  
> +static const unsigned long kxcjk1013_scan_masks[] = {0x7, 0};
> +
>  static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -956,8 +959,7 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
>  
>  	mutex_lock(&data->mutex);
>  
> -	for_each_set_bit(bit, indio_dev->active_scan_mask,
> -			 indio_dev->masklength) {
> +	for (bit = 0; bit < AXIS_MAX; bit++) {
>  		ret = kxcjk1013_get_acc_reg(data, bit);
>  		if (ret < 0) {
>  			mutex_unlock(&data->mutex);
> @@ -1224,6 +1226,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->channels = kxcjk1013_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(kxcjk1013_channels);
> +	indio_dev->available_scan_masks = kxcjk1013_scan_masks;
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &kxcjk1013_info;
> 

