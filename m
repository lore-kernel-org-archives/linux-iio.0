Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55763 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486AbbILJrO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Sep 2015 05:47:14 -0400
Subject: Re: [PATCH 4/6] Staging: iio: cdc: Prefer using the BIT macro
To: Shraddha Barke <shraddha.6596@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Andreas Dilger <andreas.dilger@intel.com>
References: <1441902761-11190-1-git-send-email-shraddha.6596@gmail.com>
Cc: Ian Abbott <abbotti@mev.co.uk>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55F3F49D.9000201@kernel.org>
Date: Sat, 12 Sep 2015 10:47:09 +0100
MIME-Version: 1.0
In-Reply-To: <1441902761-11190-1-git-send-email-shraddha.6596@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/09/15 17:32, Shraddha Barke wrote:
> This patch replaces bit shifting on 1 with the BIT(x) macro
> 
> This was done with coccinelle:
> @@ int g; @@
> 
> -(1 << g)
> +BIT(g)
> 
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
Something odd happened here as this is only a small proportion of the cases
that should be updated in this file.  There's one at the bottom of the
patch for starters!

This driver also uses  a lot of cases of 0 shifted to represent
the opposite state for a given bit in the register.  The effective
documentation provided by that is lost if we convert the bit set ones
over like this.  Might seem odd, but perhaps we need a ZERO(X) macro
as well (which is of course always 0) to cover that approach.

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7746.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index e6e9eaa..10fa372 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -46,10 +46,10 @@
>  #define AD7746_REG_VOLT_GAINL		18
>  
>  /* Status Register Bit Designations (AD7746_REG_STATUS) */
> -#define AD7746_STATUS_EXCERR		(1 << 3)
> -#define AD7746_STATUS_RDY		(1 << 2)
> -#define AD7746_STATUS_RDYVT		(1 << 1)
> -#define AD7746_STATUS_RDYCAP		(1 << 0)
> +#define AD7746_STATUS_EXCERR		BIT(3)
> +#define AD7746_STATUS_RDY		BIT(2)
> +#define AD7746_STATUS_RDYVT		BIT(1)
> +#define AD7746_STATUS_RDYCAP		BIT(0)
>  
>  /* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
>  #define AD7746_CAPSETUP_CAPEN		(1 << 7)
> 

