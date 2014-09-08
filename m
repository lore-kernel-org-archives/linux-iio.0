Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62410 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbaIHKTY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Sep 2014 06:19:24 -0400
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
Date: Mon, 08 Sep 2014 12:19:05 +0200
Message-ID: <3899885.YaIxR1zelv@wuerfel>
In-Reply-To: <540D653E.7070509@mm-sol.com>
References: <1409919274-13419-1-git-send-email-svarbanov@mm-sol.com> <3495079.hWGRuSPgx7@wuerfel> <540D653E.7070509@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday 08 September 2014 11:13:50 Stanimir Varbanov wrote:
> On 09/05/2014 03:26 PM, Arnd Bergmann wrote:
> > On Friday 05 September 2014 15:14:33 Stanimir Varbanov wrote:
> >> +       VADC_CHAN(LR_MUX1_BAT_THERM, 0)                 /* 0x30 */
> >> +       VADC_CHAN(LR_MUX2_BAT_ID, 0)
> >> +       VADC_CHAN(LR_MUX3_XO_THERM, 0)
> >> +       VADC_CHAN(LR_MUX4_AMUX_THM1, 0)
> >> +       VADC_CHAN(LR_MUX5_AMUX_THM2,by you  0)
> >> +       VADC_CHAN(LR_MUX6_AMUX_THM3, 0)
> >> +       VADC_CHAN(LR_MUX7_HW_ID, 0)
> >> +       VADC_CHAN(LR_MUX8_AMUX_THM4, 0)
> >> +       VADC_CHAN(LR_MUX9_AMUX_THM5, 0)
> >> +       VADC_CHAN(AMUX_PU1, 0)
> >> +       VADC_CHAN(AMUX_PU2, 0)
> >> +       VADC_CHAN(LR_MUX3_BUF_XO_THERM_BUF, 0)          /* 0x3c */
> >> +
> >> +       VADC_CHAN(LR_MUX1_PU1_BAT_THERM, 0)             /* 0x70 */
> >> +       VADC_CHAN(LR_MUX2_PU1_BAT_ID, 0)
> >> +       VADC_CHAN(LR_MUX3_PU1_XO_THERM, 0)
> >> +       VADC_CHAN(LR_MUX4_PU1_AMUX_THM1, 0)
> >> +       VADC_CHAN(LR_MUX5_PU1_AMUX_THM2, 0)
> >> +       VADC_CHAN(LR_MUX6_PU1_AMUX_THM3, 0)
> >> +       VADC_CHAN(LR_MUX7_PU1_AMUX_HW_ID, 0)
> >> +       VADC_CHAN(LR_MUX8_PU1_AMUX_THM4, 0)
> >> +       VADC_CHAN(LR_MUX9_PU1_AMUX_THM5, 0)
> >> +       VADC_CHAN(LR_MUX10_PU1_AMUX_USB_ID, 0)          /* 0x79 */
> >> +       VADC_CHAN(LR_MUX3_BUF_PU1_XO_THERM_BUF, 0)      /* 0x7c */
> >>
> > 
> > These numbers all look hardware specific, so why put macros into the
> > device tree rather than using them directly?
> 
> The idea was to use #defines in DT nodes when we need to overwrite the
> adc channel parameters, see example in 2/2 how it will be used.

I don't understand. The node in the example has

+               /* Channel node */
+               usb_id_nopull@39 {
+                       qcom,channel = <VADC_LR_MUX10_USB_ID>;
...
+               };


And VADC_LR_MUX10_USB_ID is defined to 0x39.  How is this helping anything?
You just introduce an artificial dependency on the header file, which makes
it a mess to merge the patches or do updates, and anybody who needs to
make updates to this now has to go through the same pain, to update the
dts files, the driver and the binding document in lockstep.

Why not remove the qcom,channel property completely and use a 'reg'
property with #address-cells=<1>, #size-cells=<0> and put the number
directly in there, with no need for obfuscation macros?

	Arnd
