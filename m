Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42484 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbbDZSlK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 14:41:10 -0400
Message-ID: <553D3145.8080707@kernel.org>
Date: Sun, 26 Apr 2015 19:41:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 03/17] iio: accel: mma9551_core: prevent buffer overrun
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com> <1428939664-12503-4-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-4-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/15 16:40, Irina Tirdea wrote:
> The mma9551 functions that read/write word arrays from the
> device have a limit for the buffer size given by the device
> specifications.
> 
> Check that the requested buffer length is within required limits
> when transferring word arrays. This will prevent buffer overrun
> in the mma9551_read/write_*_words functions and also in the
> mma9551_transfer call when writing into the MBOX response/request
> structure.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Reported-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mma9551_core.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> index 7f55a6d..c6d5a3a 100644
> --- a/drivers/iio/accel/mma9551_core.c
> +++ b/drivers/iio/accel/mma9551_core.c
> @@ -389,7 +389,12 @@ int mma9551_read_config_words(struct i2c_client *client, u8 app_id,
>  {
>  	int ret, i;
>  	int len_words = len / sizeof(u16);
> -	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
> +	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS / 2];
> +
> +	if (len_words > ARRAY_SIZE(be_buf)) {
> +		dev_err(&client->dev, "Invalid buffer size %d\n", len);
> +		return -EINVAL;
> +	}
>  
>  	ret = mma9551_transfer(client, app_id, MMA9551_CMD_READ_CONFIG,
>  			       reg, NULL, 0, (u8 *) be_buf, len);
> @@ -424,7 +429,12 @@ int mma9551_read_status_words(struct i2c_client *client, u8 app_id,
>  {
>  	int ret, i;
>  	int len_words = len / sizeof(u16);
> -	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
> +	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS / 2];
> +
> +	if (len_words > ARRAY_SIZE(be_buf)) {
> +		dev_err(&client->dev, "Invalid buffer size %d\n", len);
> +		return -EINVAL;
> +	}
>  
>  	ret = mma9551_transfer(client, app_id, MMA9551_CMD_READ_STATUS,
>  			       reg, NULL, 0, (u8 *) be_buf, len);
> @@ -459,7 +469,12 @@ int mma9551_write_config_words(struct i2c_client *client, u8 app_id,
>  {
>  	int i;
>  	int len_words = len / sizeof(u16);
> -	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
> +	__be16 be_buf[(MMA9551_MAX_MAILBOX_DATA_REGS - 1) / 2];
> +
> +	if (len_words > ARRAY_SIZE(be_buf)) {
> +		dev_err(&client->dev, "Invalid buffer size %d\n", len);
> +		return -EINVAL;
> +	}
>  
>  	for (i = 0; i < len_words; i++)
>  		be_buf[i] = cpu_to_be16(buf[i]);
> 

