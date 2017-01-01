Return-Path: <SRS0=1Z34=YP=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1480493823-21462-8-git-send-email-peda@axentia.se>
References: <1480493823-21462-1-git-send-email-peda@axentia.se> <1480493823-21462-8-git-send-email-peda@axentia.se>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Jan 2017 17:38:55 +0200
Message-ID: <CAHp75Vc2uYhaYJu_eU-uBq_PZrUgaoNt8sxpuRF8eEEs2kPUwg@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] i2c: i2c-mux-simple: new driver
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
	Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 30, 2016 at 10:17 AM, Peter Rosin <peda@axentia.se> wrote:
> This is a generic simple i2c mux that uses the generic multiplexer
> subsystem to do the muxing.

> +static const struct of_device_id i2c_mux_of_match[] = {
> +       { .compatible = "i2c-mux-simple,parent-locked",
> +         .data = (void *)0, },
> +       { .compatible = "i2c-mux-simple,mux-locked",
> +         .data = (void *)1, },
> +       {},
> +};

Perhaps

#define I2C_MUX_LOCKED_PARENT  0
#define I2C_MUX_LOCKED         1

?

-- 
With Best Regards,
Andy Shevchenko
