Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1471002271-11426-1-git-send-email-jarkko.nikula@linux.intel.com>
References: <1471002271-11426-1-git-send-email-jarkko.nikula@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Aug 2016 14:21:49 +0200
Message-ID: <CACRpkdYd2vp9KMMv8sW9iNsWkO-j2deKwY_vdzGvqyGanT91gg@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: Fix incorrect pointer access in PM callbacks
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Aug 12, 2016 at 1:44 PM, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:

> BMP280 runtime PM callbacks are incorrectly casting dev_get_drvdata() to
> struct bmp280_data * while bmp280_common_probe() sets driver data to
> struct iio_dev *. Fix this and get the struct bmp280_data * from private
> data of struct iio_dev.
>
> Fixes: 3d838118c6aa ("iio: pressure: bmp280: add power management")
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> For v4.8-rc.

Sent a fix for this already two weeks ago:
http://marc.info/?l=linux-iio&m=146965159217655&w=2

Just waiting for it to be picked up and merged.

Yours,
Linus Walleij
