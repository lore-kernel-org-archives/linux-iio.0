Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45733377EAB;
	Sun, 15 Mar 2026 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773600942; cv=none; b=pPEPOaMmAbj8wG3CMOq4/+dIc0I4qDZf4hNXDJfRBHAgWzRE+gmXpKPuWmLOsmbNU6PYUMse979yYQHZQLBW6PenFSFgm6ChSuoOh239ORTAwOo3DYYUWuaoGhGJ2IE6500P80fvpFNoY12xdvnupDohLa/ImWwVVCmEiB9qm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773600942; c=relaxed/simple;
	bh=yDLsIukzXQm+MtZ2iSe7U6Y6x7BM8zPj+Wfms7vukHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ilsx8GlKBS0nd1Nqx1TWKknX8ggRBrMH5ZDe9TTwt9OGMd30i2lJsEYnbmdnbecuGlXa3o/LA08R5fs5EC/VkmJgtwJEIFvQPiFvk3OLdtR+ShX3XqrxwC9s1bX1b6C3b+aTVkNjstiXzHgSL9BTQx1URzxYeKhy6Yv4dvwVzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0lutBre; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0lutBre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077F7C4CEF7;
	Sun, 15 Mar 2026 18:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773600942;
	bh=yDLsIukzXQm+MtZ2iSe7U6Y6x7BM8zPj+Wfms7vukHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q0lutBre81Xly06AUq+EXsTYXCCptGBvA8shLtcxB9m/YxxNmbjRoZLzQSLemVrBt
	 CFPLux4CtP72WUlvMHfEi6GubvguLLimtvjjM0iSGYPJNr1bZ/pyP+HqQUq8BkvCQl
	 J1qT4SRIld/d6c7E+AmEvjMILIQuRFn3Qd2hiGGvm1Lc7U+yW4uBmZ7mkDC872Ah17
	 rNiwIXHMpy/UjPLt++TSyiRgl+cKxp+Qc6vWqlte+nR809v0fbSVKXc+u+r1nOQS4H
	 W9yu24RTS5k9icb4LLDcd2Iwe+uVJi9HJlj0izDEuBCcTkm3UIL1J+M69dlXtLzDaj
	 uZZ4STaJGzdYg==
Date: Sun, 15 Mar 2026 18:55:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: ssp_sensors: cleanup codestyle warning
Message-ID: <20260315185533.54780844@jic23-huawei>
In-Reply-To: <20260315125509.857195-4-sanjayembedded@gmail.com>
References: <20260315125509.857195-1-sanjayembedded@gmail.com>
	<20260315125509.857195-4-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 18:25:09 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Reported by checkpatch:
> FILE: drivers/iio/common/ssp_sensors/ssp_spi.c
> 
> WARNING: Prefer __packed over __attribute__((__packed__))
> +} __attribute__((__packed__));
> 
> CHECK: Macro argument '...' may be better as '(...)'
> to avoid precedence issues
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
This looks fine to me.

Jonathan
