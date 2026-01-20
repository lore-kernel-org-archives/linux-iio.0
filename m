Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408702F3623;
	Tue, 20 Jan 2026 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905445; cv=none; b=ao4GD5cQ0bAHI7V/xjzm3jw04wcUC5z4wzl/+zs2S5plqm+erC5K+LCMT71QLCH4Pzz0ak9nsV6wjCu46Asu9HWMF4yFGYIjaEXLWEKzxxsdmv6bDGgZAaggGt79UFPX29xh2eLj0pcDdajuN3pz6VEEryGnDVxb2i/dfmghyuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905445; c=relaxed/simple;
	bh=jDEfaqgix4aL0HJNOYNVCUOIz1hcOrf0VXgOH4xFmpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9611t/o2by+NaJKsA24jpI+WnNBc1JimWGqMpU0hjGP4q6HpRbXXvxpF2GFmluFyWo4dpv/N/QiID8sybhhJnjriO+wQN89pBxhFVs1EXpg6+j7kU5HftEkUbGvbKN/rAnSUZeiAXwqsYtTgGSCEKKmFS4qe/2JvDrSXX9ThSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLnBJNoS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLnBJNoS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DCEC16AAE;
	Tue, 20 Jan 2026 10:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768905444;
	bh=jDEfaqgix4aL0HJNOYNVCUOIz1hcOrf0VXgOH4xFmpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLnBJNoSrKZr+jIao7BbTDLkfhDTkOFirjfOU9Zb8nTrlbbMp4lHgMxqrPpG14JVS
	 per3D/7LxJGORM/oKa1KLS3Gz5Sx8AHVaSj2s2qVbRxqcDLjz4qxbhwYk06fkSaiWZ
	 4a/8zjTcLJHl21IFnUN657ElYWCh2YmMgtHwJU5poTWa5uoZrRogcdxfG0qikjgFH+
	 ihYxb7sbN/dRL3M32ofi6f3dbz4yAfm4BFZuHvw1jPk09eSR3JxQK96FUoIB9vkR+2
	 FGkWYV2LC8PMsQoOni7dsuoKbAa5ZgeYwxeV24Wi6iabxCTrw4cA74qL5OtokE+eC/
	 o+GJqtgi5j1Kw==
Date: Tue, 20 Jan 2026 11:37:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Petr Hodina <petr.hodina@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: add Device Tree binding for AMS TCS3400 light
 sensor
Message-ID: <20260120-nifty-hasty-ibex-aff3cc@quoll>
References: <20260119-tsc3400-v1-0-82a65c5417aa@protonmail.com>
 <20260119-tsc3400-v1-1-82a65c5417aa@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-tsc3400-v1-1-82a65c5417aa@protonmail.com>

On Mon, Jan 19, 2026 at 06:19:06PM +0100, Petr Hodina wrote:
> Adds a new YAML binding describing the AMS TCS3400 I2C light sensor,
> including compatible string, registers, interrupts, power supply, and an
> example node.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>  .../devicetree/bindings/iio/light/ams,tcs3400.yaml | 54 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/ams,tcs3400.yaml b/Documentation/devicetree/bindings/iio/light/ams,tcs3400.yaml
> new file mode 100644
> index 000000000000..2c5a9295af1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/ams,tcs3400.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/light/ams,tcs3400.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Never tested.

> +
> +title: AMS TCS3400 Color Light-to-Digital Converter
> +
> +maintainers:
> +  - name: Petr Hodina
> +    email: petr.hodina@protonmail.com

Don't send us LLM code. Never. Why do I think you sent us LLM microslop?
Because such syntax does not exist. Nowhere.

I finished the review here, everything futher has more trivial issues
which you would fix easily if you took recent binding as starting point.

Best regards,
Krzysztof

