Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35936 "EHLO
	mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbcHARD6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Aug 2016 13:03:58 -0400
Received: by mail-qt0-f182.google.com with SMTP id 52so108167625qtq.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Aug 2016 10:03:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1470045278-18161-2-git-send-email-enric.balletbo@collabora.com>
References: <1470045278-18161-1-git-send-email-enric.balletbo@collabora.com> <1470045278-18161-2-git-send-email-enric.balletbo@collabora.com>
From: Guenter Roeck <groeck@google.com>
Date: Mon, 1 Aug 2016 09:57:28 -0700
Message-ID: <CABXOdTf9HZLV1Wn==F8GV69ynnQPQXubcnzvkckY+QnW=wjNKQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] iio: cros_ec_sensors_core: Add common functions
 for the ChromeOS EC Sensor Hub.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org, Olof Johansson <olof@lixom.net>,
	Lee Jones <lee.jones@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 1, 2016 at 2:54 AM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Add the core functions to be able to support the sensors attached behind
> the ChromeOS Embedded Controller and used by other IIO cros-ec sensor
> drivers.
>
> The cros_ec_sensor_core driver matches with current driver in ChromeOS
> 4.4 tree, so it includes all the fixes at the moment. The support for
> this driver was made by Gwendal Grignou. The original patch and all the
> fixes has been squashed and rebased on top of mainline.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> [eballetbo: split, squash and rebase on top of mainline the patches
> found in ChromeOS tree]
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Nitpick below. Please only address if you need to resend for a different reason.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>
[ ... ]

> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -0,0 +1,450 @@
> +/*
> + * cros_ec_sensors_core - Common function for Chrome OS EC sensor driver.
> + *
> + * Copyright (C) 2016 Google, Inc
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/platform_device.h>

Alphabetic oder.
