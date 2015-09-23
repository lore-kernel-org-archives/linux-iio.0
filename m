Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:51454 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829AbbIWRDx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Sep 2015 13:03:53 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 3/3] ARM: dts: omap5-uevm: enable iio gpadc for Palmas
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20150923165613.GG23801@atomide.com>
Date: Wed, 23 Sep 2015 19:03:37 +0200
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	=?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marek Belisko <marek@goldelico.com>,
	Pradeep Goudagunta <pgoudagunta@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, gg@slimlogic.co.uk,
	jic23@jic23.retrosnub.co.uk, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-iio@vger.kernel.org, notaz@openpandora.org
Message-Id: <05683602-B29C-45F9-A00D-127F6ECC4E21@goldelico.com>
References: <1437657169.3419965.331206849.51D66A2E@webmail.messagingengine.com> <cover.1443012491.git.hns@goldelico.com> <4254897D-374E-4122-A1A6-269A22C2D622@goldelico.com> <20150923165613.GG23801@atomide.com>
To: Tony Lindgren <tony@atomide.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Am 23.09.2015 um 18:56 schrieb Tony Lindgren <tony@atomide.com>:

> * H. Nikolaus Schaller <hns@goldelico.com> [150923 05:53]:
> 
> Missing description?

well, description is “ARM: dts: omap5-uevm: enable iio gpadc for Palmas"

and I didn’t catch that the commit is otherwise empty. Sorry.

> BTW, this I want to queue separately
> as I have patches in works to support omap5 variants with
> omap5-board-common.dtsi to avoid duplicating things as
> we get omap5 better supported for things like regulators.

Yes, it should work for all Palmas based OMAP5 boards and a 
omap5-board-common.dtsi would be the right place (after
it comes to existence).

> 
> Regards,
> 
> Tony
> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap5-uevm.dts | 22 ++++++++++++++++++++++
>> 1 file changed, 22 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>> index 3b16e8f..0d4c8ff 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -342,6 +342,28 @@
>> 
>> 			ti,ldo6-vibrator;
>> 
>> +			gpadc {
>> +				compatible = "ti,palmas-gpadc";
>> +				interrupts = <18 0
>> +					      16 0
>> +					      17 0>;
>> +				ti,channel0-current-microamp = <5>;
>> +				ti,channel3-current-microamp = <10>;
>> +				iio_map {
>> +					ch1 {
>> +						ti,adc-channel-number = <1>;
>> +						ti,adc-consumer-device = "generic-adc-thermal.0";
>> +						ti,adc-consumer-channel ="battery-temp-channel";
>> +					};
>> +
>> +					ch6 {
>> +						ti,adc-channel-number = <6>;
>> +						ti,adc-consumer-device = "palmas-battery";
>> +						ti,adc-consumer-channel ="vbat_channel";
>> +					};
>> +				};
>> +			};
>> +
>> 			regulators {
>> 				smps123_reg: smps123 {
>> 					/* VDD_OPP_MPU */
>> -- 
>> 2.5.1
>> 

BR,
Nikolaus

