Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40693 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJDXkm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Oct 2018 19:40:42 -0400
Received: by mail-vs1-f66.google.com with SMTP id z130-v6so5775243vsc.7
        for <linux-iio@vger.kernel.org>; Thu, 04 Oct 2018 09:46:36 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id v85-v6sm377007vkd.18.2018.10.04.09.46.35
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 09:46:35 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id s197-v6so2307780vkf.10
        for <linux-iio@vger.kernel.org>; Thu, 04 Oct 2018 09:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181004001432.21218-1-mka@chromium.org> <20181004001432.21218-3-mka@chromium.org>
In-Reply-To: <20181004001432.21218-3-mka@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 4 Oct 2018 09:46:23 -0700
Message-ID: <CAD=FV=U0k2L4aqJeges-u-CSF6VwnU1h0kfR3GCv7BgU95gOcQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: pm8998: Add die temperature
 channel node to the ADC
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,
On Wed, Oct 3, 2018 at 5:14 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add a channel node for the die temperature to the ADC.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v4:
> - added unit address to 'die-temp' node

This probably should have been "changes in v5"

> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 048f19fa0150..32b141637d13 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -75,6 +75,11 @@
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         #io-channel-cells = <1>;
> +
> +                       die-temp@ADC5_DIE_TEMP {
> +                               reg = <ADC5_DIE_TEMP>;

Thanks for adding the unit address.  Note to Andy that this ought to
go into the queue for 4.20 since you'll have the ADC5_DIE_TEMP then.


-Doug
