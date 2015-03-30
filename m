Return-Path: <mika.westerberg@linux.intel.com>
Date: Mon, 30 Mar 2015 17:18:15 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
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
Message-ID: <20150330141815.GG1524@lahna.fi.intel.com>
References: <CAE1zotL0Si3=dGLGPmq0CGhc+tsJwDxY8GYwh8fcHA-1jcBdqA@mail.gmail.com>
 <20150326144753.GO1878@lahna.fi.intel.com>
 <CAE1zot+67M96HbMnorYxEd06r=Aew=x830sCXoovBCCy_YMF7w@mail.gmail.com>
 <CAE1zot+MaycNK91yOMLAfdvo=f21S9hts9ufk4krBMJ7PNYogA@mail.gmail.com>
 <20150327100627.GW1878@lahna.fi.intel.com>
 <CACRpkda9pUqy9r9EUSfzC5ntqKpH_CywcLJLDXCUa25U_cgFgg@mail.gmail.com>
 <20150330095254.GB1524@lahna.fi.intel.com>
 <CAE1zotJCo2oUJLb3ETozxutFCXUD8gKZeUL-qWj-Y8gW0idr8Q@mail.gmail.com>
 <20150330133307.GE1524@lahna.fi.intel.com>
 <CAE1zot+CTmWaszPjuUj69WNgBgqJMccF48to-9txVPNfYu-GGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE1zot+CTmWaszPjuUj69WNgBgqJMccF48to-9txVPNfYu-GGg@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 30, 2015 at 04:52:49PM +0300, Octavian Purdila wrote:
> What if we can do the pin configuration in gpiolib right after the
> GPIO controller is initialized. I am thinking of searching the ACPI
> namespace and looking for resources that have GpioInt entries for that
> particular GPIO controller and use them to set the pins to input (and
> ideally also set the other properties like pullups, pulldowns, etc.)

The pinctrl subsystem can do this already but currently there is no ACPI
support. Using information from GpioInt to fill pinctrl pin
configuration sounds good to me.
