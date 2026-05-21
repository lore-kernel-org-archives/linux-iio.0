Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35343C37AA
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363347; cv=pass; b=DX7x/4ShzTYXqAJTXXK5ppsgEshWsmffEp/EArhfgbaUgDWHl2UmXBSHx06ijbOoS+iu5a9G81qeIh96A7ZlJj1020uNmeZJazCwOVGqrX1aLeXgBCT/UonV4qT+IjsJGDvebZb0bg56yMkZ3gpwfx3IFVhZQ+hSAFGqQl7yU54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363347; c=relaxed/simple;
	bh=8ZwLAjU19j6LvJNuKXK+AvuwjvBxXCbNma2QTYQCqq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJpfFpZSlyM01FPOzZx0JYsaDYArI5n3XGi5IHQjYVmPl3YMQSl4tcpFqeTkG5UOQv16+cc+dx/BsetU2Qd2L9Alr1P74t6eRMcv1OPNgiyPxUtTdvddLHNZIQEirlG3G2qK6uT4v8qxgQjMVAx8q3l5XSF5Hvn+o08KpTMeVMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjILIA+O; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjILIA+O"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490229aa522so26123115e9.3
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 04:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779363343; cv=none;
        d=google.com; s=arc-20240605;
        b=NcXe/cwj5ZjgjtIz4jIuWsaE9349M4ztBnDBYZggVY/s7mxrVZf+Pv6HtfmZmy8Wp9
         LPRU2SiJCTqfDBbjZv/gI3DsAliHgXfFRFsL1cV6691W836BO5O7I59pGCZxpGRW5fA2
         b5Hm8slLd4gn46yZPpsZEhpGQP/wN83PIxZjJ/LlR18l/JoS1oFeuErsrHzYgmDEys6l
         e3baQyLuEaWJ2y3hReOf/eAJoKSj526ccTfEjpkjrJvH/glP2uBTXCEJVaSFCU41reZf
         m2YGsbLAPnlSLjHirOuJ6I83aqjd7DN/l7BoIfA3GntP3GkS+a4QeB3RjSrKnEL93cqO
         kHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RkXi5kuOtamNiCL4i9DjXoq0M0D6d2pRZ79qiSxOUkc=;
        fh=2/ZEDBXMzEDqTdaoBkCz1fBUIXpr4AysDsvw0pd67T0=;
        b=YKElol0PgwsPT2Uk3vrdhtIcbvNI4qNcD09/BgCH8uiy/njhEW72l/zSNjfP7im2Lj
         6DBilcg1zIwpO5/WvvMzARcgKdwfXZOupkGaRaNVZfaZ8NNRGIjJ7/0MEtPrH1wiPjw/
         nvDsew/541IS/CXPTx3L0EdXdGBluNtC45E9Z5IjmPQSqYFjRMjvTlt83EY7S5ba8LQL
         QY+Nsxv4WhhW1QpeEp7mB9VCWEl5PyR+gQGa9XIi5rk8/ufW5YQt5q6CGWcLUw3Qyhr3
         8pkpRM20l3BmrNOdoX8NeJ451BitlyoLWK3dWwLIDXrOVEOKwn5MIhWfE8YSIwIQeQ1l
         xGCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779363343; x=1779968143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RkXi5kuOtamNiCL4i9DjXoq0M0D6d2pRZ79qiSxOUkc=;
        b=GjILIA+OCNWgb4AHvuA/ENfzidrIsYalS0M9bQMEYOfMgN69dsLbDPKt1OrR8y81A4
         KRU6pRgQOOncluiyG9OYlKwWdY7LBbOWc9FXJeM/Q7tundZQsSyMRh78Ta/PtwdG9jSO
         +z+nf4uU/fFP6D0Z1DLZOVDKZWF/0vsMw4mZltQZ/TEbStBXJb1oxi1MdgDBSCkgseRM
         dXdBJosDfB5u4ujmQuZFOcOVwWAaW7JCG5QPCZcblmwx9KMxZG/Apo52lvmOwp46q023
         mfvJ9OxuRoR/JaKlU7QLWxWjTFgd9FrlouC8x0sM12BMVTnrnWuIO2kFT1PzjS8bx/9m
         OQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779363343; x=1779968143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkXi5kuOtamNiCL4i9DjXoq0M0D6d2pRZ79qiSxOUkc=;
        b=gB53lc3fwg0PT0RHIpWN6gYGeCTQ7ZQ0ggA+hFebVMvfBXlW+kaNe6lGWqcn/JPmip
         sNhsthPLz/Pvy5gVCko8xtFtRSfe4XrHDOxPfaAtX14f9Z0yLYCnheF9rvNbOssR+PEY
         JcIR3h3EXMX4uN/YjDbrAwoDqM+mm8/ijhTjaDP0lUEReJ4YV7kVDiX+Go83q00GAwm6
         v8e9Q+iSUWIvk3JnQwWV34kmrICnyg0CkqqaB7bFjk8i2vrLbNGxr4NgukuJklKI70ER
         QddzMHMGrlaBLt2Qez39Hzl0ZqkYrEOJw3m8N54Jkt52e4e8z7cWR6EUMUQkNeNPe5hF
         xjaA==
