Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060E43CED3;
	Sat, 28 Feb 2026 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772280965; cv=none; b=bNiPEHA22oiOloPW4qzu5fJXtaZUqrQxjPoVX1YaU0fqoorBAZVsqvKlkV5pELOdYtaBoTRiB40D/zDJJOQXrjgZdqg+0ENUrynM7wUG5b/mOUT0klAM6tjw3k8kY4jh3/QN0rmsGI5oP3i/0iStLOvcK4MNEwSljPa7A/GjJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772280965; c=relaxed/simple;
	bh=9bpPP4AwO4q6d2DgkVRfHu20SLLAtCXiUPX55ih3b9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obs0u5s+PvmyZPdpgQpikQrnViK34WgxoqKklVds/Dg3jq41wRco07279mECaDSHhrbx7+J1CXiRYFfZ6hU8cPYeZv/5kU5xtfE+YsPIj1cJwSr8/9DXiAh+IpXYip5/GXl6ybhNEDBLoDB9wj14RVaJqDY24de4vg9SYXN5BUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9hLplJy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9hLplJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2C3C116D0;
	Sat, 28 Feb 2026 12:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772280964;
	bh=9bpPP4AwO4q6d2DgkVRfHu20SLLAtCXiUPX55ih3b9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L9hLplJy0t6YXTxO0r01VywZdZPvSVeGfIoxnUpE6uJO3EuY+jnxBmOmRhMNj4mlW
	 BJHzIN9DBBrEcRZV34NL/SHOuybNsLTfritnasZQklJOz2YSv2ikjVOhtDX40iACWS
	 KC/ZXiBW/+e9YiKViYhSzNx0YvAoqM/cmRRhzCLy8kVXzgRzX9/NDTrRjZSiR7cjko
	 CNHHf49ZtFCWeto1Mj1r4g+fq+0yVHniEb1rUiVhGAX7PnOaGjh/amVdwQb+Y3iYog
	 Hl6wVCCZ1R+IrAxj9l2ReUaOa1AlMidJTgrKChSQu81tCwzF8RqdsFkHNdmzFsCuUD
	 T+s4AJ/y/FvGw==
Date: Sat, 28 Feb 2026 12:15:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] iio: frequency: ad9523: fix checkpatch warnings
Message-ID: <20260228121556.6f8ee496@jic23-huawei>
In-Reply-To: <20260226231057.20669-1-rougueprince47@gmail.com>
References: <20260226231057.20669-1-rougueprince47@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 04:40:54 +0530
Bhargav Joshi <rougueprince47@gmail.com> wrote:

> These patches address several checkpatch warnings in the ad9523 driver.
> 
> Patch 1: Updated the macros to properly use their argument x.
> Patch 2: Fixed the multi-line pointer dereferences.
> Patch 3: Updated symbolic permissions to octal (0444/0200).
> 
Series applied to the testing branch of iio.git. I'll push that
out as togreg later in the week and then it will be picked up by
linux-next.

Thanks,

Jonathan

> Changes in v6:
> - Patch 1: Fixed grammar and shortened the long first line.
> - Patch 2: No changes.
> - Patch 3: No changes. Resending because something went wrong with v5.
> 
> Changes in v5:
> - Reflowed all commit messages to properly wrap near 72 characters as
>   requested.
> - Collected Reviewed-by tags for patches 1 and 3.
> 
> Changes in v4:
> - Used full name for SoB.
> 
> Changes in v3:
> - Patch 1: updated macros to use '(x)' instead of 'x'.
> - Patch 2: collected reviewed-by (no code changes).
> - Patch 3: fixed vertical spacing and broken indentation.
> 
> 
> bhargav (3):
>   iio: frequency: ad9523: fix implicit variable macros
>   iio: frequency: ad9523: fix multi-line pdata dereferences
>   iio: frequency: ad9523: use octal device permissions
> 
>  drivers/iio/frequency/ad9523.c | 88 +++++++++++++---------------------
>  1 file changed, 33 insertions(+), 55 deletions(-)
> 

