Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35736 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbdC2AbH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2017 20:31:07 -0400
Date: Tue, 28 Mar 2017 19:31:05 -0500
From: Rob Herring <robh@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        lee.jones@linaro.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        thomas.petazzoni@free-electrons.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.xyz
Subject: Re: [PATCH v3 04/11] Documentation: DT: bindings: mfd: add A33 GPADC
 binding
Message-ID: <20170329003105.keybmgnknzgtywys@rob-hp-laptop>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-5-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170321153611.16228-5-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 21, 2017 at 04:36:04PM +0100, Quentin Schulz wrote:
> This patch adds documentation for the A33 GPADC binding.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> v3:
>   - fixed missing allwinner in front of compatible,
>   - updated compatible to allwinner,sun8i-a33-ths to better reflect the
>   datasheet's name,
>   - updated example's DT node name and label to ths,
> 
> added in v2
> 
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt

If you respin, "dt-bindings: mfd: ..." for the subject.

Acked-by: Rob Herring <robh@kernel.org>
