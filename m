Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:32847 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbcJMIeR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Oct 2016 04:34:17 -0400
Received: by mail-lf0-f48.google.com with SMTP id x79so127257952lff.0
        for <linux-iio@vger.kernel.org>; Thu, 13 Oct 2016 01:33:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161012060719.GD12841@mwanda>
References: <20161012060719.GD12841@mwanda>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 13 Oct 2016 10:25:39 +0200
Message-ID: <CAKv63uskg4u6p-rH=Vt7JqmAj-VpRSfJUcv1j0SWHdd=yafxFw@mail.gmail.com>
Subject: Re: [bug report] iio: fetch and enable regulators unconditionally
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Dan,

On 12 October 2016 at 08:07, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Crt Mori,
>
> The patch 67516074884b: "iio: fetch and enable regulators
> unconditionally" from Sep 5, 2016, leads to the following static
> checker warning:
>
>         drivers/iio/pressure/ms5611_core.c:419 ms5611_init()
>         error: 'st->vdd' dereferencing possible ERR_PTR()
>
> drivers/iio/pressure/ms5611_core.c
>    388  static int ms5611_init(struct iio_dev *indio_dev)
>    389  {
>    390          int ret;
>    391          struct ms5611_state *st = iio_priv(indio_dev);
>    392
>    393          /* Enable attached regulator if any. */
>    394          st->vdd = devm_regulator_get(indio_dev->dev.parent, "vdd");
>    395          if (!IS_ERR(st->vdd)) {
>    396                  ret = regulator_enable(st->vdd);
>    397                  if (ret) {
>    398                          dev_err(indio_dev->dev.parent,
>    399                                  "failed to enable Vdd supply: %d\n", ret);
>    400                          return ret;
>    401                  }
>    402          } else {
>    403                  ret = PTR_ERR(st->vdd);
>    404                  if (ret != -ENODEV)
>    405                          return ret;
>
> You probably want to update this chunk as well?  Otherwise static
> checkers think we're dereferencing -ENODEV.

Can you explain a bit more why they would think of it like that and
what would better proposal be like?

ret is a return value and it is st->vdd pointer is checked for error
before we deduct error information out, so I do not see where
dereferencing takes part?

>
>    406          }
>    407
>    408          ret = ms5611_reset(indio_dev);
>    409          if (ret < 0)
>    410                  goto err_regulator_disable;
>    411
>    412          ret = ms5611_read_prom(indio_dev);
>    413          if (ret < 0)
>    414                  goto err_regulator_disable;
>    415
>    416          return 0;
>    417
>    418  err_regulator_disable:
>    419          regulator_disable(st->vdd);
>    420          return ret;
>    421  }
>
> regards,
> dan carpenter
