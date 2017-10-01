Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbdJAKSA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Oct 2017 06:18:00 -0400
Date: Sun, 1 Oct 2017 11:17:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dummy: events: Add missing break
Message-ID: <20171001111756.057b80f1@archlinux>
In-Reply-To: <20170929132405.28104-1-lars@metafoo.de>
References: <20170929132405.28104-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 29 Sep 2017 15:24:05 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> Add missing break in iio_simple_dummy_write_event_config() for the voltage
> threshold event enable attribute. Without this writing to the
> in_voltage0_thresh_rising_en always returns -EINVAL even though the change
> was correctly applied.
> 
> Fixes: 3e34e650db197 ("iio: dummy: Demonstrate the usage of new channel types")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to the fixes-togreg branch of iio.git and marked for stable.
It's hardly a critical stable fix, but the risk is obviously very low
as well ;)

Thanks,

Jonathan
> ---
>  drivers/iio/dummy/iio_simple_dummy_events.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy_events.c b/drivers/iio/dummy/iio_simple_dummy_events.c
> index ed63ffd849f8..7ec2a0bb0807 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_events.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_events.c
> @@ -72,6 +72,7 @@ int iio_simple_dummy_write_event_config(struct iio_dev *indio_dev,
>  				st->event_en = state;
>  			else
>  				return -EINVAL;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}

