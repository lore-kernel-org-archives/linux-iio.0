Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbdHTKDH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 06:03:07 -0400
Date: Sun, 20 Aug 2017 10:57:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/6] iio: accel: kxcjk1013: make
 sampling_frequency_avail per-type
Message-ID: <20170820105730.74ba25a1@archlinux>
In-Reply-To: <f65b8c2d74d216be9eaf2707ce7cbf7a94f4b2ae.1502979014.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502979014.git.mirq-linux@rere.qmqm.pl>
        <f65b8c2d74d216be9eaf2707ce7cbf7a94f4b2ae.1502979014.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 17 Aug 2017 16:21:37 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> Make sampling_frequency_avail per-type - like sampling_frequency is.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Hmm.  This is an ABI change, but as the interface is clearly rather
odd lets take the risk and hope no one notices.  Which they shouldn't
if they are using the ABI correctly.

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 50d9eefa745f..8bde6bead073 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -891,12 +891,13 @@ static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
>  	return sprintf(buf, "%s\n", samp_freq_avail);
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

