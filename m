Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59836 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab3ISQMs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2013 12:12:48 -0400
In-Reply-To: <201309191449.37274.jbe@pengutronix.de>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <201309161010.22151.jbe@pengutronix.de> <0fb59809-c835-49b0-bd82-e791db1a9db7@email.android.com> <201309191449.37274.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
From: Jonathan Cameron <jic23@kernel.org>
Date: Thu, 19 Sep 2013 17:12:42 +0100
To: =?ISO-8859-1?Q?J=FCrgen_Beisert?= <jbe@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org
CC: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk,
	Torokhov <dmitry.torokhov@gmail.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Message-ID: <b270500e-998f-4aa1-a592-cdee7db4ff2a@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

.

"Jürgen Beisert" <jbe@pengutronix.de> wrote:
>Hi Jonathan,
>
>On Monday 16 September 2013 17:30:32 Jonathan Cameron wrote:
>> >On Sunday 15 September 2013 12:56:25 Jonathan ,,, wrote:
>> >> On 09/11/13 09:18, Juergen Beisert wrote:
>> >> > For battery driven systems it is a very bad idea to collect the
>> >> > touchscreen data within a kernel busy loop.
>> >> >
>> >> > This change uses the features of the hardware to delay and
>> >> > accumulate samples in hardware to avoid a high interrupt and CPU
>load.
>> >> >
>> >> > Note: this is only tested on an i.MX23 SoC yet.
>> >> >
>> >> > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
>> >> > CC: linux-arm-kernel@lists.infradead.org
>> >> > CC: devel@driverdev.osuosl.org
>> >> > CC: Marek Vasut <marex@denx.de>
>> >> > CC: Fabio Estevam <fabio.estevam@freescale.com>
>> >> > CC: Jonathan Cameron <jic23@cam.ac.uk>
>> >>
>> >> While this driver is placed in IIO within staging at the moment,
>> >> these changes are definitely input related.  Hence I have cc'd
>Dmitry and
>> >> the input list.
>> >>
>> >> I am personaly a little uncomfortable that we have such a complex
>bit
>> >> of input code sat within an IIO driver but such is life.
>> >
>> > Maybe an MFD for this ADC unit would be a better way to go?
>>
>> That would be great and is definitely the preferred method.
>
>Cannot continue to convert the driver into an MFD device. The project
>does not 
>give me the time to do so.
>
>Regards,
>Juergen

Fair enough. Perhaps someone else will pick up the gauntlet :) 
The old call of why there isn't enough time in the day!

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
