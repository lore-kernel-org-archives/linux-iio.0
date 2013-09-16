Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39576 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab3IPPai (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 11:30:38 -0400
In-Reply-To: <201309161010.22151.jbe@pengutronix.de>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <1378887511-24530-6-git-send-email-jbe@pengutronix.de> <52359259.8010202@kernel.org> <201309161010.22151.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 16 Sep 2013 16:30:32 +0100
To: =?ISO-8859-1?Q?J=FCrgen_Beisert?= <jbe@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org
CC: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk,
	Torokhov <dmitry.torokhov@gmail.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Message-ID: <0fb59809-c835-49b0-bd82-e791db1a9db7@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



"Jürgen Beisert" <jbe@pengutronix.de> wrote:
>Hi Jonathan,
>
>On Sunday 15 September 2013 12:56:25 Jonathan Cameron wrote:
>> On 09/11/13 09:18, Juergen Beisert wrote:
>> > For battery driven systems it is a very bad idea to collect the
>> > touchscreen data within a kernel busy loop.
>> >
>> > This change uses the features of the hardware to delay and
>accumulate
>> > samples in hardware to avoid a high interrupt and CPU load.
>> >
>> > Note: this is only tested on an i.MX23 SoC yet.
>> >
>> > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
>> > CC: linux-arm-kernel@lists.infradead.org
>> > CC: devel@driverdev.osuosl.org
>> > CC: Marek Vasut <marex@denx.de>
>> > CC: Fabio Estevam <fabio.estevam@freescale.com>
>> > CC: Jonathan Cameron <jic23@cam.ac.uk>
>>
>> While this driver is placed in IIO within staging at the moment,
>these
>> changes are definitely input related.  Hence I have cc'd Dmitry and
>the
>> input list.
>>
>> I am personaly a little uncomfortable that we have such a complex bit
>of
>> input code sat within an IIO driver but such is life.
>
>Maybe an MFD for this ADC unit would be a better way to go?
That would be great and is definitely the preferred method.


 Currently I
>have a 
>different problem with this driver, because the ADC unit monitors the
>battery 
>as well. And the charging driver from the power subsystem needs these
>values 
>to charge the battery in a correct manner.

There is an iio client battery driver as generic_ADC_battery.c but it is currently only doing polled access. Not too hard to add buffered access though ideally we would want a generic way of combining consumers doing polled and interrupt driven accesses.
>
>> [...]
>
>Regards,
>Juergen

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
