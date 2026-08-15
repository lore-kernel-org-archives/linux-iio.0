Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAD62BCF7F;
	Sat, 15 Aug 2026 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786824027; cv=none; b=LXzPxTSFpo3wPc0jrB0t6QPhdJaasfNeroeJAKHBqb5Oalf1cOQOKkOu64WRxOEEHR1brk0Z4dpgwpDQmw9CaIJU8HKNlvDNZ5x4hF6CXhuA2K25s7gMkTqT/agK3e7+Y/PmNCNv8iuICsqd031lNewAiUA3y0yYJIgDEdTFAww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786824027; c=relaxed/simple;
	bh=4Vad5jCeq3PZFKpiHcE0odIFICLOCkF5ktkrDOb88uk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwb6J0UHX9ldWEn5v4B50yx7QaUSeBhJBmZ8gKf+dOmdMqwqL5FLI8K3HJ4uX0KYlvsHWGwMew+6c+vMJoUN0Y879/aHC8bjZ0OW1LVlUlLp2Sfe2b9MZ9+7afRmCmDW6jg9N/oJlqrQ3jdMW7QcRzjpEpjWcr8tTK+rdmmA7dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4l3jD1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4l3jD1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7F91F000E9;
	Sat, 15 Aug 2026 20:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786824026;
	bh=MVlQn7mhKg7177m1+4VT77S5ExQxaD1xM5hHvrwadVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L4l3jD1ECqnQTF/yhNzc/eJR7jrjn3+mrO+W/kgiZYosyXq1jmtd1nti/GAXpTMME
	 Mw5+344duDDGFDHv3LNYhItD7JfNCdQy0Bcl8jeUQIDBEUFCZiGtlHvumeI0Ej3NrJ
	 mqHhI8CXXc82NuyM89uSnp/JhYPNVjfL7ntN7ZIDIm7CR1NCgQUJVmLEhPANXTc199
	 CNBTO9Z8JM0ajyIi8i5UEzHMEZ11kuAK7SD0GlIiWn8dJsg19Dq49SgNPDPB+1V5Mo
	 tWzPYduryLPqihIPzK7+osBRbb1PTN/boGf6XCRZj7mpDn3lqwozhwUPq5Jl7eVtS3
	 4sgt1LvxJSnbg==
Date: Sat, 15 Aug 2026 21:00:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: <ehristev@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
 <joshua.crofts1@gmail.com>, <jorge.marques@analog.com>,
 <Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
 <antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
 <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 04/17] iio: adc: at91-sama5d2_adc: rework temp
 calibration layout handling
Message-ID: <20260815210018.460c0eca@jic23-huawei>
In-Reply-To: <20260806074024.531259-5-varshini.rajendran@microchip.com>
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
	<20260806074024.531259-5-varshini.rajendran@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 13:10:11 +0530
Varshini Rajendran <varshini.rajendran@microchip.com> wrote:

> Extend support to handle different temperature calibration layouts.
> 
> Add a temperature calibration data layout structure to describe indexes
> of the factors P1, P4, P6, tag, minimum length of the packet and the
> scaling factors for P1 (p1_scale) which are SoC-specific instead of the
> older non scalable id structure. This helps handle the differences in the
> same function flow and prepare the calibration data to be applied.
> 
> Reviewed-by: Eugen Hristev <ehristev@kernel.org>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
https://sashiko.dev/#/patchset/20260806074024.531259-1-varshini.rajendran%40microchip.com

For the unused define comment.  I 'might' tweak this is apply or go
meh i can't be bothered and apply it away :) 
Again - if you respin for another reason please tidy this up.

The other comment from Sashiko doesn't seem particularly useful to
me even if it is maybe valid.

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 66 ++++++++++++++++++++++--------
>  1 file changed, 48 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 09390f082fc4..82db8f2f4db0 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -16,6 +16,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/math.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> @@ -444,6 +445,27 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>  #define at91_adc_writel(st, reg, val)					\
>  	writel_relaxed(val, (st)->base + (st)->soc_info.platform->layout->reg)
>  
> +/* Temperature calibration tag "ACST" in ASCII */
> +#define AT91_TEMP_CALIB_TAG_ACST	0x41435354

Eagle eyed sashiko spotted this isn't used in this patch.  Should have been
introduced with first use in patch 5 I think.

