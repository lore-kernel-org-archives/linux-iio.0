Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbeKLAMt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 19:12:49 -0500
Date: Sun, 11 Nov 2018 14:24:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Song Qiang <songqiang1304521@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, preid@electromag.com.au,
        himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: Add PNI to the vendor prefixes
Message-ID: <20181111142402.1c522a78@archlinux>
In-Reply-To: <20181108092749.12167-2-songqiang1304521@gmail.com>
References: <20181108092749.12167-1-songqiang1304521@gmail.com>
        <20181108092749.12167-2-songqiang1304521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  8 Nov 2018 17:27:47 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
Applied with some fuzz as plx has gone away it seems.

Jonathan

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4b1a2a8fcc16..adcdf60124dd 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -303,6 +303,7 @@ pixcir  PIXCIR MICROELECTRONICS Co., Ltd
>  plathome	Plat'Home Co., Ltd.
>  plda	PLDA
>  plx	Broadcom Corporation (formerly PLX Technology)
> +pni     PNI Sensor Corporation
>  portwell	Portwell Inc.
>  poslab	Poslab Technology Co., Ltd.
>  powervr	PowerVR (deprecated, use img)
