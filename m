Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S940867AbdEXT25 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 May 2017 15:28:57 -0400
Date: Wed, 24 May 2017 20:28:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
        Jeff White <Jeff.White@zii.aero>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: Re: [PATCH] iio: hi8435: remote ampersands from hi8435_info
 definition
Message-ID: <20170524202853.0cfc4c1e@kernel.org>
In-Reply-To: <20170523080746.20512-1-nikita.yoush@cogentembedded.com>
References: <20170523080746.20512-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 23 May 2017 11:07:46 +0300
Nikita Yushchenko <nikita.yoush@cogentembedded.com> wrote:

> C syntax allows apersands when initializing structures fields with
> function pointers, but in Linux sources ampersands are normally not used
> in thix context.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,
Jonathan
> ---
>  drivers/iio/adc/hi8435.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index 28fc699f00f6..ef5c286c8e67 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -414,11 +414,11 @@ static const struct iio_chan_spec hi8435_channels[] = {
>  static const struct iio_info hi8435_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = hi8435_read_raw,
> -	.read_event_config = &hi8435_read_event_config,
> +	.read_event_config = hi8435_read_event_config,
>  	.write_event_config = hi8435_write_event_config,
> -	.read_event_value = &hi8435_read_event_value,
> -	.write_event_value = &hi8435_write_event_value,
> -	.debugfs_reg_access = &hi8435_debugfs_reg_access,
> +	.read_event_value = hi8435_read_event_value,
> +	.write_event_value = hi8435_write_event_value,
> +	.debugfs_reg_access = hi8435_debugfs_reg_access,
>  };
>  
>  static void hi8435_iio_push_event(struct iio_dev *idev, unsigned int val)

