Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F42222C5;
	Mon, 19 Oct 2026 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792374029; cv=none; b=X3kU9GDDlimzvZuzVToWfhOChjh4tY0ZZmpCY/ilQ1y0aRrckNEydezAAkS3tDmuUPT2cQRN43iuyz4at17XBbC0CUeOwL1ylIkLxOTJbSZ/XvuKYNPgBxK3llJWzsnPo4TXlsrNA28M7eIBJFEgWwm9VicAaVz3StDJ2+3WuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792374029; c=relaxed/simple;
	bh=trYEdX8uQs0hlx750aq4gfYSGLY7LPxJvgFUtb0TcwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqaKsb71fLdN8E4t7QIYHS3Ngkgn0I6BiLWS2kojBsQqGpGPyABiIy1CTJW/qxmwS00+pz3aXYesW1Cr9H6TM9uwbB8SA4jooofhLTAw3X9COPnCXKcgHVrmZlDd5YpB4kN6Wb/MQc3KzxCcFfNh7EdCK/YY88dyM2BZVEyPMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScmAcf6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScmAcf6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933E41F000C4;
	Mon, 19 Oct 2026 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792374027;
	bh=0TWAttW+jzTYSOQF5ruJVHSwvGCQ9V/PrVQgOjz6jAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ScmAcf6hDusWU128UigGUFFVGfqtCcrGpaK5wgPjoYptHoc6y/GfAOEM+nmO7Qc1o
	 jU+ttxVdhgy0VCWiiJgArTayHzQTH4YpjE4ilrwGZ45e2ohoigP9sXNdDLU27XitoB
	 /n4qHXXgy08pUSY0L0HIwf8kYf0YAk86J1EtuvVnis4kX4DrYMjKD8oQnsmn3rDold
	 6eM8oKz6pfNa+6883aOwEb0ha/OJoWjvmn6F7XDvVkcjb+AfAGOZ4OF2eE7gV9ShwU
	 DKvccDH25Zio88Tq1TGd/K9GfzWhhEyoAy0/Dq+Ergz79QEFAE8BPAo/TEmhzl3lzs
	 W2WfJBIrxOyMw==
Date: Mon, 19 Oct 2026 02:40:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, Sam Protsenko
 <semen.protsenko@linaro.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: exynos_adc: add Exynos850 support
Message-ID: <20261019024022.19b7bd4b@jic23-hlaptop>
In-Reply-To: <ar9elr1_tuFhJi1r@ashevche-desk.local>
References: <20261001-exynos850_adc-v1-0-791b3516bb9d@linaro.org>
	<20261001-exynos850_adc-v1-2-791b3516bb9d@linaro.org>
	<ar9elr1_tuFhJi1r@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Oct 2026 10:34:46 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Oct 01, 2026 at 04:09:13AM +0100, Alexey Klimov wrote:
> > The Exynos850 ADC controller located inside the CMGP block differs from
> > other Exynos ADC controllers, mainly in its register layout.
> > Specifically, the data register sits at offset 0x08.
> > 
> > Abstract the read_value() operation in driver data exynos_adc_data to
> > support SoC-dependent data register read callbacks.
> > Add the exynos850_adc_data struct that describes Exynos850 ADC ops.
> > It also requires its own hardware initialization and exit routines.
> > Add them as well.  
> 
> Split this to at least two patches:
> - add .read_value() callback and switch existing users
> - add new user
> 
Agreed. Other than that looks fine to me.

Thanks,

Jonathan


