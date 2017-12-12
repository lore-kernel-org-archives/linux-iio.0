Return-Path: <SRS0=Sdxo=DI=suse.de=afaerber@kernel.org>
Subject: Re: [PATCH v4 3/3] dt-bindings: iio: temperature: add MLX90632 device
 bindings
To: Crt Mori <cmo@melexis.com>, Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20171211092002.8687-1-cmo@melexis.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <13b298c0-d618-e217-406d-63bac56106fc@suse.de>
Date: Tue, 12 Dec 2017 18:45:48 +0100
MIME-Version: 1.0
In-Reply-To: <20171211092002.8687-1-cmo@melexis.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Am 11.12.2017 um 10:20 schrieb Crt Mori:
> Add device tree bindings for MLX90632 IR temperature sensor.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/iio/temperature/mlx90632.txt          | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
> new file mode 100644
> index 000000000000..0b05812001f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
[...]
> +Example:
> +
> +mlx90632@3a {

Shouldn't the node name be more general like temperature@3a?

> +	compatible = "melexis,mlx90632";
> +	reg = <0x3a>;
> +};

Also generally the dt-bindings patch should go before the first use of
the compatible string.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
