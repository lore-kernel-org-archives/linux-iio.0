Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33699 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754062AbeGEVNe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jul 2018 17:13:34 -0400
Date: Thu, 5 Jul 2018 15:13:31 -0600
From: Rob Herring <robh@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 09/10] dt-bindings: counter: Adjust dt-bindings for
 STM32 lptimer move
Message-ID: <20180705211331.GA2404@rob-hp-laptop>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <4bf9f5233a46e0dc195c27be19b76687448c17ff.1529607879.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4bf9f5233a46e0dc195c27be19b76687448c17ff.1529607879.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jun 21, 2018 at 05:08:57PM -0400, William Breathitt Gray wrote:
> From: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> The STM32 LP Timer counter driver now resides under the Counter
> subsystem. This patch adjusts dt-bindings to account for the STM32
> lptimer driver move.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  .../devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt | 0
>  Documentation/devicetree/bindings/mfd/stm32-lptimer.txt         | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)

Acked-by: Rob Herring <robh@kernel.org> 
