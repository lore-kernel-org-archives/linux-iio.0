Return-Path: <SRS0=Tcyg=ZM=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170117142515.10578-1-linus.walleij@linaro.org>
References: <20170117142515.10578-1-linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Jan 2017 10:13:33 +0100
Message-ID: <CACRpkdahNEkGoSaNYVtfBUFHqiN50rj65WmjkxYXrSoMXZbwgQ@mail.gmail.com>
Subject: Re: [PATCH 1/3 v3] iio: adc: add device tree bindings for Qualcomm
 PM8xxx ADCs
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
	Andy Gross <andy.gross@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
	Stephen Boyd <sboyd@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rama Krishna Phani A <rphani@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jan 17, 2017 at 3:25 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds the device tree bindings for the Qualcomm PM8xxx
> ADCs. This is based on the existing DT bindings for the
> SPMI ADC so there are hopefully no controversial features.
>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: Ivan T. Ivanov <iivanov.xz@gmail.com>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Rama Krishna Phani A <rphani@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:

Jonathan, can we merge this? At least the device tree bindings,
I don't see any specific problems with them.

Yours,
Linus Walleij
