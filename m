Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59BD3254BD;
	Sat, 31 Jan 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769874862; cv=none; b=cgQKtGQ2Lpwd81p3+FOKBsu59ZPB/PJWoCKT+FEaBpN9PBX7oEVTs99ldX+gAjDgq1zhrc1fg5bZlOqRaNiPjmLNnThbSlaskfPVW8l59Ttm7M1ELFHwlNZCAY3l/k/G9qVcqECTHBPDyb4Tv8VcOLfCYVUs6qg33zhKtKvG8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769874862; c=relaxed/simple;
	bh=D2qi3MpKf9EUAr6FXJLzWwHrp52zNY8AkmPWWxuabHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIB0lY0UsLDPj4PG0RI1D0WYV5j2DzI9M5F9+zAw6U6O+Hl+k81x13oLbxEf5h1VrMvbeAqS0YLAtBtLSx8FNUyX0Sfq39XyIb0rnmPh7jAYoDB2DRURCGi/tDyfe1YZB11fOMOuqmW8RwiBbwPCj6R76gdvH6bm3NE9Gs1/T3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr3xhK7/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr3xhK7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C427EC4CEF1;
	Sat, 31 Jan 2026 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769874862;
	bh=D2qi3MpKf9EUAr6FXJLzWwHrp52zNY8AkmPWWxuabHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vr3xhK7/afDZehNePDSN02qA3bD108WTQ+/Auxr5cBxdwJjMDN683sFqt4YD65wlN
	 4zr9ck0e2m+Fh15TUc3vbRpDM+Vo7mJXAyBlut4HJRIx095GIcsrEvCY7UKOERmd7a
	 7x50HnfGWdtJv3p/hjftmIAPoSTb9scziOpG72wxZiwD379x9vJElC6rHCnL2tlGea
	 xk8dqRuXZsedrtJhalevFvUdGjJ4o7BD3ojIkbV/IS4ezXl/9IcaaIq5YMx/pS+n4i
	 3Q8K3DCt8r0VYzJdAbwlxBNfx3J6XvLFZVaIXeVc02pXtBdXKFv2SVHvhUUDlZyxfT
	 NzW3zZ4Iv/3/A==
Date: Sat, 31 Jan 2026 15:54:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Michael Harris <michaelharriscode@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: iio: adt7316: remove unused macros
Message-ID: <20260131155413.28fcc701@jic23-huawei>
In-Reply-To: <20260130-adt7316-correct-macros-v1-1-8a71df1e42f1@gmail.com>
References: <20260130-adt7316-correct-macros-v1-0-8a71df1e42f1@gmail.com>
	<20260130-adt7316-correct-macros-v1-1-8a71df1e42f1@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 23:38:27 -0800
Michael Harris <michaelharriscode@gmail.com> wrote:

> Delete macros that aren't in use
Hi Michael,

Why?  

I'm not against driver authors only introducing register defines they
are using, but I'm also not against them deciding on comprehensive defines
or at least making sure they cover all the fields in a given register.

Having only parts of a register defined sometimes makes people miss
that they can't just write the whole thing because there may be other
bits they do not indent to change. As such it can be useful to have them there.

Thanks,

Jonathan


> 
> Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
> ---
>  drivers/staging/iio/addac/adt7316.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 8a9a8262c2bec34f3c3e79d8174f492b9a23fb70..4173c8822fff495e8c69d9cf6c11be9e9227a8c1 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -111,7 +111,6 @@
>  #define ADT7316_AD_SINGLE_CH_MODE	0x10
>  #define ADT7316_DISABLE_AVERAGING	0x20
>  #define ADT7316_EN_SMBUS_TIMEOUT	0x40
> -#define ADT7316_RESET			0x80
>  
>  /*
>   * ADT7316 config3
> @@ -154,7 +153,6 @@
>  /*
>   * ADT7316 value masks
>   */
> -#define ADT7316_VALUE_MASK		0xfff
>  #define ADT7316_T_VALUE_SIGN		0x400
>  #define ADT7316_T_VALUE_FLOAT_OFFSET	2
>  #define ADT7316_T_VALUE_FLOAT_MASK	0x2
> @@ -194,15 +192,6 @@ struct adt7316_chip_info {
>   * Logic interrupt mask for user application to enable
>   * interrupts.
>   */
> -#define ADT7316_IN_TEMP_HIGH_INT_MASK	0x1
> -#define ADT7316_IN_TEMP_LOW_INT_MASK	0x2
> -#define ADT7316_EX_TEMP_HIGH_INT_MASK	0x4
> -#define ADT7316_EX_TEMP_LOW_INT_MASK	0x8
> -#define ADT7316_EX_TEMP_FAULT_INT_MASK	0x10
> -#define ADT7516_AIN1_INT_MASK		0x4
> -#define ADT7516_AIN2_INT_MASK		0x20
> -#define ADT7516_AIN3_INT_MASK		0x40
> -#define ADT7516_AIN4_INT_MASK		0x80
>  #define ADT7316_VDD_INT_MASK		0x100
>  #define ADT7316_TEMP_INT_MASK		0x1F
>  #define ADT7516_AIN_INT_MASK		0xE0
> 

