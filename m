Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52714 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab3IOPKL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 11:10:11 -0400
Message-ID: <5235DBEA.7030402@kernel.org>
Date: Sun, 15 Sep 2013 17:10:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devel@driverdev.osuosl.org, marex@denx.de,
	fabio.estevam@freescale.com, Torokhov <dmitry.torokhov@gmail.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven
 touch detection
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <1378887511-24530-6-git-send-email-jbe@pengutronix.de> <52359259.8010202@kernel.org>
In-Reply-To: <52359259.8010202@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/15/13 11:56, Jonathan Cameron wrote:
> On 09/11/13 09:18, Juergen Beisert wrote:
>> For battery driven systems it is a very bad idea to collect the touchscreen
>> data within a kernel busy loop.
>>
>> This change uses the features of the hardware to delay and accumulate samples in
>> hardware to avoid a high interrupt and CPU load.
>>
>> Note: this is only tested on an i.MX23 SoC yet.
>>
>> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
>> CC: linux-arm-kernel@lists.infradead.org
>> CC: devel@driverdev.osuosl.org
>> CC: Marek Vasut <marex@denx.de>
>> CC: Fabio Estevam <fabio.estevam@freescale.com>
>> CC: Jonathan Cameron <jic23@cam.ac.uk>
> While this driver is placed in IIO within staging at the moment, these changes are definitely
> input related.  Hence I have cc'd Dmitry and the input list.
>
> I am personaly a little uncomfortable that we have such a complex bit of input code sat
> within an IIO driver but such is life.

The logic in here looks reasonable to me. I am far from a specialist in how these touch
screens are normally handled though.

One thing to note is that you really want to get a proposed device tree spec out asap
as that can take longer to review than the driver.  If you are proposing to do that as a future
patch, then take into account that you'll need to ensure these are the defaults if
it is not specified in the device tree for ever more (which is more painful than
hammering out he device tree stuff now!)
...
>> +static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
>> +						struct device_node *lradc_node)
>> +{
>> +	/* TODO retrieve from device tree */
>> +	lradc->over_sample_cnt = 4;
>> +	lradc->over_sample_delay = 2;
>> +	lradc->settling_delay = 10;
>> +
>> +	return 0;
>> +}
>> +
...
