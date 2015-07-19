Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46570 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbbGSL2N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 07:28:13 -0400
Message-ID: <55AB89CC.4070409@kernel.org>
Date: Sun, 19 Jul 2015 12:28:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>,
	=?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>
Subject: Re: [PATCH 1/1] iio: mlx90614: Added copyright notice
References: <CAKv63usOmHqmaFp1GyPGau+5et1C=+BEYP0T33PpwCtNqkWudg@mail.gmail.com>
In-Reply-To: <CAKv63usOmHqmaFp1GyPGau+5et1C=+BEYP0T33PpwCtNqkWudg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/15 15:44, Crt Mori wrote:
> Added copyright notice.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com <mailto:cmo@melexis.com>>
Bonus > on the line above.

I'd also like an Ack for this from at least one of the existing listed authors.
The changes you have in tree so far have been very minor so adding you as
an explicit author is pushing it a little.  Now if this is because you are
agreeing to responsibility for the driver with the agreement of Peter in particular
than that's fine with me.

Jonathan
> --- 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index d767d2f..102ffd6 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net <mailto:pmeerw@pmeerw.net>>
>   * Copyright (c) 2015 Essensium NV
> + * Copyright (c) 2015 Melexis
>   *
>   * This file is subject to the terms and conditions of version 2 of
>   * the GNU General Public License.  See the file COPYING in the main
> @@ -667,5 +668,6 @@ module_i2c_driver(mlx90614_driver);
>  
>  MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net <mailto:pmeerw@pmeerw.net>>");
>  MODULE_AUTHOR("Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com <mailto:vianney.leclement@essensium.com>>");
> +MODULE_AUTHOR("Crt Mori <cmo@melexis.com <mailto:cmo@melexis.com>>");
>  MODULE_DESCRIPTION("Melexis MLX90614 contactless IR temperature sensor driver");
>  MODULE_LICENSE("GPL");
> -- 

