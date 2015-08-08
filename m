Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57976 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbbHHL3z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 07:29:55 -0400
Subject: Re: [PATCH V4] iio: declare struct to fix warning
To: Pengyu Ma <pengyu.ma@windriver.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
References: <1438677139-9393-1-git-send-email-pengyu.ma@windriver.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C5E831.5030907@kernel.org>
Date: Sat, 8 Aug 2015 12:29:53 +0100
MIME-Version: 1.0
In-Reply-To: <1438677139-9393-1-git-send-email-pengyu.ma@windriver.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/08/15 09:32, Pengyu Ma wrote:
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
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
As we have had no reports of a case of this causing trouble for
a mainlined driver, and we are reasonably late in the current cycle,
I have applied this for the next merge windows (togreg branch) rather
than sending it the fast way as a fix.

Note togreg will be initially pushed out as testing to the let the
autobuilders play with it.

Thanks,

Jonathan
> ---
>  include/linux/iio/trigger.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index fa76c79..1c9e028 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -18,6 +18,9 @@ struct iio_subirq {
>  	bool enabled;
>  };
>  
> +struct iio_dev;
> +struct iio_trigger;
> +
>  /**
>   * struct iio_trigger_ops - operations structure for an iio_trigger.
>   * @owner:		used to monitor usage count of the trigger.
> 

