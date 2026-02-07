Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0546BF;
	Sat,  7 Feb 2026 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770481781; cv=none; b=gTlXwgktPs/LBHlk40e6yIUXJxkXRIqdjh4/owh2CHq1OHqLxKfw21uaxHByARkSY8VDiWx7AA4fsfr/+qNDmsX4vpLISxIyb0sVOV8xnqh+lGDwMb6Wcs2whAU+ozOj27MtN0tesF1Exc4uMxUE3UlJr9go8B8/0mcuQe9VQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770481781; c=relaxed/simple;
	bh=6k94j4eV/EZIntz7XizlestCzsICuALEnwkylekoVd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCxRcZ/WgCKUQrr1PtdxBp6o5P/VLYt4eYuVG6r8Z0/q4TXO4K30349fmtln9k1ILd9WrhDcRy6w6pXNClIkVZzoiCq6KKcS0IyYl1n38oxy3Xya3Ck20jLN2Uzh4rTgvUe3y1yTrjC0Raz5pXO4+wfsSylZNhbBrGKUMBpdA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJdEUAyI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJdEUAyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F25C116D0;
	Sat,  7 Feb 2026 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770481780;
	bh=6k94j4eV/EZIntz7XizlestCzsICuALEnwkylekoVd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DJdEUAyIU9sxF1v/LZpHyI/vG596YKSZykZwTec+K9mmZHz9tOFmeVWsK7CszL1lL
	 1qlPcZooYvKz8vh/FIw/Yyxttf/xIOPy3XQOdMpIwmb/9fLKyPXWRTwaEiOoHjnUgv
	 G6S7yHnfQVWmic3+4IoZEy2bemff42b9Vv0/3STLw0YZ4V81/LtcwtTUj1SxYUT8DA
	 lvoSdX9MQLnkGxMrXMCUhS81ze4fB+6OQ/1WiTrtMFS2Ee23nhJBj2sbHgSLkNGTaZ
	 VUx+D62Xxzns1maXXOnm22Zib7Ad2y/meDRDbj7yqRehOtKcm7ZIS4aHX2kC0qDzdA
	 Gqg1dQq5iDhhw==
Date: Sat, 7 Feb 2026 16:29:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add binding document for cm36686
Message-ID: <20260207162930.353412f5@jic23-huawei>
In-Reply-To: <20260201-cm36686-v1-1-4949a2a9ba63@gmail.com>
References: <20260201-cm36686-v1-0-4949a2a9ba63@gmail.com>
	<20260201-cm36686-v1-1-4949a2a9ba63@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 01 Feb 2026 19:03:48 +0200
Erikas Bitovtas <xerikasxx@gmail.com> wrote:

> Document the Capella cm36686 ambient light and proximity sensor devicetree
> bindings.
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
One comment inline.

Thanks,

Jonathan

> ---
>  .../bindings/iio/light/capella,cm36686.yaml        | 74 ++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm36686.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm36686.yaml
> new file mode 100644
> index 000000000000..5f0a585e3d87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/capella,cm36686.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/capella,cm36686.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Capella cm36686 I2C Ambient Light and Proximity sensor
> +
> +maintainers:
> +  - Erikas Bitovtas <xerikasxx@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - capella,cm36686
> +      - capella,cm36672p
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      I2C slave address of the device. Must be 0x60 for both cm36686

Try to avoid the word slave in new docs

      I2C address of the device ...

Is fine here.

> +      and cm36672p sensors.
>
