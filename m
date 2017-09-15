Return-Path: <SRS0=6vnB=AQ=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170914202449.31283-1-Ismail.Kose@maximintegrated.com>
References: <20170914202449.31283-1-Ismail.Kose@maximintegrated.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 15 Sep 2017 09:11:31 +0200
Message-ID: <CACRpkdYDV-kS-VgvvssU4s6Hrg-5MQ5Xh3v3NNxZWMhAwDXxxQ@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ds4422/ds4424 dac driver
To: Ismail Kose <Ismail.Kose@maximintegrated.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, William Breathitt Gray <vilhelm.gray@gmail.com>,
	Jean-Francois Dagenais <jeff.dagenais@gmail.com>, Fabrice Gasnier <fabrice.gasnier@st.com>,
	gwenhael.goavec-merou@trabucayre.com, Peter Rosin <peda@axentia.se>,
	=?UTF-8?Q?Maxime_Roussin=2DB=C3=A9langer?= <maxime.roussinbelanger@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>, "Ismail H. KOSE" <ihkose@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Thu, Sep 14, 2017 at 10:24 PM, Ismail Kose
<Ismail.Kose@maximintegrated.com> wrote:

> +struct ds4424_pdata {
> +       const char *vcc_supply_name;

Should not be needed at all, get the supply directly from the device tree.

> +       uint32_t rfs_res[DS4424_MAX_DAC_CHANNELS];
> +       struct iio_map *dac_iio_map;
> +};

Drop this entire platform data file and move all these fields
you still need into struct ds4424_data.

If you have legacy kernels still using platform data, that's too
bad, we will not maintain them upstream and not merge new
board files using platform data normally, use device tree or ACPI
DSTD only please.

Yours,
Linus Walleij
