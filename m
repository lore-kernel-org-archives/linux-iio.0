Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbeKQDOh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 22:14:37 -0500
Date: Fri, 16 Nov 2018 17:01:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: add entry in MAINTAINERS file
Message-ID: <20181116170122.562677ec@archlinux>
In-Reply-To: <c0cc8171a7bde81b19ccb31d21be4cd9833f32cb.1542272678.git.lorenzo.bianconi@redhat.com>
References: <cover.1542272678.git.lorenzo.bianconi@redhat.com>
        <c0cc8171a7bde81b19ccb31d21be4cd9833f32cb.1542272678.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 15 Nov 2018 10:10:57 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Add entry for st_lsm6dsx imu driver in MAINTAINERS file
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Applied,

Thanks,

Jonathan

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c0951c9dc3c3..6689f6feb52d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13767,6 +13767,14 @@ M:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
>  S:	Maintained
>  F:	arch/alpha/kernel/srm_env.c
>  
> +ST LSM6DSx IMU IIO DRIVER
> +M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://www.st.com/
> +S:	Maintained
> +F:	drivers/iio/imu/st_lsm6dsx/
> +F:	Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +
>  ST STM32 I2C/SMBUS DRIVER
>  M:	Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>  L:	linux-i2c@vger.kernel.org
