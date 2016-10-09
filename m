Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39042 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753276AbcJIHqu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2016 03:46:50 -0400
Subject: Re: [PATCH v2] dt: bindings: vendor-prefix: Add 3 accelerometer
 vendor prefixes
To: Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20161006170650.13518-1-hdegoede@redhat.com>
Cc: devicetree <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2f68311d-5c65-0bc1-aea8-401a843ebfd0@kernel.org>
Date: Sun, 9 Oct 2016 08:37:47 +0100
MIME-Version: 1.0
In-Reply-To: <20161006170650.13518-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/10/16 18:06, Hans de Goede wrote:
> Recently the kernel has gotten support in the iio subsystem for a number
> of new accelerometers from mCube, Memsic and MiraMEMS.
> 
> This commit adds the vendor prefixes already used for these vendors
> in Documentation/devicetree/bindings/i2c/trivial-devices.txt to
> vendor-prefixes.txt.
> 
> The "full" company names were taken from the company's websites:
> http://www.mcubemems.com/
> http://www.memsic.com/
> http://www.miramems.com/en/
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Applied to the togreg branch of iio.git - initially pushed out as testing.
Thanks,

Jonathan
> ---
> Changes in v2:
> -Drop domintech, it is already in the iio/next tree
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 5c67e91..abe0129 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -157,13 +157,16 @@ lltc	Linear Technology Corporation
>  marvell	Marvell Technology Group Ltd.
>  maxim	Maxim Integrated Products
>  meas	Measurement Specialties
> +mcube	mCube
>  mediatek	MediaTek Inc.
>  melexis	Melexis N.V.
> +memsic	MEMSIC Inc.
>  merrii	Merrii Technology Co., Ltd.
>  micrel	Micrel Inc.
>  microchip	Microchip Technology Inc.
>  micron	Micron Technology Inc.
>  minix	MINIX Technology Ltd.
> +miramems	MiraMEMS Sensing Technology Co., Ltd.
>  mitsubishi	Mitsubishi Electric Corporation
>  mosaixtech	Mosaix Technologies, Inc.
>  moxa	Moxa
> 

