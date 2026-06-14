Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FCF303A35;
	Sun, 14 Jun 2026 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781459871; cv=none; b=gdwSz4xoXlroMo/YPbVfpAip6kLR014ug+Iq2Y2KEsvWiQxiX3NnbyXoZXV0OwFpGbkvNjoamnTdGwUYswMUeW/uBs6hifvO7YjZDAYInnWqZ81jboeXG2BxB10mvZWzDjIvg0v08/RP8QFNiQQwKUGLgT8pgFtfJ3tnh0Lmeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781459871; c=relaxed/simple;
	bh=TXjqj/4pmnnKvT/53TQlFE/FD34TYAqsSx3MsKEuKJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJB3cK57/CgFTydho5BAMoHmvhNBgjeNb9w8nnqVLDqCkS7KZ0hfpA1LL9lNx+y4l+1ySMzWt5TKgctnv0dk6p7F4wkm1EafAKhu2+jqGDZn0jYumdlR0rvCK6pG04XaenjcXePYOY07RshY54Fh52BnhKBd42EUqFebaWI3B54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuhAe9bG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuhAe9bG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76DD1F000E9;
	Sun, 14 Jun 2026 17:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781459870;
	bh=DauTCXOBmHSgstOu88XTN6FSX1Ww5vmgjV3IuE4PRDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QuhAe9bGISt6myY6XKqL1Mn/yQ5wQxDEYvdfMRvDGbfHUxxQBDvMgpoBah+bAZvoi
	 QlFrXnrwRl0OogjTe7mDFwh1AeiwmZXjOkqWBwXnwR62vpj+WIh1/IMGN9ntVAuAhd
	 4DBvwTuXv+teqpDYOHG2ClRUJs96VJHpjkWPFKMG4vQp5pHxHjdVXvsOVDd+B3M0Cn
	 nbNggKGP3C/Y5gLb5EfHae3ES/oGQ7IJ1Ebuv5RasNkgNExaLIq+BI4veqKqWl1JnE
	 JDniEfreB7k4Z4XzHIpI1hdyccbWNCeM4u/APYvwgx72fsVs26huuebJ44iVZr9YRP
	 wYG9UOfOQ63dQ==
Date: Sun, 14 Jun 2026 18:57:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v4 1/6] dt-bindings: iio: add Open Sensor Fusion
 device
Message-ID: <20260614185742.3cc7bdd9@jic23-huawei>
In-Reply-To: <20260607234343.22109-2-kimjinseob88@gmail.com>
References: <20260607234343.22109-1-kimjinseob88@gmail.com>
	<20260607234343.22109-2-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jun 2026 08:43:38 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Describe the OSF sensor aggregation hub.
> 
> Use the generic opensensorfusion,osf compatible.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>

This seems to be a patch against an earlier version of your series.
Make sure this applies directly on the upstream kernel (release or rc1
typically depending on which is most recent).

Jonathan

> ---
>  .../iio/imu/opensensorfusion,osf-green.yaml   | 43 -------------------
>  .../bindings/iio/opensensorfusion,osf.yaml    | 43 +++++++++++++++++++
>  MAINTAINERS                                   | 27 ++++++------
>  3 files changed, 57 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml b/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
> deleted file mode 100644
> index 626b41fb0..000000000
> --- a/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/iio/imu/opensensorfusion,osf-green.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
As above. There shouldn't be anything to remove!

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 56181470d..e227b9aff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19977,19 +19977,6 @@ F:	Documentation/networking/oa-tc6-framework.rst
>  F:	drivers/net/ethernet/oa_tc6.c
>  F:	include/linux/oa_tc6.h
>  
> -OPEN SENSOR FUSION IIO DRIVER
> -M:	Jinseob Kim <kimjinseob88@gmail.com>
> -S:	Maintained
> -F:	Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
> -F:	Documentation/iio/open-sensor-fusion-protocol-v0.rst
> -F:	drivers/iio/opensensorfusion/Kconfig
> -F:	drivers/iio/opensensorfusion/Makefile
> -F:	drivers/iio/opensensorfusion/osf_core.*
> -F:	drivers/iio/opensensorfusion/osf_iio.*
> -F:	drivers/iio/opensensorfusion/osf_protocol.*
> -F:	drivers/iio/opensensorfusion/osf_serdev.c
> -F:	drivers/iio/opensensorfusion/osf_stream.*
> -
>  OPEN FIRMWARE AND FLATTENED DEVICE TREE
>  M:	Rob Herring <robh@kernel.org>
>  M:	Saravana Kannan <saravanak@kernel.org>
> @@ -20024,6 +20011,20 @@ F:	Documentation/devicetree/
>  F:	arch/*/boot/dts/
>  F:	include/dt-bindings/
>  
> +OPEN SENSOR FUSION IIO DRIVER
> +M:	Jinseob Kim <kimjinseob88@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> +F:	Documentation/iio/open-sensor-fusion-protocol-v0.rst
> +F:	drivers/iio/opensensorfusion/Kconfig
> +F:	drivers/iio/opensensorfusion/Makefile
> +F:	drivers/iio/opensensorfusion/osf_core.*
> +F:	drivers/iio/opensensorfusion/osf_iio.*
> +F:	drivers/iio/opensensorfusion/osf_protocol.*
> +F:	drivers/iio/opensensorfusion/osf_serdev.c
> +F:	drivers/iio/opensensorfusion/osf_stream.*
> +
One blank line.

> +
>  OPENCOMPUTE PTP CLOCK DRIVER
>  M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
>  L:	netdev@vger.kernel.org

