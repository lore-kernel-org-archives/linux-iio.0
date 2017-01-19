Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34384 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754415AbdASTQ6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 14:16:58 -0500
Date: Thu, 19 Jan 2017 13:16:50 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rama Krishna Phani A <rphani@codeaurora.org>
Subject: Re: [PATCH 1/3 v3] iio: adc: add device tree bindings for Qualcomm
 PM8xxx ADCs
Message-ID: <20170119191650.o3ghoysxkhrqw4gw@rob-hp-laptop>
References: <20170117142515.10578-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170117142515.10578-1-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jan 17, 2017 at 03:25:13PM +0100, Linus Walleij wrote:
> This adds the device tree bindings for the Qualcomm PM8xxx
> ADCs. This is based on the existing DT bindings for the
> SPMI ADC so there are hopefully no controversial features.
> 
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: Ivan T. Ivanov <iivanov.xz@gmail.com>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Rama Krishna Phani A <rphani@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Collapse the ratiometric property into one that enables and
>   selects a ratiometric reference in one go.
> - Use foo: adc-channel@X notation consequently
> - Document that the reference voltage is compulsory.
> ChangeLog v1->v2:
> - Spelling fixes
> ---
>  .../bindings/iio/adc/qcom,pm8xxx-xoadc.txt         | 149 +++++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt

Acked-by: Rob Herring <robh@kernel.org>
