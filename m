Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42477 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbbDZSkP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 14:40:15 -0400
Message-ID: <553D310D.4010406@kernel.org>
Date: Sun, 26 Apr 2015 19:40:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 01/17] iio: accel: mma9553: fix endianness issue when
 reading status
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com> <1428939664-12503-2-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-2-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/15 16:40, Irina Tirdea wrote:
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
> Reported-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the fixes-togreg branch of iio.git

Thanks
> ---
>  drivers/iio/accel/mma9553.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 2df1af7..607dbfc 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -316,22 +316,19 @@ static int mma9553_set_config(struct mma9553_data *data, u16 reg,
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

