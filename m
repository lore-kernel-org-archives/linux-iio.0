Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33563285C8E;
	Sat, 14 Feb 2026 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771089716; cv=none; b=LxrKPWdA3A9xhV2KtAlgcSSxJhLMvOTeTGBUh2q087WcXmMvdddvlLvqee+liH7YnD14/5dA1J/KhHx/eg7TrXVSndzWBFlc4HZadM4cnDCP2rppEXCAg360LjB+ZKag5n1U0YAIHSqftc7xAIjX8Df5cgiASPhRI0lDCF/YmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771089716; c=relaxed/simple;
	bh=1i7gSbu41hFYgTCQF1arKUFvWp4WQocuuxlQ71+EUnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYqBXQVMfAj0aTqU4HA8MPReTx+XyrzRH9ZfHvW0pKgX/v5cK6JbPJPax2d9bSWOJORsNmR/j10AFSZKu21mAoZ2qXqaUbbgz9JrrYZEWPifNLtsI44NV/HAkfAe9/r/uvhBYNaqBchjJum0iau3tj+56aU8bYpWcivLsngDXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0ZqRKau; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0ZqRKau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638D4C16AAE;
	Sat, 14 Feb 2026 17:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771089715;
	bh=1i7gSbu41hFYgTCQF1arKUFvWp4WQocuuxlQ71+EUnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i0ZqRKauN6Fd1sn2OtSYTf8S5LDExvFq2oxtrsi3n+cb8XpVL9ev8Y437Q4HTVvuJ
	 nYHU6PSOEPV6t4ATsGxT0hdM6CYLC8pUwMa14AJNLTo/Dyce++tnYR3zRTE0DG+JsK
	 rA+/WLUCOiF848cFBEcbF9zObAbGrEnE7qZKsGuq+0qqCzlrajsok2iUYZ6Moue304
	 TCvPSkkw9J31wadZ2Sf5sUJQycDpIR1usX+5yWnHFDakGMkU0VqQT0BhBOjBXcD0S/
	 rfOleePvxM7VwQFTUn/kxmTBxmZqwmpmYtevUfCitCQkBQOJyFAbm548HwiVWcZ8YR
	 HKv54UmRrZQ+Q==
Date: Sat, 14 Feb 2026 17:21:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: dlechner@baylibre.com, rdunlap@infradead.org, skhan@linuxfoundation.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: accel: adxl345: Add event scaling and doc
 fixes
Message-ID: <20260214172145.69cab531@jic23-huawei>
In-Reply-To: <20260208150515.14798-1-0rayn.dev@gmail.com>
References: <20260208150515.14798-1-0rayn.dev@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  8 Feb 2026 10:05:01 -0500
Taha Ed-Dafili <0rayn.dev@gmail.com> wrote:

> This series addresses ADXL345 driver non-compliance with the IIO ABI
> for event thresholds.
> 
> Currently, the driver exposes raw values for thresholds (e.g., tap,
> activity) without providing the necessary scale factor to convert them
> to SI units (m/s^2), as mandated by the ABI.
> 
> This series implements `IIO_EV_INFO_SCALE` in the IIO core and applies
> it to the ADXL345 driver, ensuring that userspace can correctly
> interpret threshold values. It also cleans up existing documentation
> errors and typos.

Nice series thanks!

Applied to the testing branch of iio.git which I'll rebase once rc1 is available.

Jonathan

> 
> Changes in v3:
> - Patch 1: Reverted "axis" -> "axes" change in documentation as it is
>   used as an adjective (Randy Dunlap).
> - Patch 2: Reworded commit message to "Implement support for..." instead
>   of "missing from..." (David Lechner).
> - Patch 4: Simplified documentation table by removing repetitive scale
>   values from every row. Added explicit table entries for the new
>   `in_accel_gesture_scale` and `in_accel_mag_scale` attributes instead
>   (Jonathan Cameron).
> - Patch 4: Fixed "inscale" typo in commit message.
> 
> Changes in v2:
> - Added core infrastructure for IIO_EV_INFO_SCALE.
> - Implemented event scaling (0.612915 m/s^2) for ADXL345.
> - Fixed technical math/decimal errors in existing documentation.
> - Cleaned up grammar and pluralization issues in .rst file.
> 
> Taha Ed-Dafili (4):
>   docs: iio: adxl345: fix typos and grammar
>   iio: core: Add IIO_EV_INFO_SCALE to event info
>   iio: accel: adxl345: Implement event scaling for ABI compliance
>   docs: iio: adxl345: update math and examples for scaling
> 
>  Documentation/iio/adxl345.rst    | 65 +++++++++++++++++++-------------
>  drivers/iio/accel/adxl345_core.c | 28 +++++++++++---
>  drivers/iio/industrialio-event.c |  1 +
>  include/linux/iio/types.h        |  1 +
>  4 files changed, 63 insertions(+), 32 deletions(-)
> 

