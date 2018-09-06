Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua1-f68.google.com ([209.85.222.68]:32889 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbeIGBrF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Sep 2018 21:47:05 -0400
Received: by mail-ua1-f68.google.com with SMTP id i4-v6so10300892uak.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Sep 2018 14:09:48 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id f60-v6sm834948uaf.10.2018.09.06.14.09.46
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:09:47 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id c12-v6so10282346uan.3
        for <linux-iio@vger.kernel.org>; Thu, 06 Sep 2018 14:09:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180906210454.247219-3-mka@chromium.org>
References: <20180906210454.247219-1-mka@chromium.org> <20180906210454.247219-3-mka@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 6 Sep 2018 14:09:44 -0700
Message-ID: <CAD=FV=XTbkfF0fTot_ebqD+ohbgQBYKVwHTZunuoxC7uGYN9Zw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: pm8998: Add adc node
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Thu, Sep 6, 2018 at 2:04 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> This adds the adc node to pm8998 based on the examples in the
> bindings. It also fixes the order of the included headers.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> --
> Changes in v2:
> - removed io-channel-ranges attribute
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
