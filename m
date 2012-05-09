Return-Path: <Nicolas.FERRE@atmel.com>
Message-ID: <4FAA7CB6.8030506@atmel.com>
Date: Wed, 9 May 2012 16:18:30 +0200
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Jonathan Cameron
	<jic23@cam.ac.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson
	<olof@lixom.net>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<thomas@free-electrons.com>, <patrice.vilchez@atmel.com>,
	<plagnioj@jcrosoft.com>
Subject: Re: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On 05/09/2012 11:05 AM, Maxime Ripard :
> Hi all,
> 
> Here is another version of the patches to bring ADC driver to Atmel boards.
> Since last version, here is what changed:
>   * Rebased on top of staging-next to move out of staging. Had to change to IIO
>     kfifo buffer along the way.
>   * Reworked the DT bindings according to Jean-Christophe reviews
>   * Made various fixes according to reviews
>   * Support for X5 boards
> 
> Thanks,
> Maxime

Hi Maxime,

Thanks for posting this new series. My overall feeling is that it is
very close to an achievement! Apart from some trivial fixes, you can add
my :

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

on the whole series.

Jonathan, Arnd, Olof,

As explained by Maxime, this patch series is adding the Atmel ADC driver
to the out-of-staging iio subsystem. It relies on patches that are in
staging-next.
On the other hand, I really wouldn't like to split the series between
iio and arm-soc...
My question is: would it be possible to take this series in Jonathan
iio/staging-next git tree for inclusion in 3.5? Arnd & Olof, is it ok
for you? Do you want to add your Acked-by on some patches?

Thanks, best regards,
-- 
Nicolas Ferre
