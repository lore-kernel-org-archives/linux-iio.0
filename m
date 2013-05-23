Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:39209
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751438Ab3EWI1j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2013 04:27:39 -0400
Message-ID: <519DD204.4040807@analog.com>
Date: Thu, 23 May 2013 10:23:32 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: <linux-iio@vger.kernel.org>
Subject: Re: iio: frequency: New driver for Analog Devices ADF4350/ADF4351
 Wideband Synthesizers
References: <20130522202531.GA1438@elgon.mountain>
In-Reply-To: <20130522202531.GA1438@elgon.mountain>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/22/2013 10:25 PM, Dan Carpenter wrote:
> Hello Michael Hennerich,
>
> The patch e31166f0fd48: "iio: frequency: New driver for Analog
> Devices ADF4350/ADF4351 Wideband Synthesizers" from May 29, 2012,
> leads to the following warning:
> "drivers/iio/frequency/adf4350.c:212 adf4350_set_freq()
> 	 warn: 0x13c001fc0 is larger than 32 bits"
>
> I have been messing with Smatch recently and this is not the right
> warning...  :/
>
> drivers/iio/frequency/adf4350.c
>     207          st->regs[ADF4350_REG2] =
>     208                  ADF4350_REG2_10BIT_R_CNT(r_cnt) |
>     209                  ADF4350_REG2_DOUBLE_BUFF_EN |
>     210                  (pdata->ref_doubler_en ? ADF4350_REG2_RMULT2_EN : 0) |
>     211                  (pdata->ref_div2_en ? ADF4350_REG2_RDIV2_EN : 0) |
>     212                  (pdata->r2_user_settings & (ADF4350_REG2_PD_POLARITY_POS |
>     213                  ADF4350_REG2_LDP_6ns | ADF4350_REG2_LDF_INT_N |
>     214                  ADF4350_REG2_CHARGE_PUMP_CURR_uA(5000) |
>     215                  ADF4350_REG2_MUXOUT(0x7) | ADF4350_REG2_NOISE_MODE(0x9)));
>                          ^^^^^^^^^^^^^^^^^^^^^^^^   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 0x7 and 0x9 are signed int so when we do "<< 29" it wraps or has a sign
> extention.  Also we are doing a bitwise AND with 32 bit unsigned values
> so they get truncated that way too.
>
> It's not clear what was intended here.
>
> regards,
> dan carpenter
>
>
Hi Dan,

Thanks for the reminder.
We actually fixed the typo in the mask some time ago,
0x9 should be 0x3, we send a patch shortly.

7 or 3 being signed by default shouldn't matter. The whole term
at the end is just a big mask used to reject some bits being
set in r2_user_settings.

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


