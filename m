Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
Date: Tue, 24 Mar 2015 11:44:36 +0100
Message-ID: <CACRpkdawMLA=ROND=hp-_J6Ye=By5YYqwgBc0TYViUUpWj8X6w@mail.gmail.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
From: Linus Walleij <linus.walleij@linaro.org>
To: Robert Dolca <robert.dolca@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 23, 2015 at 2:40 PM, Robert Dolca <robert.dolca@intel.com> wrote:

Oh more comments still...

> +       /* Get IRQ GPIO */
> +       gpiod_irq = devm_gpiod_get_index(&client->dev, 0, 0);
> +       if (IS_ERR(gpiod_irq))
> +               return -ENODEV;

Shouldn't that be devm_gpiod_get_index_optional()?

I think the driver is useable also without that GPIO/IRQ
and should not error out. (Will cause bugs in other
platforms!)

Also: maybe the GPIO/IRQ support should be in a separate
patch so as not to confuse with the ACPI stuff.

Yours,
Linus Walleij
