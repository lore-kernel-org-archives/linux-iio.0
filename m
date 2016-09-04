Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50114 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbcIDOnt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Sep 2016 10:43:49 -0400
Subject: Re: [PATCH v3 2/3] iio: add resource managed triggered buffer init
 helpers
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1472841954.git.gregor.boirie@parrot.com>
 <6c078d51cfdc4b795004fea18d6d00e4aea59f27.1472841954.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Alexander Kurz <akurz@blala.de>, Tejun Heo <tj@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        Vlad Dogaru <vlad.dogaru@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e7aabbc9-113b-e498-ba44-94e1d99793b8@kernel.org>
Date: Sun, 4 Sep 2016 15:42:29 +0100
MIME-Version: 1.0
In-Reply-To: <6c078d51cfdc4b795004fea18d6d00e4aea59f27.1472841954.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/16 19:47, Gregor Boirie wrote:
> Add resource managed devm_iio_triggered_buffer_setup() and
> devm_iio_triggered_buffer_cleanup() to automatically clean up triggered
> buffers setup by IIO drivers, thus leading to simplified IIO drivers code.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
This feels a little less certain than the trigger one in my mind,
but on balance probably still a good idea.

Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  Documentation/driver-model/devres.txt              |  2 ++
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 42 ++++++++++++++++++++++
>  drivers/iio/industrialio-core.c                    |  3 +-
>  include/linux/iio/iio.h                            |  1 +
>  include/linux/iio/triggered_buffer.h               |  8 +++++
>  5 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index 6a2138a..75bc5b8 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -266,6 +266,8 @@ IIO
>    devm_iio_device_unregister()
>    devm_iio_kfifo_allocate()
>    devm_iio_kfifo_free()
> +  devm_iio_triggered_buffer_setup()
> +  devm_iio_triggered_buffer_cleanup()
>    devm_iio_trigger_alloc()
>    devm_iio_trigger_free()
>    devm_iio_trigger_register()
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index 4b2858b..d3db1fc 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -98,6 +98,48 @@ void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL(iio_triggered_buffer_cleanup);
>  
> +static void devm_iio_triggered_buffer_clean(struct device *dev, void *res)
> +{
> +	iio_triggered_buffer_cleanup(*(struct iio_dev **)res);
> +}
> +
> +int devm_iio_triggered_buffer_setup(struct device *dev,
> +				    struct iio_dev *indio_dev,
> +				    irqreturn_t (*h)(int irq, void *p),
> +				    irqreturn_t (*thread)(int irq, void *p),
> +				    const struct iio_buffer_setup_ops *ops)
> +{
> +	struct iio_dev **ptr;
> +	int ret;
> +
> +	ptr = devres_alloc(devm_iio_triggered_buffer_clean, sizeof(*ptr),
> +			   GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	*ptr = indio_dev;
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, h, thread, ops);
> +	if (!ret)
> +		devres_add(dev, ptr);
> +	else
> +		devres_free(ptr);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_setup);
> +
> +void devm_iio_triggered_buffer_cleanup(struct device *dev,
> +				       struct iio_dev *indio_dev)
> +{
> +	int rc;
> +
> +	rc = devres_release(dev, devm_iio_triggered_buffer_clean,
> +			    devm_iio_device_match, indio_dev);
> +	WARN_ON(rc);
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_cleanup);
> +
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>  MODULE_DESCRIPTION("IIO helper functions for setting up triggered buffers");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index d2b8899..fc340ed 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1308,7 +1308,7 @@ static void devm_iio_device_release(struct device *dev, void *res)
>  	iio_device_free(*(struct iio_dev **)res);
>  }
>  
> -static int devm_iio_device_match(struct device *dev, void *res, void *data)
> +int devm_iio_device_match(struct device *dev, void *res, void *data)
>  {
>  	struct iio_dev **r = res;
>  	if (!r || !*r) {
> @@ -1317,6 +1317,7 @@ static int devm_iio_device_match(struct device *dev, void *res, void *data)
>  	}
>  	return *r == data;
>  }
> +EXPORT_SYMBOL_GPL(devm_iio_device_match);
>  
>  /**
>   * devm_iio_device_alloc - Resource-managed iio_device_alloc()
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 854e2da..cb8d598 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -642,6 +642,7 @@ static inline struct iio_dev *iio_priv_to_dev(void *priv)
>  }
>  
>  void iio_device_free(struct iio_dev *indio_dev);
> +int devm_iio_device_match(struct device *dev, void *res, void *data);
>  struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv);
>  void devm_iio_device_free(struct device *dev, struct iio_dev *indio_dev);
>  struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
> diff --git a/include/linux/iio/triggered_buffer.h b/include/linux/iio/triggered_buffer.h
> index f72f70d..3014561 100644
> --- a/include/linux/iio/triggered_buffer.h
> +++ b/include/linux/iio/triggered_buffer.h
> @@ -12,4 +12,12 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
>  	const struct iio_buffer_setup_ops *setup_ops);
>  void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev);
>  
> +int devm_iio_triggered_buffer_setup(struct device *dev,
> +				    struct iio_dev *indio_dev,
> +				    irqreturn_t (*h)(int irq, void *p),
> +				    irqreturn_t (*thread)(int irq, void *p),
> +				    const struct iio_buffer_setup_ops *ops);
> +void devm_iio_triggered_buffer_cleanup(struct device *dev,
> +				       struct iio_dev *indio_dev);
> +
>  #endif
> 

