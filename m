Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1091A3160;
	Mon, 21 Sep 2026 01:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789954450; cv=none; b=saR9KTYahqypO7cbEJFSMEjWdnk7Z4A3gRTbt9A9m9Ps5pQCF1rBQuEFSOvf5dhydBJzEgrvvyj3U0ZQ1MkKEBxG9XbAZbscS2SIrfAfLCi06Uu707CtTP+pjc+/L2BXg8diXAHUYiR3KEBGGV3rwyj2roH/hxSR2jmwk7L4jgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789954450; c=relaxed/simple;
	bh=9lZmMMVNTLVNNix/PYd37VtKi1Mu4DSGOhNY2bQIt8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOITBKF+GcMfWq4uiEbBibgWrMouecsjK3GOAsDHd0cYwLtomjQ6zoNEUvVmy1/WzJrDeCdYDj6yWNaTb3h5Enc8Bql18wE9SiQik4kTDmEO2yoafY1hIG5Hau1603xSITsoEoAK6rMXp6rcbgf0JXf9unlomcLHYCGjtRffKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQxiiLrQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQxiiLrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3711F000FF;
	Mon, 21 Sep 2026 01:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789954448;
	bh=rvLHmV27fQxW73eYvNxFQ1B1ClRJ+MKyKUA+T9i2g5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UQxiiLrQUlfCjlMikGm4B8ntkRiKi6JVgUVg5h35C+vrAfuM6Jg3fpJtUWmtE48Ne
	 ySdCGncC2x3z1ae+OiIip/SHDa3q/Sl8VduZKdOysV9FR7mv+Ax4f3bDX6SaqVNXdH
	 5MoqcsKPiC0Mgzz9nao/R3IAlsbVZLCTQ2OYSiTkZfuNmHJH67ObAZL0JYjmUwfufj
	 JLvNZB1LvhtWF/mLB4UpkpA9YzMfsCB9LPpZnbf3vwOpXkRhNw7VGQ/dA5a2kgMrf0
	 maj97h78pma735lInuw5RlV4ToPQCiGdxdYP7v6Hs8nbf3mGHekNXm6ERuilTXCvCR
	 nOC9uIdTmvOPw==
Date: Mon, 21 Sep 2026 02:34:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andy@kernel.org>, <Michael.Hennerich@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 10/15] dt-bindings: iio: adc: adi,ad4134: Document
 external multiplexer usage
Message-ID: <20260921023402.64d22eeb@jic23-hlaptop>
In-Reply-To: <a2de3620e1d712b69ed121fbc340bd1f5e1a49e4.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
	<a2de3620e1d712b69ed121fbc340bd1f5e1a49e4.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Sep 2026 16:15:05 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The AD4134 design has two data interfaces. One interface allows register
> access for device configuration while the other (separate interface)
> provides ADC sample data. One way of handling both peripheral interfaces =
is
> to merge them into a single SPI interface by switching between register
> access and sample access according to device user requests. Though, such
> solution requires extra hardware, external to the ADC chip. The access mo=
de
> switch can be done with an external multiplexer selecting either AD4134 S=
DO
> or AD4134 DOUT0 to connect to the controller. The external multiplexer
> becomes part of hardware requested for AD4134 device operation and thus
> must be provided for operating the peripheral in such merged interface
> schema. Still, there are alternative ways of handling the two AD4134 data
> interfaces so the multiplexer is not always required.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> New patch.
>=20
> Detailed reasoning for the external multiplexer usage.
>=20
> Before coming to the current solution, the following configuration was tr=
ied.
>=20
>   +-----------------------+                           +-----------------+
>   |       AD4134          |                           | SPI Controller  |
>   |                       |                           |                 |
>   | SPI interface         |                           |                 |
>   | for register     SCLK |<--------------------------| SCLK            |
>   | access             CS |<--------------------------| CS              |
>   |                   SDI |<--------------------------| SDO             |
>   |                   SDO |---+                       |                 |
>   |                       |   |                       |                 |
>   | Data interface  DOUT0 |---+---------------------->| SDI0            |
>   | for ADC data    DOUT1 |-------------------------->| SDI1            |
>   | read back       DOUT2 |-------------------------->| SDI2            |
>   |                 DOUT3 |-------------------------->| SDI3            |
>   |                 DCLK  |<--------------------------| DCLK
>   |                 ODR   |<------------------+    +->| Offload Trigger |
>   +-----------------------+                   |    |  +-----------------+
>                                               |    +--| PWM1            |
>                                               +-------| PWM0            |
>                                               +-------| GPIO            |
>                                                       +-----------------+
>=20
> Though, because DOUT0 never goes high-Z, the DOUT0 pin keeps driving the =
data
> line, causing register reads to fail.=20
>=20
> Alternatively, we could have something like
>=20
>   +-----------------------+                           +-----------------+
>   |       AD4134          |                           | SPI Controller  |
>   |                       |                           |                 |
>   | SPI interface         |                           |                 |
>   | for register     SCLK |<--------------------------| SCLK            |
>   | access             CS |<--------------------------| CS              |
>   |                   SDI |<--------------------------| SDO             |
>   |                   SDO |-------------------------->| SDI0            |
>   |                       |                           |                 |
>   | Data interface  DOUT0 |-------------------------->| SDI1            |
>   | for ADC data    DOUT1 |-------------------------->| SDI2            |
>   | read back       DOUT2 |-------------------------->| SDI3            |
>   |                 DOUT3 |-------------------------->| SDI4            |
>   |                 DCLK  |<--------------------------| DCLK
>   |                 ODR   |<------------------+    +->| Offload Trigger |
>   +-----------------------+                   |    |  +-----------------+
>                                               |    +--| PWM1            |
>                                               +-------| PWM0            |
>                                               +-------| GPIO            |
>                                                       +-----------------+
>=20
> The downside of the above is the peripheral would need fine-grained confi=
g of
> controller SDI lines to only read SDI0 for register access, and only read=
 SDI1,
