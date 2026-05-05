Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA113B7A8;
	Tue,  5 May 2026 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984493; cv=none; b=IZp2Ure2SMimUNhIhh3Cu6TB8GdEJnu1dSIzqjcjOsVjERX7Sr4cLb5mTPAkb/VcYm7A0+mw603FgTgjHYCaoX1uGxyLlfVYsbMfBf/cKuU3xt+3c5DHb9N3ApsWeyZdvDBv1nnQM+JTWUgo8hkbtQChbSZPb+AtXPGpHDeCY/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984493; c=relaxed/simple;
	bh=rR53OEJls2m/Eol63utoDIo8PM37iXGT7NGV05DVgfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTXSyyBGlBKT6xtWcAhN08nlFmR/9MkyeumtmJy97ufgaBBtvOpL/i0l2JrwfnbYj+IDMx+cmU4N+jT4yoippD0hT7ru48nBu3Ux45bfg3Er2zgrCjZD0m87oBLvMVu7JZypR+c2RAIrUob0vmRwG64ju7fHT9fcr/DkL14HFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgBz6OZN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgBz6OZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D68C2BCB4;
	Tue,  5 May 2026 12:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984492;
	bh=rR53OEJls2m/Eol63utoDIo8PM37iXGT7NGV05DVgfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UgBz6OZNNJKJ5mafi57zYezuYuuYOUuEN4eTVlqNDG9j32hYnyKDgbtw/v4ykGVv6
	 3+v3cDb8AV3vTF81f84Fr3LeBthWSEhSI4npwDF1Q/YGDqLkCzg5BHIGRljyjImVsC
	 2OyxJyoTLPYZS/H7dJVgceYv63/fCV52YWOY7RjAIEoa4CeBbjGIvlo0SxMzlM9nOL
	 nnWUVAVFp1uD1sE8nYffKQtJLVbE5hkJqmXRLNiboTMQZvY/aYEMoPyceQOlYXECL0
	 +6YskqNMphGIZnSnCETf0lOvfyuOg+Fo5gbhuLTdDkyddTEnKP7EiGC7MC8ipPSmwO
	 0Pbj8Yt5OupQw==
Date: Tue, 5 May 2026 13:34:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jean-Francois Dagenais <jeff.dagenais@gmail.com>, Maxime =?UTF-8?B?Um91?=
 =?UTF-8?B?c3Npbi1Cw6lsYW5nZXI=?= <maxime.roussinbelanger@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, sashiko-bot
 <sashiko-bot@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 0/8] iio: light: si1133: driver cleanup
Message-ID: <20260505133443.4e345627@jic23-huawei>
In-Reply-To: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
References: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 May 2026 09:31:25 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> This series deals with the cleanup and modernization of the Silicon
> Labs SI1133 UV/Ambient light sensor.
> 
> What seemed like a simple checkpatch cleanup turned out to be more
> complex, therefore I've ended up doing a patch series instead.
> 
> Changes include:
>  - adding missing headers
>  - removing unused macros
>  - adding guard(mutex)() support
>  - code style fixes
>  - race condition fixes reported by Sashiko
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied.

Sashiko is far from happy but I think what it is picking up on
are either wrong (like the i2c stuff) or about other potential issues
in the driver.

Correctly recovering from every error case is fine so I tend
to think of that as best effort only rather than worrying too much
about the more complex parts.

So applied with that one tweak to where timeout is assigned in patch 7.

Thanks,

Jonathan

> ---
> Changes in v5:
> - PATCH 5: fix commit message
> - Pick up Andy's Reviewed-by tag
> - Link to v4: https://lore.kernel.org/r/20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com
> 
> Changes in v4:
> - Changed logical ordering of patchset
> - PATCH 1: fix typo in comment, edit commit message
> - PATCH 2: edit commit message
> - PATCH 3: edit commit message
> - PATCH 5: remove irqreturn.h and add mod_devicetable.h
> - Link to v3: https://lore.kernel.org/r/20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com
> 
> Changes in v3:
> - PATCH 6: add local variable for timeout
> - PATCH 7 & 8: fix potential race conditions as pointed out by Sashiko
> - Link to v2: https://lore.kernel.org/r/20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com
> 
> Changes in v2:
> - Change v2 to patch series
> - PATCH 2: remove unused macros
> - PATCH 3: add missing include headers
> - PATCH 4: group generic <linux/*> headers
> - PATCH 5: add guard(mutex)() support
> - Link to v1: https://lore.kernel.org/r/20260427-si1133-checkup-v1-1-20f5f11eba6c@gmail.com
> 
> ---
> Joshua Crofts (8):
>       iio: light: si1133: reset counter to prevent race condition
>       iio: light: si1133: prevent race condition on timeout
>       iio: light: si1133: remove unused macros
>       iio: light: si1133: prefer complex macros enclosed in parenthesis
>       iio: light: si1133: add missing include headers
>       iio: light: si1133: group generic <linux/*> headers
>       iio: light: si1133: add local variable for timeout
>       iio: light: si1133: use guard(mutex)() macro
> 
>  drivers/iio/light/si1133.c | 69 +++++++++++++++++++++++++++-------------------
>  1 file changed, 41 insertions(+), 28 deletions(-)
> ---
> base-commit: d86db1905add39f905cf9f04252804b359914ed6
> change-id: 20260427-si1133-checkup-abcc5280adf3
> 
> Best regards,

