Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39671 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab3IHRDq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Sep 2013 13:03:46 -0400
In-Reply-To: <201309081811.49663.marex@denx.de>
References: <1378169292-29899-1-git-send-email-festevam@gmail.com> <201309081700.17212.marex@denx.de> <1f25c7ea-016a-4501-a58c-f89813040185@email.android.com> <201309081811.49663.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 2/2] iio: mxs-lradc: Add MODULE_ALIAS
From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 08 Sep 2013 18:03:39 +0100
To: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <festevam@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Message-ID: <b5a49b55-2c3b-4c70-aa84-574ff980c5a2@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Marek Vasut <marex@denx.de> wrote:
>Dear Jonathan Cameron,
>
>> Marek Vasut <marex@denx.de> wrote:
>> >Dear Fabio Estevam,
>> >
>> >> Hi Jonathan/Marek,
>> >> 
>> >> On Sun, Sep 8, 2013 at 11:31 AM, Jonathan Cameron
><jic23@kernel.org>
>> >
>> >wrote:
>> >> > On 09/03/13 01:59, Marek Vasut wrote:
>> >> >> Dear Fabio Estevam,
>> >> >> 
>> >> >>> From: Fabio Estevam <fabio.estevam@freescale.com>
>> >> >>> 
>> >> >>> Add MODULE_ALIAS, so that auto module loading can work.
>> >> >>> 
>> >> >>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> >> >> 
>> >> >> Acked-by: Marek Vasut <marex@denx.de>
>> >> > 
>> >> > Applied to the togreg branch of iio.git
>> >> > 
>> >> > Anyone fancy getting this driver into a clean form and proposing
>> >
>> >taking
>> >
>> >> > it out of staging?
>> >> 
>> >> Does anyone know what still needs to be done in order to take it
>out
>> >
>> >of
>> >
>> >> staging?
>> >
>> >I think it should have been taken out of staging for a while now ;-)
>> 
>> Post a patch moving it with full code (turn off the move stuff in git
>> format patch) and see what reviews you get.
>> 
>> Obviously best if someone who knows the driver does an initial pass
>for any
>> cleanups code simplifications and stuff like missing docs.
>
>Will it not be better to get Jurgens' patches in first ?
Indeed. It will.
>
>Best regards,
>Marek Vasut
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
