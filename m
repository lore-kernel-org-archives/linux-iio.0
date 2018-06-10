Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753524AbeFJNkh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Jun 2018 09:40:37 -0400
Date: Sun, 10 Jun 2018 14:40:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Paolo Cretaro <paolocretaro@gmail.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 4/9] iio: cros_ec: Switch to SPDX identifier.
Message-ID: <20180610144031.57213b84@archlinux>
In-Reply-To: <20180605092209.22887-5-enric.balletbo@collabora.com>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
        <20180605092209.22887-5-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue,  5 Jun 2018 11:22:04 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
This code has seen quite a few contributors, I'd like at least
some of them to agree they are happy with this change.

There hasn't been much general resistance in general to SPDX
headers replacing text, but there has been some, so I've been
asking this for all the IIO related SPDX patches.

Thanks,

Jonathan

> ---
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c      | 23 ++++--------------
>  .../common/cros_ec_sensors/cros_ec_sensors.c  | 24 ++++++-------------
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 18 ++++----------
>  .../cros_ec_sensors/cros_ec_sensors_core.h    | 12 ++--------
>  drivers/iio/light/cros_ec_light_prox.c        | 18 ++++----------
>  drivers/iio/pressure/cros_ec_baro.c           | 18 ++++----------
>  6 files changed, 26 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 063e89eff791..e7350ddec328 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -1,21 +1,8 @@
> -/*
> - * Driver for older Chrome OS EC accelerometer
> - *
> - * Copyright 2017 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the memory mapper cros-ec interface to communicate
> - * with the Chrome OS EC about accelerometer data.
> - * Accelerometer access is presented through iio sysfs.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Driver for older Chrome OS EC accelerometer
> +//
> +// Copyright (C) 2017 Google, Inc.
> +// Author: Gwendal Grignou <gwendal@chromium.org>
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 705cb3e72663..3dbc90baf6bb 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -1,20 +1,10 @@
> -/*
> - * cros_ec_sensors - Driver for Chrome OS Embedded Controller sensors.
> - *
> - * Copyright (C) 2016 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the cros-ec interface to communicate with the Chrome OS
> - * EC about sensors data. Data access is presented through iio sysfs.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Driver for Chrome OS Embedded Controller sensors.
> +//
> +// Copyright (C) 2016 Google, Inc.
> +//
> +// This driver uses the cros-ec interface to communicate with the ChromeOS
> +// EC about sensors data. Data access is presented through iio sysfs.
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index a620eb5ce202..05221994197c 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -1,17 +1,7 @@
> -/*
> - * cros_ec_sensors_core - Common function for Chrome OS EC sensor driver.
> - *
> - * Copyright (C) 2016 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Common functions for ChromeOS EC sensor driver.
> +//
> +// Copyright (C) 2016 Google, Inc.
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> index 2edf68dc7336..a9935489030e 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> @@ -1,16 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * ChromeOS EC sensor hub
>   *
> - * Copyright (C) 2016 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> + * Copyright (C) 2016 Google, Inc.
>   */
>  
>  #ifndef __CROS_EC_SENSORS_CORE_H
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index 8e8a0e7f78d1..8635e1c18cd5 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -1,17 +1,7 @@
> -/*
> - * cros_ec_light_prox - Driver for light and prox sensors behing CrosEC.
> - *
> - * Copyright (C) 2017 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Driver for light and prox sensors behind ChromeOS EC.
> +//
> +// Copyright (C) 2017 Google, Inc.
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 4599fde4dd25..8e134d65d18d 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -1,17 +1,7 @@
> -/*
> - * cros_ec_baro - Driver for barometer sensor behind CrosEC.
> - *
> - * Copyright (C) 2017 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Driver for barometer sensor behind ChromeOS EC.
> +//
> +// Copyright (C) 2017 Google, Inc.
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>

