Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:43795 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab2EKHyo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 03:54:44 -0400
Message-ID: <4FACC5B1.80601@free-electrons.com>
Date: Fri, 11 May 2012 09:54:25 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	thomas@free-electrons.com, plagnioj@jcrosoft.com,
	patrice.vilchez@atmel.com
Subject: Re: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com> <4FAB7D29.9000107@free-electrons.com> <4FAB815A.8040109@atmel.com> <201205101328.36524.arnd@arndb.de>
In-Reply-To: <201205101328.36524.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Since everyone seems to have put his Acked-By (Nicolas, Arnd and you),
are you ok to merge it in your tree ?

You still had some minor comments, do you you want me to post a new
patchset to the mailing list, or a public git branch would be enough ?

Thanks,
Maxime

Le 10/05/2012 15:28, Arnd Bergmann a =E9crit :
> On Thursday 10 May 2012, Nicolas Ferre wrote:
>> So I would really like to keep the non-DT probing. This will give th=
e
>> ability for users to experiment IIO/ADC with whichever kernel revisi=
on,
>> whichever AT91 SoC they like.
>>
>> Arnd, we will have to agree on a way to push this work into mainline=
,
>> but please consider keeping the non-DT part for this driver.
>=20
> Ok. If the non-DT part is important to you, I suggest you merge it
> all through the IIO tree, to avoid dependency problems with the
> platform data header file.
>=20
> Please add my Acked-by for the arch/arm patches.
>=20
> 	Arnd


--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
