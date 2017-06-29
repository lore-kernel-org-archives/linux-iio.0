Return-Path: <SRS0=b2ZH=6C=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170626225346.12019-2-lorenzo.bianconi@st.com>
References: <20170626225346.12019-1-lorenzo.bianconi@st.com> <20170626225346.12019-2-lorenzo.bianconi@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Jun 2017 14:48:31 +0200
Message-ID: <CACRpkdbF3iVLSr3kBNGmoZjoPX=1KOO74OS3wmTSxFrzqwak3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] iio: accel: st_accel_spi: add OF capability to st_accel_spi
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jun 27, 2017 at 12:53 AM, Lorenzo Bianconi
<lorenzo.bianconi83@gmail.com> wrote:

> Add device tree support for LIS3DH, LSM330D, LSM330DL, LSM330DLC,
> LIS331DLH, LSM330, LSM303AGR, LIS2DH12, LIS3L02DQ, LNG2DM accel sensors.
> Fix LIS302DL support defining of_device_id data field in st_accel_of_match
> table
>
> Fixes: 762227721fe6 (iio: accel: st_accel: handle deprecated bindings)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

Looks right.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
