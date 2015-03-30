Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:33643 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbbC3E4E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2015 00:56:04 -0400
Received: by qcbjx9 with SMTP id jx9so61758365qcb.0
        for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2015 21:56:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5516B4AB.1090805@kernel.org>
References: <1427503398-19682-1-git-send-email-abrestic@chromium.org>
	<5516B4AB.1090805@kernel.org>
Date: Sun, 29 Mar 2015 21:56:03 -0700
Message-ID: <CAL1qeaHOORmp9+WUeq3ZkRp_wTKzR4L+fArgW7i3_H1XXD2e+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: Add binding document for a generic ADC keypad
From: Andrew Bresticker <abrestic@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Mar 28, 2015 at 7:03 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 28/03/15 00:43, Andrew Bresticker wrote:
>> Add a binding document for a generic ADC keypad.  Buttons on an ADC
>> keypad are connected in a resistor ladder to an ADC.  The binding
>> describes the mapping of ADC channel and voltage ranges to buttons.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> Cc: Kumar Gala <galak@codeaurora.org>
>
> Just thinking about this, what options do we have for how such a keypad might
> be wired.  The interesting cases are the more than one key at a time ones.
>
> If that happens, then we end up with a voltage that should allow us to
> work out which combination of keys is pressed.
>
> http://en.wikipedia.org/wiki/Resistor_ladder
>
> The binding as it stands only works for single keys being pressed at a time
> (I think!)

Right.  The binding was meant for the simplest resistor ladder case,
something like http://linksprite.com/wiki/images/d/d2/Lcd-button-ladder.png
where only a single button press can be detected.  It will also work
with the more complex resistor ladders, but will only be able to
detect if a single button is pressed.

> Do we want to make it flexible enough to cope with multiple keys?
> I guess we'd need to model the common resistor ladder forms and provide
> a way of specifying the different setups in the device tree.

Given that the hardware I'm dealing with doesn't support this, I'd
prefer to leave it as a possible future extension :).  That said, one
way to do this would be to specify a table mapping the possible
combinations to voltages in the DT, though that table would grow
exponentially.  Another way would be to describe the circuit (R-2R,
logarithmic, etc.) with resistor values in the DT and then have the
driver do the math.

Thanks,
Andrew
