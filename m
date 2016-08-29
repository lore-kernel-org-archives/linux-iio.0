Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42014 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbcH2RBQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 13:01:16 -0400
Subject: Re: [PATCH v2 3/4] iio: chemical: vz89x: prevent corrupted buffer
 from being read
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1472107490-11924-1-git-send-email-mranostay@gmail.com>
 <1472107490-11924-4-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1b1d4202-e3a4-dc38-2707-cb1a1aab543c@kernel.org>
Date: Mon, 29 Aug 2016 18:01:14 +0100
MIME-Version: 1.0
In-Reply-To: <1472107490-11924-4-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/08/16 07:44, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied to the togreg branch of iio.git.
Initially pushed out as testing for the autobuilders to
play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/chemical/vz89x.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> index 289d2919deea..cd3870ead3fd 100644
> --- a/drivers/iio/chemical/vz89x.c
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -55,6 +55,7 @@ struct vz89x_data {
>  	struct mutex lock;
>  	int (*xfer)(struct vz89x_data *data, u8 cmd);
>  
> +	bool is_valid;
>  	unsigned long last_update;
>  	u8 buffer[VZ89TE_REG_MEASUREMENT_RD_SIZE];
>  };
> @@ -229,7 +230,10 @@ static int vz89x_get_measurement(struct vz89x_data *data)
>  
>  	/* sensor can only be polled once a second max per datasheet */
>  	if (!time_after(jiffies, data->last_update + HZ))
> -		return 0;
> +		return data->is_valid ? 0 : -EAGAIN;
> +
> +	data->is_valid = false;
> +	data->last_update = jiffies;
>  
>  	ret = data->xfer(data, chip->cmd);
>  	if (ret < 0)
> @@ -239,7 +243,7 @@ static int vz89x_get_measurement(struct vz89x_data *data)
>  	if (ret)
>  		return -EAGAIN;
>  
> -	data->last_update = jiffies;
> +	data->is_valid = true;
>  
>  	return 0;
>  }
> 

