Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48605 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbaBYUtc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2014 15:49:32 -0500
Message-ID: <530D0208.7030307@kernel.org>
Date: Tue, 25 Feb 2014 20:50:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:magnetometer:mag3110: Fix unreachable code
References: <20140224220419.GC29170@elgon.mountain> <1393357985-9314-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1393357985-9314-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/02/14 19:53, Peter Meerwald wrote:
>          drivers/iio/magnetometer/mag3110.c:197 mag3110_read_raw()
>          info: ignoring unreachable code.
>
> drivers/iio/magnetometer/mag3110.c
>     185          case IIO_CHAN_INFO_SCALE:
>     186                  switch (chan->type) {
>     187                  case IIO_MAGN:
>     188                          *val = 0;
>     189                          *val2 = 1000;
>     190                          return IIO_VAL_INT_PLUS_MICRO;
>     191                  case IIO_TEMP:
>     192                          *val = 1000;
>     193                          return IIO_VAL_INT;
>     194                  default:
>     195                          return -EINVAL;
>     196                  }
>     197                  return IIO_VAL_INT_PLUS_MICRO;
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> introduced by f9279d3a, mag3110: Scale factor missing
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/magnetometer/mag3110.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
> index 9f260a5..e3106b4 100644
> --- a/drivers/iio/magnetometer/mag3110.c
> +++ b/drivers/iio/magnetometer/mag3110.c
> @@ -194,7 +194,6 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
>   		default:
>   			return -EINVAL;
>   		}
> -		return IIO_VAL_INT_PLUS_MICRO;
>   	case IIO_CHAN_INFO_SAMP_FREQ:
>   		i = data->ctrl_reg1 >> MAG3110_CTRL_DR_SHIFT;
>   		*val = mag3110_samp_freq[i][0];
>

