Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40337 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbaBHKcW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2014 05:32:22 -0500
Message-ID: <52F607D3.2000507@kernel.org>
Date: Sat, 08 Feb 2014 10:32:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Beomho Seo <beomho.seo@samsung.com>, linux-iio@vger.kernel.org
CC: ldewangan@nvidia.com, Peter Meerwald <pmeerw@pmeerw.net>,
	Myungjoo Ham <myungjoo.ham@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH RESEND 2/2] iio: ak8975: Add device name
References: <52F0AFD0.50104@samsung.com>
In-Reply-To: <52F0AFD0.50104@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/02/14 09:16, Beomho Seo wrote:
>
> This patch add device name.
>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Applied to the togreg branch of iio.git

Whilst this is bringing the driver inline with the ABI, it probably doesn't
count as a bug fix and so can wait until the next merge window.

Thanks,

Jonathan
> ---
>   drivers/iio/magnetometer/ak8975.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 0542354..74866d1 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -513,6 +513,7 @@ static int ak8975_probe(struct i2c_client *client,
>   	indio_dev->channels = ak8975_channels;
>   	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
>   	indio_dev->info = &ak8975_info;
> +	indio_dev->name = id->name;
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>
>   	err = iio_device_register(indio_dev);
>

