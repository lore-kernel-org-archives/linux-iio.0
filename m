Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33094 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbcHYWLi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2016 18:11:38 -0400
Received: by mail-oi0-f44.google.com with SMTP id c15so86509087oig.0
        for <linux-iio@vger.kernel.org>; Thu, 25 Aug 2016 15:10:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <067a4882-c6f2-5994-e3ce-100e317ed121@kernel.org>
References: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdY0gCLKD3rmiYuFgWSYOe6dtUaBeRi1ns-UFF=AspntFg@mail.gmail.com>
 <c8e83cf2-f9dc-0bc9-fcde-326b05ee290b@kernel.org> <57BD9EB6.1090504@parrot.com>
 <067a4882-c6f2-5994-e3ce-100e317ed121@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 26 Aug 2016 00:04:45 +0200
Message-ID: <CACRpkda-Mz0wOAXx4uoZ43OCVw0U_E0+iCrboUO_7keYV2scBw@mail.gmail.com>
Subject: Re: [PATCH] iio: document bindings for mounting matrixes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Aug 24, 2016 at 11:29 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> Gregor:
>> So I feel like we should keep away from any temptation to define the coordinates
>> system too strictly.
>> I also think of systems composed of multiple hardware parts with sensors
>> scattered all over them. What would be the right "device/main hardware" reference
>> frame definition in these cases ?
>> As this is product specific, I feel like "device/main hardware" reference frame
>> definition should be left to the "board/main hardware/device..." implementor's
>> choice.
>
> Flexible is good, but I think we should define a base rule for the chips frame
> of reference and fix up any that disagree (which is nasty ABI breakage :(
> Trivial choice of either right handed or left handed frame might be all we
> define in general.  Useful to define consistent frames for device types that
> are common perhaps as well.  (such as the screen ones Linus has here).

Admittedly I come from the mobile phone industry.

So these frames of reference is not cooked up by me, I installed the
Android app "Sensors test" to test two devices relative the world, so this
is the frame of reference used by all mobile phones and tablets on the
planet (I hardly think iPhone deviates).

I would be happy to write explicitly that for human interaction devices
with screens that frame of reference should always be assumed, but for
other uses and device types other frames of reference may apply, would
you agree?

Yours,
Linus Walleij
