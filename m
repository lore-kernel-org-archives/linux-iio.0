Return-Path: <SRS0=zMLN=X4=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL8pJSFb8LbABAYJOQ0URaMpyupbFryk_mS2ToN1kStdA@mail.gmail.com>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-4-git-send-email-benjamin.gaignard@st.com>
 <20161212190205.b5t3x6i2o7igldlo@rob-hp-laptop> <20161213111137.GW3625@dell.home>
 <CAL_JsqL8pJSFb8LbABAYJOQ0URaMpyupbFryk_mS2ToN1kStdA@mail.gmail.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 13 Dec 2016 17:28:36 +0100
Message-ID: <CA+M3ks6CQsOA0w82yiTaCw04e7gRwNx1mfeHanE3MDjkuX-gjg@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] PWM: add pwm-stm32 DT bindings
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
	Linux PWM List <linux-pwm@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Gerald Baeza <gerald.baeza@st.com>,
	Arnaud POULIQUEN <arnaud.pouliquen@st.com>, Linus Walleij <linus.walleij@linaro.org>,
	"linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2016-12-13 16:57 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Tue, Dec 13, 2016 at 5:11 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> On Mon, 12 Dec 2016, Rob Herring wrote:
>>
>>> On Fri, Dec 09, 2016 at 03:15:14PM +0100, Benjamin Gaignard wrote:
>>> > Define bindings for pwm-stm32
>>> >
>>> > version 6:
>>> > - change st,breakinput parameter format to make it usuable on stm32f7=
 too.
>>> >
>>> > version 2:
>>> > - use parameters instead of compatible of handle the hardware configu=
ration
>>> >
>>> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>> > ---
>>> >  .../devicetree/bindings/pwm/pwm-stm32.txt          | 33 ++++++++++++=
++++++++++
>>> >  1 file changed, 33 insertions(+)
>>> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.t=
xt
>>> >
>>> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Do=
cumentation/devicetree/bindings/pwm/pwm-stm32.txt
>>> > new file mode 100644
>>> > index 0000000..866f222
>>> > --- /dev/null
>>> > +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>>> > @@ -0,0 +1,33 @@
>>> > +STMicroelectronics STM32 Timers PWM bindings
>>> > +
>>> > +Must be a sub-node of an STM32 Timers device tree node.
>>> > +See ../mfd/stm32-timers.txt for details about the parent node.
>>> > +
>>> > +Required parameters:
>>> > +- compatible:              Must be "st,stm32-pwm".
>>> > +- pinctrl-names:   Set to "default".
>>> > +- pinctrl-0:               List of phandles pointing to pin configur=
ation nodes for PWM module.
>>> > +                   For Pinctrl properties see ../pinctrl/pinctrl-bin=
dings.txt
>>> > +
>>> > +Optional parameters:
>>> > +- st,breakinput:   Arrays of three u32 <index level filter> to descr=
ibe break input configurations.
>>> > +                   "index" indicates on which break input the config=
uration should be applied.
>>> > +                   "level" gives the active level (0=3Dlow or 1=3Dhi=
gh) for this configuration.
>>> > +                   "filter" gives the filtering value to be applied.
>>> > +
>>> > +Example:
>>> > +   timers@40010000 {
>>>
>>> timer@...
>>
>> No, it should be timers.
>
> Read the spec. "timer" is a generic node name. "timers" is not. How
> many is not relevant.

"timer" is already used in stm32 DT for clocksource node... It is also why
I use "timers" for this.

>
>> The 's' is intentional, since this parent (MFD) device houses 3
>> different types of timers.  The "timer" node is a child of this one.



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
