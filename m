Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-138.synserver.de ([212.40.185.138]:1057 "EHLO
	smtp-out-138.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbbHBJra (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 05:47:30 -0400
Message-ID: <55BDE72F.7050705@metafoo.de>
Date: Sun, 02 Aug 2015 11:47:27 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Pengyu Ma <pengyu.ma@windriver.com>, jic23@kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: declare struct to fix warning
References: <1438247937-29955-1-git-send-email-pengyu.ma@windriver.com>
In-Reply-To: <1438247937-29955-1-git-send-email-pengyu.ma@windriver.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/30/2015 11:18 AM, Pengyu Ma wrote:
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
> 1st warning: 'struct iio_trigger' was used before declaration;
> 2nd warning: 'struct iio_dev' was used without including head file.
> 
> Signed-off-by: Pengyu Ma <pengyu.ma@windriver.com>
> ---
>  include/linux/iio/trigger.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 68f46cd..cbe4286 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -9,6 +9,7 @@
>  #include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/atomic.h>
> +#include <linux/iio/iio.h>
>  

Instead of including iio.h just add a forward declaration for struct
iio_dev. We dont need to dereference the struct so that will be fine.

>  #ifndef _IIO_TRIGGER_H_
>  #define _IIO_TRIGGER_H_
> @@ -18,6 +19,8 @@ struct iio_subirq {
>  	bool enabled;
>  };
>  
> +struct iio_trigger; /* forward declaration */
> +
>  /**
>   * struct iio_trigger_ops - operations structure for an iio_trigger.
>   * @owner:		used to monitor usage count of the trigger.
> 

