Return-Path: <SRS0=Jxe3=LU=chromium.org=dianders@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180906210454.247219-4-mka@chromium.org>
References: <20180906210454.247219-1-mka@chromium.org> <20180906210454.247219-4-mka@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 6 Sep 2018 14:10:43 -0700
Message-ID: <CAD=FV=WLcgKQWAp8HnBFZhZ4+32keMANcYJ+nGquePqsOnjJ7A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: pm8998: Add die temperature
 channel node to the ADC
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, devicetree@vger.kernel.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi,

On Thu, Sep 6, 2018 at 2:04 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> Add a channel node for the die temperature to the ADC.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Double-SoB?

...presumably Andy can remove that when he lands and doesn't need a re-post...

-Doug
