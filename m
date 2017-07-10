Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35109 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbdGJP0r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jul 2017 11:26:47 -0400
Date: Mon, 10 Jul 2017 10:26:40 -0500
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: lee.jones@linaro.org, benjamin.gaignard@linaro.org,
        jic23@kernel.org, thierry.reding@gmail.com, mark.rutland@arm.com,
        alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: mfd: Add STM32 LPTimer binding
Message-ID: <20170710152640.4llr46cxco5hld33@rob-hp-laptop>
References: <1499445068-7037-1-git-send-email-fabrice.gasnier@st.com>
 <1499445068-7037-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499445068-7037-2-git-send-email-fabrice.gasnier@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jul 07, 2017 at 06:31:00PM +0200, Fabrice Gasnier wrote:
> Add documentation for STMicroelectronics STM32 Low-Power Timer binding.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> Changes in v3:
> - Rob's comment on node name: timer@...
> 
> Changes in v2:
> - Lee's comments: s/Low Power/Low-Power/, remove 0x in example, improve
>   properties descriptions
> ---
>  .../devicetree/bindings/mfd/stm32-lptimer.txt      | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt

Acked-by: Rob Herring <robh@kernel.org>
