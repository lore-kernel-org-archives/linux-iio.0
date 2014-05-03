Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51404 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaECK5D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 06:57:03 -0400
Message-ID: <5364CBDC.9060702@kernel.org>
Date: Sat, 03 May 2014 11:58:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
CC: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH 4/4] iio: Fix spelling of illuminance in gp2ap020a00f
 driver
References: <1399046089-6616-1-git-send-email-pmeerw@pmeerw.net> <1399046089-6616-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046089-6616-5-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/14 16:54, Peter Meerwald wrote:
> Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks,

J
> ---
>   drivers/iio/light/gp2ap020a00f.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index 5ea4a03..04bdb85 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -5,13 +5,13 @@
>    * IIO features supported by the driver:
>    *
>    * Read-only raw channels:
> - *   - illiminance_clear [lux]
> - *   - illiminance_ir
> + *   - illuminance_clear [lux]
> + *   - illuminance_ir
>    *   - proximity
>    *
>    * Triggered buffer:
> - *   - illiminance_clear
> - *   - illiminance_ir
> + *   - illuminance_clear
> + *   - illuminance_ir
>    *   - proximity
>    *
>    * Events:
>

