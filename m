Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41318 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753517AbcK0LcO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 06:32:14 -0500
Subject: Re: [PATCH 2/2] iio: adis16203: Fix copyright year
To: Reto Schneider <reto@reto-schneider.ch>,
        linux-kernel@vger.kernel.org
References: <c828757d-55c2-7f28-c38a-1b20b733a408@reto-schneider.ch>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <aff20582-76be-67f6-52a8-f34504ea4593@kernel.org>
Date: Sun, 27 Nov 2016 11:32:12 +0000
MIME-Version: 1.0
In-Reply-To: <c828757d-55c2-7f28-c38a-1b20b733a408@reto-schneider.ch>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/11/16 00:42, Reto Schneider wrote:
> From: Reto Schneider <code@reto-schneider.ch>
> Date: Mon, 12 Oct 2015 01:44:51 +0200
> Subject: [PATCH 2/2] iio: adis16203: Fix copyright year
> 
> The copyright year can not be in the future.
> 
> Signed-off-by: Reto Schneider <code@reto-schneider.ch>
Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to play with them.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16203_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
> index f32c900..bd8119a 100644
> --- a/drivers/staging/iio/accel/adis16203_core.c
> +++ b/drivers/staging/iio/accel/adis16203_core.c
> @@ -1,7 +1,7 @@
>  /*
>   * ADIS16203 Programmable 360 Degrees Inclinometer
>   *
> - * Copyright 2030 Analog Devices Inc.
> + * Copyright 2010 Analog Devices Inc.
>   *
>   * Licensed under the GPL-2 or later.
>   */
> 