X-Forwarded-Encrypted: i=1; AFNElJ/ncVd0QNGi5dUv1nYJeJJlqSEyYHLqGp1HRDjTSen+8ZqNUMrHKWdlhS0rejUfCvVo/TKzCcu4M0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4A+gCGYsqglqFlFChPbkzQMPejBVrhcIcCcZj6Wg2CtsJFIVl
	8F826Y8FhaSUsrEUP8URFLWCaMZ7cV1atYz9DJMAfrw0SOxM5KAsXHGfXLn9LcFk7Lyqm/mgkcj
	Uj68FxYccC28p5Gw4CCV0VX77IZtkOv4=
X-Gm-Gg: Acq92OFoppIzpCDs5tGoMT5xEck5pl7coE4YiRYHVXbepxeNlcDVirM+/WalebrN1+L
	EmvHaPazKite0uKS+fKvRAeQvAiTxTjeEu+UKSnwTjMPNCa8kYlcsUTs1iek+N/H40xzIGs3dbo
	q6UNuILDdQf3qNpi//Ti5sqi7rIiWX8VTeyU+OKnOIV+65vtIL65rErkYoiYqGfUxjJg/Y5QBzH
	q2KY5+XwP5cLY/efV4PGBbcyxOC6P4jqhyuYdNSHeBPMD4vlQRhosMTUZ+qVVlNfBDBkcTN+3iT
	6In9OnshEJnBVrtXK6/eFpUhyxFMjsYxubIcFIkizQYpMOWYq3oEaiPf6zVH9wUUFJpwHYOucJr
	q9HpgciqrTgwcTXK9IsFRCsyA3rmp02C/DYuceM8PuUGgGGg2NZ3Q+yTF+CfMahC0zVAtdV+kQd
	0mENwmcA==
X-Received: by 2002:a05:600c:4654:b0:48e:635a:18d9 with SMTP id
 5b1f17b1804b1-4903608439fmr24471885e9.15.1779363342368; Thu, 21 May 2026
 04:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com> <20260521-opt3001-cleanup-v3-6-820169dec8c3@gmail.com>
In-Reply-To: <20260521-opt3001-cleanup-v3-6-820169dec8c3@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 21 May 2026 13:35:32 +0200
X-Gm-Features: AVHnY4Lg1Bd1fclD3rvlC766utvv_soFAawJNxF4dKNJNjoBq5-CdHlW0U5JLnc
Message-ID: <CALoEA-xi=pDxLdTEP2+6fy_dFcq0=q+YkHpAYPQ=FKuE1xdZvw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] iio: light: opt3001: move driver to guard(mutex)() use
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
	Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 May 2026 at 11:55, Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Move driver to use guard(mutex)() macro, to facilitate automatic
