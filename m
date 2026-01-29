Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607FB38D
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769650674; cv=none; b=AdrBM8MdUKyUsdj968gXvsrR8omtduBKguD9FUyUXqcLZqZYkzrtLfj7nvLH1WCpaRAhWSjRKMh9KGc/Cg8GT19ni33T4NSd9fHIMyUzQLKxxwHTz0hqEkFwLVMF/hbhUqpppVb12jC1Lf52Q1MAWLPajv/wWykgqMpWZvsbC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769650674; c=relaxed/simple;
	bh=yh4a8rS5GiW+FXI0v3E0P4PCN9vRYgfWVEPQ/DeYq4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPlhBQJjqHye07WlzkvLaYaJrP7GYedayQ2Ym0+ZkEUugq4T91JrbcMFBaQxUNvEXIiChHelsTD9OKz+1K9kx3B32dzvWjWw0TUZIpdwNroUwJIhgUPm/vp9KIOPk4dBA9BcI4G84IaeieiFQqMV0IWVU5VV0TyOxHLCPoF6xJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/jm8fCv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/jm8fCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2584CC4CEF1;
	Thu, 29 Jan 2026 01:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769650673;
	bh=yh4a8rS5GiW+FXI0v3E0P4PCN9vRYgfWVEPQ/DeYq4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/jm8fCvkwMRcWGLKzI8fP92FJqtStdY+cS6S/Ao4t3IggQ3RzqJR1YP4ALqSZTKY
	 6FyyLSvWgCylA8GcjSpU8Bv7QkGK5xA4Fj89F+wH0BmneBz0nUBqqTCFzHK9Hr0okR
	 tkO2vmD9cxeo/oMRDcMvCw0F+jCz6QidvdxVdF1qb8LBsdK2V8u8qotZZdWlwzt1BI
	 Jl7vGJdP2gTvLVTw7HzdkAMwUCZIPz+6kjPiHLUufyYLdWLDH64AaMCRgPRrVYtZRC
	 yWTzlyfUivZG+Cm2gDT7CtdqmokD35BGwqk55yDQAUNXuo4GZz07UFtuUY3dQu8OOS
	 g+hS0sVi27dxw==
Date: Thu, 29 Jan 2026 01:37:50 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jic23@kernel.org, nvaccaro@google.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: cros_ec: Allow enabling/disabling calibration
 mode
Message-ID: <aXq57lVUZmZ91nWZ@google.com>
References: <20260128032702.1714041-1-gwendal@chromium.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128032702.1714041-1-gwendal@chromium.org>

On Tue, Jan 27, 2026 at 07:27:02PM -0800, Gwendal Grignou wrote:
> 'calibrate' was a one-shot event sent to the sensor to calibrate itself.
> It is used on Bosch sensors (BMI160, BMA254).
> Light sensors work differently: They are first put in calibration mode,
> tests are run to collect information and calculate the calibration
> values to apply. Once done, the sensors are put back in normal mode.
> 
> Accept boolean true and false (not just true) to enter/exit calibration
> state.
> 
> Check "echo 0 > calibrate" is supported.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Nick Vaccaro <nvaccaro@google.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
