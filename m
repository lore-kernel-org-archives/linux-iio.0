Return-Path: <pmeerw@pmeerw.net>
Date: Wed, 30 Sep 2015 07:44:10 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Suresh Rajashekara <sureshraj@google.com>
cc: linux-iio@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com,
    mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
    devicetree@vger.kernel.org, matthias.bgg@gmail.com,
    linux-kernel@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v2 2/2] iio:light:tsl2563: Add DT support
In-Reply-To: <1443576270-36548-2-git-send-email-sureshraj@google.com>
Message-ID: <alpine.DEB.2.02.1509300740590.5858@pmeerw.net>
References: <1443576270-36548-1-git-send-email-sureshraj@google.com> <1443576270-36548-2-git-send-email-sureshraj@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello Suresh,

> * Add Device Tree support for the Dyna Image AP3223 ambient light sensor and
> * proximity driver,
> * Document the binding and
> * Add a vendor prefix for Dyna Image

the mail's subject line should read something like
iio: light: Add AP3223 DT support

tsl2563 is a different driver

> v2
> * Seperating the device tree changes from code

Separating

> 
> Signed-off-by: Suresh Rajashekara <sureshraj@google.com>
> ---
>  Documentation/devicetree/bindings/iio/light/ap3223.txt | 18 ++++++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt  |  1 +
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/ap3223.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/ap3223.txt b/Documentation/devicetree/bindings/iio/light/ap3223.txt
> new file mode 100644
> index 0000000..b255d27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/ap3223.txt
> @@ -0,0 +1,18 @@
> +* Dyna Image AP3223 ambient light sensor and proximity sensor
> +
> +http://www.dyna-image.com/english/product/optical-sensor-detail.php?cpid=2&dpid=8
> +
> +Required properties:
> +
> +  - compatible : should be "dynaimage,ap3223"
> +  - reg : the I2C address of the sensor
> +
> +Example:
> +
> +ap3223@1c {
> +	compatible = "dynaimage,ap3223";
> +	reg = <0x1c>;
> +
> +	pinctrl-0 = <&ap3223_pins>;
> +	pinctrl-names = "default";
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 5f20add..704da45 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -46,6 +46,7 @@ digilent	Diglent, Inc.
>  dlg	Dialog Semiconductor
>  dlink	D-Link Corporation
>  dmo	Data Modul AG
> +dynaimage	Dyna-Image
>  ebv	EBV Elektronik
>  edt	Emerging Display Technologies
>  elan	Elan Microelectronic Corp.
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
