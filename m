Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964938AbdKRPxX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Nov 2017 10:53:23 -0500
Date: Sat, 18 Nov 2017 15:53:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kepplinger <martink@posteo.de>
Cc: harinath922@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: mma8452: replace license description with SPDX
 specifier
Message-ID: <20171118155318.6a1f3b3f@archlinux>
In-Reply-To: <20171118091011.9061-1-martink@posteo.de>
References: <20171118091011.9061-1-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 18 Nov 2017 10:10:11 +0100
Martin Kepplinger <martink@posteo.de> wrote:

> This replaces the custom license information text with the appropriate
> SPDX identifier. While the information here stays the same, it is easier
> to read.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>

I'm not 100% sure the intent of the SPDX work is to remove
existing licence text.  So far the big sets have only been
adding tags to files missing their licenses entirely...

Anyone found any specific guidance on this?

Jonathan
> ---
> 
> Sorry I had forgotten to add the mailing lists and got Peter's Ack
> privately. -.-  But thanks Peter for the quick response!
> 
> Again, an Acked-by from Harinath would be good here too.
> 
> thanks
> 
>                              martin
> 
> revision history
> ----------------
> v2: adds Peter's Acked-by and adds all mailing lists to CC
> 
> 
>  drivers/iio/accel/mma8452.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index bfd4bc806fc2..62c0d4646c16 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * mma8452.c - Support for following Freescale / NXP 3-axis accelerometers:
>   *
> @@ -13,9 +14,6 @@
>   * Copyright 2015 Martin Kepplinger <martink@posteo.de>
>   * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
>   *
> - * This file is subject to the terms and conditions of version 2 of
> - * the GNU General Public License.  See the file COPYING in the main
> - * directory of this archive for more details.
>   *
>   * TODO: orientation events
>   */

