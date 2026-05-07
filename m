Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F213C4547
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152794; cv=none; b=a9xepspX9FjL0eMH5lTiXgdzvLh3C430XzYipau7wDVj6tVKr+cBmJaqaCNJIce+usK1kah18w9yhOAsU90h9sLCUcTHFeKrdJyUIwuscGFGceskKiBk+LN9rY14TPKar2qwhOZn87IxgHCJ2p0WJVS+0W8fAdp3OJAllVxX/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152794; c=relaxed/simple;
	bh=f6dSOOBOrr4Nuqx5fzA2PmCUxgT5hzIFcxKN8w7AU5k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtF3sNVR11zIIyiQ8bHT1ihvJ0OBSDwJNDEVWHyaF49ZhTKxSGgv0Ns8lA8m1OA/1la72ive2djo0UN80iQtEg70RbAVMi+ZaurAazAGl767CNleDEFIt7U9BC3DhDXtymjf6MEjeSXpj0fSu0Rk2R9zAbbxy2OVxpKpDqMyef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eowm4Ano; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eowm4Ano"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48896199cbaso6253675e9.1
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 04:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778152788; x=1778757588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/HfYKdw9t8t7YQxRwq0mAE+fhOLgPCxr7w0hEuXz/ZI=;
        b=eowm4AnotIEdHPnkk7YexySQiFQR8LPI2oLTSBM6QcF42h027bNccl2wDxyJlTshER
         MdNSN3K4YN+B0tmd3JfBqk5+7+GbLhyzq7y2kc7F76MwiWNAmxqrts0MrfoxhY7af9S5
         2vPnU4lNCISYv3eXO9q2djooJD5YQjICE2/uXRzWp5d4EhHTOXZxt9T8D67EO9PX1Gjt
         Q70MIZY4HunQVXmamluS+Sr88X1y5r5fGpIySZga/CYhMKUk8zY3zG2z4n9X0qgjm0Jz
         QIQyaPBPSV/lYyZYJHIwsM47Bw77gVTQhImLTHiwEg6VeUA1q6e7tdUmEOR6xAImg0cT
         uR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778152788; x=1778757588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HfYKdw9t8t7YQxRwq0mAE+fhOLgPCxr7w0hEuXz/ZI=;
        b=ajDwNY/9EjCBWEUXC7RNiF0MZY1U9j71opTIdaqeKoPw7O0hMOCPvXJ3esfoqPYyYZ
         j1eQvFLnNDSSgy9utwSNJKK00cv5Oq+FFNH/qoNzOuEGwNQfSF693PI07x5mS1V7+ohe
         IZlMqxF0VuOV0Cum+QfOIX2PcwZTBaWxw4147++iRUFTgEyX7VrrZOy/MeOAWdosSxKq
         ihoQUxd9Ut7QYqlg69ux4UR2+K5IHBquO8zLMr2fJDGAejjUPJiThFA77hQrDtbb/Fjc
         tExOHBLOplo87CbdFycNes0MnJSm9n731lhgIFT8M3Q17ix1gdjyzYWgdjP+flpnmWLn
         /nWg==
X-Forwarded-Encrypted: i=1; AFNElJ+DmyePmFXEVJw85cA9MfXZ15F3DcdHdqMtg4xQoOhR2T6yI2/bgVEJsAE2ROzVoLVCPOdqQh8P7GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWcuSw4u88dtCXoencpoqPhsL+sa0qRsKJ6l2Bue6VFr9qghC0
	/yEVqqf71tDUtF4RWfkiipw1fgmzGAJ6ilBShHbZIHjQrPQ+46j+DdYD
