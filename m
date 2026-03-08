Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0B2236F0;
	Sun,  8 Mar 2026 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772994705; cv=none; b=dGpEgDZQbocPpGlMzdN9I8T+gO5X+uRZ7f4GhsbS04smHzBYbqvki86MtrI2h6fSzxYq4wiD7/2Fl62Cf6kaBzJsJ6g0WUUVSfxKgX83lWmYm1GhUKRoMXAHPO6C94forlz+fPmLL+vQRdnVkhQnNI7xZqodU6wCatPVK94kRI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772994705; c=relaxed/simple;
	bh=xuSXSE3ewqEmhxFNAJVaVE5y4sWJ3Y2EpEuyDhKPIaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISOwE7JqHGdNIeKEKwGEqAoo2W0pJbKhXnag/mVYOFot5e2Ep/bvdNlysQiR7PNMwfT+1D6jDyVAhblamEWSZZEVKRcEjdLifnUkp+b1wzuqHEg7LW348MhDluOFTvXcRT+XobQqATf7zvpUnF/uyCzFUxZt4wXSyyrnzvCvs3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l28LC5N/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l28LC5N/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D5BC116C6;
	Sun,  8 Mar 2026 18:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772994704;
	bh=xuSXSE3ewqEmhxFNAJVaVE5y4sWJ3Y2EpEuyDhKPIaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l28LC5N/+8rkAxBB0G7WnE9v/W4+gCC8mt8YMJxVF3V8rnO+56mkbzyKADJhyFXqO
	 MY6rwZ6Rjdo4J8w7QQ/RxKjmMwt7R//kNZ1IaVt8p2dJRIYk6aMX37+ag0fwdLFc9A
	 spFdI3dcn5Eji5DGRqyGseBXZnnGI0YH58OJZ0C3CLbSaB33/r8N1Zn99NPpZVNQm8
	 bkDN9iVqLz/kx5uBqHH6A97OS8nm5W11T5NG/1jfQeDgHI5kF0nP2eHFddmoB9EZ+U
	 sSRL52ibnaF2hURl61DGrZ3acNWVWqwyT8No/A/KWHjJByL7grGPsHkR8/jc5ifjm6
	 fUKT9aYu1OACw==
Date: Sun, 8 Mar 2026 18:31:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH] staging: iio: ad9832: modernize ABI and remove
 dds.h dependency
Message-ID: <20260308183135.1de38062@jic23-huawei>
In-Reply-To: <20260305210347.120446-1-rougueprince47@gmail.com>
References: <20260305210347.120446-1-rougueprince47@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Mar 2026 02:33:47 +0530
Bhargav Joshi <rougueprince47@gmail.com> wrote:

> The AD9832 driver currently relies on legacy custom IIO macros defined
> in dds.h. This triggers checkpatch.pl warnings (NON_OCTAL_PERMISSIONS)
> and, more importantly, exposes a non-standard sysfs ABI (e.g.,
> frequency0, frequency1, phase0-3) directly to user space.
> 
> This patch removes the custom macros and migrates the driver to standard
> IIO API mechanisms:
> - Standard attributes (frequency, phase) now use info_mask_separate.
> - Non standard specific toggles (frequencysymbol, phasesymbol,
>   pincontrol) have been migrated to an ext_info array.
> - Remove dds.h header dependency.
> - Pointless frequency_scale and phase_scale attributes are dropped as
>   suggested by Jonathan in
>   https://lore.kernel.org/linux-iio/20251231180939.422e9e62@jic23-huawei/
> 
> NOTE: This patch introduces an intentional ABI changes. The non-standard
> attributes (out_altvoltage0_frequency0, etc.) have been removed. They
> are replaced by standard attributes (out_altvoltage0_frequency and
> out_altvoltage0_phase). Routing to correct register while writing is
> handled by checking currently active frequencysymbol or phasesymbol.

Ah I think maybe the discussions around this bit got confused as this was
not the direction I was expecting it to go in.

This doesn't align with the existing cases of how we do symbol selection
devices.

Often the last thing we want to do is change the active symbol before we've set
the value. We could have done a multiplexing write function but if
we had it would need to be separate from the controls on which symbol is
in use.

There are a few examples of existing ABI for this in tree.
e.g. 
dac/ad8460.c which has 16 different rawX outputs and a symbol to pick between those.
dac/ltc2644.c which has _raw0 and _raw1 for similar purposes
dac/ltc2688.c is similar.

We've never added more 'standard' control for channels with symbol controls simply
because there aren't that many users yet.

	
> 
> Testing: This patch has been strictly compile-tested. I do not have
> access to physical AD9832 hardware. I am submitting this as an RFC to
> see if these changes are acceptable, and to ask if someone with physical
> hardware could test thisg and provide a Tested-by tag.
> 
> Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>

