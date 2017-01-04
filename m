Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35683 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933517AbdADVgK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jan 2017 16:36:10 -0500
MIME-Version: 1.0
In-Reply-To: <2204d490-90bb-07a7-15fa-b05e1add76c9@gmail.com>
References: <20161230191800.2532-1-marek.vasut@gmail.com> <CAMuHMdX20kc8h4DiNLu0KwaA0FL6F-WXLnA3YXvu02VJTh_7fQ@mail.gmail.com>
 <f4bb8922-36dc-ff69-45fc-e1d9cba821ba@gmail.com> <CAMuHMdVgaAD5EaK0aMS3HEXUeNQaz_ZiwG4cTtpDMMma_YWBbg@mail.gmail.com>
 <2204d490-90bb-07a7-15fa-b05e1add76c9@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Jan 2017 22:36:08 +0100
Message-ID: <CAMuHMdXD6F7DzCFU6b8UGADkukKRYFhXeHpuEFYaS_qUuNZCOg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Add Renesas GyroADC driver
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-iio@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marek,

On Wed, Jan 4, 2017 at 10:19 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On 01/04/2017 09:36 PM, Geert Uytterhoeven wrote:
>> On Wed, Jan 4, 2017 at 3:27 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>> On 01/02/2017 11:01 AM, Geert Uytterhoeven wrote:
>>>> On Fri, Dec 30, 2016 at 8:18 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>>>>> @@ -0,0 +1,38 @@
>>>>> +* Renesas RCar GyroADC device driver
>>>>> +
>>>>> +Required properties:
>>>>> +- compatible:  Should be "renesas,rcar-gyroadc" for regular GyroADC or
>>>>> +               "renesas,rcar-gyroadc-r8a7792" for GyroADC without interrupt
>>>>
>>>> Please use "renesas,r8a7792-gyroadc" to match existing practices.
>>>
>>> Actually, that should probably be gyroadc-r8a7791 if we want to match
>>> the existing practice. Fixed.
>>
>> No, "renesas,r8a7791-gyroadc" ("<vendor>,<family>-<block>").
>
> So I guess scif is an exception then ? Example from r8a7791.dtsi :
>
>  616     compatible = "renesas,scifa-r8a7791",
>  617                  "renesas,rcar-gen2-scifa", "renesas,scifa";

SCIF follows the old deprecated scheme.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
