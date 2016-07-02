Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35119 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbcGBWOi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Jul 2016 18:14:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id a66so13296435wme.2
        for <linux-iio@vger.kernel.org>; Sat, 02 Jul 2016 15:14:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1467497127-32431-1-git-send-email-mranostay@gmail.com>
References: <1467497127-32431-1-git-send-email-mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Sat, 2 Jul 2016 15:13:57 -0700
Message-ID: <CAKzfze9e0=W3=XnXbOMnuW8LiaVOuohzX0TgE6D0dJyty9T8Ag@mail.gmail.com>
Subject: Re: [RFC 0/2] iio: add support for LMP91000EVM potentiostat board
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Matt Ranostay <mranostay@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jul 2, 2016 at 3:05 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> LMP91000EVM evaluation board has LMP91000 potentiostat along with an
> 16-bit ADC for chemical sensoring applications.
>
>  * add support for the TI LMP91000 potentiostat
>  * add support for ADC141S626 and ADC161S626 ADC chips

Probably should have put what I am RFC'ing :).

* does this belong in a new path drivers/iio/potentiostat ?
* first example of a iio consumer within drivers/iio, does it seems sane?
* ADC driver has no IIO_CHAN_INFO_SCALE due to no regulators being defined
* Should ADC value be signed or unsigned?   -16636 is 0V, 0 is 2/VA ,
16635 is ~VA. Of course true zero is defined by the VREF voltage.

>
> Matt Ranostay (2):
>   iio: adc: ti-adc1x1s: add support for TI 1-channel differential ADCs
>   iio: potentiostat: add LMP91000 support
>
>  .../devicetree/bindings/iio/adc/ti-adc1x1s.txt     |  16 ++
>  .../bindings/iio/potentiostat/lmp91000.txt         |  28 ++
>  drivers/iio/Kconfig                                |   1 +
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/adc/Kconfig                            |  12 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/ti-adc1x1s.c                       | 233 ++++++++++++++++
>  drivers/iio/potentiostat/Kconfig                   |  21 ++
>  drivers/iio/potentiostat/Makefile                  |   6 +
>  drivers/iio/potentiostat/lmp91000.c                | 303 +++++++++++++++++++++
>  10 files changed, 622 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc1x1s.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
>  create mode 100644 drivers/iio/adc/ti-adc1x1s.c
>  create mode 100644 drivers/iio/potentiostat/Kconfig
>  create mode 100644 drivers/iio/potentiostat/Makefile
>  create mode 100644 drivers/iio/potentiostat/lmp91000.c
>
> --
> 2.7.4
>
