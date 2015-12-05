Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33778 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbbLER3L (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Dec 2015 12:29:11 -0500
Subject: Re: [PATCH] iio: st_accel_core: Remove unneeded define
To: Robert Kmiec <robert.r.kmiec@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, denis.ciocca@st.com,
	linus.walleij@linaro.org, giuseppe.barba@st.com,
	alban.bedel@avionic-design.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1449186888-22070-1-git-send-email-robert.r.kmiec@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56631EE4.7080002@kernel.org>
Date: Sat, 5 Dec 2015 17:29:08 +0000
MIME-Version: 1.0
In-Reply-To: <1449186888-22070-1-git-send-email-robert.r.kmiec@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/12/15 23:54, Robert Kmiec wrote:
> Definition of ST_SENSORS_WAI_ADDRESS was introduced within a very
> first commit of this driver, but it was never used.
> This address is already defined as ST_SENSORS_DEFAULT_WAI_ADDRESS
> in include/linux/iio/common/st_sensors.h
> 
> To avoid duplication of the same constant in two different places
> called almost exactly the same, the one which was never used
> should be removed.
> 
> Signed-off-by: Robert Kmiec <robert.r.kmiec@gmail.com>
Fair enough.

Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 25258e2..8447c31 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -18,9 +18,6 @@
>  #include <asm/unaligned.h>
>  #include <linux/iio/common/st_sensors.h>
>  
> -
> -#define ST_SENSORS_WAI_ADDRESS		0x0f
> -
>  static inline u32 st_sensors_get_unaligned_le24(const u8 *p)
>  {
>  	return (s32)((p[0] | p[1] << 8 | p[2] << 16) << 8) >> 8;
> 

