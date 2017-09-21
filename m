Return-Path: <SRS0=wEBv=AW=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170830115043.3738-4-lorenzo.bianconi@st.com>
References: <20170830115043.3738-1-lorenzo.bianconi@st.com> <20170830115043.3738-4-lorenzo.bianconi@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Sep 2017 13:15:55 +0200
Message-ID: <CACRpkdbFvAr26d_ExN-PuazsA_ZbPoOFuCKn-k-s3uwVvd64jg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] iio: st_sensors: do not always write enable_axis register
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@st.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Wed, Aug 30, 2017 at 1:50 PM, Lorenzo Bianconi
<lorenzo.bianconi83@gmail.com> wrote:

> New devices (e.g. LIS2DW12) enable all axis by default and do not export
> that capability in register map. Check if the enable_axis register
> address has been declared in st_sensor_settings map in order to verify if
> the driver needs to enable all sensor axis
>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
