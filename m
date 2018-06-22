Return-Path: <SRS0=wsFM=JI=huawei.com=jonathan.cameron@kernel.org>
Date: Fri, 22 Jun 2018 17:59:25 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
CC: <gregkh@linuxfoundation.org>, <jic23@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<fabrice.gasnier@st.com>, <benjamin.gaignard@st.com>, <robh+dt@kernel.org>,
	<knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
	<mark.rutland@arm.com>
Subject: Re: [PATCH v7 05/10] counter: 104-quad-8: Documentation: Add
 Generic Counter sysfs documentation
Message-ID: <20180622175925.00005cbc@huawei.com>
In-Reply-To: <891d9716ce95bd8568296ef53d5b8d266f7efe3e.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
	<891d9716ce95bd8568296ef53d5b8d266f7efe3e.1529607879.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Thu, 21 Jun 2018 17:08:08 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds standard documentation for the Generic Counter interface
> userspace sysfs attributes of the 104-QUAD-8 driver.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
This stuff is very device specific obviously, but looks fine to me.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../ABI/testing/sysfs-bus-counter-104-quad-8  | 36 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> new file mode 100644
> index 000000000000..062637df3c78
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> @@ -0,0 +1,36 @@
> +What:		/sys/bus/counter/devices/counterX/signalY/index_polarity
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Active level of index input Signal Y; irrelevant in
> +		non-synchronous load mode.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
> +What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_available
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available values for the respective Signal Y
> +		configuration are listed in this file.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Configure the counter associated with Signal Y for
> +		non-synchronous or synchronous load mode. Synchronous load mode
> +		cannot be selected in non-quadrature (Pulse-Direction) clock
> +		mode.
> +
> +		Non-synchronous:
> +			A logic low level is the active level at this index
> +			input. The index function (as enabled via preset_enable)
> +			is performed directly on the active level of the index
> +			input.
> +
> +		Synchronous:
> +			Intended for interfacing with encoder Index output in
> +			quadrature clock mode. The active level is configured
> +			via index_polarity. The index function (as enabled via
> +			preset_enable) is performed synchronously with the
> +			quadrature clock on the active level of the index input.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4083523699f3..a06fd762f5d9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -270,6 +270,7 @@ ACCES 104-QUAD-8 DRIVER
>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
>  F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
>  F:	drivers/counter/104-quad-8.c
>  
