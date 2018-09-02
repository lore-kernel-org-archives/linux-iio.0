Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:56264 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeICAuz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Sep 2018 20:50:55 -0400
Date: Sun, 2 Sep 2018 21:33:53 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: bh1750: switch to SPDX identifier
Message-ID: <20180902213353.1c21a78a@archlinux>
In-Reply-To: <20180901195144.11389-1-tduszyns@gmail.com>
References: <20180901195144.11389-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  1 Sep 2018 21:51:44 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Drop boilerplate license text and use SPDX identifier instead.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied.  Thanks,

Jonathan

> ---
>  drivers/iio/light/bh1750.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index a814828e69f5..493ca7420602 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ROHM BH1710/BH1715/BH1721/BH1750/BH1751 ambient light sensor driver
>   *
>   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   * Data sheets:
>   *  http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1710fvc-e.pdf
>   *  http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1715fvc-e.pdf
