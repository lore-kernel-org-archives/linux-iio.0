Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35975 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755920AbcJ1H6z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Oct 2016 03:58:55 -0400
Received: by mail-qk0-f194.google.com with SMTP id z190so4263980qkc.3
        for <linux-iio@vger.kernel.org>; Fri, 28 Oct 2016 00:58:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161025190616.GA30520@elgon.mountain>
References: <20161025190616.GA30520@elgon.mountain>
From: Matt Ranostay <matt@ranostay.consulting>
Date: Fri, 28 Oct 2016 00:58:53 -0700
Message-ID: <CAJ_EiST2k3O2Gjqw91fDXDm_Uw2kyQEw5YM86ikWWWoHegg+Bw@mail.gmail.com>
Subject: Re: [bug report] iio: adc: ti-adc161s626: add regulator support
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Oct 25, 2016 at 12:06 PM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> Hello Matt Ranostay,
>
> The patch 92f0afb5b2be: "iio: adc: ti-adc161s626: add regulator
> support" from Sep 18, 2016, leads to the following static checker
> warning:
>
>         drivers/iio/adc/ti-adc161s626.c:237 ti_adc_probe()
>         error: 'data->ref' dereferencing possible ERR_PTR()
>
> drivers/iio/adc/ti-adc161s626.c
>    214
>    215          data->ref = devm_regulator_get(&spi->dev, "vdda");
>    216          if (!IS_ERR(data->ref)) {
>
> I don't understand what's going on here.

Ok seems weird but this is because of devm_regulator_get() returning a
dummy regulator (CONFIG_REGULATOR_DUMMY) in case "vdda" isn't defined.
  So no reason to enable that...

>
>    217                  ret = regulator_enable(data->ref);
>    218                  if (ret < 0)
>    219                          return ret;
>    220          }
>    221
>    222          ret = iio_triggered_buffer_setup(indio_dev, NULL,
>    223                                           ti_adc_trigger_handler, NULL);
>    224          if (ret)
>    225                  goto error_regulator_disable;
>    226
>    227          ret = iio_device_register(indio_dev);
>    228          if (ret)
>    229                  goto error_unreg_buffer;
>    230
>    231          return 0;
>    232
>    233  error_unreg_buffer:
>    234          iio_triggered_buffer_cleanup(indio_dev);
>    235
>    236  error_regulator_disable:
>    237          regulator_disable(data->ref);
>
> Static checker is correct.

Ok that is part is probably true and maybe needs a IS_ERR check

>
>    238
>    239          return ret;
>    240  }
>
> regards,
> dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
