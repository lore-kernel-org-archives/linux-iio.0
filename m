Return-Path: <SRS0=FZ0A=7S=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170816170253.8382-1-lorenzo.bianconi@st.com>
References: <20170816170253.8382-1-lorenzo.bianconi@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Aug 2017 23:07:16 +0200
Message-ID: <CACRpkdbG25mxZA40+6S8bdQZTh7d3o8Eu=iN=ZapKdaKb4_H=Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add support to LIS2MDL magnetometer sensor
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

n Wed, Aug 16, 2017 at 7:02 PM, Lorenzo Bianconi
<lorenzo.bianconi83@gmail.com> wrote:

> Fix two interrupt issues for LSM303AGR magn sensor
>
> Lorenzo Bianconi (4):
>   iio: magnetometer: st_magn: fix status register address for LSM303AGR
>   iio: magnetometer: st_magn: remove ihl property for LSM303AGR
>   iio: magnetometer: add support to LIS2MDL
>   dt-bindings: iio: magn: add LIS2MDL sensor device binding

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
for all the patches.

Yours,
Linus Walleij
