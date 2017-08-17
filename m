Return-Path: <SRS0=qZBe=7T=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170816170253.8382-5-lorenzo.bianconi@st.com>
References: <20170816170253.8382-1-lorenzo.bianconi@st.com> <20170816170253.8382-5-lorenzo.bianconi@st.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Thu, 17 Aug 2017 09:01:22 +0200
Message-ID: <CAA2SeN+iPatt4h1B+qkez0HuVd1ZiojjgXkvu5hYLL_xOU5O2g@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: iio: magn: add LIS2MDL sensor device binding
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo BIANCONI <lorenzo.bianconi@st.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Added devicetree ml in cc

> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> ---
>  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> index 1e305f61f3df..9ec6f5ce54fc 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -64,6 +64,7 @@ Magnetometers:
>  - st,lsm303dlhc-magn
>  - st,lsm303dlm-magn
>  - st,lis3mdl-magn
> +- st,lis2mdl
>
>  Pressure sensors:
>  - st,lps001wp-press
> --
> 2.14.0
>
