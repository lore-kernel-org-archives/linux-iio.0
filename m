Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:54228 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbdGXGGW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2017 02:06:22 -0400
MIME-Version: 1.0
In-Reply-To: <CAGb2v679W=Xzd1pio994Zu0PFmaF0VoUmw==_FfLnF0-DPLdBA@mail.gmail.com>
References: <20170723141354.42646-1-icenowy@aosc.io> <20170723141354.42646-2-icenowy@aosc.io>
 <CAGb2v679W=Xzd1pio994Zu0PFmaF0VoUmw==_FfLnF0-DPLdBA@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 24 Jul 2017 14:05:58 +0800
Message-ID: <CAGb2v65BPQzWN2awtemDKHWQ1_o2=WSFmZtLSA_ZgaAp6EuaMw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 1/5] dt-bindings: update the Allwinner
 GPADC device tree binding for H3
To: Chen-Yu Tsai <wens@csie.org>
Cc: Icenowy Zheng <icenowy@aosc.io>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 24, 2017 at 2:01 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Sun, Jul 23, 2017 at 10:13 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> Allwinner H3 features a thermal sensor like the one in A33, but has its
>> register re-arranged, the clock divider moved to CCU (originally the
>> clock divider is in ADC) and added a pair of bus clock and reset.
>>
>> Update the binding document to cover H3.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

One other thing. IIRC the new SoCs have ADC calibration data stored
somewhere in the e-fuses. Any chance you would use them, and need to
reference them in the device node?

ChenYu
