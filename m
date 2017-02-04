Return-Path: <SRS0=bEoA=ZR=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1D4293AF-7894-470C-BF50-3C1A9C0EB247@jic23.retrosnub.co.uk>
References: <20170131100938.23660-1-linus.walleij@linaro.org>
 <CACRpkdYDMH9A=ezPkANRQXcqceEqn-A+oL2TxHyNkjmSms5AOA@mail.gmail.com>
 <0c54c4d8-265c-112e-60f1-af21b73148ec@kernel.org> <CACRpkdYLwVEuOcjyGYo7U=57JY3-R2FCYnEBWFqL89iqm3yEDA@mail.gmail.com>
 <1D4293AF-7894-470C-BF50-3C1A9C0EB247@jic23.retrosnub.co.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 4 Feb 2017 21:33:19 +0100
Message-ID: <CACRpkdb_0QhbqdUoQw4+8SMuDA1e-CZDi1h0eoP+c-D4iru1Ow@mail.gmail.com>
Subject: Re: [PATCH 3/3 v4] iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
	Andy Gross <andy.gross@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
	Stephen Boyd <sboyd@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rama Krishna Phani A <rphani@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Feb 2, 2017 at 5:25 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
> On 2 February 2017 14:47:34 GMT+00:00, Linus Walleij <linus.walleij@linaro.org> wrote:

>>Then I get the following with x86_64 allyesconfig:
(...)
> Drat shows I never build other than modules :)
> Will probably have to be a helper module.

Hahah yeah I guess we resort to that if I can't figure this out,
what a mess. I'm trying my best to figure something out that
works with both allyesconfig and allmodconfig and when I find
it I will use the pattern everywhere for the rest of my life.

Yours,
Linus Walleij
