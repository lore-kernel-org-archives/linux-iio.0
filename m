Return-Path: <SRS0=iXHn=N4=gmail.com=robherring2@kernel.org>
Date: Sat, 17 Nov 2018 09:37:54 -0600
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 9/9] dt-bindings: iio: imu: st_lsm6dsx: add support to
 i2c pullup resistors
Message-ID: <20181117153754.GA23006@bogus>
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
 <97543627e6e0a26d7ea6b4daa160f10813c05335.1541945612.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <97543627e6e0a26d7ea6b4daa160f10813c05335.1541945612.git.lorenzo.bianconi@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Nov 11, 2018 at 03:15:36PM +0100, Lorenzo Bianconi wrote:
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index 879322ad50fd..69d53d98d0f0 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -13,6 +13,7 @@ Required properties:
>  Optional properties:
>  - st,drdy-int-pin: the pin on the package that will be used to signal
>    "data ready" (valid values: 1 or 2).
> +- st,pullups : enable/disable internal i2c controller pullup resistors.

bias-pull-up is the standard property for this.

>  - drive-open-drain: the interrupt/data ready line will be configured
>    as open drain, which is useful if several sensors share the same
>    interrupt line. This is a boolean property.
> -- 
> 2.19.1
> 
