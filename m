Return-Path: <SRS0=Z54M=LS=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
References: <20180904200434.10442-1-afonsobordado@az8.co> <20180904200434.10442-3-afonsobordado@az8.co>
In-Reply-To: <20180904200434.10442-3-afonsobordado@az8.co>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Sep 2018 22:26:01 +0300
Message-ID: <CAHp75Vdptz=mj+FaAwKP1NCZPknZ2T4TCCu99Egzh37wbtQJmQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: fxas21002c: add ODR/Scale support
To: afonsobordado@az8.co
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 4, 2018 at 10:07 PM Afonso Bordado <afonsobordado@az8.co> wrote:
>
> This patch adds support for reading/writing ODR/Scale
>
> We don't support the scale boost modes.

> @@ -44,7 +44,10 @@
>  #define FXAS21002C_REG_F_EVENT         0x0A
>  #define FXAS21002C_REG_INT_SRC_FLAG    0x0B
>  #define FXAS21002C_REG_WHO_AM_I        0x0C
> +
>  #define FXAS21002C_REG_CTRL_REG0       0x0D
> +#define FXAS21002C_SCALE_MASK          GENMASK(1, 0)
> +
>  #define FXAS21002C_REG_RT_CFG          0x0E
>  #define FXAS21002C_REG_RT_SRC          0x0F
>  #define FXAS21002C_REG_RT_THS          0x10

This hunk doesn't belong to this patch.

> +static const int fxas21002c_anglevel_scale_avail[4][2] = {
> +       [FXAS21002C_SCALE_62MDPS] = { 0, IIO_DEGREE_TO_RAD(62500) },
> +       [FXAS21002C_SCALE_31MDPS] = { 0, IIO_DEGREE_TO_RAD(31250) },
> +       [FXAS21002C_SCALE_15MDPS] = { 0, IIO_DEGREE_TO_RAD(15625) },
> +       [FXAS21002C_SCALE_7MDPS]  = { 0, IIO_DEGREE_TO_RAD(7812) },

This is just set of powers of two. No table needed.

> +};

> +static const int fxas21002c_sample_freq_avail[7][2] = {
> +       [FXAS21002C_ODR_800]  = { 800, 0 },
> +       [FXAS21002C_ODR_400]  = { 400, 0 },
> +       [FXAS21002C_ODR_200]  = { 200, 0 },
> +       [FXAS21002C_ODR_100]  = { 100, 0 },
> +       [FXAS21002C_ODR_50]   = { 50, 0 },
> +       [FXAS21002C_ODR_25]   = { 25, 0 },
> +       [FXAS21002C_ODR_12_5] = { 12, 500000 },

Ditto.

> +};


--
With Best Regards,
Andy Shevchenko
