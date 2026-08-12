Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE66E3594A;
	Wed, 12 Aug 2026 04:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786509306; cv=none; b=gTvaSovhS2/eGAf8e2TxEQ3q3/5o+BXw6jYqWhbls5CnBRqA4aVij/7zrhNjAcjDilT/Sc2+PFgOkjjh5BK6wTiZDhu+p41epvQpk/QMR06x2Sbh6ecYYc5WvR+XqeErsYMfHeIczvFLfKnHuONCaGjlLVYQGi3DwmyWsKKRruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786509306; c=relaxed/simple;
	bh=9fC/Okpl0yuS2JxNbPG6V4hEqzuor/r3UhIccPULWV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLSPw6QpAZ6maWPlDyLc3eO4IR39sEyxuFHsXjD3qO0/yk0a6O+y/8uYkToYK7YyOKTZE2tB/SKRFVO28QAwx9itwlT9d3N/U4DWECAwIxLk9r4GY+sLHY2qXu5Q/06q8uy1Xf8jHM5JbB4mZ0FBf80//6B9hqqhSNZUI4gCdUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csvUU3FL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csvUU3FL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA141F00A3A;
	Wed, 12 Aug 2026 04:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786509304;
	bh=MIH/F/0+Mxv8oCW7vVu9Ljse8nesImLC7DHf6JhzZ2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=csvUU3FLw03gjhDNlvQm/IjOQlxwVCxbG75u3Xdbn8cjbl0e1CT/+wPtvG2KqAY/h
	 IMCWdapqinO34qxXd/v7YZOL6omCXZIzeIpYUvKroRr3PQ/m3q8Ru33+ylNOAIEXV1
	 B7F0PorjYPnZWHOG9rSAQ5Rl/QT5gfdWw/cHp0fwUzaCcxZEVitJrOyc08JQaOgxSE
	 dcYZSV3KQamwJWDPh6ePCQ3gIscL1Fl3KB69QyUp96FryvUvbfy5m1o7ZgkxqOcfiC
	 mW8fIIugeyKBI2zEoDk2n/NDKJ+B0UnheHtxEyZ90PMsexH7Lb/TCQoMgwEJ6jsJhN
	 y4nCSfn52dwVg==
Date: Wed, 12 Aug 2026 05:34:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mranostay@gmail.com, ~lkcamp/patches@lists.sr.ht,
 linux-kernel-mentees@lists.linux.dev, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: proximity: move LIDAR-Lite v2
 out of trivial-devices
Message-ID: <20260812053450.2e14b074@jic23-huawei>
In-Reply-To: <20260810192131.153495-2-rodrigo.gobbi.7@gmail.com>
References: <20260810192131.153495-1-rodrigo.gobbi.7@gmail.com>
	<20260810192131.153495-2-rodrigo.gobbi.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 16:18:40 -0300
Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:

> The PulsedLight LIDAR-Lite v2 is currently described as a trivial device,
> but it is not one: besides the I2C interface it exposes a power-enable
> pin and a mode-control pin.
> 
> The mode-control pin can trigger acquisitions and report the measured
> distance through a PWM signal, entirely bypassing I2C. That usage is
> bidirectional and non-cyclic, so it doesn't map onto any existing
> binding for describing pin behaviour, and is intentionally left
> undocumented here. The same pin can, however, also be used as a plain
> status output while I2C remains the active interface, which is
> described through the new interrupts property.
> 
> Move the device to a dedicated binding file and document the
> power-enable, power-supply and interrupt properties that
> trivial-devices.yaml has no way to express.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
>  .../proximity/pulsedlight,lidar-lite-v2.yaml  | 64 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 64 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> new file mode 100644
> index 000000000000..e19c8d166b81
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/pulsedlight,lidar-lite-v2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Pulsedlight LIDAR-Lite v2 range-finding sensor
> +
> +maintainers:
> +  - Matt Ranostay <mranostay@gmail.com>
I'll need an Ack or Reviewed-by from Matt for this. If Matt either doesn't
reply for a while, or isn't happy to take on this much fuller binding,
is it something you'd consider putting yourself down for?

Otherwise LGTM

Thanks,

Jonathan
