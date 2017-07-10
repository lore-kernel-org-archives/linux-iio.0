Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36148 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932070AbdGJP1N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jul 2017 11:27:13 -0400
Date: Mon, 10 Jul 2017 10:27:11 -0500
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: lee.jones@linaro.org, benjamin.gaignard@linaro.org,
        jic23@kernel.org, thierry.reding@gmail.com, mark.rutland@arm.com,
        alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 5/9] dt-bindings: iio: Add STM32 LPTimer trigger
 binding
Message-ID: <20170710152711.wl6ujgy3lngtl42d@rob-hp-laptop>
References: <1499445068-7037-1-git-send-email-fabrice.gasnier@st.com>
 <1499445068-7037-6-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499445068-7037-6-git-send-email-fabrice.gasnier@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jul 07, 2017 at 06:31:04PM +0200, Fabrice Gasnier wrote:
> Add documentation for STMicroelectronics STM32 Low-Power Timer Trigger
> binding.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> Changes in v3:
> - Rob's comments: node name timer@..., update reg property
>   description
> 
> Changes in v2:
> - s/Low Power/Low-Power
> - remove leading 0x in example (parent node)
> - improve reg property description
> ---
>  .../bindings/iio/timer/stm32-lptimer-trigger.txt   | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt

Acked-by: Rob Herring <robh@kernel.org>
