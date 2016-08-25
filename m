Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:33397 "EHLO mail.aswsp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757031AbcHYMYx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Aug 2016 08:24:53 -0400
Message-ID: <57BEE48B.5020408@parrot.com>
Date: Thu, 25 Aug 2016 14:28:59 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC: Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] iio: document bindings for mounting matrixes
References: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org> <CACRpkdY0gCLKD3rmiYuFgWSYOe6dtUaBeRi1ns-UFF=AspntFg@mail.gmail.com> <c8e83cf2-f9dc-0bc9-fcde-326b05ee290b@kernel.org> <57BD9EB6.1090504@parrot.com> <067a4882-c6f2-5994-e3ce-100e317ed121@kernel.org>
In-Reply-To: <067a4882-c6f2-5994-e3ce-100e317ed121@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 08/24/2016 11:29 PM, Jonathan Cameron wrote:

[snip...]

>>>> +
>>>> +The axes may also be flipped: for a screen you probably want (x) coordinates to
>>>> +go from negative on the left to positive on the right and (z) depth to be
>>>> +negative under the screen and positive in front of it, toward the face of the
>>>> +user.
>>> I'm not sure we don't want to define that it can't be flipped and enforce the
>>> correct coordinate system on the underlying drivers (fingers crossed they are
>>> currently all left or all right handed? - oops should have been keeping an eye on
>>> this).
>> As to coordinate system definition, multiple conventions seem to exist across
>> industries. For UAV, we use the one described here:
>> https://en.wikipedia.org/wiki/Flight_dynamics_(fixed-wing_aircraft)
>>
>> So I feel like we should keep away from any temptation to define the coordinates
>> system too strictly.
>> I also think of systems composed of multiple hardware parts with sensors
>> scattered all over them. What would be the right "device/main hardware" reference
>> frame definition in these cases ?
>> As this is product specific, I feel like "device/main hardware" reference frame
>> definition should be left to the "board/main hardware/device..." implementor's
>> choice.
> Flexible is good, but I think we should define a base rule for the chips frame
> of reference and fix up any that disagree (which is nasty ABI breakage :(
We might as well expose another property to userspace to indicate
coordinates system convention currently in use.
This seems overly complex to me but might ease portability across platforms
and products. I have no clear opinion on this.

Anyway, DT / BSP maintainer would always have the ability to customize
mounting matrix values on a per-product basis to fit their application
expectations.
E.g., from Parrot's UAVs perspective, flight control stack expects 
coordinates
system to be defined according to aeronautic convention (hardcoded).
Even if DT required a strict definition of coordinates system, this 
would implies
no changes to rotation matrix values currently set into our DTs...
> Trivial choice of either right handed or left handed frame might be all we
> define in general.  Useful to define consistent frames for device types that
> are common perhaps as well.  (such as the screen ones Linus has here).
It seems most common definition is what is described here:
https://www.w3.org/TR/2016/CR-orientation-event-20160818/
and here:
https://developer.android.com/guide/topics/sensors/sensors_overview.html#sensors-coords
given that Android devices represent a fair amount of phones and tablets 
in use.

Searched for IoT related things but no clear conventions came out...
And I can't think of PC world as a reference for this kind of stuff.

Yours,
Greg.
