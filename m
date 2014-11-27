Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-064.synserver.de ([212.40.185.64]:1090 "EHLO
	smtp-out-064.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857AbaK0IH3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Nov 2014 03:07:29 -0500
Message-ID: <5476DBC2.50309@metafoo.de>
Date: Thu, 27 Nov 2014 09:07:30 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: inkern: add iio_write_channel_raw
References: <1417041765-12782-1-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1417041765-12782-1-git-send-email-dbaryshkov@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/26/2014 11:42 PM, Dmitry Eremin-Solenikov wrote:
> Introduce API for easy in-kernel setting of DAC values.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Looks good...

> ---
>   drivers/iio/inkern.c         | 29 +++++++++++++++++++++++++++++
>   include/linux/iio/consumer.h | 11 +++++++++++
>   2 files changed, 40 insertions(+)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index f084610..5b03e69 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -608,3 +608,32 @@ err_unlock:
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(iio_get_channel_type);
> +
> +static int iio_channel_write(struct iio_channel *chan, int val, int val2,
> +	enum iio_chan_info_enum info)
> +{
> +	int ret;
> +
> +	ret = chan->indio_dev->info->write_raw(chan->indio_dev,
> +			chan->channel, val, val2, info);
> +
> +	return ret;


... but this is something the kbuild bot tester will complain about. There 
is no need for the ret variable.

> +}


