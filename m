Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53905 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab3JAKGX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 06:06:23 -0400
Message-ID: <524AACC9.9080700@kernel.org>
Date: Tue, 01 Oct 2013 12:06:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, marex@denx.de,
	fabio.estevam@freescale.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, jic23@cam.ac.uk,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 6/9] Staging/iio/adc/touchscreen/MXS: add interrupt driven
 touch detection
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-7-git-send-email-jbe@pengutronix.de> <201310011128.38928.jbe@pengutronix.de> <524AA91F.7000906@kernel.org>
In-Reply-To: <524AA91F.7000906@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/13 11:51, Jonathan Cameron wrote:
> On 10/01/13 10:28, Jürgen Beisert wrote:
>> Hi Jonathan,
>>
>> On Tuesday 01 October 2013 11:25:46 Jonathan Cameron wrote:
>>> a couple of the patch descriptions say that they are untested on i.MX28.
>>
>> On Monday 23 September 2013 16:36:35 Juergen Beisert wrote:
>>> For battery driven systems it is a very bad idea to collect the touchscreen
>>> data within a kernel busy loop.
>>>
>>> This change uses the features of the hardware to delay and accumulate
>>> samples in hardware to avoid a high interrupt and CPU load.
>>>
>>> Note: this is only tested on an i.MX23 SoC yet.
>>
>> This note is no longer true. Marek tested it on his M28EVK, Lothar on his TX28 
>> and myself also on an i.MX28EVK.
>>
>> For the IIO part of the driver I tested on my i.MX23 based ChumbyOne and some 
>> customer hardware and it seems still to work (I can only guess if the values I 
>> read from the sysfs entries are correct, sorry).
> 
> Excellent. I'll assume everyone is happy then and add some appropriate
> tested-by tags. I'd missed Marek's reply saying he was fine with this.

This one is not applying cleanly.  I've merged what I think is the right
fixup, but please check.

The issue is around the error handling after mxs_lradc_ts_register which has
been changed in the meantime it seems.

Jonathan
> 
> 
> Thanks,
> 
> Jonathan
>>
>> Regards,
>> Juergen
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
