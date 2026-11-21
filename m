Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795289407;
	b=d1sm4z2Jx0SLAEAhXBbp2WfOF+Hnynbms7STtIjIgh6zKke/fkYoQHqOehojpV4tcjA/
	 dtWdIvc1NCo4mqcgDjUODe1nFsl0EOhq/HFQtCIPawJzYCzLkQB3T/XwmXcjiH7ohcyq/
	 mEaUkZoup3KMny23ChnbTIVxCy5VO3lbg9A4z5YL8UrmAJoZsn9tE0gaP/c2o6RWV+ec1
	 SCutgv9qF+a6hmqx+8rtqopG5KDTvzZGMBUtBgV4vNh+Xy8EvmWlr/JMnAy29MIkbGQZQ
	 VVNvVL2bEhSRNGwpxLtSr6hEh3eB1FobrPjxHAPfL3XxkXpWFk0kZbk6gkflEgD2Dfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795289407;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=03K4baZo0+hChBw1mPe9JO6QtHiwPqHPetQawahxVho=;
	b=WwL+cCxk6HCAP5e3cnq5+0vZ5+fKZEmO4QF51qQJ06rxpLOR/SK0P8RohcMRqDvdhgaN
	 hi/w2/gI/UWuS09F+wLN8V5O/w+w+Z8cCvCS+eyUNkkxnyzrarnDay61B6HF5yHI/PP68
	 y7HVTY4sSo2IGp6R/BzfG1Pau8dhjKFrcXBJ8NuGgHDAu+xuTmDmkk7kA5ZxAVjYHJFPL
	 Lf0oPivZaLXtBbKplifJlz+2sKNoPzTi4juiYwXtQcEsMW5YtSpNk1sG8qVh73BOVuDEP
	 xJnKr/MorKIZCHvTMEmvxuXfQP/qrrxdE/VtcUQskEOHxE0Lc7PSrw9lhs0jqVSBqfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fakqwj6o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33C1606A33A;
	Sat, 21 Nov 2026 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fakqwj6o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFAE1F000C0;
	Sat, 21 Nov 2026 19:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795289407;
	bh=03K4baZo0+hChBw1mPe9JO6QtHiwPqHPetQawahxVho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fakqwj6oM/jGmcb+SRJARwnoJQCMLKDCzqNnyQW+Iu6HMimP+33FhSLbCV3ZugOwK
	 LtosdVHnVSp3x5z9skhJz0f9zLI8dBOa2b8PxABRj2qos7IAbBT1C9CHUFqGuTf50Q
	 6bCd1KsTqfHb2Hyy9dkQe3+cf6yOUW/Bcj6N+odJDag6hZNahmHT7ALzeW+boEYgYY
	 Zj99kxukNdbsu6qCxPFzhiZFFcVUVSyLT+sPO4wRVXv1moYovEvLeZxWcsAAFum+zk
	 62g7I3kYP9zLg5CpHUUm8ZGJHbxMxy5+bMpnfaQbyW/HrAcyoVnYwpmm4Yt5QzAPyq
	 9M0OL1RBL8Nag==
Date: Sat, 21 Nov 2026 19:29:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Viral Patel <viral8854@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dixit Parmar <dixitparmar19@gmail.com>, Victor
 Chernyakin <chernyakin.victor.j@outlook.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: magnetometer:
 infineon,tlv493d-a1b6: add TLE493D-W2B6
Message-ID: <20261121192959.1ea94de9@jic23-hlaptop>
In-Reply-To: <20261121-tle493d-v2-1-92d7e57cec89@gmail.com>
References: <20261121-tle493d-v2-0-92d7e57cec89@gmail.com>
	<20261121-tle493d-v2-1-92d7e57cec89@gmail.com>
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

On Sat, 21 Nov 2026 11:25:10 +0530
Viral Patel <viral8854@gmail.com> wrote:

> Add the Infineon TLE493D-W2B6, a 3D Hall effect magnetic sensor with
> 12-bit resolution per axis and an integrated temperature sensor,
> accessed over I2C. It is a second-generation sibling of the
> TLV493D-A1B6 with a different register interface, so it gets its own
> compatible, but it has the same supply range and the same /INT output
> sharing the SCL pin, so it fits the existing binding.
> 
> The A0 to A3 variants of the part only differ in their default I2C
> address, so a single compatible covers all of them.
> 
> Signed-off-by: Viral Patel <viral8854@gmail.com>
Hi Viral

A few comments inline.  Nothing to stop me merging this if nothing
else comes up though!

Jonathan

> ---
>  .../bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml   | 14 ++++++++++++--
>  MAINTAINERS                                                |  6 ++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
> index dd23a9370a71..3f0058cbf538 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
> @@ -4,17 +4,27 @@
>  $id: http://devicetree.org/schemas/iio/magnetometer/infineon,tlv493d-a1b6.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Infineon Technologies TLV493D Low-Power 3D Magnetic Sensor
> +title: Infineon Technologies TLV493D and TLE493D 3D Magnetic Sensors
>  
>  maintainers:
>    - Dixit Parmar <dixitparmar19@gmail.com>
> +  - Viral Patel <viral8854@gmail.com>
> +
> +description: |

Don't need to retain line wraps so IIRC > rather than | is appropriate.

> +  3D Hall effect magnetic sensors with an I2C interface. The /INT output
> +  shares a pin with SCL.
> +
> +  The A0 to A3 variants of the TLE493D-W2B6 only differ in their default
> +  I2C address (0x35, 0x22, 0x78 and 0x44).

For a binding I'm not sure we need this level of detail.  Perhaps
just keep the first sentence.  I don't mind either way on this one.

>  
>  properties:
>    $nodename:
>      pattern: '^magnetometer@[0-9a-f]+$'
>  
>    compatible:
> -    const: infineon,tlv493d-a1b6
> +    enum:
> +      - infineon,tle493d-w2b6
> +      - infineon,tlv493d-a1b6
>  
>    reg:
>      maxItems: 1
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 02015eaec312..c3004f683e78 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13117,6 +13117,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/infineon,peb2466.yaml
>  F:	sound/soc/codecs/peb2466.c
>  
> +INFINEON TLE493D-W2B6 DRIVER
> +M:	Viral Patel <viral8854@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
I guess this is fine for most scripts, but I wonder if anything will drip up over
a file being listed in two maintainers entries.  I wouldn't necessarily worry
about adding the binding to here as you have that line in the actual file anyway
to point people to include you on changes etc.


> +
>  INFINEON TLV493D Driver
>  M:	Dixit Parmar <dixitparmar19@gmail.com>
>  L:	linux-iio@vger.kernel.org
> 

