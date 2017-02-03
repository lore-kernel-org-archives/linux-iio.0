Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0116.outbound.protection.outlook.com ([104.47.0.116]:58783
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752625AbdBCI0D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Feb 2017 03:26:03 -0500
Subject: Re: [PATCH v8 07/12] dt-bindings: i2c: i2c-mux-simple: document
 i2c-mux-simple bindings
To: Rob Herring <robh@kernel.org>
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
 <1484755035-25927-8-git-send-email-peda@axentia.se>
 <20170127193917.6xuunrkjkqh4f2v7@rob-hp-laptop>
 <835415bf-77af-6131-d018-d0bc7d8233b0@axentia.se>
 <CAL_JsqLVrzm4BEv3kpOGRoaRq+cqvSm+A6weZfU8H8i9dc=tcA@mail.gmail.com>
 <cdc958c3-2496-be52-6407-bf9aefdfa965@axentia.se>
 <CAL_JsqLCdM5s8FYqys-m5wpr4QeeE-rQaRXCt+rjQz3qm+E2qA@mail.gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <5dc05e28-45c7-1dfe-3cd2-53e55490b48a@axentia.se>
Date: Fri, 3 Feb 2017 09:25:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLCdM5s8FYqys-m5wpr4QeeE-rQaRXCt+rjQz3qm+E2qA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-02-02 17:08, Rob Herring wrote:
> On Tue, Jan 31, 2017 at 1:36 AM, Peter Rosin <peda@axentia.se> wrote:
>> If you see this new driver as something that is superseding the existing
>> i2c-mux-gpio driver, I'm sad to inform you that the code is not simply
>> not there. i2c-mux-gpio has acpi support and users may provide platform
>> data from code. The existing i2c-mux-gpio driver also has the below
>> mentioned locking heuristic. Adding all those things to the new driver
>> would make it big and unwieldy and having even more unwanted tentacles
>> into other subsystems. And why should it be only i2c-mux-gpio that is
>> merged into this new i2c-mux driver? Why not implement a mux-pinctrl
>> driver for the new mux subsustem and then merge i2c-mux-pinctrl as well?
>> I say no, that way lies madness.
> 
> Sounds like a good idea to me. I'm not saying you need to merge any of
> them right now though (that's Wolfram's call).

If we're pedantic I probably have some stake in it too, being the i2c-mux
maintainer and all. But, agreed, I arrived quite late to the Linux kernel
party and my opinion might perhaps not carry all that much weight...

> None of this has anything to do with the binding though. Compatible
> strings should be specific. That's not up for debate. Whether the

Ok, I'm going to focus on the compatible string for a minute and leave
the implementation details for some other discussion.

> driver bound to a compatible string is common or specific to that
> compatible string is completely up to the OS. That decision can change
> over time, but the binding should not.

So, there's the existing compatible "i2c-mux-gpio" ("i2c-gpio-mux" is
wrong) that you seem to suggest is what I should stick to. I object to
that.

As you say, the bindings and compatible strings should describe hardware,
and you also state they should be specific. I agree. But, why are you
then apparently suggesting (by implication) that for this (hypothetical)
hardware...

    .----.
    |SDA0|-----------.
    |SCL0|---------. |
    |    |         | |
    |    |      .-------.
    |    |      |adg792a|
    |    |      |       |
    |ADC0|------|D1  S1A|---- signal A
    |    |      |    S1B|---- signal B
    |    |      |    S1C|---- signal C
    |    |      |    S1D|---- signal D
    |    |      |       |
    |SDA1|---+--|D2  S2A|---- i2s segment foo A
    |SCL1|-. |  |    S2B|---- i2s segment foo B
    '----' | |  |    S2C|---- i2s segment foo C
           | |  |    S2D|---- i2s segment foo D
           | |  |       |
           | '--|D3  S3A|---- i2s segment bar A
           |    |    S3B|---- i2s segment bar B
           |    |    S3C|---- i2s segment bar C
           |    |    S3D|---- i2s segment bar D
           |    '-------'
           |                  A B C D   A B C D  (feed SCL1 to each of
           |                  | | | |   | | | |   the 8 muxed segments)
           '------------------+-+-+-+---+-+-+-'

...the devicetree should be like below?

&i2c0 {
	mux: mux-controller@50 {
		compatible = "adi,adg792a";
		reg = <0x50>;
		#mux-control-cells = <1>;
	};
};

adc-mux {
	compatible = "io-channel-mux";
	io-channels = <&adc 0>;
	io-channel-names = "parent";

	mux-controls = <&mux 0>;

	...
};

i2c-mux-foo {
	compatible = "i2c-mux-gpio";
	i2c-parent = <&i2c1>;

	mux-controls = <&mux 1>;

	...
};

i2c-mux-bar {
	compatible = "i2c-mux-gpio";
	i2c-parent = <&i2c1>;

	mux-controls = <&mux 2>;

	...
};

There must be some disconnect, because those "i2c-mux-gpio" compatible
strings are just dead wrong. There simply are no gpio pins involved at
all and that "gpio" suffix is just totally out of place.

So, since you are not happy with "i2c-mux-simple", "i2c-mux-generic" or
"i2c-mux" that I have suggested, can you please come up with something
that is good enough for the above?

Or, are you /really/ suggesting "i2c-mux-gpio"?

Cheers,
peda

