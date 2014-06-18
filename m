Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:59031 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756377AbaFRIRu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jun 2014 04:17:50 -0400
Received: by mail-la0-f42.google.com with SMTP id pn19so288398lab.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Jun 2014 01:17:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1403072503-29246-5-git-send-email-beomho.seo@samsung.com>
References: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com>
	<1403072503-29246-5-git-send-email-beomho.seo@samsung.com>
Date: Wed, 18 Jun 2014 13:47:48 +0530
Message-ID: <CAK5sBcEU=mwfRF4YHuVfEf6kCLodRi_aTPwmmipa=7Txh3WK2w@mail.gmail.com>
Subject: Re: [PATCH 4/5] iio: light: gp2ap020a00f: Use devm_* APIs
From: Sachin Kamat <spk.linux@gmail.com>
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org,
	j.anaszewski@samsung.com, Sachin Kamat <sachin.kamat@linaro.org>,
	naveen krishna <ch.naveen@samsung.com>, ktsai@capellamicro.com,
	srinivas.pandruvada@linux.intel.com, t.figa@samsung.com,
	myungjoo.ham@samsung.com, jh80.chung@samsung.com,
	cw00.choi@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jun 18, 2014 at 11:51 AM, Beomho Seo <beomho.seo@samsung.com> wrote:
> This patch changes APIs from request_threaded_irq()
> and iio_device_register() to devm_* APIs. Using them make simpler.
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
>  drivers/iio/light/gp2ap020a00f.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index 221ed16..1745c6a 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -1562,7 +1562,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
>         }
>
>         /* This needs to be requested here for read_raw calls to work. */
> -       err = request_threaded_irq(client->irq, NULL,
> +       err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>                                    &gp2ap020a00f_thresh_event_handler,
>                                    IRQF_TRIGGER_FALLING |
>                                    IRQF_ONESHOT,
> @@ -1581,10 +1581,10 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
>         err = iio_trigger_register(data->trig);
>         if (err < 0) {
>                 dev_err(&client->dev, "Failed to register iio trigger.\n");
> -               goto error_free_irq;
> +               goto iio_uninit_buffer;
>         }
>
> -       err = iio_device_register(indio_dev);
> +       err = devm_iio_device_register(&client->dev, indio_dev);
>         if (err < 0)
>                 goto error_trigger_unregister;
>
> @@ -1592,8 +1592,6 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
>
>  error_trigger_unregister:
>         iio_trigger_unregister(data->trig);
> -error_free_irq:
> -       free_irq(client->irq, indio_dev);
>  error_uninit_buffer:
>         iio_triggered_buffer_cleanup(indio_dev);
>  error_regulator_disable:
> @@ -1613,9 +1611,7 @@ static int gp2ap020a00f_remove(struct i2c_client *client)
>         if (err < 0)
>                 dev_err(&indio_dev->dev, "Failed to power off the device.\n");
>
> -       iio_device_unregister(indio_dev);
>         iio_trigger_unregister(data->trig);
> -       free_irq(client->irq, indio_dev);
>         iio_triggered_buffer_cleanup(indio_dev);
>         regulator_disable(data->vled_reg);

Same comments as patch 1, ordering issue?

-- 
Regards,
Sachin.
