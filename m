Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085830;
	b=kp4rp8EZ3YBhA7Cc4ynL19Vl74ophGd54zofRJWETS8r6lhvYv/notWrgF/KYJvWZaJS
	 REiv/TdRbP2YTqbBE9GQr227kVoQb/CvJ4eSxiC4EOWVmgyEv9NAvTko25JkYLYvpdTbG
	 EzlreAzrOTZLJKaZMN7DBhr2zfSLQD6b7Dq9Bm/MjWekYyYrbNGK7use9ytHKcOYpBuxK
	 uf1M0DWYLCaSQvh2Sljzfr62u/2kRHNJyhBU8Y69bopwYlu9TvSJbScTJ3o+vDh+DOwzo
	 ZCEoD1Ezl0BX0KQ8CZwxwxaZFXyCsTdHbG/LlUpOCkxZCuNRiH+zDdR0VkT9TyFUj/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085830;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ytl/23dencL1Kjh9JLygxJpOYoOZT3gKsICQUgciBFk=;
	b=zCak/7yXs40tRC0S8JzYZ6Yqog5SqhIi13dUYrZXQHEet2POeeadq7lN05M2Y/n/z1wF
	 n1UziNatu5w9ktwPFubVE4OamCmt6qeUn2Qv5I0lfsp1FRYfZ9SdIHO5pJeOWGVBEk2Jd
	 ABFSQ6CnYJmxsgJLgXJKblT+48TevuoSZsBeMuNH+hrLzGbxNvcM104R3aIF4t/Ovbbun
	 CvaqwjkU4QGxSBfelFR1BfK4ZTpfjNOzJZL8lHQGE0sG4p4WfkLMmrILKExT6qZakGocI
	 mNXKePQRQy0t2hZZr8N3EMoo0xGiBFmyCm6vpr5AHNz7MxOU6Nsj/XdSQGy6MtmR5tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Me/gCXvJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D8606A326;
	Sat,  7 Nov 2026 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Me/gCXvJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEAC1F0089F;
	Sat,  7 Nov 2026 21:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794085830;
	bh=ytl/23dencL1Kjh9JLygxJpOYoOZT3gKsICQUgciBFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Me/gCXvJupNPxDpMoeUd9lZVfdbXNEpLuQCr+IrxQ8JIZ6WeVdowPbwjTTlz4yooH
	 VRbOllPF5DawZM93iZvi2oq2CzBhVcrXwb/OcUU0j4H7VQYjj78DuEVrqA+pDrPuTI
	 B9KXYI6jr/KNBYA5PoUSsNC86H1LlYoAWhAM/inqhQVHPZ1fpmqg1Z5c2xHw6qF2Ux
	 cyYdtdEbc0hwno/6eeTuZEY1eKRHeNgfKQTg7Zz1omEuTGPOqoE4DG1E3mGfE/J9Iw
	 B7wPbNciEXtcnaOu8eD+W5HGEKCdRSDQAeo0QTsZwtueR25q2dCKLgIt9SMzSgyZU3
	 E+j0pIPZ+Q5fw==
Date: Sat, 7 Nov 2026 21:10:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cwweng@nuvoton.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
Message-ID: <20261107211021.418a931c@jic23-hlaptop>
In-Reply-To: <20261104091136.151269-2-cwweng.linux@gmail.com>
References: <20261104091136.151269-1-cwweng.linux@gmail.com>
	<20261104091136.151269-2-cwweng.linux@gmail.com>
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

On Wed,  4 Nov 2026 17:11:35 +0800
Chi-Wen Weng <cwweng.linux@gmail.com> wrote:

> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Add a binding for the Enhanced Analog-to-Digital Converter found on
> Nuvoton MA35D1 SoCs.
> 
> The controller has eight external analog inputs. They can be used as
> single-ended inputs or as the four fixed differential pairs 0-4, 1-5,
> 2-6 and 3-7.
> 
> Use the common ADC channel properties to describe the physical input
> independently of the logical channel index.
> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
A couple of really trivial things inline.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> new file mode 100644
> index 000000000000..85b0feac0236
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nuvoton,ma35d1-eadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Enhanced Analog-to-Digital Converter
> +
> +maintainers:
> +  - Chi-Wen Weng <cwweng@nuvoton.com>
> +
> +description: |

Similar to below. I think this is overconstraining the formatting.

> +  The Nuvoton MA35D1 Enhanced Analog-to-Digital Converter (EADC) is a
> +  12-bit successive approximation converter with eight external analog
> +  inputs and one internally connected VBAT input.
> +
> +  The external inputs can be used as eight single-ended channels or as
> +  four fixed differential pairs: 0-4, 1-5, 2-6 and 3-7. The internally
> +  connected VBAT input is not described by a channel child node.
> +
> +  The controller provides four interrupt outputs, ADINT0 through ADINT3.

> +patternProperties:
> +  '^channel@[0-7]$':
> +    type: object
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    description: |

IIRC > instead of | is appropriate here. You want to maintain paragraphs but
otherwise allow rewraapping.

> +      External EADC channel description. The reg property identifies the
> +      logical IIO channel index.
> +
> +      A single-ended channel may use single-channel to select an external
> +      analog input independently of reg. If single-channel and diff-channels
> +      are both absent, the external analog input is selected by reg.
> +
> +      A differential channel uses diff-channels to select one of the fixed
> +      hardware input pairs: 0-4, 1-5, 2-6 or 3-7. Each single-ended input
> +      and each differential input pair may be described at most once.
> +
>
> +...

