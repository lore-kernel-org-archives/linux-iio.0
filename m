Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1460466079-15392-1-git-send-email-linus.walleij@linaro.org>
References: <1460466079-15392-1-git-send-email-linus.walleij@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 13 Apr 2016 15:52:22 -0500
Message-ID: <CAL_JsqKudTxbK9goinYCQhGLK=Gd_+PHgQ+mnpkU=cz4pB0k2w@mail.gmail.com>
Subject: Re: [PATCH 4/4 v4] iio: st_sensors: support open drain mode
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Apr 12, 2016 at 8:01 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Some types of ST Sensors can be connected to the same IRQ line
> as other peripherals using open drain. Add a device tree binding
> and a sensor data property to flip the right bit in the interrupt
> control register to enable open drain mode on the INT line.
>
> If the line is set to be open drain, also tag on IRQF_SHARED
> to the IRQ flags when requesting the interrupt, as the whole
> point of using open drain interrupt lines is to share them with
> more than one peripheral (wire-or).
>
> Cc: devicetree@vger.kernel.org
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Rename DT bool property st,int-pin-open-drain to int-pin-open-drain
> - Rob Herring ACKed st,int-pin-open-drain but not including his ACK
>   on this even though it's close

We already have st,irq-open-drain, gpio-open-drain, linux,open-drain
and drive-open-drain (from pinctrl).

If we want something common, then it should probably be part of
interrupt bindings, not something common to IIO.

Rob
