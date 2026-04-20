Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016E257843;
	Mon, 20 Apr 2026 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692745; cv=none; b=YuGeYbQsHXlNsZDT8pWiGctm/wIQyPA2fEpivELs3kOLd5zif+Bxi0OAyZqJJoWDMF7DjPxFZoBWkaFcWmikyNU6DokEUzFO/7IB+1XFzFSrbJtfgasvW9/1RO2kZHdmkZWZ8BbueXT+/vuSMUGS3gwwEYYfZMA7rwqsusMgZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692745; c=relaxed/simple;
	bh=4uUk2tFvmOxKKp5v4lSQpIV3bzDsnc23UWWbpL071Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipfBXzAqRpwfkUs98vzOYOQyoqINmmeP2BaYveb12ZvyrIENdpJcB3iNzJ6GKw1w7WF6YzjB4iKb6htBfd62J5ZU9Mo/06D3tAeO2bUVZtqQMMVqkSusdGrCKgyriaXMYnPgTOjKNposLAYbf2zV6goQDVEEDdeqduZ1GMqomAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHCGOJpk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHCGOJpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F5EC4AF49;
	Mon, 20 Apr 2026 13:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776692745;
	bh=4uUk2tFvmOxKKp5v4lSQpIV3bzDsnc23UWWbpL071Uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hHCGOJpkva/8VYwQgX9ppy9NKmxx0Xc/L9x+Bs+Ps8mpCVZ6gwsIWxKwsXy60x9qG
	 IgBpyNlX3viG51kYqsPlK02hCw7wqAcLm0uP9Rm3zkWcMxsK7njBlDu0SrYCKXBG+6
	 lcL9O/86XKuRcwzklDturUYBHPV86bZqnI7nTMIH9iuNK6V+8MRhr2NcjogzdGB+sG
	 5WWTZ1pr1QiL09H/Af5ZSDEfuKwJ5N7QctZtWrmByCCNP5Zd/qJ+M9IqadCDVcY73u
	 7D098w4S+CYCeDmTVkhnSdAF44NMxjLQdyukpaQhYeU0lQUaa7SGxE5JQ6jKtHWamT
	 J0HYlnKG8//tg==
Date: Mon, 20 Apr 2026 14:45:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hardik Phalet <hardik.phalet@pm.me>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, me@brighamcampbell.com, nuno.sa@analog.com,
 robh@kernel.org, skhan@linuxfoundation.org, Hardik Phalet
 <hardik.phalet@gmail.com>
Subject: Re: [PATCH v3 0/5] iio: magnetometer: add driver for QST QMC5883P
Message-ID: <20260420144534.0e47c06a@jic23-huawei>
In-Reply-To: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Apr 2026 22:32:09 +0000
Hardik Phalet <hardik.phalet@pm.me> wrote:

> This series adds an IIO driver for the QST QMC5883P, a 3-axis
> anisotropic magneto-resistive (AMR) magnetometer with a 16-bit ADC,
> communicating over I2C. To my knowledge there is no existing
> upstream driver for this device (see "Prior-art register-map check"
> below).
> 
> The driver supports:
>   - Raw magnetic field readings on X, Y and Z axes
>   - Four full-scale ranges (+/-2 G, +/-8 G, +/-12 G, +/-30 G),
>     selectable via IIO_CHAN_INFO_SCALE
>   - Four output data rates (10, 50, 100, 200 Hz), selectable via
>     IIO_CHAN_INFO_SAMP_FREQ
>   - Four oversampling ratios (1, 2, 4, 8), selectable via
>     IIO_CHAN_INFO_OVERSAMPLING_RATIO

I'm suspicious about this one based on a very quick read of the datasheet.
Conventional oversampling would involve running the internal sampling
engine at a multiple of the sampling frequency, and then averaging the
results.  The datasheet describes this as:
"Over sample Rate (OSR1) registers are used to control bandwidth of an
 internal digital filter. Larger OSR value leads to smaller filter bandwidth,
 less in-band noise and higher power consumption. It could be used to reach a
 good balance between noise and power. Four over sample ratios can be selected,
 8,4,2 or 1."

That sounds like a boxcar filter to me not oversampling (which would be
a combination of box car and reducing the output data rate).

If possible, can you enable the data ready output and put a scope on it
to see if that changes frequency when OSR or OSR2 are modified.

Trickier to do would be looking at the noise levels whilst playing with
these filters and see if they at least match with standard filter types.

If we can't figure these out, then it may be a case of picking something
that works well and hard coding that rather than letting userspace
change things in a fashion that might not match the ABI.

>   - Runtime PM with a 2 s autosuspend delay
>   - System suspend/resume delegated to the runtime callbacks


