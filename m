Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42138 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbcH2RZA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 13:25:00 -0400
Subject: Re: [PATCH] iio: document bindings for mounting matrixes
To: Linus Walleij <linus.walleij@linaro.org>
References: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdY0gCLKD3rmiYuFgWSYOe6dtUaBeRi1ns-UFF=AspntFg@mail.gmail.com>
 <c8e83cf2-f9dc-0bc9-fcde-326b05ee290b@kernel.org>
 <57BD9EB6.1090504@parrot.com>
 <067a4882-c6f2-5994-e3ce-100e317ed121@kernel.org>
 <CACRpkda-Mz0wOAXx4uoZ43OCVw0U_E0+iCrboUO_7keYV2scBw@mail.gmail.com>
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ec3fb3a4-1f8e-1eae-e4b7-42f8eb16fe25@kernel.org>
Date: Mon, 29 Aug 2016 18:24:58 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkda-Mz0wOAXx4uoZ43OCVw0U_E0+iCrboUO_7keYV2scBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/08/16 23:04, Linus Walleij wrote:
> On Wed, Aug 24, 2016 at 11:29 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> Gregor:
>>> So I feel like we should keep away from any temptation to define the coordinates
>>> system too strictly.
>>> I also think of systems composed of multiple hardware parts with sensors
>>> scattered all over them. What would be the right "device/main hardware" reference
>>> frame definition in these cases ?
>>> As this is product specific, I feel like "device/main hardware" reference frame
>>> definition should be left to the "board/main hardware/device..." implementor's
>>> choice.
>>
>> Flexible is good, but I think we should define a base rule for the chips frame
>> of reference and fix up any that disagree (which is nasty ABI breakage :(
>> Trivial choice of either right handed or left handed frame might be all we
>> define in general.  Useful to define consistent frames for device types that
>> are common perhaps as well.  (such as the screen ones Linus has here).
> 
> Admittedly I come from the mobile phone industry.
> 
> So these frames of reference is not cooked up by me, I installed the
> Android app "Sensors test" to test two devices relative the world, so this
> is the frame of reference used by all mobile phones and tablets on the
> planet (I hardly think iPhone deviates).
> 
> I would be happy to write explicitly that for human interaction devices
> with screens that frame of reference should always be assumed, but for
> other uses and device types other frames of reference may apply, would
> you agree?
Absolutely.  The references Gregor gave might also be worth mentioning
as they provide pretty pictures etc ;)

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

