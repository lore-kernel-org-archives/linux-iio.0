Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbeEFSAA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 May 2018 14:00:00 -0400
Date: Sun, 6 May 2018 18:59:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        drew.paterson@ams.com
Subject: Re: [PATCH v2 01/11] staging: iio: tsl2x7x: use GPL-2.0+ SPDX
 license identifier
Message-ID: <20180506185954.7367ef59@archlinux>
In-Reply-To: <20180504025319.28953-2-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
        <20180504025319.28953-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  3 May 2018 22:53:09 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The summary text for the GPL is not needed since the SPDX identifier
> is a legally binding shorthand that can be used instead.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
I'm always less than totally keen on these patches not coming from the
copyright holder, but is is probably fine.  If taos is unhappy we
can always switch back again.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to ignore it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 11 +----------
>  drivers/staging/iio/light/tsl2x7x.h | 15 +--------------
>  2 files changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index e65621948cf8..01bff4593640 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1,19 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Device driver for monitoring ambient light intensity in (lux) and proximity
>   * detection (prox) within the TAOS TSL2X7X family of devices.
>   *
>   * Copyright (c) 2012, TAOS Corporation.
>   * Copyright (c) 2017-2018 Brian Masney <masneyb@onstation.org>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
>   */
>  
>  #include <linux/delay.h>
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index 91ce8f98982e..8eb7f4749ea7 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -1,22 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * Device driver for monitoring ambient light intensity (lux)
>   * and proximity (prox) within the TAOS TSL2X7X family of devices.
>   *
>   * Copyright (c) 2012, TAOS Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write to the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA	02110-1301, USA.
>   */
>  
>  #ifndef __TSL2X7X_H

