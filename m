Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE3A30C608;
	Thu,  2 Jul 2026 02:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782961130; cv=none; b=Nl3qVxn7F+W03vnpOZVKixbAd9On06TkhoTRqudDjHaYsrcYUa6H3NelRHyBsPQCSdYPHJsX3quZ2gCBylkdnOE4i6ipSMW12O257w/l3Dv95/NWiqZ/7vLMVQnAmfWczC/wnZH5GtGvOWdZh+7oer01R4QixbTY52CC9Q1YtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782961130; c=relaxed/simple;
	bh=Jv19ErEM0AgboKyRk3i1RZMf+aoIt5Xehs+7Tvlz/wU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPcPTzRjC9AIpiR6zJ5S/Hb2kvhO9wv64r9EoXtwStEBhCnOB0LZ1d02QsiaYCBG7fwCtuE07ZyNxJTjW6tz5PI34G/L5HPFUT5miaYDgpRB/7hCxCeKJQAU1yVxJ2sof0pd9k1RFeBL7USORNJqZVAVny41+dUG34mcUNeg5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrFubotP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrFubotP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8781F000E9;
	Thu,  2 Jul 2026 02:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782961129;
	bh=pw9OL4CQ4Cnx/Bsvz9ePcfgFpZ0WIaEWdQaiu0A70tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BrFubotPB+lTSdlXiBYBjcBf+pH8KxyTETVHCB56etk72dVeOCJXuXyk0u2L4Hoqf
	 ciZ22bdvuWs72UJuGk6LDroeazY121ZLVRTqNNUUJmTyOmenVzPXDwYPziyudIoKI3
	 FGgvjH08tWOeGKXuKs18p3CIPXKTK1XArPpAU+3aUQPxKtvaMpyt0qOpDIuZvIR9dq
	 M9LapriMKnKLfzfqEsjsuWlsKphkwP4u1eu5KMpAb+Nc0xUcMTd8erP3P0ZvCzfH1v
	 9xkUs+7cHsesRy62MGVkqQ1F+/HLiHbqgoGFqqgwl2ezpod7Uk7AgcmZhLkGdf9vsF
	 wjdjKIiSulSnA==
Date: Thu, 2 Jul 2026 03:58:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, conor@kernel.org,
 conor+dt@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: iio: health: add adi,max86150
Message-ID: <20260702035843.6287b13c@jic23-huawei>
In-Reply-To: <20260623201124.18271-2-shofiqtest@gmail.com>
References: <20260623174600.17100-1-shofiqtest@gmail.com>
	<20260623201124.18271-1-shofiqtest@gmail.com>
	<20260623201124.18271-2-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 23:11:21 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> Add Device Tree binding schema for the Analog Devices MAX86150
> integrated ECG and PPG biosensor.
> 
> The device exposes two PPG channels (Red LED and IR LED) and one ECG
> channel over I2C, with a 32-entry hardware FIFO and an active-low
> interrupt.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  .../bindings/iio/health/adi,max86150.yaml     | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
> new file mode 100644
> index 000000000000..c191f4f1525b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/health/adi,max86150.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX86150 ECG and PPG Biosensor

I'd spell out the acronyms. I knew what ECGs were but PPG was
new to me.  Oddly I did know what Plethysmography is
and even more randomly have a patent on a different approach
to measure a different form (respiration rather than blood).

Like many of these sensors it is serious optimistic to say the
sensor measures anything itself - instead it measures stuff
that after some tricky processing can be used to derive it
and I'm going to guess that like the previous sensors that
magic maths is not readily available?

The datasheet only seems to mention pulse oximetry which brings
it inline with the older parts.

> +
> +maintainers:
> +  - Md Shofiqul Islam <shofiqtest@gmail.com>
> +
> +description: |
> +  The MAX86150 is an integrated biosensor SoC that combines:

Why call it a SoC?  that term isn't used on the datasheet and to me would
imply sophisticated CPU to do the processing on chip.

> +    - Two PPG (photoplethysmography) channels: Red LED and IR LED,
> +      for heart rate and blood-oxygen saturation (SpO2) measurement.
> +    - One ECG (electrocardiogram) channel for biopotential recording.
> +
> +  The device communicates over I2C at up to 400 kHz and raises an
> +  active-low interrupt when the 32-entry hardware FIFO reaches its
> +  configurable almost-full threshold.

Not sure this bit is useful for the binding.  Almost all I2C devices
work at 400kHz maximum. Maybe mentioning the fifo is worthwhile.

> +
> +  Datasheet:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/MAX86150.pdf
> +
> +properties:
> +  compatible:
> +    const: adi,max86150
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: |
> +      Active-low interrupt line.  Asserted when the FIFO almost-full
> +      threshold is reached or when a new PPG sample is ready
The almost full definition is certainly 'novel'.  Not a suggestion
to change this, but it rather surprised me when I wondered what this
was talking about.

Jonathan
