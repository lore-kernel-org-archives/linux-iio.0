Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC238B99E;
	Thu, 22 Jan 2026 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114041; cv=none; b=sbwWzr0sfaPq6XrGc/pQuOPvV6XmFL4PwJDz2DizyzePrDiIq5Bnahw4cvQV/msST1pqg4cCh/JuhT64S2WdVZh65ca9FyKz5VLSqDrnaUt+qyjAK5mICtUtiX5WDKRsbbwq75E/nWuoyWT0Q++2Mskb1SdzdFQ75P4KN+W9POE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114041; c=relaxed/simple;
	bh=CMxgFMRRNZU/Zo9fn/0capcReeHVflLObvh1bw1FIi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pvt3BFXbX8lg18wkCslgwXyBChmUIck/+xQosAxVAhpLHzAK2SfE+XK164XLi55nIc0oxizGippnJW466WSZw/igfkdWOjhyy/gmDtxgk2IE2wfYMBYqvq+wUL31cq+jbG+pj5K7LUps5YOy/EntRwPlCtEnvFng9FRO4Z1/98Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4CvMTjz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4CvMTjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FFEC116C6;
	Thu, 22 Jan 2026 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769114041;
	bh=CMxgFMRRNZU/Zo9fn/0capcReeHVflLObvh1bw1FIi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F4CvMTjzgnaOQH9q73X+MfjMwFQiwWdJ7mTm+itF1GgumdM8E3XN2ceWNvzxrmuHk
	 2UJBOzvdoats5weDlUOBJUb6YPOJDl30xYlB0NvlsGzdocbiH8MNxMgHlPyIUqE6E6
	 Q8AODqFMKfVMUzeUpKBBTiwMspptevFZbL9HTgIzCsuqR1a43BTMGwfknx06A6RPCm
	 N5dhqwG9MjyzYs8l+VSgI6QYsGU6tAY4iDzBqvd0mLE2cC6N9dfnoPGhOTNYIJvNAT
	 gTUG8m6r4NlWNNCG+2bVvqaH3abFPUWSztkFobVL6QcB6THBVIBK4K4iPgD38Xj/R6
	 GIK3jR4ick5tA==
Date: Thu, 22 Jan 2026 20:33:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Linus Walleij
 <linus.walleij@linaro.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] drivers: iio: mpu3050: use dev_err_probe for
 regulator request
Message-ID: <20260122203329.7664dff0@jic23-huawei>
In-Reply-To: <aXJJMZGeSboC4K8t@smile.fi.intel.com>
References: <20260122153425.8751-1-clamor95@gmail.com>
	<20260122153425.8751-2-clamor95@gmail.com>
	<aXJJMZGeSboC4K8t@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 17:58:41 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jan 22, 2026 at 05:34:25PM +0200, Svyatoslav Ryhel wrote:
> > Regulator requesting may result in deferred probing error which will
> > abort driver probing. To avoid this just use dev_err_probe which handles
> > deferred probing.  
> 
> I believe this deserves a Fixes tag.
> 
> Anyway, the rest LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Added one. It goes all the way back to:
3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
in 2016.

Given age of issue and timing I've queued this for the next merge window.

Thanks,

Jonathan
