Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:59136 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757237Ab2EOIkD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 May 2012 04:40:03 -0400
Message-ID: <4FB2165F.605@cam.ac.uk>
Date: Tue, 15 May 2012 09:39:59 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
	marek.belisko@gmail.com, shubhrajyoti@ti.com
Subject: Re: [PATCH 8/9] iio: reorganize hmc5843_set_rate()
References: <1337034454-29717-1-git-send-email-pmeerw@pmeerw.net> <1337034454-29717-9-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1337034454-29717-9-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/14/2012 11:27 PM, Peter Meerwald wrote:
> From: Peter Meerwald<p.meerwald@bct-electronic.com>
>
Sensible change.  Note I'm not looking at the previous lot as
I acked patches with the same name and you haven't told me anything
changed...  (if it didn't then consider these acked as well...)
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/magnetometer/hmc5843.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 2e1bc6c..97cfac7 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -343,12 +343,13 @@ static s32 hmc5843_set_rate(struct i2c_client *client,
>   	struct hmc5843_data *data = iio_priv(indio_dev);
>   	u8 reg_val;
>
> -	reg_val = (data->meas_conf) |  (rate<<  HMC5843_RATE_OFFSET);
>   	if (rate>= HMC5843_RATE_NOT_USED) {
>   		dev_err(&client->dev,
>   			"data output rate is not supported\n");
>   		return -EINVAL;
>   	}
> +
> +	reg_val = data->meas_conf | (rate<<  HMC5843_RATE_OFFSET);
>   	return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
>   }
>

