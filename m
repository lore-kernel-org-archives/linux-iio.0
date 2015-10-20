Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:31306 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbbJTQsO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Oct 2015 12:48:14 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3 3/3] ARM: dts: omap5-uevm: enable iio gpadc for Palmas
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20151020162425.GH3078@atomide.com>
Date: Tue, 20 Oct 2015 18:48:00 +0200
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	=?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marek Belisko <marek@goldelico.com>,
	Pradeep Goudagunta <pgoudagunta@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Graeme Gregory <gg@slimlogic.co.uk>,
	jic23@jic23.retrosnub.co.uk, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-omap <linux-omap@vger.kernel.org>,
	linux-iio@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>
Message-Id: <A872C46B-C0CF-4C67-9615-0A46EDAE9A57@goldelico.com>
References: <cover.1445000017.git.hns@goldelico.com> <05c57453151c9e2cbd3f15145f1e15223410cd87.1445000017.git.hns@goldelico.com> <20151020162425.GH3078@atomide.com>
To: Tony Lindgren <tony@atomide.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Am 20.10.2015 um 18:24 schrieb Tony Lindgren <tony@atomide.com>:

> Hi,
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [151016 05:58]:
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap5-uevm.dts | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>> index 0e8128b..63f81bb 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -342,6 +342,16 @@
>> 
>> 			ti,ldo6-vibrator;
>> 
>> +			gpadc {
>> +				compatible = "ti,palmas-gpadc";
>> +				interrupts = <18 0
>> +					      16 0
>> +					      17 0>;
>> +				#io-channel-cells = <1>;
>> +				ti,channel0-current-microamp = <5>;
>> +				ti,channel3-current-microamp = <10>;
>> +			};
>> +
>> 			regulators {
>> 				smps123_reg: smps123 {
>> 					/* VDD_OPP_MPU */
> 
> FYI, please send this one separately once the binding and driver is
> merged.
> 
> This need to be updated arch/arm/boot/dts/omap5-board-common.dts, so
> this will cause merge conflicts if applied with the driver.

Ok!

We have our own OMAP5 board in the pipeline and there it will help
as well to rebase it using arch/arm/boot/dts/omap5-board-common.dts

BR,
Nikolaus

