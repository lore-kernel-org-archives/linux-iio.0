Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42792 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755879AbcH2TPa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 15:15:30 -0400
Subject: Re: [PATCH v2] fix:iio:common:st_sensors:st_sensors_trigger:mark
 symbols static where possible
To: Baoyou Xie <baoyou.xie@linaro.org>, lars@metafoo.de,
        pmeerw@pmeerw.net
References: <1472367851-14762-1-git-send-email-baoyou.xie@linaro.org>
Cc: linus.walleij@linaro.org, rob@kernel.org, maitysanchayan@gmail.com,
        leonard.crestez@intel.com, gregor.boirie@parrot.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@linaro.org, xie.baoyou@zte.com.cn
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9bbf59e2-26e7-ee92-7568-4e1ecb990719@kernel.org>
Date: Mon, 29 Aug 2016 20:15:22 +0100
MIME-Version: 1.0
In-Reply-To: <1472367851-14762-1-git-send-email-baoyou.xie@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/08/16 08:04, Baoyou Xie wrote:
> We get 2 warnings when biuld kernel with W=1:
> drivers/iio/common/st_sensors/st_sensors_trigger.c:69:13: warning: no previous prototype
> for 'st_sensors_irq_handler' [-Wmissing-prototypes]
> drivers/iio/common/st_sensors/st_sensors_trigger.c:85:13: warning: no previous prototype
> for 'st_sensors_irq_thread' [-Wmissing-prototypes]
> 
> In fact, these functions are only used in the file in which they are
> declared and don't need a declaration, but can be made static.
> so this patch marks these functions with 'static'.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Hi.

Please don't resend just to add Reviewed-by / acked-by tags.
The maintainer will pick those up directly from the mailing list.

If there is anything else different here and I'm missing it you
should have highlighted what it was below the --- and
I'm really being unobservant!

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index e66f12e..fa73e67 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -66,7 +66,7 @@ static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
>   * @irq: irq number
>   * @p: private handler data
>   */
> -irqreturn_t st_sensors_irq_handler(int irq, void *p)
> +static irqreturn_t st_sensors_irq_handler(int irq, void *p)
>  {
>  	struct iio_trigger *trig = p;
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> @@ -82,7 +82,7 @@ irqreturn_t st_sensors_irq_handler(int irq, void *p)
>   * @irq: irq number
>   * @p: private handler data
>   */
> -irqreturn_t st_sensors_irq_thread(int irq, void *p)
> +static irqreturn_t st_sensors_irq_thread(int irq, void *p)
>  {
>  	struct iio_trigger *trig = p;
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> 

