Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35272 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbCYIof (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2015 04:44:35 -0400
Received: by oiag65 with SMTP id g65so15582005oia.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2015 01:44:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150324150630.GP1878@lahna.fi.intel.com>
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
	<551155C3.2030403@metafoo.de>
	<CAFPB+YdwrPoob1CPdUfSt2uBJWPi=6_0-d0NChj2agD6-z-8qw@mail.gmail.com>
	<551168F0.1090901@metafoo.de>
	<CACRpkdaOQ-onkgQJSyoVEQNtkZ9nF_4z=9jNdU-tug-TwvAAkQ@mail.gmail.com>
	<20150324150630.GP1878@lahna.fi.intel.com>
Date: Wed, 25 Mar 2015 09:44:34 +0100
Message-ID: <CACRpkdYmN5YnH5rcA13NerPKdx62TpQVi5Hwr1vchu13QUcaOw@mail.gmail.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
From: Linus Walleij <linus.walleij@linaro.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Robert Dolca <robert.dolca@gmail.com>,
	Robert Dolca <robert.dolca@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 24, 2015 at 4:06 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> This has few problems that I have not yet figured out. Maybe someone
> here can suggest what to do:
>
>  1) Who is responsible in releasing the GPIO?
>  2) What if the driver wants to use that pin as a GPIO instead? The GPIO
>     is already requested by the I2C core.

In the DT usecase we actually specify that in the DTS file
so we don't have the problem. Either the consumer accesses
the irqchip API with:

interrupts = <nn nn>;

or it accesses the GPIO API with:

gpios = <nn nn>;

so in that sense it is clear what is requested. Then the core
of course uses gpiochip_lock/unlock_as_irq() to handle the
case where bugs make a collision (like if both were specified
and both APIs tries to access the same resource).

But as long as the DTS file is consistent there is no problem.

So it seems the ACPI tables are lacking this semantic
information?

Yours,
Linus Walleij
