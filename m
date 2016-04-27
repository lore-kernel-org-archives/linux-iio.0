Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CACRpkdZxE4Z6f_0uVV0sD5EUxEigzbMvWRD+MTDWNZbuauVweg@mail.gmail.com>
References: <cover.1461056711.git.gregor.boirie@parrot.com>
	<CACRpkdZxE4Z6f_0uVV0sD5EUxEigzbMvWRD+MTDWNZbuauVweg@mail.gmail.com>
Date: Wed, 27 Apr 2016 14:02:23 +0200
Message-ID: <CACRpkdZ=DSEKi6dOBuxA23ivsQYsoigvG_cC11HR-66aN_BUpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/9] iio:st_sensors: fixes and lps22hb pressure sensor
From: Linus Walleij <linus.walleij@linaro.org>
To: Gregor Boirie <gregor.boirie@parrot.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 27, 2016 at 1:26 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> After the patch:
>
> $ cat in_pressure_raw && cat in_temp_raw
> 15232
> 1652
> $ cat in_pressure_raw && cat in_temp_raw
> 15233
> 1656
> $ cat in_pressure_raw && cat in_temp_raw
> 15234
> 1657

And now I also have in_pressure_scale and in_temp_scale,
which yields these values if I multiply each tuple with the
scale factor:

95.2
25812.5
95.2
25875
95.2
25890

So ~95 kPa, 25.8 degrees celsius.
Seems like my office environment.
An atmosphere is ~100 kPa IIRC.

Yours,
Linus Walleij
