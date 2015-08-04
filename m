Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34125 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbHDIao (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 04:30:44 -0400
MIME-Version: 1.0
In-Reply-To: <1438676274-8978-1-git-send-email-pengyu.ma@windriver.com>
References: <1438676274-8978-1-git-send-email-pengyu.ma@windriver.com>
Date: Tue, 4 Aug 2015 11:30:41 +0300
Message-ID: <CAEnQRZBjgQ0w0SL0DdaiTujb-mkaA2Rpszmq_aXdOHU2OOvChQ@mail.gmail.com>
Subject: Re: [PATCH V3] iio: declare struct to fix warning
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Pengyu Ma <pengyu.ma@windriver.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 4, 2015 at 11:17 AM, Pengyu Ma <pengyu.ma@windriver.com> wrote:
> When compile iio related driver the following warning shown:
>
> include/linux/iio/trigger.h:35:34: warning: 'struct iio_trigger'
> declared inside parameter list
>   int (*set_trigger_state)(struct iio_trigger *trig, bool state);
>
> include/linux/iio/trigger.h:38:18: warning: 'struct iio_dev'
> declared inside parameter list
>            struct iio_dev *indio_dev);
>
> 'struct iio_dev' and 'struct iio_trigger' was used before declaration,
> forward declaration for these structs to fix warning.
>
> Signed-off-by: Pengyu Ma <pengyu.ma@windriver.com>

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  include/linux/iio/trigger.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index fa76c79..1c9e028 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -18,6 +18,9 @@ struct iio_subirq {
>         bool enabled;
>  };
>
> +struct iio_dev;
> +struct iio_trigger;
> +
>  /**
>   * struct iio_trigger_ops - operations structure for an iio_trigger.
>   * @owner:             used to monitor usage count of the trigger.
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
