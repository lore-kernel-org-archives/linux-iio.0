Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37288 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034994AbdEAAFw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 20:05:52 -0400
Subject: Re: [PATCH 3/5] iio: ade7754: Convert symbolic permissions to octal
To: Quentin Swain <dudebrobro179@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        apw@canonical.com, joe@perches.com
References: <20170430231702.377-1-dudebrobro179@gmail.com>
 <20170430231702.377-4-dudebrobro179@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <72f5e641-a326-0c1d-83b9-6961ee315197@kernel.org>
Date: Mon, 1 May 2017 01:05:48 +0100
MIME-Version: 1.0
In-Reply-To: <20170430231702.377-4-dudebrobro179@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/05/17 00:17, Quentin Swain wrote:
> Convert symbolic S_IRUGO and S_IWUSR macros to octal permissions
> to resolve warnings reported by checkpatch.pl
> 
> Signed-off-by: Quentin Swain <dudebrobro179@gmail.com>
Applied.
> ---
>  drivers/staging/iio/meter/ade7754.c | 56 ++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> index 32dc503..be0df3f 100644
> --- a/drivers/staging/iio/meter/ade7754.c
> +++ b/drivers/staging/iio/meter/ade7754.c
> @@ -316,111 +316,111 @@ static IIO_DEV_ATTR_AENERGY(ade7754_read_24bit, ADE7754_AENERGY);
>  static IIO_DEV_ATTR_LAENERGY(ade7754_read_24bit, ADE7754_LAENERGY);
>  static IIO_DEV_ATTR_VAENERGY(ade7754_read_24bit, ADE7754_VAENERGY);
>  static IIO_DEV_ATTR_LVAENERGY(ade7754_read_24bit, ADE7754_LVAENERGY);
> -static IIO_DEV_ATTR_VPEAK(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_VPEAK(0644,
>  		ade7754_read_8bit,
>  		ade7754_write_8bit,
>  		ADE7754_VPEAK);
> -static IIO_DEV_ATTR_IPEAK(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_IPEAK(0644,
>  		ade7754_read_8bit,
>  		ade7754_write_8bit,
>  		ADE7754_VPEAK);
> -static IIO_DEV_ATTR_APHCAL(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_APHCAL(0644,
>  		ade7754_read_8bit,
>  		ade7754_write_8bit,
>  		ADE7754_APHCAL);
> -static IIO_DEV_ATTR_BPHCAL(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_BPHCAL(0644,
>  		ade7754_read_8bit,
>  		ade7754_write_8bit,
>  		ADE7754_BPHCAL);
> -static IIO_DEV_ATTR_CPHCAL(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_CPHCAL(0644,
>  		ade7754_read_8bit,
>  		ade7754_write_8bit,
>  		ADE7754_CPHCAL);
> -static IIO_DEV_ATTR_AAPOS(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_AAPOS(0644,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_AAPOS);
> -static IIO_DEV_ATTR_BAPOS(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_BAPOS(0644,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_BAPOS);
> -static IIO_DEV_ATTR_CAPOS(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_CAPOS(0644,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_CAPOS);
> -static IIO_DEV_ATTR_WDIV(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_WDIV(0644,
>  		ade7754_read_8bit,
>  		ade7754_write_8bit,
>  		ADE7754_WDIV);
> -static IIO_DEV_ATTR_VADIV(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_VADIV(0644,
>  		ade7754_read_8bit,
>  		ade7754_write_8bit,
>  		ADE7754_VADIV);
> -static IIO_DEV_ATTR_CFNUM(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_CFNUM(0644,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_CFNUM);
> -static IIO_DEV_ATTR_CFDEN(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_CFDEN(0644,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_CFDEN);
> -static IIO_DEV_ATTR_ACTIVE_POWER_A_GAIN(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_ACTIVE_POWER_A_GAIN(0644,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_AAPGAIN);
> -static IIO_DEV_ATTR_ACTIVE_POWER_B_GAIN(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_ACTIVE_POWER_B_GAIN(0644,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_BAPGAIN);
> -static IIO_DEV_ATTR_ACTIVE_POWER_C_GAIN(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_ACTIVE_POWER_C_GAIN(0644,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_CAPGAIN);
> -static IIO_DEV_ATTR_AIRMS(S_IRUGO,
> +static IIO_DEV_ATTR_AIRMS(0444,
>  		ade7754_read_24bit,
>  		NULL,
>  		ADE7754_AIRMS);
> -static IIO_DEV_ATTR_BIRMS(S_IRUGO,
> +static IIO_DEV_ATTR_BIRMS(0444,
>  		ade7754_read_24bit,
>  		NULL,
>  		ADE7754_BIRMS);
> -static IIO_DEV_ATTR_CIRMS(S_IRUGO,
> +static IIO_DEV_ATTR_CIRMS(0444,
>  		ade7754_read_24bit,
>  		NULL,
>  		ADE7754_CIRMS);
> -static IIO_DEV_ATTR_AVRMS(S_IRUGO,
> +static IIO_DEV_ATTR_AVRMS(0444,
>  		ade7754_read_24bit,
>  		NULL,
>  		ADE7754_AVRMS);
> -static IIO_DEV_ATTR_BVRMS(S_IRUGO,
> +static IIO_DEV_ATTR_BVRMS(0444,
>  		ade7754_read_24bit,
>  		NULL,
>  		ADE7754_BVRMS);
> -static IIO_DEV_ATTR_CVRMS(S_IRUGO,
> +static IIO_DEV_ATTR_CVRMS(0444,
>  		ade7754_read_24bit,
>  		NULL,
>  		ADE7754_CVRMS);
> -static IIO_DEV_ATTR_AIRMSOS(S_IRUGO,
> +static IIO_DEV_ATTR_AIRMSOS(0444,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_AIRMSOS);
> -static IIO_DEV_ATTR_BIRMSOS(S_IRUGO,
> +static IIO_DEV_ATTR_BIRMSOS(0444,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_BIRMSOS);
> -static IIO_DEV_ATTR_CIRMSOS(S_IRUGO,
> +static IIO_DEV_ATTR_CIRMSOS(0444,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_CIRMSOS);
> -static IIO_DEV_ATTR_AVRMSOS(S_IRUGO,
> +static IIO_DEV_ATTR_AVRMSOS(0444,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_AVRMSOS);
> -static IIO_DEV_ATTR_BVRMSOS(S_IRUGO,
> +static IIO_DEV_ATTR_BVRMSOS(0444,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_BVRMSOS);
> -static IIO_DEV_ATTR_CVRMSOS(S_IRUGO,
> +static IIO_DEV_ATTR_CVRMSOS(0444,
>  		ade7754_read_16bit,
>  		ade7754_write_16bit,
>  		ADE7754_CVRMSOS);
> @@ -549,7 +549,7 @@ static IIO_DEV_ATTR_TEMP_RAW(ade7754_read_8bit);
>  static IIO_CONST_ATTR(in_temp_offset, "129 C");
>  static IIO_CONST_ATTR(in_temp_scale, "4 C");
>  
> -static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_SAMP_FREQ(0644,
>  		ade7754_read_frequency,
>  		ade7754_write_frequency);
>  
> 

