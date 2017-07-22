Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbdGVUX6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jul 2017 16:23:58 -0400
Date: Sat, 22 Jul 2017 21:23:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH v2 07/10] dt-bindings: iio: humidity: hts221: support
 active-low interrupts
Message-ID: <20170722212352.5149b4c1@kernel.org>
In-Reply-To: <20170717173905.8209-8-lorenzo.bianconi@st.com>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
        <20170717173905.8209-8-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Jul 2017 19:39:02 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Update hts221 device binding with active-low interrupts support
> (IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_EDGE_FALLING).
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/humidity/hts221.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/hts221.txt b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
> index b20ab9c12080..fca263e13400 100644
> --- a/Documentation/devicetree/bindings/iio/humidity/hts221.txt
> +++ b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
> @@ -7,7 +7,8 @@ Required properties:
>  Optional properties:
>  - interrupt-parent: should be the phandle for the interrupt controller
>  - interrupts: interrupt mapping for IRQ. It should be configured with
> -  flags IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING.
> +  flags IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
> +  IRQ_TYPE_EDGE_FALLING.
>  
>    Refer to interrupt-controller/interrupts.txt for generic interrupt
>    client node bindings.