> locking/unlocking of resources. This modernizes the driver and
> improves code style.
>
> While at it, remove unnecessary gotos and return variables.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/opt3001.c | 140 +++++++++++++++++++-------------------------
>  1 file changed, 60 insertions(+), 80 deletions(-)
>
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index d5262488dac889066a53d3234762e0557f9e3cbc..ac1c7ba5679867f6b814894680e317615f2e373b 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -10,6 +10,7 @@
>
>  #include <linux/array_size.h>
>  #include <linux/bits.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/dev_printk.h>
>  #include <linux/errno.h>
> @@ -477,7 +478,6 @@ static int opt3001_read_raw(struct iio_dev *iio,
>                             int *val, int *val2, long mask)
>  {
>         struct opt3001 *opt = iio_priv(iio);
> -       int ret;
>
>         if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
>                 return -EBUSY;
> @@ -485,23 +485,17 @@ static int opt3001_read_raw(struct iio_dev *iio,
>         if (chan->type != opt->chip_info->chan_type)
>                 return -EINVAL;
>
> -       mutex_lock(&opt->lock);
> +       guard(mutex)(&opt->lock);
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
>         case IIO_CHAN_INFO_PROCESSED:
> -               ret = opt3001_get_processed(opt, val, val2);
> -               break;
> +               return opt3001_get_processed(opt, val, val2);
>         case IIO_CHAN_INFO_INT_TIME:
> -               ret = opt3001_get_int_time(opt, val, val2);
> -               break;
> +               return opt3001_get_int_time(opt, val, val2);
>         default:
> -               ret = -EINVAL;
> +               return -EINVAL;
>         }
> -
> -       mutex_unlock(&opt->lock);
> -
> -       return ret;
>  }
>
>  static int opt3001_write_raw(struct iio_dev *iio,
> @@ -509,7 +503,6 @@ static int opt3001_write_raw(struct iio_dev *iio,
>                              int val, int val2, long mask)
>  {
>         struct opt3001 *opt = iio_priv(iio);
> -       int ret;
>
>         if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
>                 return -EBUSY;
> @@ -523,11 +516,9 @@ static int opt3001_write_raw(struct iio_dev *iio,
>         if (val != 0)
>                 return -EINVAL;
>
> -       mutex_lock(&opt->lock);
> -       ret = opt3001_set_int_time(opt, val2);
> -       mutex_unlock(&opt->lock);
> +       guard(mutex)(&opt->lock);
>
> -       return ret;
> +       return opt3001_set_int_time(opt, val2);
>  }
>
>  static int opt3001_read_event_value(struct iio_dev *iio,
> @@ -538,28 +529,23 @@ static int opt3001_read_event_value(struct iio_dev *iio,
>                                     int *val, int *val2)
>  {
>         struct opt3001 *opt = iio_priv(iio);
> -       int ret = IIO_VAL_INT_PLUS_MICRO;
>
> -       mutex_lock(&opt->lock);
> +       guard(mutex)(&opt->lock);
>
>         switch (dir) {
>         case IIO_EV_DIR_RISING:
>                 opt3001_to_iio_ret(opt, opt->high_thresh_exp,
>                                    opt->high_thresh_mantissa,
>                                    val, val2);
> -               break;
> +               return IIO_VAL_INT_PLUS_MICRO;
>         case IIO_EV_DIR_FALLING:
>                 opt3001_to_iio_ret(opt, opt->low_thresh_exp,
>                                    opt->low_thresh_mantissa,
>                                    val, val2);
> -               break;
> +               return IIO_VAL_INT_PLUS_MICRO;
>         default:
> -               ret = -EINVAL;
> +               return -EINVAL;
>         }
> -
> -       mutex_unlock(&opt->lock);
> -
> -       return ret;
>  }
>
>  static int opt3001_write_event_value(struct iio_dev *iio,
> @@ -586,12 +572,12 @@ static int opt3001_write_event_value(struct iio_dev *iio,
>         if (val < 0)
>                 return -EINVAL;
>
> -       mutex_lock(&opt->lock);
> +       guard(mutex)(&opt->lock);
>
>         ret = opt3001_find_scale(opt, val, val2, &exponent);
>         if (ret < 0) {
>                 dev_err(dev, "can't find scale for %d.%06u\n", val, val2);
> -               goto err;
> +               return ret;
>         }
>
>         whole = opt->chip_info->factor_whole;
> @@ -614,20 +600,16 @@ static int opt3001_write_event_value(struct iio_dev *iio,
>                 opt->low_thresh_exp = exponent;
>                 break;
>         default:
> -               ret = -EINVAL;
> -               goto err;
> +               return -EINVAL;
>         }
>
>         ret = i2c_smbus_write_word_swapped(client, reg, value);
>         if (ret < 0) {
>                 dev_err(dev, "failed to write register %02x\n", reg);
> -               goto err;
> +               return ret;
>         }
>
> -err:
> -       mutex_unlock(&opt->lock);
> -
> -       return ret;
> +       return 0;
>  }
>
>  static int opt3001_read_event_config(struct iio_dev *iio,
> @@ -659,7 +641,7 @@ static int opt3001_write_event_config(struct iio_dev *iio,
>         if (!state && opt->mode == OPT3001_CONFIGURATION_M_SHUTDOWN)
>                 return 0;
>
> -       mutex_lock(&opt->lock);
> +       guard(mutex)(&opt->lock);
>
>         mode = state ? OPT3001_CONFIGURATION_M_CONTINUOUS
>                 : OPT3001_CONFIGURATION_M_SHUTDOWN;
> @@ -668,7 +650,7 @@ static int opt3001_write_event_config(struct iio_dev *iio,
>         if (ret < 0) {
>                 dev_err(dev, "failed to read register %02x\n",
>                         OPT3001_CONFIGURATION);
> -               goto err;
> +               return ret;
>         }
>
>         reg = ret;
> @@ -678,13 +660,10 @@ static int opt3001_write_event_config(struct iio_dev *iio,
>         if (ret < 0) {
>                 dev_err(dev, "failed to write register %02x\n",
>                         OPT3001_CONFIGURATION);
> -               goto err;
> +               return ret;
>         }
>
> -err:
> -       mutex_unlock(&opt->lock);
> -
> -       return ret;
> +       return 0;
>  }
>
>  static const struct iio_info opt3001_info = {
> @@ -726,6 +705,31 @@ static int opt3001_read_id(struct opt3001 *opt)
>         return 0;
>  }
>
> +static void opt3001_power_off(void *data)
> +{
> +       struct opt3001 *opt = data;
> +       struct i2c_client *client = opt->client;
> +       struct device *dev = opt->dev;
> +       u16 reg_val;
> +       int ret;
> +
> +       ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read register %02x\n",
> +                       OPT3001_CONFIGURATION);
> +               return;
> +       }
> +
> +       reg_val = ret;
> +       opt3001_set_mode(opt, &reg_val, OPT3001_CONFIGURATION_M_SHUTDOWN);
> +
> +       ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION,
> +                                          reg_val);
> +       if (ret < 0)
> +               dev_err(dev, "failed to write to register %02x\n",
> +                       OPT3001_CONFIGURATION);
> +}
> +
>  static int opt3001_configure(struct opt3001 *opt)
>  {
>         struct i2c_client *client = opt->client;
> @@ -764,6 +768,11 @@ static int opt3001_configure(struct opt3001 *opt)
>                 return dev_err_probe(dev, ret, "failed to write register %02x\n",
>                                      OPT3001_CONFIGURATION);
>
> +       ret = devm_add_action_or_reset(dev, opt3001_power_off, opt);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "failed to register power off function\n");
> +
>         ret = i2c_smbus_read_word_swapped(client, OPT3001_LOW_LIMIT);
>         if (ret < 0)
>                 return dev_err_probe(dev, ret, "failed to read register %02x\n",
> @@ -857,7 +866,10 @@ static int opt3001_probe(struct i2c_client *client)
>         opt->client = client;
>         opt->chip_info = i2c_get_match_data(client);
>
> -       mutex_init(&opt->lock);
> +       ret = devm_mutex_init(dev, &opt->lock);
> +       if (ret)
> +               return ret;
> +
>         init_waitqueue_head(&opt->result_ready_queue);
>         i2c_set_clientdata(client, iio);
>
> @@ -879,49 +891,18 @@ static int opt3001_probe(struct i2c_client *client)
>
>         /* Make use of INT pin only if valid IRQ no. is given */
>         if (irq > 0) {
> -               ret = request_threaded_irq(irq, NULL, opt3001_irq,
> -                                          IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -                                          "opt3001", iio);
> +               ret = devm_request_threaded_irq(dev, irq, NULL, opt3001_irq,
> +                                               IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +                                               "opt3001", iio);

Nope nope nope, disregard this patch, obviously I've merged this incorrectly
so that's another reason for a v4 (perhaps some patches could get picked up
though).

-- 
Kind regards

CJD
