Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58116 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbbHHLvn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 07:51:43 -0400
Subject: Re: [PATCH 2/9] iio: Add inverse unit conversion macros
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
 <1438781901-28000-3-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C5ED4D.3000105@kernel.org>
Date: Sat, 8 Aug 2015 12:51:41 +0100
MIME-Version: 1.0
In-Reply-To: <1438781901-28000-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/08/15 14:38, Lars-Peter Clausen wrote:
> Add inverse unit conversion macro to convert from standard IIO units to
> units that might be used by some devices.
> 
> Those are useful in combination with scale factors that are specified as
> IIO_VAL_FRACTIONAL. Typically the denominator for those specifications will
> contain the maximum raw value the sensor will generate and the numerator
> the value it maps to in a specific unit. Sometimes datasheets specify those
> in different units than the standard IIO units (e.g. degree/s instead of
> rad/s) and so we need to do a unit conversion.
> 
> From a mathematical point of view it does not make a difference whether we
> apply the unit conversion to the numerator or the inverse unit conversion
> to the denominator since (x / y) / z = x / (y * z). But as the denominator
> is typically a larger value and we are rounding both the numerator and
> denominator to integer values using the later method gives us a better
> precision (E.g. the relative error is smaller if we round 8000.3 to 8000
> rather than rounding 8.3 to 8).
> 
> This is where in inverse unit conversion macros will be used.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied and marked for stable given the next patch.
> ---
>  include/linux/iio/iio.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index f791482..6bcc9537 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -645,6 +645,15 @@ int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
>  #define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) / 18000000ULL)
>  
>  /**
> + * IIO_RAD_TO_DEGREE() - Convert rad to degree
> + * @rad: A value in rad
> + *
> + * Returns the given value converted from rad to degree
> + */
> +#define IIO_RAD_TO_DEGREE(rad) \
> +	(((rad) * 18000000ULL + 314159ULL / 2) / 314159ULL)
> +
> +/**
>   * IIO_G_TO_M_S_2() - Convert g to meter / second**2
>   * @g: A value in g
>   *
> @@ -652,4 +661,12 @@ int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
>   */
>  #define IIO_G_TO_M_S_2(g) ((g) * 980665ULL / 100000ULL)
>  
> +/**
> + * IIO_M_S_2_TO_G() - Convert meter / second**2 to g
> + * @ms2: A value in meter / second**2
> + *
> + * Returns the given value converted from meter / second**2 to g
> + */
> +#define IIO_M_S_2_TO_G(ms2) (((ms2) * 100000ULL + 980665ULL / 2) / 980665ULL)
> +
>  #endif /* _INDUSTRIAL_IO_H_ */
> 

