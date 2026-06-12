Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF02331EBF;
	Fri, 12 Jun 2026 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281823; cv=none; b=hdNtmQ9JPlxJdmnO82hS43d631w4yaid4MEpYvioFM/weOj5+SB5Dwu7O5KH9IzTV+pIJKcuAqDFmnurVEd53c7oARW/QT1XWk4TKySJ6EpPo0M675iypT7Apf5/d/wLEunmzJ9/+VXWwiGYo1EtYvmNzet35AzGk1ldjCBgSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281823; c=relaxed/simple;
	bh=eheKkHKXMzklCDKLpMcrXV1m1+X4pO1+oEgc8MJ4gKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+0V6MpMiV1nAA9eb0C5NTXg1t9ZQBzsOH6ElVY5aEmQ3WVkHHMozojfGHmILYl8PyIzzSNwlTKgs7rCvixEqRAOqJfGXKJIqeodMJ/QpsSEZmG8h5rvYHWHdUYSBty8Hz45KMP0Cuji11lHPHCG085BpcN1ZdmKIMFEI4kBMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QA+fCtli; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QA+fCtli"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C141F00A3A;
	Fri, 12 Jun 2026 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781281818;
	bh=UZ9Iumb2g1TRxob6WsvtSWW84/17leWiNilXq74yt9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QA+fCtlizB2KYnlOw7dBoRWziA0zii8lLJjx1ObpjMVdFoHNF7f+Q3BXr5a6MKRi1
	 qCxc4CeW3mQ1xVF2ok+OFC+yj8vfxxO682lxoUZZn3XkqOK+vXowKcr8QUj5Wdqy9O
	 J/M8S5N1WJaloiMBy8j7Hg/FQAQTOwsSU7NoxEqCDx6kj/+R3aLbiTLLrWkuwrwm2O
	 xE3ikJexxfoXa2lYSKhNfgVafwgcqgkTRuAvnQjBOsPQhmJ2MSCLT81CCH0cpL8R/m
	 P8pX0slYIqeJdNJuGR9MoewD7QBhThAcV8i+4glN7ha8JOlvQfFnaPz6qZF//m7Mpv
	 07g7Y/OC9UryQ==
Date: Fri, 12 Jun 2026 17:30:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <email@sirat.me>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: magnetometer: add QST QMC5883L
 Sensor
Message-ID: <20260612173013.64f435ab@jic23-huawei>
In-Reply-To: <20260612124557.13750-3-email@sirat.me>
References: <20260612124557.13750-1-email@sirat.me>
	<20260612124557.13750-3-email@sirat.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 18:45:26 +0600
Siratul Islam <email@sirat.me> wrote:

> Add devicetree binding for the QST QMC5883L 3-Axis Magnetic Sensor
> connected via i2c.
> Interrupt not implemented in driver but kept in the binding for future
> addition.
No need to mention that
> Used enum so that more driver could use this binding

More devices perhaps rather than drivers (binding has nothing
directly to do with drivers).

> 
> Signed-off-by: Siratul Islam <email@sirat.me>
> ---
>  .../iio/magnetometer/qstcorp,qmc5883l.yaml    | 48 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml
> new file mode 100644
> index 000000000000..238cc7e22b89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/qstcorp,qmc5883l.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QST QMC5883L 3-Axis Magnetic Sensor
> +
> +maintainers:
> +  - Siratul Islam <email@sirat.me>
It is a bit unusual to have to description section.  Maybe
just have a link to a datasheet if there is someone that seems
reasonable stable to link to.

> +
> +properties:
> +  compatible:

The rest looks good to  me.

Thanks,

Jonathan
