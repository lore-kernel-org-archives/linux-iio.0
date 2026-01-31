Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5700C2DE6F1;
	Sat, 31 Jan 2026 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885490; cv=none; b=Hs1FJYfzNBf9fRMGbY0DuA5uU92PHDQC993Nc95UvPv8GEiaxXIUiYSgbW3fgKiQzHxVviP14l51RR+akoYBdB1Vrvk47KKltkAYrx8qNV2NhCHMSXuSa6SsT93saeoe5nBeSZL9tLfLufzfMIOh25uWHvAKZa1IDoGObQZkHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885490; c=relaxed/simple;
	bh=zWiay6IqhFhhZs/FGppzgFOgJacw8dCy0QwNS5zyn2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlMJyloSzzfN6dxVgSsJ+r01eSPDOGRTME5n4ejzOEaPRS8LzCrH0bUmA8M7rA3SuzR476CMmZGpwsLPl+47CHOE2o+J/8NW7rpyHp1iPyiqVY0qDEfsMFkYGK7/9F6J/yEXH3hoceLdxSszcD8z8ulGqKL1DwLQqBpF72zRuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY4ccLEh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY4ccLEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D5CC4CEF1;
	Sat, 31 Jan 2026 18:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769885489;
	bh=zWiay6IqhFhhZs/FGppzgFOgJacw8dCy0QwNS5zyn2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nY4ccLEhBrG7QRjWrUEBPasGNpVd1bIOpyLCwfUf+fxQ8+C7KU/dQEpaVicgTANmA
	 mn2XdSNmL09BSl6hBfqk+JMNAeEJZkRLtKJExzthrQ7swrQPr4nVGf3kjb9yf5MYzW
	 QRM50NWmpjNE4PkDvBKce9sGr6forsSgHGkS0dhTk4e0w+c5LBltd1cPElamvn5LJX
	 uPATPPxZNKwZeZvEpPWxjUkUlJbO7DbsleVDsg7jNTN6tvJuE8Riffj0CTIHPDedvz
	 ifOPU8mEGlvxafW9RyD0UkUOTZgqrPRnO3XufOGg4O0FunNYRRDsvvnlbZjaLt0BgK
	 O94vu9+UQFOTA==
Date: Sat, 31 Jan 2026 18:51:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan.Cameron@huawei.com, nuno.sa@analog.com, andy@kernel.org,
 dlechner@baylibre.com
Subject: Re: [RFC PATCH v1 1/9] iio: ABI: Drop unused in_energy_input
Message-ID: <20260131185121.0e37989e@jic23-huawei>
In-Reply-To: <c4bd27e1a0db2d50ae9130ae49188ba33d796a96.1768759292.git.marcelo.schmitt1@gmail.com>
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
	<c4bd27e1a0db2d50ae9130ae49188ba33d796a96.1768759292.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 15:18:57 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> No IIO driver declares a channel of type IIO_ENERGY with info_mask
> containing IIO_CHAN_INFO_PROCESSED. Thus, in_energy_input has never been
> seen in user space.
> 
> Fixes: 72c66644673a ("iio: core: Introduce ENERGY channel type")

I don't think the fixes tag makes sense.  This is just tidy up of
unused ABI, because why document what doesn't exist?

> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
> Added a fix tag though not sure it's needed/desired since it might not be worth
> to backport documentation?
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5f87dcee78f7..aec39b8e3345 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1601,7 +1601,6 @@ Description:
>  		For a list of available output power modes read
>  		in_accel_power_mode_available.
>  
> -What:		/sys/.../iio:deviceX/in_energy_input
>  What:		/sys/.../iio:deviceX/in_energy_raw
>  What:		/sys/.../iio:deviceX/in_energyY_active_raw
>  What:		/sys/.../iio:deviceX/in_energyY_reactive_raw

