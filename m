Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752334AbeDHQ3o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Apr 2018 12:29:44 -0400
Date: Sun, 8 Apr 2018 17:29:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: dt: iio: imu: st_lsm6dsx: add
 ism330dlc sensor device binding
Message-ID: <20180408172939.7af3c984@archlinux>
In-Reply-To: <20180330203351.22681-3-lorenzo.bianconi@redhat.com>
References: <20180330203351.22681-3-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 30 Mar 2018 22:33:51 +0200
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
applied to the togreg branch of iio.git and pushed out as testint.

Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index 1ff1af799c76..ef8a8566c63f 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -6,6 +6,7 @@ Required properties:
>    "st,lsm6ds3h"
>    "st,lsm6dsl"
>    "st,lsm6dsm"
> +  "st,ism330dlc"
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:

