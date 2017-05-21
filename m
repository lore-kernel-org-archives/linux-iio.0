Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36763 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753213AbdEULM1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 07:12:27 -0400
Subject: Re: [PATCH v5 5/9] iio: light: rpr0521 whitespace fixes
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-iio@vger.kernel.org
References: <1495109577-29596-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1495109577-29596-6-git-send-email-mikko.koivunen@fi.rohmeurope.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3844665e-1534-8f19-ec3f-b52313d0e8d7@kernel.org>
Date: Sun, 21 May 2017 12:12:24 +0100
MIME-Version: 1.0
In-Reply-To: <1495109577-29596-6-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/05/17 13:12, Mikko Koivunen wrote:
> Just whitespace change, no functional changes.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Applied.
> ---
> 
>   drivers/iio/light/rpr0521.c |    3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 38095d7..52c559d 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -371,6 +371,7 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>   		*val = le16_to_cpu(raw_data);
>   
>   		return IIO_VAL_INT;
> +
>   	case IIO_CHAN_INFO_SCALE:
>   		mutex_lock(&data->lock);
>   		ret = rpr0521_get_gain(data, chan->address, val, val2);
> @@ -379,6 +380,7 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>   			return ret;
>   
>   		return IIO_VAL_INT_PLUS_MICRO;
> +
>   	default:
>   		return -EINVAL;
>   	}
> @@ -398,6 +400,7 @@ static int rpr0521_write_raw(struct iio_dev *indio_dev,
>   		mutex_unlock(&data->lock);
>   
>   		return ret;
> +
>   	default:
>   		return -EINVAL;
>   	}
> 

