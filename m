Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:60689 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbJSMaq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Oct 2015 08:30:46 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3 2/3] iio:adc:palmas: add DT support
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <5624DAAB.9040207@metafoo.de>
Date: Mon, 19 Oct 2015 14:30:33 +0200
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	=?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
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
Message-Id: <6E3CF32E-809D-4BA4-BD78-E10192B2C91C@goldelico.com>
References: <cover.1445000017.git.hns@goldelico.com> <79429ca1a6d0465b6b19ede16d90de23e4363431.1445000017.git.hns@goldelico.com> <5624DAAB.9040207@metafoo.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Am 19.10.2015 um 13:57 schrieb Lars-Peter Clausen <lars@metafoo.de>:

> On 10/16/2015 02:53 PM, H. Nikolaus Schaller wrote:
> [...]
>> +Optional sub-nodes:
>> +ti,channel0-current-microamp: Channel 0 current in uA.
>> +	Values are rounded to derive 0uA, 5uA, 15uA, 20uA.
>> +ti,channel3-current-microamp: Channel 3 current in uA.
>> +	Valid are rounded to derive 0uA, 10uA, 400uA, 800uA.
>> +ti,enable-extended-delay: Enable extended delay.
> 
> Those three above sound more like configuration policy, rather than hardware
> description. What influence which values should be chosen?

e.g. the nominal value of the NTC that can be connected if the Palmas
is hooked up in a standard way.

If a board has no NTC and uses channel0 for a different purpose one
should choose 0uA.

If it is let's say 10kOhm it should probably be 20uA to give a nominal voltage
reading of 200mV.

100kOhm will give 2V which is at the limit of the ADC input range and
therefore it would be better to choose 15uA or 5uA.

I think choosing extended delay depends on the noisiness of the input
signal but I am not a specialist for this feature.

So I would say the board hardware mandates some specific value.

BR,
Nikolaus

