Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51572 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196AbbDILoC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 07:44:02 -0400
Message-ID: <55266607.6040109@kernel.org>
Date: Thu, 09 Apr 2015 12:44:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] iio: accel: mma9553: refactor mma9553_read_activity_stepcnt
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com> <1428503857-9081-5-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428503857-9081-5-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/15 15:37, Irina Tirdea wrote:
> Refactor code for simplicity and clarity.
> 
> This also fixes an endianness issue with the original code.
> When reading multiple registers, the received buffer of
> 16-bytes words is little endian (status, step count). On
> big endian machines, casting them to u32 would result in
> reversed order in the buffer (step count, status) leading
> to incorrect values for step count and activity.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
Sensible fix, again fill pickup from reordered series.
Thanks,
> ---
>  drivers/iio/accel/mma9553.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index d781999..ee2be3f 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -318,22 +318,19 @@ static int mma9553_set_config(struct mma9553_data *data, u16 reg,
>  static int mma9553_read_activity_stepcnt(struct mma9553_data *data,
>  					 u8 *activity, u16 *stepcnt)
>  {
> -	u32 status_stepcnt;
> -	u16 status;
> +	u16 buf[2];
>  	int ret;
>  
>  	ret = mma9551_read_status_words(data->client, MMA9551_APPID_PEDOMETER,
> -					MMA9553_REG_STATUS, sizeof(u32),
> -					(u16 *) &status_stepcnt);
> +					MMA9553_REG_STATUS, sizeof(u32), buf);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
>  			"error reading status and stepcnt\n");
>  		return ret;
>  	}
>  
> -	status = status_stepcnt & MMA9553_MASK_CONF_WORD;
> -	*activity = mma9553_get_bits(status, MMA9553_MASK_STATUS_ACTIVITY);
> -	*stepcnt = status_stepcnt >> 16;
> +	*activity = mma9553_get_bits(buf[0], MMA9553_MASK_STATUS_ACTIVITY);
> +	*stepcnt = buf[1];
>  
>  	return 0;
>  }
> 

