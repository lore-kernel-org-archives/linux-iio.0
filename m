Return-Path: <SRS0=b2ZH=6C=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170627002533.97293-1-mka@chromium.org>
References: <20170627002533.97293-1-mka@chromium.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Jun 2017 14:51:56 +0200
Message-ID: <CACRpkdZGUDryau4SMHwa3QDG-vrDrB9bkB9iKrxAcs-R2YDLQw@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: Only declare ACPI table when ACPI is enable
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jun 27, 2017 at 2:25 AM, Matthias Kaehlcke <mka@chromium.org> wrote:

> Don't inflate the kernel size with data that isn't used. The conditional
> declaration also fixes the following warning when building with clang:
>
> drivers/iio/magnetometer/ak8975.c:704:36: error: variable 'ak_acpi_match'
>   is not needed and will not be emitted
>   [-Werror,-Wunneeded-internal-declaration]
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
