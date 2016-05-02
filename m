Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34567 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbcEBGHA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 May 2016 02:07:00 -0400
MIME-Version: 1.0
In-Reply-To: <500c5874-4ef8-b37b-e12f-80fd5205c172@kernel.org>
References: <1461441479-23218-1-git-send-email-stefan.wahren@i2se.com>
	<500c5874-4ef8-b37b-e12f-80fd5205c172@kernel.org>
Date: Mon, 2 May 2016 08:06:58 +0200
Message-ID: <CAL7P5jJF9EL4Zk-AC9csyadfrmUp4R+6ceVAN_kNm7dKgo+ZgQ@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] iio: mxs-lradc: simplify TS handling
From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Juergen Borleis <jbe@pengutronix.de>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun, May 1, 2016 at 10:08 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> Ksenija,
>
> How would you prefer we handle this interaction of this set and your series.
> Options are:
>
> 1. I apply these now and you rebase on top of the result.
> 2. You pull these into your series, probably after the driver split making sure these
>    improvements end up in the new drivers.
> 3. We ask Stephan to re roll them at a later date (least preferred option as that adds
> another person we need to chase down to get to the end of this process!)
>
> No immediate rush on any of the above as we've probably missed this cycle now anyway.
> I've been cut off today so not sure what Linus has said today.

My understanding was that you will take this patch series so I already included
changes made by this patch set in touchscreen part, I will check if I missed
something.
I think the best is to apply these now.

Thanks,
Ksenija

> Jonathan
> On 23/04/16 20:57, Stefan Wahren wrote:
>> This patch series simplifies TS handling of mxs-lradc.
>>
>> These patches has been tested with i.MX23 and i.MX28 but without
>> a touchscreen. I added only a bogus touchscreen in devicetree.
>>
>> It would be nice if someone with a real touchscreen could test it.
>>
>> Changes in V3:
>> - remove dev.parent assignment as suggested by Dimitry
>> - add new patch to remove mxs_lradc_ts_unregister
>> - remove PM implementation from series in order to wait until
>>   Ksenija has split the driver
>>
>> Changes in V2:
>> - rebase on iio/testing since patch 2 and 3 from V1 has been applied
>> - also remove input_unregister_device in patch 1
>> - use mask of virtual channels for IRQ disabling in patch 2
>>
>> Stefan Wahren (3):
>>   iio: mxs-lradc: simplify TS registration
>>   iio: mxs-lradc: remove mxs_lradc_ts_unregister
>>   iio: mxs-lradc: disable only masked channels in
>>     mxs_lradc_hw_stop
>>
>>  drivers/iio/adc/mxs-lradc.c |   34 ++++++----------------------------
>>  1 file changed, 6 insertions(+), 28 deletions(-)
>>
>
