Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F792EA498;
	Wed, 29 Apr 2026 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457499; cv=none; b=KJHCXTb+z2kv/jTOx+ejH/a/KPQDQLF8NEuuAx3aTGBfQoaO7kh8YcwHLyx4sDakk3TD/NDjc1PFhup28PePyF9nWa7ZF3Igj9j9nLOeuQFoii/d5YqLoGQeG4ViI3ElSgV8A5A8GEhS8bwa8LLlqrz443W9zF44CHEc5EZfCAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457499; c=relaxed/simple;
	bh=iBN5H3Gy6WyzjWpcEbhX9VvE+zAW7xfwipGnt2yNtPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYESSO/0DFDDQnpeCxgITfVIebaNJjiimGzLtrEDMqkzPqxBe3zqTsra3O1zhZ125z2+Ky/fr1t8+x0YOm1RuBL5veFb4amFIecFmF9qlEcbgVRsFvNTJYeKQTqpQTqIOjYCqDGxiBVWQncPFKVJRBaWnBrXyB53HwCRk4Vm1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bix2Il20; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bix2Il20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D5AC2BCB3;
	Wed, 29 Apr 2026 10:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777457498;
	bh=iBN5H3Gy6WyzjWpcEbhX9VvE+zAW7xfwipGnt2yNtPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bix2Il2056a3j1rXFiEvCfF4mlYPhbqr1HE9NfpUtVG1wVmAi/lStt2QVNygrLpD1
	 rAcIeoLRCslCEvsfuLqym5e9jgRYV8rXHjkzU/uY8KlUasNU0IDER+9Qt2H32OfiB/
	 I2NTp6HnuEbQ4/31iSnM+ySw410UmhBHDYk/Pd0byPJfOCljUZnc9T8P+QKxtaD9DY
	 urfFLwjn0dv3Vg57tLZnCOZX27FYQScnVgPoXm3kvyC0/TqWdKxuPCQtB4qiHysSTu
	 +FG9EpFFwk6XuWb+PwUg5j23qObFcMpGPNP81GeEmh4gVjoLUpmIjLx25cKeoN77ZI
	 bMsOUGZUYD1Ng==
Date: Wed, 29 Apr 2026 11:11:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 05/11] iio: dac: ad5686: refactor include headers
Message-ID: <20260429111129.7f3538cf@jic23-huawei>
In-Reply-To: <20260428-ad5686-fixes-v3-5-9cff7bd67a15@analog.com>
References: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
	<20260428-ad5686-fixes-v3-5-9cff7bd67a15@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 18:02:20 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Apply IWYU principle, replacing unused/generic headers for
> specific/missing headers. The resulting include directive lists are sorted
> accordingly.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Sashiko has comments on this as well and they smell mostly write.
kstrtox one in particular is easy to verify.
https://sashiko.dev/#/patchset/20260428-ad5686-fixes-v3-0-9cff7bd67a15%40analog.com
