Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E4392B7E;
	Thu, 22 Jan 2026 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114327; cv=none; b=GmkjqJBNg0LxlWBmUA7ACSnGfArFaqm1mk4PFAtoaFG//qq9m2SGfSATcjvwACrx1hetxH11RAZY3Dvg/sr9NW/xBBzCwMbmaKT2C5fK9SxiewJaRiLH2FcKU/HF0qk6NizCOfGCF28RZx7iQgEDudg7tzHY3RM7OpMyF9F41xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114327; c=relaxed/simple;
	bh=KXMy6g3Wkg4/OPTqy1LkPPp26Fiy2UD7XLpXJvZwlho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYiU8b0Uz2BbqdHFOl5Y8hYJmfz1feyFO+wZt8/g9GQGsZqGPc3IVpxCMckkd94tUZT3SQ9HCUf7ZmmTpUvaBsNdOBvAjlzodrTm0zaMpkatDqd2AoM/+kFanpi3C1fESqRYGPXETP2mBjJJ2UODFj6y+JYDfbVMlp1h3DqfTMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlQa3TKn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlQa3TKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40F0C116C6;
	Thu, 22 Jan 2026 20:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769114325;
	bh=KXMy6g3Wkg4/OPTqy1LkPPp26Fiy2UD7XLpXJvZwlho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nlQa3TKnnrZ+uVSiwZ27/HrcxrhJyLiuWupLCiaXIBPhygsSP9bW47kXvE8fZHEXo
	 cirjgiBx/zS34Rb9V5g7rYoT34oEg+rQ1PqbyosD60S68oB8i9nduf7QC26drwz4NJ
	 dyVALILpKBi4BVgg+axyXeT9e13QutWle3Pt0F+XxmyC1l9Djc7rich5eDMZLrEszF
	 B7Kt/vrcO0WLIOCZlmGLI0SSFCuSCc7H8G1tVvBy9QXyHiuj/0wP7uU0Iu5jz6dqOv
	 UNVPgaAD/swN7PSPlb/g6yFap/ov79wxAeF5nz3qrOuqcC9RqjCTtOtgtz0wauOnsw
	 vGzCHIorZt5RA==
Date: Thu, 22 Jan 2026 20:38:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] iio: adc: ad9467: Support alternative backends
Message-ID: <20260122203836.3019efe8@jic23-huawei>
In-Reply-To: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
References: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 12:08:29 +0000
Tomas Melin <tomas.melin@vaisala.com> wrote:

> To facilitate backends with different set of features, add support
> for defining capabilites provided by the backend. These capabilites

Spell check. capabilities

> typically extend beyond a single operation and are therefore not
> directly linked to if a single function call is implemented or not.
> Furthermore, the capabilites determine if a certain set of operations
> should be attempted, or skipped by the frontend. This way
> the frontend driver can work with a minimalistic set of features and
> still have the device in fully functional state.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
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
> Tomas Melin (4):
>       iio: industrialio-backend: support backend capabilities
>       iio: adc: adi-axi-adc: define supported iio-backend capabilities
>       iio: adc: adi-axi-dac: define supported iio-backend capabilities
>       iio: adc: ad9467: check for backend capabilities
> 
>  drivers/iio/adc/ad9467.c           | 72 ++++++++++++++++++++++++--------------
>  drivers/iio/adc/adi-axi-adc.c      |  3 ++
>  drivers/iio/dac/adi-axi-dac.c      |  2 ++
>  drivers/iio/industrialio-backend.c | 16 +++++++++
>  include/linux/iio/backend.h        | 25 +++++++++++++
>  5 files changed, 91 insertions(+), 27 deletions(-)
> ---
> base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
> change-id: 20251215-b4-ad9467-optional-backend-23f1099ee4d7
> 
> Best regards,

