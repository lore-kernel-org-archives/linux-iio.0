Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:44539 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbASTD2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jan 2015 14:03:28 -0500
Received: by mail-la0-f53.google.com with SMTP id gq15so6028667lab.12
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2015 11:03:26 -0800 (PST)
Message-ID: <54BD54EB.6020704@gmail.com>
Date: Mon, 19 Jan 2015 21:03:07 +0200
From: =?windows-1252?Q?Kristina_Mart=9Aenko?=
	<kristina.martsenko@gmail.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Juergen Beisert <jbe@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 2/4] iio: mxs-lradc: make ADC reads not disable touchscreen
 interrupts
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com> <1421454131-3501-3-git-send-email-kristina.martsenko@gmail.com> <201501180121.19946.marex@denx.de>
In-Reply-To: <201501180121.19946.marex@denx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/01/15 02:21, Marek Vasut wrote:
> On Saturday, January 17, 2015 at 01:22:09 AM, Kristina Martšenko wrote:
>> Reading a channel through sysfs, or starting a buffered capture, will
>> currently turn off the touchscreen. This is because the read_raw() and
>> buffer preenable()/postdisable() callbacks disable interrupts for all
>> LRADC channels, including those the touchscreen uses.
>>
>> So make the callbacks only disable interrupts for the channels they use.
>> This means channel 0 for read_raw() and channels 0-5 for the buffer (if
>> the touchscreen is enabled). Since the touchscreen uses different
>> channels (6 and 7), it no longer gets turned off.
>>
>> Note that only i.MX28 is affected by this issue, i.MX23 should be fine.
>>
>> Signed-off-by: Kristina Martšenko <kristina.martsenko@gmail.com>
>> ---
>>  drivers/staging/iio/adc/mxs-lradc.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>> b/drivers/staging/iio/adc/mxs-lradc.c index fc65cd311be9..0cf276ff0dc5
>> 100644
>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>> @@ -218,8 +218,11 @@ struct mxs_lradc {
>>  	 * channels: #6 and #7. This means that only 6 virtual channels (instead
>>  	 * of 8) will be available for buffered capture.
>>  	 */
>> -#define TS_VCH1		7
>> -#define TS_VCH2		6
>> +#define TS_VCH1				7
>> +#define TS_VCH2				6
> 
> Please fix the indent in 1/4 , so you don't have to change it again this patch.

Right, of course, I'll do that in v2.

> Reviewed-by: Marek Vasut <marex@denx.de>

Thanks for taking time to review all the patches!

Kristina
