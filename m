Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:24894 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757AbbC3JxE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 30 Mar 2015 05:53:04 -0400
Date: Mon, 30 Mar 2015 12:52:54 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
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
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
Message-ID: <20150330095254.GB1524@lahna.fi.intel.com>
References: <CAE1zotJas26oRGdext7V69mNNyaYT3Ds7+Ruhg_kNKBf-Ewoew@mail.gmail.com>
 <20150326101616.GD1878@lahna.fi.intel.com>
 <CAE1zotKAJBS2_rnYG9K0DxbvVP9-G4iGm_E+b5jQtHVYjiQwVA@mail.gmail.com>
 <20150326140430.GM1878@lahna.fi.intel.com>
 <CAE1zotL0Si3=dGLGPmq0CGhc+tsJwDxY8GYwh8fcHA-1jcBdqA@mail.gmail.com>
 <20150326144753.GO1878@lahna.fi.intel.com>
 <CAE1zot+67M96HbMnorYxEd06r=Aew=x830sCXoovBCCy_YMF7w@mail.gmail.com>
 <CAE1zot+MaycNK91yOMLAfdvo=f21S9hts9ufk4krBMJ7PNYogA@mail.gmail.com>
 <20150327100627.GW1878@lahna.fi.intel.com>
 <CACRpkda9pUqy9r9EUSfzC5ntqKpH_CywcLJLDXCUa25U_cgFgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkda9pUqy9r9EUSfzC5ntqKpH_CywcLJLDXCUa25U_cgFgg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 27, 2015 at 11:36:25AM +0100, Linus Walleij wrote:
> On Fri, Mar 27, 2015 at 11:06 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Thu, Mar 26, 2015 at 06:28:19PM +0200, Octavian Purdila wrote:
> 
> >> For the sleep case I think the GPIO controller needs to do the pin
> >> enable and set input direction operation in it's irq_bus_sync_unlock.
> >
> > I wonder how DT handles all this? Is it the boot firmware that sets up
> > the pins accordingly or is there something we are missing?
> 
> DT systems mostly do not have firmware for power usecases, they
> handle it all using pin control. I would more say that is a feature of
> all-SW systems without power-firmware ideas, without ACPI and
> without PSCI (well PSCI systems do not care about much more
> than CPU power down in firmware anyway...)

OK, thanks.

In case of ACPI (where firmware does lot more) it is supposed to
configure pins based on what is connected, if the firmware knows that.
Due to bugs in the boot firmware that obviously does not happen in all
cases (like this one).

If we want to support requesting IRQ directly through irqchip interface
on ACPI systems there needs to be some way the GPIO/pinctrl core can use
to turn the pin as input, GPIO mode.

Octavian's patch does that but not sure if it is good idea for non-ACPI
systems as they already work. We could also do the same in GPIO/irqchip
drivers but there is no guarantee for the caller that it is done. IMHO
safest option is to explictly request the GPIO, turn it input and then
convert the GPIO to interrupt. That way we know the pin is configured
just like we expect.