> SDI2, SDI3, SDI4 for ADC sample data (currently available
> SPI_MULTI_LANE_MODE_STRIPE reads from all SDI lines).
>=20
> The currently proposed solution looks like the following
>=20
>   +-----------------------+                         +-----------------+
>   |         AD4134        |                         | SPI Controller  |
>   |                       |                         |                 |
>   | SPI interface    SCLK |<------------------------| SCLK            |
>   | for register       CS |<------------------------| CS              |
>   | access            SDI |<------------------------| SDO             |
>   |                   SDO |------->|=C2=AF=C2=AF=C2=AF=C2=AF\           |=
                 |
>   |                       |        |MUX  >--------->| SDI0            |
>   | Data interface  DOUT0 |------->|____/           |                 |
>   | for ADC sample        |          ^              |                 |
>   | data read       DOUT1 |------------------------>| SDI1            |
>   |                 DOUT2 |------------------------>| SDI2            |
>   |                 DOUT3 |------------------------>| SDI3            |
>   |                  DCLK |<------------------------| DCLK            |
>   |                   ODR |<----------------+    +->| Offload Trigger |
>   +-----------------------+          |      |    |  +-----------------+
>                                      |      |    +--| PWM1            |
>                                      |      +-------| PWM0            |
>                                      |      +-------| GPIO0           |
>                                      +--------------| GPIO1           |
>                                                     +-----------------+
>=20
> By being able to mux between AD4134 SDO and AD4134 DOUT0, the peripheral =
can be
> connected to a single bus such that controllers able to read from multipl=
e lines
> will be able to gather ADC sample data from all SDI lines (SPI_MULTI_LANE=
_MODE_STRIPE).
> With that, AD4134 maximum data throughput can be supported with what is a=
lready
> available from the SPI core. See additional details on the AD4134 IIO
> documentation (patch 15).
>=20
> Yet another possibility would be to have the peripheral connecting to two=
 buses.
>=20
>   +-----------------------+                           +-----------------+
>   |       AD4134          |                           | SPI Controller A|
>   |                       |                           |                 |
>   | SPI interface    SCLK |<--------------------------| SCLK            |
>   | for register       CS |<--------------------------| CS              |
>   | access            SDI |<--------------------------| SDO             |
>   |                   SDO |-------------------------->| SDI             |
>   |                       |                           +-----------------+
>   |                       |                           | SPI Controller B|
>   |                       |                           |                 |
>   | Data interface  DOUT0 |-------------------------->| SDI0            |
>   | for ADC sample  DOUT1 |-------------------------->| SDI1            |
>   | data read       DOUT2 |-------------------------->| SDI2            |
>   |                 DOUT3 |-------------------------->| SDI3            |
>   |                 DCLK  |<--------------------------| DCLK            |
>   |                 ODR   |<------------------+    +->| Offload Trigger |
>   +-----------------------+                   |    |  +-----------------+
>                                               |    +--| PWM1            |
>                                               +-------| PWM0            |
>                                               +-------| GPIO            |
>                                                       +-----------------+
>=20
> That may be a fallback option if what's currently being proposed fails to=
 comply
> to Linux code standards.

I'm not against the MUX option but would imagine anyone reading
the datasheet is at least someone likely to choose this last version.
Still until we have a user for that as far as I am concerned the mux
one is fine.

>=20
>=20
>  .../devicetree/bindings/iio/adc/adi,ad4134.yaml    | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> index 012e09decf7a..d89134ce4af6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> @@ -104,6 +104,20 @@ properties:
>        GPIO connected to ODR pin. Used to sample ADC data in minimum I/O =
mode.
>      maxItems: 1
> =20
> +  mux-states:
> +    description:
> +      mux controller node to route SDO and DOUT0 signals from peripheral=
 to
> +      controller.
> +    maxItems: 2
> +
> +  mux-state-names:
> +    description:
> +      mux state names for routing SDO and DOUT0 signals from peripheral =
to
> +      controller.
> +    items:
> +      - const: data_read
> +      - const: reg_access
Throw in an example.

Jonathan

> +
>    adi,asrc-mode:
>      $ref: /schemas/types.yaml#/definitions/string
>      description:

