Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E3136E3F;
	Sat, 14 Feb 2026 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771084641; cv=none; b=ZLWb0HCkt/AksX5EqvjHNfCilcn7YF6oGII+KNBqLDDMMFPjIFIQhS3QAAtX+DwlmLpam9GZU4WXNuNdoJM0IQW9Kr68GL9ohFCF1/G+oI0FOdVGhbYj2YYdm3l4D6HczpcBv3pdjm6nW7kpc91ILj/TYie0If1F1tH2BmkATMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771084641; c=relaxed/simple;
	bh=pyux4UoYIzKBl1eKxJh0HuHP8fM70OdUtxfXSJ7PVq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Woi7/U2Na0yPZ+Sf5hAiCKlU6lsS4Ox/IdwhFD7XpMUVI9+jj6yKtEX6cPRxSBPIoilJQoyvlkWQC1qA0vcepwFCW2c+VExk18ZwAUR5L3uS/hNE9LMSZ8x2sWhJ0q0w/sXuS4nC44TNlAWt94p9Scsa0XKBTMFjfKVVEKzCesQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri3n5JXH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri3n5JXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF294C16AAE;
	Sat, 14 Feb 2026 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771084640;
	bh=pyux4UoYIzKBl1eKxJh0HuHP8fM70OdUtxfXSJ7PVq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ri3n5JXHTlsu/gnvMvmXbVR/YPGfQp9Pj/hfgMJ0lkQvbwKe3JC0SePLm+9h9lb5F
	 gdoEAi/lbTU8w71nm6KC0St+OvZGNEBvaBOaf5TBxu4GVt9kxLdqhN/7UcS1ETaWza
	 Zy61Bu3pgtVJBLGNFo2IsCweyUMfVOK6Nq2XwkBMRpzU8W40MZVbW+Xb0tRp5YvNam
	 ZISdhWW1MOpPvmNj0gNTxGY/9v98b1cTtAS1LMHQSwGojQz36VP7wjTIuKeWlkampr
	 yxSgverryQBvQK4/84fp1WX3EFfhcJs1eZ/jbQ80pXHI72cB1u7KCajVq93EBgsWYZ
	 GCuk6v7QGVboQ==
Date: Sat, 14 Feb 2026 15:57:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 0/6] iio: adc: ad9467: Support alternative backends
Message-ID: <20260214155711.2c0094cf@jic23-huawei>
In-Reply-To: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
References: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 10:53:33 +0000
Tomas Melin <tomas.melin@vaisala.com> wrote:

> To facilitate backends with different set of features, add support
> for defining capabilities provided by the backend. These capabilities
> typically extend beyond a single operation and are therefore not
> directly linked to if a single function call is implemented or not.
> Furthermore, the capabilities determine if a certain set of operations
> should be attempted, or skipped by the frontend. This way
> the frontend driver can work with a minimalistic set of features and
> still have the device in fully functional state.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Hi Tomas,

I made the two tweaks Andy suggested to patch 5 and applied the
whole series to my temporary IIO branch that gets pushed out as testing.
I'll be rebasing that on rc1 once available.

Jonathan

> ---
> Changes in v7:
> - Fix missing check for calibration for test mode off
> - Add commit to clean up device usage in probe
> - Add empty lines around calibration check
> - Link to v6: https://patch.msgid.link/20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com
> 
> Changes in v6:
> - Renamed CAP_ALWAYS_ON to CAP_ENABLE with inverted interpretation
> - Renamed CAP_BUFFERING to CAP_BUFFER
> - Added sd_adc_modulator capability commit (CAP_ENABLE)
> - minor fixups in code and docs
> - Link to v5: https://patch.msgid.link/20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com
> 
> Changes in v5:
> - As per recommendation, use guard for whole block
> - Typo fix in commit message and cover letter
> - Link to v4: https://lore.kernel.org/r/20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com
> 
> Changes in v4:
> - Readd CAP_BUFFERING and also add CAP_ALWAYS_ON to support backends
>   that do not need explicit enable/disable
> - Don't mix checks for eopnotsupp and caps. Prefer capability checking
>   also for caps that map to single operation
> - Move capability checking to top of call stack
> - Revise iio_backend_has_caps to use bool signature and fixup semantics
> - Amend documentation texts
> - Add capability checks for axi-dac
> - Drop two's complement patch from this series, already applied
> - Link to v3: https://lore.kernel.org/r/20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com
> 
> Changes in v3:
> - Reduce set of capabilities to only include calibration. The other
>   ones propsed in V2 can be seen as subset of calibration, or single
>   operation failing with opnotsupported
> - Rename backends checking function
> - Relocate caps field inside backend struct (pahole)
> - Add kernel-docs
> - Add capabilites for exisiting backend variants
> - Link to v2: https://lore.kernel.org/r/20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com
> 
> Changes in v2:
> - Added industrialio-backend capabilities feature
> - Removed acceptance for fully optional backend, instead require atleast
>   minimalistic backend to exist
> - Switched to FIELD_MODIFY()
> - Fixed kernel test robot reported failure for missing bitfield.h
> - Link to v1: https://lore.kernel.org/r/20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com
> 
> ---
> Tomas Melin (6):
>       iio: industrialio-backend: support backend capabilities
>       iio: adc: adi-axi-adc: define supported iio-backend capabilities
>       iio: dac: adi-axi-dac: define supported iio-backend capabilities
>       iio: adc: sd_adc_modulator: define supported iio-backend capabilities
>       iio: adc: ad9467: simplify device pointer in probe
>       iio: adc: ad9467: check for backend capabilities
> 
>  drivers/iio/adc/ad9467.c           | 95 +++++++++++++++++++++++---------------
>  drivers/iio/adc/adi-axi-adc.c      |  5 ++
>  drivers/iio/adc/sd_adc_modulator.c |  1 +
>  drivers/iio/dac/adi-axi-dac.c      |  2 +
>  drivers/iio/industrialio-backend.c | 16 +++++++
>  include/linux/iio/backend.h        | 24 ++++++++++
>  6 files changed, 105 insertions(+), 38 deletions(-)
> ---
> base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
> change-id: 20251215-b4-ad9467-optional-backend-23f1099ee4d7
> 
> Best regards,
> --  
> Tomas Melin <tomas.melin@vaisala.com>
> 
> 

