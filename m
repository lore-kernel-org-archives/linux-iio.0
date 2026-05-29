Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002E41DDC1D;
	Fri, 29 May 2026 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060136; cv=none; b=NRh2pUVi1vRGJYc7h97N1WqO+DndTqqCofIg/rUkRDALZNPdgONONzV72v600/VY17GYHFjf6UMBzougXL0QZcQnEXrb1Fg3ackPZQcvcq+YOafAhJGY1uX/iGbI3U+aaBmAcBpaTMYm7Qyy7HJHBPX45Ltfz6EPjfcMgTFgs0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060136; c=relaxed/simple;
	bh=edwdmi0wEJ+fwilGX8xqh6lmAe/VRe5Ao/4vAbCAAYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMnp/aw83HQWj4hcnBf6um/Y88TB8EilIu+fyfxKiRBrVGzJW7wHwmZN+KTlyB8tK46nMtSTNFgnfPA1lxzWi6obOE4Y68wiFaWPyUJymVk67qcTUVrGnAIHEgoOYt88GW1e/R4QVfNea1p1OH6vzyXqLJ1T4esJvtg5Cc/d9WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft1GVhpu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft1GVhpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28221F00893;
	Fri, 29 May 2026 13:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780060135;
	bh=/crD2cYoejChyxWfzcHWxr8KwNtb1RyAFV93Uy9oPYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ft1GVhpuuU71gzbtjhQq7tF86nImzukBFtF6XifLhbYndR689Q1QzUjT7BwdpC3Sv
	 kwAE3uFtJUP2NlG6leZAySeSoesYaelspY5i/LkXBIPgmhAAIQsHYchmoDmUMHVLoQ
	 rZOVNe7h0da/BJlqUC27SZJhz0SbfR8Bvm9Q9eOEJhKNE/EC475U2QHlF0hEjythvK
	 +NC++P66Jm5fpSIRmoOYomBMNKyh1wRe7EG2Q01Pf3dpECx5JS9v1MOOL4SS8yRi8e
	 5ve2z1b5kAsX+n8/6RmFRcelgnO0qIiohA1NtJLdoO4A6rDB2LFErlY6edbu9MYVP3
	 VHLwBdXaW4wZg==
Date: Fri, 29 May 2026 14:08:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] iio: PM-enable leak on probe error path
 (goto-variant drivers)
Message-ID: <20260529140847.46d71c22@jic23-huawei>
In-Reply-To: <cover.1780051096.git.sozdayvek@gmail.com>
References: <cover.1780051096.git.sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 15:45:40 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> This is the goto-variant follow-up to the standalone ti-ads1015 patch and
> the 4-patch series for the simple drivers.  In these four drivers probe
> calls pm_runtime_enable() but the existing register-failure path jumps to
> a manual cleanup label (out_err / buffer_cleanup / error_power_down)
> rather than returning directly.  None of those cleanup labels call
> pm_runtime_disable(), so the runtime PM enable_count leaks on probe
> failure and on subsequent rebind.
> 
> The conversion is the same as in the rest of the class: replace
> pm_runtime_enable() with devm_pm_runtime_enable() and drop the
> pm_runtime_disable() / pm_runtime_set_suspended() calls in .remove().
> On the new error path from devm_pm_runtime_enable() each patch jumps to
> the same existing cleanup label that iio_device_register() uses, so the
> manual unwind for the non-devm resources held earlier in probe still
> runs.  In apds9960 nothing is powered or registered at that point so a
> plain return is used.
This is v2.  Make sure you increment version numbers even for the sort
of commit message reformat you made here.  Sending as the same version
confuses readers and potentially scripts.

Note this is a clarification not a request that you resend now as v2!
J
> 
> Standalone precedent already on the list:
>   iio: adc: ti-ads1015 -
>   https://lore.kernel.org/all/20260529101011.3030-1-sozdayvek@gmail.com/
> 
> Companion 4-patch series for the simple-return drivers (isl29028,
> tsl2583, mlx90614, bmi088-accel) was posted alongside this one.
> 
> Stepan Ionichev (4):
>   iio: light: pa12203001: use devm_pm_runtime_enable() to fix probe
>     error path
>   iio: light: us5182d: use devm_pm_runtime_enable() to fix probe error
>     path
>   iio: light: apds9960: use devm_pm_runtime_enable() to fix probe error
>     path
>   iio: accel: mma8452: use devm_pm_runtime_enable() to fix probe error
>     path
> 
>  drivers/iio/accel/mma8452.c    | 7 +++----
>  drivers/iio/light/apds9960.c   | 6 +++---
>  drivers/iio/light/pa12203001.c | 7 +++----
>  drivers/iio/light/us5182d.c    | 7 +++----
>  4 files changed, 12 insertions(+), 15 deletions(-)
> 
> 
> base-commit: 7cb1c5b32a2bfde961fff8d5204526b609bcb30a

