Return-Path: <SRS0=Fxpb=GC=googlemail.com=martin.blumenstingl@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180308093153.GB16525@mwanda>
References: <20180308093153.GB16525@mwanda>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 12 Mar 2018 21:43:19 +0100
Message-ID: <CAFBinCCV7ioofBc7MU6mr4JrVQPMZfMG-kFPB6bcFCJNoMrPPA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson-saradc: unlock on error in meson_sar_adc_lock()
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Carlo Caione <carlo@caione.org>,
	Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
	Paolo Cretaro <paolocretaro@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>, Xingyu Chen <xingyu.chen@amlogic.com>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Dan,

On Thu, Mar 8, 2018 at 10:31 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> The meson_sar_adc_lock() function is not supposed to hold the
> "indio_dev->mlock" on the error path.
>
> Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

(even if I might be too late already since Jonathan already applied this patch)

thank you for finding and fixing this!
out of curiosity: did you find this with some tool (sparse?) or by
looking at the code?


Regards
Martin
