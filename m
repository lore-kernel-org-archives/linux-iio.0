Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
Date: Tue, 24 Mar 2015 11:22:40 +0100
Message-ID: <CACRpkdb6BkCfPw7tdv-Mo8VWVGjUB=3u5izP4CaOkiwzxoJUtw@mail.gmail.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
From: Linus Walleij <linus.walleij@linaro.org>
To: Robert Dolca <robert.dolca@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 23, 2015 at 2:40 PM, Robert Dolca <robert.dolca@intel.com> wrote:

> Signed-off-by: Robert Dolca <robert.dolca@intel.com>

That's a very terse commit message.

> +       /* Get IRQ GPIO */
> +       gpiod_irq = devm_gpiod_get_index(&client->dev, 0, 0);
> +       if (IS_ERR(gpiod_irq))
> +               return -ENODEV;
> +
> +       /* Configure IRQ GPIO */
> +       ret = gpiod_direction_input(gpiod_irq);
> +       if (ret)
> +               return ret;


Why issue two calls when one is enough. And don't discard
the nice return code. Do this instead:

gpiod_irq = devm_gpiod_get_index(&client->dev, 0, 0, GPIOD_IN);
if (IS_ERR(gpiod_irq))
        return PTR_ERR(gpiod_irq);

Yours,
Linus Walleij
