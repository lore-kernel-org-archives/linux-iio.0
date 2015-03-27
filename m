Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34013 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbbC0KgZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2015 06:36:25 -0400
Received: by obbgh1 with SMTP id gh1so5522096obb.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2015 03:36:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150327100627.GW1878@lahna.fi.intel.com>
References: <20150325122505.GX1878@lahna.fi.intel.com>
	<20150325132116.GY1878@lahna.fi.intel.com>
	<CAE1zotJas26oRGdext7V69mNNyaYT3Ds7+Ruhg_kNKBf-Ewoew@mail.gmail.com>
	<20150326101616.GD1878@lahna.fi.intel.com>
	<CAE1zotKAJBS2_rnYG9K0DxbvVP9-G4iGm_E+b5jQtHVYjiQwVA@mail.gmail.com>
	<20150326140430.GM1878@lahna.fi.intel.com>
	<CAE1zotL0Si3=dGLGPmq0CGhc+tsJwDxY8GYwh8fcHA-1jcBdqA@mail.gmail.com>
	<20150326144753.GO1878@lahna.fi.intel.com>
	<CAE1zot+67M96HbMnorYxEd06r=Aew=x830sCXoovBCCy_YMF7w@mail.gmail.com>
	<CAE1zot+MaycNK91yOMLAfdvo=f21S9hts9ufk4krBMJ7PNYogA@mail.gmail.com>
	<20150327100627.GW1878@lahna.fi.intel.com>
Date: Fri, 27 Mar 2015 11:36:25 +0100
Message-ID: <CACRpkda9pUqy9r9EUSfzC5ntqKpH_CywcLJLDXCUa25U_cgFgg@mail.gmail.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
From: Linus Walleij <linus.walleij@linaro.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
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

On Fri, Mar 27, 2015 at 11:06 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Thu, Mar 26, 2015 at 06:28:19PM +0200, Octavian Purdila wrote:

>> For the sleep case I think the GPIO controller needs to do the pin
>> enable and set input direction operation in it's irq_bus_sync_unlock.
>
> I wonder how DT handles all this? Is it the boot firmware that sets up
> the pins accordingly or is there something we are missing?

DT systems mostly do not have firmware for power usecases, they
handle it all using pin control. I would more say that is a feature of
all-SW systems without power-firmware ideas, without ACPI and
without PSCI (well PSCI systems do not care about much more
than CPU power down in firmware anyway...)

Sometimes the power-down/up path includes driving pins to
GND using the generic pin config option PIN_CONFIG_OUTPUT to
drive the logic.

For details on this mess where HW designers think that low-power
sleep mode is "GPIO-something" see Documentation/pinctrl.txt
section named "GPIO mode pitfalls". I..e the question is not what
registers are involved and what these are named, but the actual
usecase.

Yours,
Linus Walleij
