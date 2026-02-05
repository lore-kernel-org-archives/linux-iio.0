Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA66117D2;
	Thu,  5 Feb 2026 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323436; cv=none; b=sNhJWNygsJM2WGs/KRB4/X5Hz1mTilHOxLO3ahqTuBer2GpTlUz6DJmsuO/uep4nlefU6wnhvmUbeKSEvCCZJ+OLUziCvx97LQgaULK5UcuOjWH6dAW+riZ40haMUfwvol16N/rHJ4YTTxtulcOOPn2C9Eb2k9apVxgMnAfmaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323436; c=relaxed/simple;
	bh=CHtW1nbVoSUrFnAWfO3pqP2nS8+BIqOcs504jW6+f6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNjXNVYx0hqz/82k2c0Dom9mkzbxQ308Hk0GNjA35TLDwFN5uY0MuGpY/cKHT2K6AZf/MwbhN+aMm9+Fq376ci8vXLMkHpj2N3QiQ/t/g/nmzzaOTlxt9lriy9vXveT69T5WRonszJmJLyxzpXqYnzsALVIqgLSrb0+ouoIIrbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZ0ie0yD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZ0ie0yD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42871C4CEF7;
	Thu,  5 Feb 2026 20:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770323436;
	bh=CHtW1nbVoSUrFnAWfO3pqP2nS8+BIqOcs504jW6+f6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tZ0ie0yDzViPBGZg1hvhp/LDeZG8WqCJr/55UIvYskZBGGxFEVHkFG9iT2jeUgNPs
	 qGthPFcuMQfSHIF7YQFajK5JvK/5brHwzTg8P5QYsgE3jaqKek/2F9I0TVhTV0kmGB
	 ou/Yzq7/uU6/JOb2Xyb/lTwGlzBXH4hJ0LEYD//bfgWcHDnrJCuql+sBeaE4xhP3mW
	 ggosVd8S7F9KAW9m51s8rpAF/rsG9Rii9BNUWfqGOLPR1pVTXUa2FsQ0fjI9JxG5w3
	 Phm2thH/4KLC8LXzgCuub3CY6WWDRgRFT3WQghahXAl0CAkv06nNtR2gPvv7jMn/RU
	 5UFTg1j9VgFHQ==
Date: Thu, 5 Feb 2026 20:30:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Spencer <spencercw@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 vassilisamir@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] iio: chemical: bme680: Fix measurement wait duration
 calculation
Message-ID: <20260205203029.5e2d9c3a@jic23-huawei>
In-Reply-To: <20260205145703.198609-1-spencercw@gmail.com>
References: <20260205145703.198609-1-spencercw@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Feb 2026 14:55:45 +0000
Chris Spencer <spencercw@gmail.com> wrote:

> This function refers to the Bosch BME680 API as the source of the
> calculation, but one of the constants does not match the Bosch
> implementation. This appears to be a simple transposition of two digits,
> resulting in a wait time that is too short. This can cause the following
> 'device measurement cycle incomplete' check to occasionally fail, returning
> EBUSY to user space.
> 
> Adjust the constant to match the Bosch implementation and resolve the EBUSY
> errors.
> 
> Fixes: 4241665e6ea0 ("iio: chemical: bme680: Fix sensor data read operation")
> Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L521
> Signed-off-by: Chris Spencer <spencercw@gmail.com>
> Acked-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> Cc: stable@vger.kernel.org
Applied to the fixes-togreg branch of iio.git

Thanks.

Jonathan
