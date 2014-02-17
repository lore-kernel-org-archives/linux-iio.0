Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2lp0212.outbound.protection.outlook.com ([207.46.163.212]:48851
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753020AbaBQB14 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Feb 2014 20:27:56 -0500
From: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
To: Shawn Guo <shawn.guo@linaro.org>
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"sachin.kamat@linaro.org" <sachin.kamat@linaro.org>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v5 1/3] ARM: dts: vf610-twr: Add ADC support
Date: Mon, 17 Feb 2014 01:27:40 +0000
Message-ID: <86c9f84523464c5cb2b25ab901e367d8@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1390714773-23066-1-git-send-email-B38611@freescale.com>
 <1390714773-23066-2-git-send-email-B38611@freescale.com>
 <20140216075021.GB2946@S2101-09.ap.freescale.net>
In-Reply-To: <20140216075021.GB2946@S2101-09.ap.freescale.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Shawn Guo <shawn.guo@linaro.org>
Data: Sunday, February 16, 2014 3:50 PM

>To: Duan Fugang-B38611
>Cc: jic23@kernel.org; sachin.kamat@linaro.org; pmeerw@pmeerw.net;
>lars@metafoo.de; mark.rutland@arm.com; linux-iio@vger.kernel.org
>Subject: Re: [PATCH v5 1/3] ARM: dts: vf610-twr: Add ADC support
>
>On Sun, Jan 26, 2014 at 01:39:31PM +0800, Fugang Duan wrote:
>> @@ -178,6 +187,14 @@
>>
>>  				/* functions and groups pins */
>>
>> +				adc0 {
>> +					pinctrl_adc0_ad5: adc0_ad5 {
>> +						fsl,pins = <
>> +						VF610_PAD_PTC30__ADC0_SE5	0xa1
>> +						>;
>> +					};
>
>We have been moving pinctrl setting nodes into board dts.  Please rebase the
>patch against my for-next branch.
>
>Shawn
>
>> +				};
>> +
>

Ok, thanks shawn.
