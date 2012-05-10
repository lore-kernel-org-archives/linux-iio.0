Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44212 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492Ab2EJMPU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 May 2012 08:15:20 -0400
Message-ID: <4FABB158.4040101@kernel.org>
Date: Thu, 10 May 2012 13:15:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 5/8] iio: add check for measurement configuration value
 passed to hmc5843
References: <1336515606-12364-1-git-send-email-pmeerw@pmeerw.net> <1336515606-12364-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1336515606-12364-6-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/8/2012 11:20 PM, Peter Meerwald wrote:
> From: Peter Meerwald<p.meerwald@bct-electronic.com>
>
I'm not keen on the underlying code, but this is still worth having!
Something string based at least, or that played well with runtime
power management would be nice. Ah well, can't have everything :(
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/magnetometer/hmc5843.c |    7 ++++++-
>   1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 6888e04..57ab4fb 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -281,9 +281,14 @@ static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
>   	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
>   	struct hmc5843_data *data = iio_priv(indio_dev);
>   	unsigned long meas_conf = 0;
> -	int error = kstrtoul(buf, 10,&meas_conf);
> +	int error;
> +
> +	error = kstrtoul(buf, 10,&meas_conf);
>   	if (error)
>   		return error;
> +	if (meas_conf>= HMC5843_MEAS_CONF_NOT_USED)
> +		return -EINVAL;
> +
>   	mutex_lock(&data->lock);
>
>   	dev_dbg(dev, "set mode to %lu\n", meas_conf);

