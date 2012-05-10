Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:34275 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436Ab2EJIv2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 May 2012 04:51:28 -0400
Message-ID: <4FAB815A.8040109@atmel.com>
Date: Thu, 10 May 2012 10:50:34 +0200
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <thomas@free-electrons.com>,
	<plagnioj@jcrosoft.com>, <patrice.vilchez@atmel.com>
Subject: Re: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com> <201205091440.14587.arnd@arndb.de> <4FAB7D29.9000107@free-electrons.com>
In-Reply-To: <4FAB7D29.9000107@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/10/2012 10:32 AM, Maxime Ripard :
> Le 09/05/2012 16:40, Arnd Bergmann a =E9crit :
>> On Wednesday 09 May 2012, Maxime Ripard wrote:
>>> Here is another version of the patches to bring ADC driver to Atmel=
 boards.
>>> Since last version, here is what changed:
>>>   * Rebased on top of staging-next to move out of staging. Had to c=
hange to IIO
>>>     kfifo buffer along the way.
>>>   * Reworked the DT bindings according to Jean-Christophe reviews
>>>   * Made various fixes according to reviews
>>>   * Support for X5 boards
>>
>> What's the reason for providing both DT and non-DT probing in that d=
river?
>> Doesn't it make more sense to just require that everyone who uses th=
is
>> device boots using the device tree?
>=20
> Mostly historical actually.
> The first versions were made using only non-DT probing, and then DT w=
as
> added, so I didn't remove it.
> I've no strong feeling about this however, I believe we can definitel=
y
> drop it, moreover if it makes life easier for you to merge it.
>=20
> I'll send an updated version.

Hold on Maxime,

Non-DT is important for us as several boards are not converted to DT an=
d
I guess that some never will. Moreover, some AT91 SoC will certainly
never be converted to DT but all are equipped with ADC...

So I would really like to keep the non-DT probing. This will give the
ability for users to experiment IIO/ADC with whichever kernel revision,
whichever AT91 SoC they like.

Arnd, we will have to agree on a way to push this work into mainline,
but please consider keeping the non-DT part for this driver.

Best regards,
--=20
Nicolas Ferre
