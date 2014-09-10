Return-Path: <iivanov@mm-sol.com>
Message-ID: <1410342595.2359.14.camel@iivanov-dev>
Subject: Re: [PATCH 1/2] iio: vadc: Qualcomm SPMI PMIC voltage ADC driver
From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>,  Pawel Moll <pawel.moll@arm.com>, Rob
 Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>,  Mark
 Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Lars-Peter Clausen <lars@metafoo.de>, Hartmut
 Knaack <knaack.h@gmx.de>, Angelo Compagnucci
 <angelo.compagnucci@gmail.com>, Doug Anderson <dianders@chromium.org>,
 Fugang Duan <B38611@freescale.com>, Johannes Thumshirn
 <johannes.thumshirn@men.de>, Jean Delvare <jdelvare@suse.de>, Philippe
 Reynes <tremyfr@yahoo.fr>, Lee Jones <lee.jones@linaro.org>, Josh
 Cartwright <joshc@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>,
 David Collins <collinsd@codeaurora.org>
Date: Wed, 10 Sep 2014 12:49:55 +0300
In-Reply-To: <540EF769.9080002@mm-sol.com>
References: <1409919274-13419-1-git-send-email-svarbanov@mm-sol.com>
	 <3899885.YaIxR1zelv@wuerfel> <540DCB78.8060206@mm-sol.com>
	 <7045486.CbS74HiY8I@wuerfel> <540EF769.9080002@mm-sol.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi,

On Tue, 2014-09-09 at 15:49 +0300, Stanimir Varbanov wrote:
> On 09/09/2014 01:32 PM, Arnd Bergmann wrote:
> > On Monday 08 September 2014 18:30:00 Stanimir Varbanov wrote:
> >>>>> These numbers all look hardware specific, so why put macros into the
> >>>>> device tree rather than using them directly?
> >>>>
> >>>> The idea was to use #defines in DT nodes when we need to overwrite the
> >>>> adc channel parameters, see example in 2/2 how it will be used.
> >>>
> >>> I don't understand. The node in the example has
> >>>
> >>> +               /* Channel node */
> >>> +               usb_id_nopull@39 {
> >>> +                       qcom,channel = <VADC_LR_MUX10_USB_ID>;
> >>> ...
> >>> +               };
> >>>
> >>>
> >>> And VADC_LR_MUX10_USB_ID is defined to 0x39.  How is this helping anything?
> >>> You just introduce an artificial dependency on the header file, which makes
> >>> it a mess to merge the patches or do updates, and anybody who needs to
> >>> make updates to this now has to go through the same pain, to update the
> >>> dts files, the driver and the binding document in lockstep.
> >>>
> >>> Why not remove the qcom,channel property completely and use a 'reg'
> >>> property with #address-cells=<1>, #size-cells=<0> and put the number
> >>> directly in there, with no need for obfuscation macros?
> >>
> >> OK thanks for the remarks. I will fix this mess.
> >>
> >> I hope you are expecting to see this:
> >>
> >> pmic_vadc: vadc@3100 {
> >>         #address-cells = <1>;
> >>         #size-cells = <0>;
> >>         #io-channel-cells = <1>;
> >>         io-channel-ranges;
> >>
> >>         usb_id_nopull@39 {
> >>                 reg = <0x39>;
> >>         };
> >> };
> >>
> >> and use the vadc channel from usb device node
> >>
> >> usb {
> >>         ...
> >>         io-channels = <&pmic_vadc 0x39>;

I believe this will be more readable and clear.

	     io-channels = <&pmic_vadc VADC_LR_MUX10_USB_ID>;

I would like to keep channels definitions macros in DT header.

Regards,
Ivan
