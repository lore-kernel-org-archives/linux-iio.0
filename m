Return-Path: <lee.jones@linaro.org>
Date: Thu, 24 Nov 2016 08:52:59 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	alexandre.torgue@st.com, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Gerald Baeza <gerald.baeza@st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 1/7] add binding for stm32 multifunctions timer driver
Message-ID: <20161124085259.GU10134@dell.home>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-2-git-send-email-benjamin.gaignard@st.com>
 <20161122165228.GK10134@dell.home>
 <CA+M3ks4cVLtVe4zSvSiDUz6jKy0Wbw8j24VuStf_31D5ntwfvw@mail.gmail.com>
 <20161123092148.GO10134@dell.home>
 <CA+M3ks6rnago88JC0C5Uj6JpGZGuwyoOj-W8+r7Oj4s8_GuXyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CA+M3ks6rnago88JC0C5Uj6JpGZGuwyoOj-W8+r7Oj4s8_GuXyA@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Rob,

Would you mind casting an eye on this please?

On Wed, 23 Nov 2016, Benjamin Gaignard wrote:
> 2016-11-23 10:21 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> > On Wed, 23 Nov 2016, Benjamin Gaignard wrote:
> >
> >> 2016-11-22 17:52 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> >> > On Tue, 22 Nov 2016, Benjamin Gaignard wrote:
> >> >
> >> >> Add bindings information for stm32 timer MFD
> >> >>
> >> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >> >> ---
> >> >>  .../devicetree/bindings/mfd/stm32-timer.txt        | 53 ++++++++++++++++++++++
> >> >>  1 file changed, 53 insertions(+)
> >> >>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timer.txt
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/mfd/stm32-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-timer.txt
> >> >> new file mode 100644
> >> >> index 0000000..3cefce1
> >> >> --- /dev/null
> >> >> +++ b/Documentation/devicetree/bindings/mfd/stm32-timer.txt
> >> >> @@ -0,0 +1,53 @@
> >> >> +STM32 multifunctions timer driver
> >> >
> >> > "STM32 Multi-Function Timer/PWM device bindings"
> >> >
> >> > Doesn't this shared device have a better name?
> >>
> >> In SoC documentation those hardware blocks are named "advanced-control
> >> timers", "general purpose timers" or "basic timers"
> >> "stm32-timer" name is already used for clock source driver, that why I
> >> have prefix it with mfd
> >
> > MFD is a Linuxisum and has no place in hardware description.
> >
> > Please used one of the names you mentioned above.
> 
> I will go for "st,stm32-advanced-timer"
> 
> >
> > Hopefully the one that best fits.
> >
> >> >> +stm32 timer MFD allow to handle at the same time pwm and IIO timer devices
> >> >
> >> > No need for this sentence.
> >> >
> >> OK
> >>
> >> >> +Required parameters:
> >> >> +- compatible: must be one of the follow value:
> >> >> +     "st,stm32-mfd-timer1"
> >> >> +     "st,stm32-mfd-timer2"
> >> >> +     "st,stm32-mfd-timer3"
> >> >> +     "st,stm32-mfd-timer4"
> >> >> +     "st,stm32-mfd-timer5"
> >> >> +     "st,stm32-mfd-timer6"
> >> >> +     "st,stm32-mfd-timer7"
> >> >> +     "st,stm32-mfd-timer8"
> >> >> +     "st,stm32-mfd-timer9"
> >> >> +     "st,stm32-mfd-timer10"
> >> >> +     "st,stm32-mfd-timer11"
> >> >> +     "st,stm32-mfd-timer12"
> >> >> +     "st,stm32-mfd-timer13"
> >> >> +     "st,stm32-mfd-timer14"
> >> >
> >> > We don't normally number devices.
> >> >
> >> > What's stopping you from simply doing:
> >> >
> >> >         pwm1: pwm1@40010000 {
> >> >                 compatible = "st,stm32-pwm";
> >> >         };
> >> >         pwm2: pwm1@40020000 {
> >> >                 compatible = "st,stm32-pwm";
> >> >         };
> >> >         pwm3: pwm1@40030000 {
> >> >                 compatible = "st,stm32-pwm";
> >> >         };
> >> >
> >>
> >> Because each instance of the hardware is slightly different: number of
> >> pwm channels, triggers capabilities, etc ..
> >> so I need to distinguish them.
> >> Since it look to be a problem I will follow your suggestion and add a
> >> property this driver to be able to identify each instance.
> >> Do you think that "id" parameter (integer for 1 to 14) is acceptable ?
> >
> > Unfortunately not. IDs aren't allowed in DT.
> >
> > What about "pwm-chans" and "trigger"?
> >
> > pwm-chans              : Number of available channels available
> 
> For pwm I need those 4 properties:
> st,pwm-number: the number of PWM devices

st,pwm-num-chan is already documented.

Please use that instead of creating new properties.

> st,complementary: if exist have complementary ouput
> st,32bit-counter: if exist have 32 bits counter
> st,breakinput-polarity: if set enable break input feature.
> 
> Is it acceptable from pwm maintainer point of view ?
> 
> > trigger                : Boolean value specifying whether a timer is present
> 
> Following our discussion on IRC I will try to code for your proposal:
> 
> advanced-timer@40010000 {
>         compatible = "st,stm32-advanced-timer";
>         reg = <0x40010000 0x400>;
>         clocks = <&rcc 0 160>;
>         clock-names = "clk_int";
> 
>         pwm@0 {
>                 compatible = "st,stm32-pwm";
>                 st,pwm-number= <4>;
>                 st,complementary;
>                 st,breakinput;
>         };
> 
>         timer@0 {
>                 reg = <1>;
>                 compatible = "st,stm32-iio-timer";
>                 interrupts = <27>;
>                 triggers = <5 2 3 4>;
>         };
> };
> 
> triggers parameter will be used to know which trigger are valid for
> the IIO device

Except for "st,pwm-number" as mentioned above, this looks good to me.

Rob, would what do you think?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
