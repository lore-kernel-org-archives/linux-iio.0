Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:58536 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077Ab2EJIc7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 May 2012 04:32:59 -0400
Message-ID: <4FAB7D29.9000107@free-electrons.com>
Date: Thu, 10 May 2012 10:32:41 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	thomas@free-electrons.com, nicolas.ferre@atmel.com,
	plagnioj@jcrosoft.com, patrice.vilchez@atmel.com
Subject: Re: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com> <201205091440.14587.arnd@arndb.de>
In-Reply-To: <201205091440.14587.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Le 09/05/2012 16:40, Arnd Bergmann a =E9crit :
> On Wednesday 09 May 2012, Maxime Ripard wrote:
>> Here is another version of the patches to bring ADC driver to Atmel =
boards.
>> Since last version, here is what changed:
>>   * Rebased on top of staging-next to move out of staging. Had to ch=
ange to IIO
>>     kfifo buffer along the way.
>>   * Reworked the DT bindings according to Jean-Christophe reviews
>>   * Made various fixes according to reviews
>>   * Support for X5 boards
>=20
> What's the reason for providing both DT and non-DT probing in that dr=
iver?
> Doesn't it make more sense to just require that everyone who uses thi=
s
> device boots using the device tree?

Mostly historical actually.
The first versions were made using only non-DT probing, and then DT was
added, so I didn't remove it.
I've no strong feeling about this however, I believe we can definitely
drop it, moreover if it makes life easier for you to merge it.

I'll send an updated version.

Maxime

--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
