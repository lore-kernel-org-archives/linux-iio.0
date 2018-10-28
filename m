Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeJ2Din (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 23:38:43 -0400
Date: Sun, 28 Oct 2018 18:53:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kelly <martin@martingkelly.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: iio: magn: add LSM9DS1 bindings
Message-ID: <20181028185308.20edd4f3@archlinux>
In-Reply-To: <20181026023812.29720-4-martin@martingkelly.com>
References: <20181026023812.29720-1-martin@martingkelly.com>
        <20181026023812.29720-4-martin@martingkelly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 25 Oct 2018 19:38:12 -0700
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> Add DT binding documentation for the LSM9DS1 magnetometer driver.
> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
Given here isn't really an alternative way of doing this (or we
haven't come up with one yet) in the sensors that are basically multiple
chips in one package, I'll hope that Rob is happy with the new name
and apply it.   As I'm only pushing out for build tests today I can
revert or add his Reviewed-by as needed.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> index 6f626f73417e..07f1767c7ee6 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -67,6 +67,7 @@ Magnetometers:
>  - st,lsm303dlm-magn
>  - st,lis3mdl-magn
>  - st,lis2mdl
> +- st,lsm9ds1-magn
>  
>  Pressure sensors:
>  - st,lps001wp-press
