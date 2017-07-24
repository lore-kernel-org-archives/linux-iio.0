Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:54294 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbdGXGPD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2017 02:15:03 -0400
MIME-Version: 1.0
In-Reply-To: <56900ea0ab9a28aea673d68097049354@aosc.io>
References: <20170723141354.42646-1-icenowy@aosc.io> <20170723141354.42646-3-icenowy@aosc.io>
 <CAGb2v65a3tyr5EJLgB9mhz2aYsU9NkMSg+wF_aJuhmT3tNpL2w@mail.gmail.com> <56900ea0ab9a28aea673d68097049354@aosc.io>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 24 Jul 2017 14:14:38 +0800
Message-ID: <CAGb2v64BzoDmEGcugtes6be7dkoMaz_0chbwREHHPCSz3PUWzw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 2/5] iio: adc: sun4i-gpadc-iio: rename
 A23/A33-specified registers to contain A23
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
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

On Mon, Jul 24, 2017 at 2:06 PM,  <icenowy@aosc.io> wrote:
> 在 2017-07-24 14:02，Chen-Yu Tsai 写道：
>>
>> On Sun, Jul 23, 2017 at 10:13 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>>>
>>> As the H3 SoC, which is also in sun8i line, has totally different
>>> register map for the thermal sensor (a cut down version of GPADC), we
>>> should rename A23/A33-specified registers to contain A23, in order to
>>> prevent obfuscation with H3 registers. Currently these registers are
>>> only prefixed "SUN8I", not "SUN8I_A23".
>>>
>>> Add "_A23" after "SUN8I" on the register names.
>>
>>
>> Nit: the compatible string as well as the initial driver targets the A33.
>> Naming the registers as such would be more consistent.
>
>
> But the registers are the same between A23 and A33.
>
> In fact the only difference between A23 and A33 is the formula's factors.

The goal here is to keep things consistent. Nothing in this driver as
it currently is mentions A23. Unless you plan on adding additional
commits to support the A23, and a note explaining the similarity
of the A23 and A33 ADCs, this is only going to confuse people.

ChenYu

>
>>
>> Otherwise,
>>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
