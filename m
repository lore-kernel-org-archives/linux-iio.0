Return-Path: <knaack.h@gmx.de>
Message-ID: <55CBA8A6.7020404@gmx.de>
Date: Wed, 12 Aug 2015 22:12:22 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Markus Pargmann <mpa@pengutronix.de>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 01/20] regmap: Add missing comments about struct regmap_bus
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de> <1439374365-20623-2-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439374365-20623-2-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Markus Pargmann schrieb am 12.08.2015 um 12:12:
> There are some fields of this struct undocumented or old. This patch
> updates the missing comments.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  include/linux/regmap.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 59c55ea0f0b5..6ff83c9ddb45 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -296,8 +296,11 @@ typedef void (*regmap_hw_free_context)(void *context);
>   *                if not implemented  on a given device.
>   * @async_write: Write operation which completes asynchronously, optional and
>   *               must serialise with respect to non-async I/O.
> + * @reg_write: Write operation for a register. Writes value to register.
>   * @read: Read operation.  Data is returned in the buffer used to transmit
>   *         data.
> + * @reg_read: Read operation for a register. Reads a value from a register.
> + * @free_conetext: Free context.

Typo: free_context

>   * @async_alloc: Allocate a regmap_async() structure.
>   * @read_flag_mask: Mask to be set in the top byte of the register when doing
>   *                  a read.
> @@ -307,7 +310,6 @@ typedef void (*regmap_hw_free_context)(void *context);
>   * @val_format_endian_default: Default endianness for formatted register
>   *     values. Used when the regmap_config specifies DEFAULT. If this is
>   *     DEFAULT, BIG is assumed.
> - * @async_size: Size of struct used for async work.
>   */
>  struct regmap_bus {
>  	bool fast_io;
> 
