Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093029B764;
	Sun, 19 Apr 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776619023; cv=none; b=c8gXW9uMa4A9DAdYozjkpeZeZ+JAzehreuxfiPO+1vXmE5VQnLAfVRkHGx4EboIDzl4gBp0SOEr0ADy3HBoie2UWUVcXic1tL6XEeZvclrNqtqkHzTsb7e25YIeEttzsg6B5DIy9M9mWXCbDrHV+sTBSs3gyGgq6NVWgzxVB+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776619023; c=relaxed/simple;
	bh=5ayzhMgE+cIGLnYtnr7G2udwD2S+httZqDQKa5qzDng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3pdXtSYMKNG8/7QeGv9rKRZYCuALN8IWtgefWdY07+WoRJ63HFuihQS4r9eyiDXtcqRdpwfZBFctJjeOdm0n1pc8k5drTS0hVtUu/ezvEKV8F3bLApGdBBFd5rvpwYMf1X4cPmGu3MguwH+ceZvSA8G5IUvKu8mmqvRss99bhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZeziM7b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZeziM7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359B5C2BCAF;
	Sun, 19 Apr 2026 17:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776619023;
	bh=5ayzhMgE+cIGLnYtnr7G2udwD2S+httZqDQKa5qzDng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hZeziM7bsxyRyLCmbKiP/r8KVTupPey7Mk9i9a2asSJ23fUih9u/LSbaLDA1n7kTR
	 VxB35bfvZIe7ALOzZq4SAb9hmVC2V4j8Qp5S1vke4RioRJbUKb55Fom7igBF+WQBtF
	 69NI2VoBBuOqVWvfoOsHigUYfBiZzC18TM+UXzWsEQI3Mqh9z2G4kmLmWchGQq1hpJ
	 VFq1g+oZ4Sz+dN2z2GlOqmLt7YovwWWhLsh+vBYR8vRNABENSgGv8H8QgneC1EPS4O
	 YDbBq1kYf5zwKgusQojuwmhsZjkHdt0li/Fd2/LxSgU3NAQe1lYD6ai/I+a6Ex7BCp
	 DnCP/FmrUcd1w==
Date: Sun, 19 Apr 2026 18:16:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Felix Gu <ustc.gu@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] iio: adc: nxp-sar-adc: Avoid division by zero
Message-ID: <20260419181653.15d0f111@jic23-huawei>
In-Reply-To: <20260416090122.758990-1-andriy.shevchenko@linux.intel.com>
References: <20260416090122.758990-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Apr 2026 11:01:22 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> When Common Clock Framework is disabled, clk_get_rate() returns 0.
> This is used as part of the divisor to perform nanosecond delays
> with help of ndelay(). When the above condition occurs the compiler,
> due to unspecified behaviour, is free to do what it wants to. Here
> it saturates the value, which is logical from mathematics point of
> view. However, the ndelay() implementation has set a reasonable
> upper threshold and refuses to provide anything for such a long
> delay. That's why code may not be linked under these circumstances.
> 
> To solve the issue, provide a wrapper that calls ndelay() when
> the value is known not to be zero.
> 
> Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603311958.ly6uROit-lkp@intel.com/
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
Thanks,

Jonathan
