Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbdI3UC3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 16:02:29 -0400
Date: Sat, 30 Sep 2017 21:02:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 5/8] iio: accel: kxcjk1013: make
 sampling_frequency_avail per-type
Message-ID: <20170930210225.7a5c5961@archlinux>
In-Reply-To: <11167c3b3ab21d89a755db885597d98af3cb6744.1505660069.git.mirq-linux@rere.qmqm.pl>
References: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
        <11167c3b3ab21d89a755db885597d98af3cb6744.1505660069.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 17 Sep 2017 17:01:03 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> Make sampling_frequency_avail per-type - like sampling_frequency is.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/kxcjk-1013.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 9b4f953c5782..4e8919d48635 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -889,12 +889,13 @@ static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
>  	return sprintf(buf, "%s\n", kxcjk1013_samp_freq_avail);
>  }
>  
> -static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(kxcjk1013_get_samp_freq_avail);
> +static IIO_DEVICE_ATTR(in_accel_sampling_frequency_available, S_IRUGO,
> +		       kxcjk1013_get_samp_freq_avail, NULL, 0);
>  
>  static IIO_CONST_ATTR(in_accel_scale_available, "0.009582 0.019163 0.038326");
>  
>  static struct attribute *kxcjk1013_attributes[] = {
> -	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_in_accel_sampling_frequency_available.dev_attr.attr,
>  	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
>  	NULL,
>  };

