Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbeKLCe4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 21:34:56 -0500
Date: Sun, 11 Nov 2018 16:45:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 9/9] dt-bindings: iio: imu: st_lsm6dsx: add support
 to i2c pullup resistors
Message-ID: <20181111164552.6346392f@archlinux>
In-Reply-To: <97543627e6e0a26d7ea6b4daa160f10813c05335.1541945612.git.lorenzo.bianconi@redhat.com>
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
        <97543627e6e0a26d7ea6b4daa160f10813c05335.1541945612.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 11 Nov 2018 15:15:36 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
There seems to be some precedents in tree for this, so fair enough.
It's one of those things that almost seems worth standardising, but
it's not totally apparent where it would be done as it can apply
to any bus or gpio.

Anyhow, applied this as is (Rob / Mark input of course welcome) to
my togreg branch which will be pushed out in a few mins as testing
for the autobuilders to play with it.

Thanks,

Jonathan
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
>  - drive-open-drain: the interrupt/data ready line will be configured
>    as open drain, which is useful if several sensors share the same
>    interrupt line. This is a boolean property.
