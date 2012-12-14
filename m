Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46768 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab2LNB67 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Dec 2012 20:58:59 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so2794175obb.19
        for <linux-iio@vger.kernel.org>; Thu, 13 Dec 2012 17:58:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1355449598-15980-2-git-send-email-marex@denx.de>
References: <1355449598-15980-1-git-send-email-marex@denx.de>
	<1355449598-15980-2-git-send-email-marex@denx.de>
Date: Thu, 13 Dec 2012 23:58:59 -0200
Message-ID: <CAOMZO5DDcPpePEiJe0hg0Er60OBuJM+Rik1CSc9zcphycpEr4g@mail.gmail.com>
Subject: Re: [PATCH 2/3 V2] iio: mxs: Implement support for touchscreen
From: Fabio Estevam <festevam@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marek,

On Thu, Dec 13, 2012 at 11:46 PM, Marek Vasut <marex@denx.de> wrote:

> +static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
> +{
> +       struct input_dev *input;
> +       struct device *dev = lradc->dev;
> +       int ret;
> +
> +       if (!lradc->use_touchscreen)
> +               return 0;

Shouldn't we return an error code here?

> +
> +       input = input_allocate_device();
> +       if (!input) {
> +               dev_warn(dev, "Failed to allocate TS device, disabling.\n");
> +               lradc->use_touchscreen = MXS_LRADC_TOUCHSCREEN_NONE;
> +               return 0;
> +       }

Shouldn't we return an error code here?

Regards,

Fabio Estevam
