Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbeICAtb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Sep 2018 20:49:31 -0400
Date: Sun, 2 Sep 2018 21:32:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] dt-bindings: iio: imu: st_lsm6dsx: add LSM6DSO
 device bindings
Message-ID: <20180902213229.0a199f3e@archlinux>
In-Reply-To: <20180830205259.7029-6-lorenzo.bianconi@redhat.com>
References: <20180830205259.7029-6-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 30 Aug 2018 22:52:59 +0200
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

Applied.  Thanks.
> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index ef8a8566c63f..858a2898908a 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -7,6 +7,7 @@ Required properties:
>    "st,lsm6dsl"
>    "st,lsm6dsm"
>    "st,ism330dlc"
> +  "st,lsm6dso"
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:
