Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF135DCEE;
	Thu, 22 Jan 2026 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109418; cv=none; b=ssRr/nzwhAvmle4GahBP5PouxIxc2VrrfjDTNAHNKLDCmzIzv+r7fkJX3m5uI6eM1awtUw1YPg3b4tJW77mY8YJdGBDLvJKjhdYctXphFSwIQ6WkQr/vH39PmTmWLbvcwdG/3pX/jDyNzZmwHrB3rzj2+gUPr+Dv8htyS2S5MSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109418; c=relaxed/simple;
	bh=0kZ71WJP6OLB8TARzAvQV419UxdEmSp/UWUFCdxlmaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIrdLflNO6NxXEOXrkCWsJHAbE1/9LFvAGk7GXQ/fb6/hLe/vb5jVqyAXPG6KY+87AY6zWcOeI4bIPR2Pdo7pkvfRIdpCj9zSMn/HLS2nMhq/j8UsgtvFj9qat6WanE//0XLb0SBT/kbsmdgYDcgCucSlFuGtMqJfTKINT+rbSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHS6IVM3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHS6IVM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5FEC116C6;
	Thu, 22 Jan 2026 19:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769109417;
	bh=0kZ71WJP6OLB8TARzAvQV419UxdEmSp/UWUFCdxlmaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HHS6IVM3DA68UiUmvhfmjDI/X2bY520P9zeNm/WYeLlznDK862hrXMRa1EJh5YOC1
	 6BhVB/qVjSuI3bvSx3YdgLM4L9Ol75bXulPvTYJFoFaAev7KeuXCshDh8PaHtFijsZ
	 nyUSeCFyeji36UDHppMSHYYFMZiwSCW2trwURDxbW5vom8y2mAkcZ2h20M/Prypsn8
	 XYMtsMs0IFJ9F6PTV09t2wDlMOWkJDbRgjwzNxtWs+wtrsxg/06/j5SgJpek5TAO3j
	 e9ckli1/EBJXNaatQSjSM2dEW3aNWzTz6dXdM/yFKB4xceOhk9EOk14HuKj+JVNeJM
	 9Ny8kX9QFYQYw==
Date: Thu, 22 Jan 2026 19:16:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Benson
 Leung <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck
 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
Subject: Re: [PATCH v5 0/7] iio: core: Introduce cleanup.h support for mode
 locks
Message-ID: <20260122191648.2c10cdf6@jic23-huawei>
In-Reply-To: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 01:20:40 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Hi,
> 
> In a recent driver review discussion [1], Andy Shevchenko suggested we
> add cleanup.h support for the lock API:
> 
> 	iio_device_claim_{direct,buffer_mode}().
> 
> Which would allow some nice code simplification in many places. Some
> examples are given as patches, but the last two are the biggest
> differences.
> 
> In this version I dropped the RFC tag, as the general feeling is to go
> through with this after some modifications. Main one is the addition of
> IIO_DEV_ACQUIRE_{BUFFER,CLAIM}_MODE() wrappers to avoid drivers using
> the guard classes directly. I also added comments on the forbidden ways
> to use this API but I definitely still take suggestions on this.
> 
> For now I dropped iio_device_claim_buffer_mode() rename, as this point
> is still being discussed. My suggestion based on the RFC discussion is
> to do it, but in a separate patch (using coccinelle) and while we're at
> it rename the whole API like this:
> 
> 	iio_dev_mode_lock()
> 	iio_dev_mode_direct_trylock()
> 	iio_dev_mode_buffer_trylock()
> 	iio_dev_mode_unlock()
> 
> Let me know what you think and thanks for taking a look!
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
I've queued this up. For now it'll just be pushed out on the testing branch.
Hopefully the new noise from sparse won't bother anyone too much.

Jonathan

> ---
> v5:
> 
>   - Fix all function/macro names in kernel-doc
> 
> v4: https://lore.kernel.org/r/20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com
> 
>   - Replace "," with ";" in __iio_dev_mode_lock() docs.
> 
>   - Fix "bellow" -> "below" typo.
> 
>   - Drop first example in IIO_DEV_ACQUIRE_DIRECT_MODE() docs.
> 
>   - Match variable names in kernel-doc and definitions.
> 
>   - Replace "markings" with "annotations" in the "static inline" remark
> 
>   - Replace "claim_ptr" with "claim" in IIO_DEV_ACQUIRE_FAILED() and get
>     the pointer inside.
> 
> v3: https://lore.kernel.org/r/20260106-lock-impr-v3-0-1db909b192c0@gmail.com
> 
>   - Reword commit message of patch 1: infallible -> unconditional.
> 
>   - Drop "*strongly*" in __iio_dev_mode_lock() kernel-doc and be a bit
>     more clear on the function's intention.
> 
>   - Keep comment about inline functions and sparse markings, but drop
>     the __cond_acquires() part, as the new implementation makes it
>     unnecessary.
> 
>   - Implement iio_device_release_*() as macros around
>     __iio_dev_mode_unlock().
> 
>   - Rename iio_device_claim_buffer_mode() ->
>     iio_device_try_claim_buffer_mode() to avoid silently breaking
>     out-of-tree drivers.
> 
>   - Drop the `_` argument prefix in new macros, as there are no name
>     conflicts.
> 
>   - Drop "dummy" from IIO_DEV_ACQUIRE_DIRECT_MODE kernel-doc, as the
>     `claim` variable does store the error value.
> 
>   - Drop IIO_DEV_ACQUIRE_BUFFER_MODE() until a driver actually needs it.
> 
>   - Rename IIO_DEV_ACQUIRE_ERR() -> IIO_DEV_ACQUIRE_FAILED() to make the
>     name more clear.
> 
>   - Rename IIO_DEV_GUARD_ANY_MODE() -> IIO_DEV_GUARD_CURRENT_MODE() to
>     make the name more clear.
> 
>   - Add missing . in iio_device_release_direct() kernel-doc.
> 
>   NOTE: Andy suggested __iio_dev_mode_*() be exported into the IIO_CORE
>         namespace. However, this cannot be done because these functions
> 	need to be called inline, so Sparse can see the __acquires() and
> 	__releases() tags.
> 
>   Happy new year to everyone :)
> 
> v2: https://lore.kernel.org/r/20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com
> 
>   - Add __iio_dev_mode_lock() (formerly iio_device_claim()) in the first
>     patch.
> 
>   - Added comments to make sure __iio_dev_mode_lock() is not used by
>     drivers to protect internal state, or in general.
> 
>   - Add patch which re-implements iio_device_claim_direct() using
>     __iio_dev_mode_lock().
> 
>   - Match iio_device_claim_buffer_mode() semantics by reimplementing it
>     in the same way as iio_device_claim_direct().
> 
>   - Guard classes now are prefixed with __priv__ to make sure drivers
>     don't use them directly.
> 
>   - Add IIO_DEV_ACQUIRE_{BUFFER,DIRECT}_MODE() documented wrappers
> 
>   - Avoid any function renames (for now).
> 
>   - Rename dummy variable `claim` instead of `busy` on vcnl4000 patch.
> 
>   - Avoid scoped guard in max30102.
> 
>   - Keep using iio_trigger_validate_own_device() insted of
>     iio_trigger_using_own() in opt4060.
> 
> v1: https://lore.kernel.org/r/20251203-lock-impr-v1-0-b4a1fd639423@gmail.com
> 
> ---
> Kurt Borja (7):
>       iio: core: Add and export __iio_dev_mode_lock()
>       iio: core: Refactor iio_device_claim_direct() implementation
>       iio: core: Match iio_device_claim_*() semantics and implementation
>       iio: core: Add cleanup.h support for iio_device_claim_*()
>       iio: light: vcnl4000: Use IIO cleanup helpers
>       iio: health: max30102: Use IIO cleanup helpers
>       iio: light: opt4060: Use IIO cleanup helpers
> 
>  drivers/iio/adc/ade9000.c                          |   2 +-
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   5 +-
>  drivers/iio/health/max30100.c                      |   8 +-
>  drivers/iio/health/max30102.c                      |  33 ++---
>  drivers/iio/industrialio-core.c                    |  86 +++----------
>  drivers/iio/light/opt4060.c                        |  52 +++-----
>  drivers/iio/light/vcnl4000.c                       |  49 +++-----
>  include/linux/iio/iio.h                            | 139 +++++++++++++++++++--
>  8 files changed, 190 insertions(+), 184 deletions(-)
> ---
> base-commit: eab91f819af428173f7e0aa1c80b3e561c3707bb
> change-id: 20251130-lock-impr-6f22748c15e8
> 

