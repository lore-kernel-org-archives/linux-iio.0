Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539240;
	b=f3VzZCB9dfcqSRLRWHUAHrJVuQF1MFr5/Lb63GAXIJRKgrobx+POxlRY5CmeVHRtVsJx
	 QZ2xpF3fEz0zMABlXFWEjbWZH5N9Nt8vO6bEPY2YihSpqCnITwPRX6hNITbAC2ClWblp3
	 t3/rRn/fQ/N60OKzJm+ElNHuO9R8lXNXxw3JNM8EO9DDIpQRZlSEmR7CvCsPOs7IMp2O/
	 N+fWYaPZIO5MF9EX7SZeevrRfLABuGaUmlzW2FzWgyCXzsPRS+nTX1q1JHLvkFF5ojZiF
	 HeMFDnTUCyzmFScbDkOk9CGUME3m21IjhO7Z/TkW+J6T/kFgTsZOaUdSyLi9bhJ9buw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539240;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7lnqcJxB3Woa0yeWDWouhsD+g9Rsq2yVgwq1W8KzE0Y=;
	b=hZlUXlHKn7bOM5SZbohdpBsvzyjjptfmk6JygMwXHvXIGOCccTH6Q+VWY7CrOYUJPCU2
	 JmVM6ee9VYX/VXYifKG8aiY/UrtPPtWpCLZOX0/7mJVw2hYZeB0RVlMcln8x9loHIKrrG
	 X3hrQlUB4ikHW2zskqfx4MaTrpVXTI1vS9QpA3pbLzNp7geLeK2TARo+2HubNFeF98FjM
	 XrONj2qDkIABNSIOicKkzsuc7zBJFCLklLR68F/ZFe/+vfTySsL/Q786oLtZJVkQXLG35
	 ncmJ01h0FQfCR3hSmudAIMdwkHSOZ4+SonM7+If3iwTCHJagPG/7fFVixun5vJ+pbug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpRIDKdx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10C606A321;
	Fri, 13 Nov 2026 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpRIDKdx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705611F000C4;
	Fri, 13 Nov 2026 03:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794539239;
	bh=7lnqcJxB3Woa0yeWDWouhsD+g9Rsq2yVgwq1W8KzE0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CpRIDKdxb1p6z9nn6ICnv673v/iG5r1io7Hs0XPt5e+GbjftAh+qCuwsj6NQB9pdV
	 LR9KHQc1EEMjq/S6XYVoCEr9f20V8gqu4bWUGF0J2AiL2qDH8ZmZHzWJInzjFqzcSS
	 4psmiv1E0b1YSzmnUEH7Qy7837B0N4UwNE9RH+TVM3HxOgAPWrtslhIJCGAtTm7J+t
	 GauGL/YtmcW5H2H/MmI+QOy+fXpMruvoKIcr9cZeS4Oxl5yjD2A5wgcdarPmmKJvgZ
	 ICAZlM7HOtN5GJbvCre80L7cXZTLyphf9cyhMFws+4Yfjq8Ybb1b8XtN1iOWi4aiZJ
	 qn/Gi7aCKMSDA==
Date: Fri, 13 Nov 2026 03:07:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Conall O'Griofa <conall.ogriofa@amd.com>,
 <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>, Sai Krishna Potthuri
 <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v5 05/16] iio: adc: xilinx-xadc: Use bitfield helpers
 and bit macros
Message-ID: <20261113030711.3deb9cde@jic23-hlaptop>
In-Reply-To: <20261110050201.1850399-6-dileepkumar.nagavarapu@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
	<20261110050201.1850399-6-dileepkumar.nagavarapu@amd.com>
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

On Tue, 10 Nov 2026 10:31:50 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Replace open-coded bit manipulation with FIELD_GET(),
> FIELD_PREP(), BIT(), and GENMASK() helpers.
> 
> Using the kernel bitfield helpers improves readability and
> makes bit operations less error-prone.
> 
> No functional changes intended.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Sashiko seems to have found an issue. Looks plausible to me.
https://sashiko.dev/#/patchset/20261110050201.1850399-1-dileepkumar.nagavarapu%40amd.com

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 50 ++++++++++++++++++------------
>  drivers/iio/adc/xilinx-xadc.h      | 29 +++++++++--------
>  2 files changed, 46 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 66c6f3319ca0..eb63675464bb 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -11,6 +11,8 @@
>   *  - AXI XADC interface: Xilinx PG019
>   */
>  
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -47,28 +49,28 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
>  #define XADC_ZYNQ_REG_CTL		0x18
>  
>  #define XADC_ZYNQ_CFG_ENABLE		BIT(31)
> -#define XADC_ZYNQ_CFG_CFIFOTH_MASK	(0xf << 20)
> +#define XADC_ZYNQ_CFG_CFIFOTH_MASK	GENMASK(23, 20)
>  #define XADC_ZYNQ_CFG_CFIFOTH_OFFSET	20
> -#define XADC_ZYNQ_CFG_DFIFOTH_MASK	(0xf << 16)
> +#define XADC_ZYNQ_CFG_DFIFOTH_MASK	GENMASK(19, 16)
>  #define XADC_ZYNQ_CFG_DFIFOTH_OFFSET	16

As part of this patch I'd expect the changes to FIELD_PREP()
and FIELD_GET() to remove the need for these offsets.

This one is no longer used for example. I'd expect almost all
if not all the _OFFSET defines to be dropped.
Many of them weren't used in the first place. I didn't track
down if any are still used after this patch.

>  #define XADC_ZYNQ_CFG_WEDGE		BIT(13)
>  #define XADC_ZYNQ_CFG_REDGE		BIT(12)
> -#define XADC_ZYNQ_CFG_TCKRATE_MASK	(0x3 << 8)
> -#define XADC_ZYNQ_CFG_TCKRATE_DIV2	(0x0 << 8)

>  
> @@ -822,7 +832,7 @@ static int xadc_preenable(struct iio_dev *indio_dev)
>  	int ret;
>  
>  	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
> -				  XADC_CONF1_SEQ_DEFAULT);
> +				  FIELD_PREP(XADC_CONF1_SEQ_MASK, XADC_CONF1_SEQ_DEFAULT));
>  	if (ret)
>  		goto err;
>  

Sashiko calls out there is another write of CONF1 later in the function that still
seems to be using the prior approach rather than FIELD_PREP().

> diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
> index fb911ed87600..f5bf2d08eedc 100644
> --- a/drivers/iio/adc/xilinx-xadc.h
> +++ b/drivers/iio/adc/xilinx-xadc.h
> @@ -9,6 +9,7 @@
>  
> -#define XADC_CONF2_DIV_MASK	0xff00
> +#define XADC_CONF2_DIV_MASK	GENMASK(15, 8)
>  #define XADC_CONF2_DIV_OFFSET	8

Similar to above, I'd expect us to not need the _OFFSET defines
after moving to FIELD_PREP/GET()