X-Gm-Gg: AeBDieuTtJ+Ona89WAfwRWtbvb1fZz9vS5Lf8WVA3Lp9dG/wXlHuaJxEqh//4LtnCK7
	6vzlWFF+mJBnRZpx9biwTVUdaMehl0s9p6QXPw56vYehtdadVOglkCqOiSsoMMRaNOrWhMJV4m/
	VONFne3Y0Dgtg/uEhKjaPbSde9ltjVmKnhqpTC9Zj3qbhqLfYS3ICW89YgzHbyKzt9VTPwtNEJR
	rlunHu1vfEz1LTUDpGYWUZEjrzoXEwhsrxE+2RH4SM2b1/py+qwsWcS/RikDNuzio46T4MwNFvG
	gvZZV+YCHE1tiZHO9jQ6KlZ/tF9iWcwn8xff9OE0e1tuFsc12Qw3BWynMkBefjwVSE963X04+8W
	lBkAEBw8EGaebdXPID9K0O8U5VtQ8iX8q7uFbqgB06EBAHwlfiD4Ub+cjFWeE8n7MUgpQiWnYHE
	9hEKb7JJCJMpEW+7wyJifF5qyA7N7jRQh3/LtOdXZ60nrrzV7Nmje6mmSv6pvwnwkFeUUw3nEdD
	KqhwIAL1OI3y33KmykTZ0RF/3UXzgrG2GauWzDqQB1s0uqMf9D4SFvEctDS
X-Received: by 2002:a05:600c:83c5:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-48e51f2a759mr110026335e9.9.1778152787811;
        Thu, 07 May 2026 04:19:47 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5382a327sm209504235e9.0.2026.05.07.04.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 04:19:46 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Thu, 7 May 2026 12:19:40 +0100
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v11 09/11] iio: frequency: adf41513: features on
 frequency change
Message-ID: <j6gysb6cp4cjzvf3erwgmpmltnwsjif5pcr5uxmysqbhbj72ml@svc7ncvercju>
References: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
 <20260506-adf41513-iio-driver-v11-9-2b7e99cfe8f2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506-adf41513-iio-driver-v11-9-2b7e99cfe8f2@analog.com>

On 26/05/06 03:08PM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Set Bleed current when PFD frequency changes (bleed enabled when in
> fractional mode). Set lock detector window size, handling bias and
> precision. Add phase resync support, setting clock dividers when
> PFD frequency changes.

Sashiko's feedback:
https://sashiko.dev/#/patchset/20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2%40analog.com?part=9

...

> +static void adf41513_set_phase_resync(struct adf41513_state *st)
> +{
> +	u32 total_div, clk1_div, clk2_div;
> +
> +	if (!st->data.phase_resync_period_ns)
> +		return;
> +
> +	/* assuming both clock dividers hold similar values */
> +	total_div = mul_u64_u64_div_u64(st->settings.pfd_frequency_uhz,
> +					st->data.phase_resync_period_ns,
> +					1ULL * MICROHZ_PER_HZ * NSEC_PER_SEC);
> +	clk1_div = clamp(int_sqrt(total_div), 1,
> +			 ADF41513_MAX_CLK_DIVIDER);
> +	clk2_div = clamp(DIV_ROUND_CLOSEST(total_div, clk1_div), 1,
> +			 ADF41513_MAX_CLK_DIVIDER);
> +
> +	FIELD_MODIFY(ADF41513_REG5_CLK1_DIV_MSK, &st->regs[ADF41513_REG5],
> +		     clk1_div);
> +	FIELD_MODIFY(ADF41513_REG7_CLK2_DIV_MSK, &st->regs[ADF41513_REG7],
> +		     clk2_div);
> +
> +	/* enable phase resync */
> +	st->regs[ADF41513_REG7] |= ADF41513_REG7_CLK_DIV_MODE_MSK;

	Does this accidentally write a reserved hardware state by forcing all bits
	in the mask to 1? 
	If ADF41513_REG7_CLK_DIV_MODE_MSK is a multi-bit field, using the bitwise
	OR operator will set all bits in the field to 1 (e.g., 0b11). Typically,
	phase resync is 0b10, fast lock is 0b01, and 0b11 is reserved.
	Should this use FIELD_MODIFY() with a specific phase resync mode value
	instead of directly OR-ing the mask?

Indeed, it should be using FIELD_MODIFY() here:

	FIELD_MODIFY(ADF41513_REG7_CLK_DIV_MODE_MSK, &st->regs[ADF41513_REG7], 2);

-- 
Kind regards,

Rodrigo Alencar
