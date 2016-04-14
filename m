Return-Path: <robh@kernel.org>
Date: Thu, 14 Apr 2016 12:09:01 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH 4/4 v5] iio: st_sensors: support open drain mode
Message-ID: <20160414170901.GA9172@rob-hp-laptop>
References: <1460623521-8755-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460623521-8755-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 14, 2016 at 10:45:21AM +0200, Linus Walleij wrote:
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
> ChangeLog v4->v5:
> - Rename DT bool property int-pin-open-drain to drive-mode-open-drain
>   reusing the pin control subsystem binding.
> ChangeLog v3->v4:
> - Rename DT bool property st,int-pin-open-drain to int-pin-open-drain
> - Rob Herring ACKed st,int-pin-open-drain but not including his ACK
>   on this even though it's close
> ChangeLog v2->v3:
> - Rebase on top of the patches fixing the other issues (handling
>   IRQ status check and channel reading bug).
> ChangeLog v1->v2:
> - Rebased to fit the new patch order.
> ---
>  Documentation/devicetree/bindings/iio/st-sensors.txt |  4 ++++

Acked-by: Rob Herring <rob@kernel.org>

>  drivers/iio/accel/st_accel_core.c                    |  8 ++++++++
>  drivers/iio/common/st_sensors/st_sensors_core.c      | 20 ++++++++++++++++++++
>  drivers/iio/common/st_sensors/st_sensors_trigger.c   | 13 +++++++++++++
>  drivers/iio/pressure/st_pressure_core.c              |  8 ++++++++
>  include/linux/iio/common/st_sensors.h                |  6 ++++++
>  include/linux/platform_data/st_sensors_pdata.h       |  2 ++
>  7 files changed, 61 insertions(+)
