Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:64088 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbaLAOIq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Dec 2014 09:08:46 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so4349507ier.20
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2014 06:08:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <547C4A26.3070108@nod.at>
References: <547B4464.9090300@nod.at>
	<E1XvOXs-00014Z-6F@stardust.g4.wien.funkfeuer.at>
	<547C4A26.3070108@nod.at>
Date: Mon, 1 Dec 2014 15:08:45 +0100
Message-ID: <CACRpkdbSUJMF_1_8aZ+ECHAT+ztsa4jXuSFo_+V9gr1MzsNCcg@mail.gmail.com>
Subject: Re: iio: dht11 broken
From: Linus Walleij <linus.walleij@linaro.org>
To: Richard Weinberger <richard@nod.at>
Cc: Harald Geyer <harald@ccbib.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Stephen Warren <swarren@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Dec 1, 2014 at 11:59 AM, Richard Weinberger <richard@nod.at> wrote:
> Am 01.12.2014 um 11:49 schrieb Harald Geyer:

>> Any input from gpiolib people about what the proper fix would be in
>> their opinion, of course is appreciated. I don't think the dht11 driver
>> is doing anything unreasonable per se, so maybe they can clarify how
>> the API is intended to be used?
>
> Your driver sets up a GPIO as IRQ and then you switch the mode to output
> to enable the DHT sensor.
> This is not an API issue, it is an design issue.
> I'm not a hardware expert but AFAIK setting an IRQ pin into output mode can
> lead to undefined behavior.

Well that check is there exactly to prevent madness like this.

IRQs on pins set to output *does* *not* *make* *sense*.

Remove the IRQ before setting the pin to output and vice
versa and everyone will be happier.

Yours,
Linus Walleij
