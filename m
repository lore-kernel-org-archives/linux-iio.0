Return-Path: <SRS0=9gR9=3R=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <46160aa5-f4f0-56a9-7105-50469b9089d1@kernel.org>
References: <20170404120819.6921-1-linus.walleij@linaro.org>
 <20170404120819.6921-3-linus.walleij@linaro.org> <46160aa5-f4f0-56a9-7105-50469b9089d1@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Apr 2017 01:09:22 +0200
Message-ID: <CACRpkdbrxaosJd9+GRY-cCbAdEX6E6nX+SNuxVimyPTNR5T2=g@mail.gmail.com>
Subject: Re: [PATCH 3/3 v5] iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
	Andy Gross <andy.gross@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
	Stephen Boyd <sboyd@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rama Krishna Phani A <rphani@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Apr 8, 2017 at 6:47 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> If you have time, it would be great to make these build
> with COMPILE_TEST to get some better build coverage in general..
> I bodged it in for the MFD and it works but there may be other
> hidden dependencies.

That's what I did too. I'll make a proper patch and send to Lee
and see what happens in the autobuilders if we do that.

Yours,
Linus Walleij
