Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371998;
	b=iOIqpvBhQvPdsDo/XQkk02s7ipE7LbUfRpfKW39HTT87LBlP7P94+p3w9COAN2e+qiX7
	 vpYc0ULpEkQIn7tQLfCn/7kcfYz3Rq6Y4OpjeGLQfb07XxyOKRp4XXqV9ZAlU6hToi8kr
	 tYExuyjZg/47Ejy7SWNZJ7h4gfr1QUPBtFOVCtmmvPGL16VR4RwptXTOBqFYKReI8lhk2
	 WY8Orhabdvq4Xr80f8E2MMmoxmDpudL5ojRspYWVq3fMZK/lV+Gxl5SCuDMxVtvciUoI6
	 83V+D4rD/G6+Shku5oYJJto/YcbuPcqUml633sUVp6hJdftHCQg+0HrWCkwDp9JWhaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371998;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZzhNnPgB2Wlr2bjnDZCcd0zumtaYtjaiOyOvRDsDDWc=;
	b=q7BO1hVSm+8G7LShGCF7cixOItgNMaZQ8tlJOCt9eTP91qTs818NSAAWwzyC9JenV/ic
	 v8q6zIE1OouIEgyOt9jM12ETCC1fHqJxUcV2ELOZc4G4Ny0fPHijW7g2Yzkh4pKfUQzqW
	 QHsANTfe8DXqGqRAcZuMvL8UfMX5vVE2A9EOhT5gmTr+0+fZf8msKMwdyXdxCEDjAUfzi
	 YT4nFt6Cj6I7sx27K5z/i6V/NJKyw1pHc3oF2rTEjjAWGrtkuD1wuRc9ZmPFHBMbRhGNm
	 /9VUhKMPAnB3Ir3MnGMrsFTObVxFVCuKWcaqW2mYA2BCgqN0qsYSusPTQ10G3ammFiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yzgxr2ej;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B928606A685;
	Sun, 22 Nov 2026 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yzgxr2ej
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B175D1F000C4;
	Sun, 22 Nov 2026 18:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795371997;
	bh=ZzhNnPgB2Wlr2bjnDZCcd0zumtaYtjaiOyOvRDsDDWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yzgxr2ejXJe0BOIhOE5AULrMJEydlhLuKmMjy+u2XG9AH5jq6OcPawP+CaahVOKH6
	 Gtaeh6SEFjfmQyuDP/hUcAJMPkFWvaPwAxHKY4ts8eYKse19v15DWUv7yd4onMVzW/
	 vvL4xIZrj2X/eNF+9e3saggmGH07GF44a2nJXBITRbp8vm4xEJUfuj0NziZKS+/SN+
	 8eOtwfsMFRMA+UaG+lPzJVm6kh8I4O0l0iUyp1IDACsVV0cKVQNFesi8dWqdW13hVA
	 /hxI+Hk3yypbLfgPPvyKR2VIyRIW3Cnm2AyyHRdLuQwtUCIAUgTUNW6BkDXeLywj+W
	 Ge5H+JZfIXPrA==
Date: Sun, 22 Nov 2026 18:26:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gerard Marull-Paretas <gerard@teslabs.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: magnetometer: Add MEMSIC MMC5603
Message-ID: <20261122182635.381d2cbd@jic23-hlaptop>
In-Reply-To: <20261122093412.71604-1-gerard@teslabs.com>
References: <20261122093412.71604-1-gerard@teslabs.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Nov 2026 10:34:12 +0100
Gerard Marull-Paretas <gerard@teslabs.com> wrote:

> The MMC5603NJ is listed in trivial-devices.yaml, which allows no
> properties besides the register address and interrupts. Boards need to
> describe how the sensor is oriented, and the supply it runs from, which
> is often switched on wearables.

Why this part but not the mmc5633 that is in the same driver so I assume
similar enough to cover with this binding?

That part is a little more complex because it can also be connected over
i3c but I'd still expect them in the same binding doc.

> 
> Give it a binding of its own with a mount-matrix and its single VDD
> supply, the package having no separate I/O supply pin.
> 

I'm not seeing support in the driver for mount matrix or supply.
Normally if the argument is to move it out of trivial devices because
it needs those I'd expect to see it as part of a series adding that
support.

Or do you care about this for a non Linux usecase?

Also no need to talk about what it doesn't have.

> Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
> ---
> 
> Notes:
>     Checked with dtschema 2026.9: the steps of dt_binding_check run by hand (host make too old), yamllint and dt-check-style --mode=strict.
> 
>  .../iio/magnetometer/memsic,mmc5603.yaml      | 45 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 45 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5603.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5603.yaml b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5603.yaml
> new file mode 100644
> index 000000000000..039f53a5f912
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5603.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/memsic,mmc5603.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MEMSIC MMC5603NJ 3-axis magnetic sensor
> +
> +maintainers:
> +  - Gerard Marull-Paretas <gerard@teslabs.com>
> +
> +properties:
> +  compatible:
> +    const: memsic,mmc5603
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        magnetometer@30 {
> +            compatible = "memsic,mmc5603";
> +            reg = <0x30>;
> +            vdd-supply = <&vdd_1v8_reg>;
> +            mount-matrix = "-1", "0", "0",
> +                           "0", "1", "0",
> +                           "0", "0", "-1";
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index a8b2b9deade4..17a32dd8772e 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -261,8 +261,6 @@ properties:
>            - meas,tsys01
>              # MEMSIC magnetometer
>            - memsic,mmc35240
> -            # MEMSIC 3-axis magnetometer
> -          - memsic,mmc5603
>              # MEMSIC 3-axis magnetometer (Support I3C HDR)
>            - memsic,mmc5633
>              # MEMSIC 3-axis accelerometer
> 
> base-commit: c44104f3642da720164042623e4832836aefdd8e

