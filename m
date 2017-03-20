Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34277 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbdCTPJa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 11:09:30 -0400
Date: Mon, 20 Mar 2017 10:09:06 -0500
From: Rob Herring <robh@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        lee.jones@linaro.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        stefan.mavrodiev@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com,
        thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH v2 06/11] Documentation: DT: bindings: input:
 touschcreen: remove sun4i documentation
Message-ID: <20170320150906.piixax6ejrpm6ljv@rob-hp-laptop>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
 <20170310103921.19469-7-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170310103921.19469-7-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 10, 2017 at 11:39:16AM +0100, Quentin Schulz wrote:
> This patch removes the sun4i touchscreen controller binding
> documentation since it has been merged with the sun4i GPADC binding
> documentation.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> added in v2
> 
>  .../bindings/input/touchscreen/sun4i.txt           | 38 ----------------------
>  1 file changed, 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/sun4i.txt

Acked-by: Rob Herring <robh@kernel.org>
