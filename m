Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:58205 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572AbaIIKc5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Sep 2014 06:32:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Doug Anderson <dianders@chromium.org>,
	Fugang Duan <B38611@freescale.com>,
	Johannes Thumshirn <johannes.thumshirn@men.de>,
	Jean Delvare <jdelvare@suse.de>,
	Philippe Reynes <tremyfr@yahoo.fr>,
	Lee Jones <lee.jones@linaro.org>,
	Josh Cartwright <joshc@codeaurora.org>,
	Stephen Boyd <sboyd@codeaurora.org>,
	David Collins <collinsd@codeaurora.org>,
	"Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH 1/2] iio: vadc: Qualcomm SPMI PMIC voltage ADC driver
Date: Tue, 09 Sep 2014 12:32:26 +0200
Message-ID: <7045486.CbS74HiY8I@wuerfel>
In-Reply-To: <540DCB78.8060206@mm-sol.com>
References: <1409919274-13419-1-git-send-email-svarbanov@mm-sol.com> <3899885.YaIxR1zelv@wuerfel> <540DCB78.8060206@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday 08 September 2014 18:30:00 Stanimir Varbanov wrote:
> >>> These numbers all look hardware specific, so why put macros into the
> >>> device tree rather than using them directly?
> >>
> >> The idea was to use #defines in DT nodes when we need to overwrite the
> >> adc channel parameters, see example in 2/2 how it will be used.
> > 
> > I don't understand. The node in the example has
> > 
> > +               /* Channel node */
> > +               usb_id_nopull@39 {
> > +                       qcom,channel = <VADC_LR_MUX10_USB_ID>;
> > ...
> > +               };
> > 
> > 
> > And VADC_LR_MUX10_USB_ID is defined to 0x39.  How is this helping anything?
> > You just introduce an artificial dependency on the header file, which makes
> > it a mess to merge the patches or do updates, and anybody who needs to
> > make updates to this now has to go through the same pain, to update the
> > dts files, the driver and the binding document in lockstep.
> > 
> > Why not remove the qcom,channel property completely and use a 'reg'
> > property with #address-cells=<1>, #size-cells=<0> and put the number
> > directly in there, with no need for obfuscation macros?
> 
> OK thanks for the remarks. I will fix this mess.
> 
> I hope you are expecting to see this:
> 
> pmic_vadc: vadc@3100 {
>         #address-cells = <1>;
>         #size-cells = <0>;
>         #io-channel-cells = <1>;
>         io-channel-ranges;
> 
>         usb_id_nopull@39 {
>                 reg = <0x39>;
>         };
> };
> 
> and use the vadc channel from usb device node
> 
> usb {
>         ...
>         io-channels = <&pmic_vadc 0x39>;
>         io-channel-names = "usbidnopull";
> };

The ID stuff looks good now, but I had not noticed the
"io-channel-names" property before. I think you misunderstood
the purpose of that, because it is very similar to the name of the
adc provider (usb_id_nopull@39).

Like anything else that we refer to by name (interrupt, reg,
clock, regulator, ...), the name used in the client is supposed
to be a string that identifies what the connection means to the
client, not what it means to the provider. This string is
supposed to be defined in the binding of the client device and
independent of what other hardware block provides it.

E.g. if you have two usb devices that need a separate adc channel,
it could look like

pmic_vadc: vadc@3100 {

	usb_1_id_nopull@39 {
		reg = 0x39;
	};
	usb_2_id_nopull@40 {
		reg = 0x40;
	};

};

usb@100000 {
	io-channels = <&pmic_vadc 0x39>;
	io-channel-names = "vadc";
};

usb@200000 {
	io-channels = <&pmic_vadc 0x40>;
	io-channel-names = "vadc";
};

Now the usb driver just asks for an io channel named "vadc"
and the ADC core code will perform that lookup.

	Arnd
