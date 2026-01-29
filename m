Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B933D6F5
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703536; cv=none; b=Wdggxh8yg3Q8p5Z8MIYbrWBuAhZlJHoNjQTO6ngQbRMqHGU//xDTCpsotNFdJV3tHd/oCTxNq5AAQTGplsLYenGN/7djjxHNTQZGm7TC3SmkmQgQhr88rFpeNN5O72emtT4Y+o1R7GrKyDZfvV5eZ1AnmiGTf5sxFEFKOjVuDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703536; c=relaxed/simple;
	bh=+W0zpDJPFfqKXKnU5ptbCImAeafyJtfs+yjtta7sN0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfckcPrViMXUUVTWeeLY12eD7A7dQcZi0NulkEtjLfNjBZ3CUsn4sbG6VWtxygqDLtyY59UjhbicsqU1UirnYDK6V8iharTj1quwvEYVkenexJVpepeemaXDt4hIWVqL7x4riWxw/TL9wNn1wh9eUB8zCQNrAZfkpuAKCNTSDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgCfS2e/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgCfS2e/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BC5C4CEF7;
	Thu, 29 Jan 2026 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703535;
	bh=+W0zpDJPFfqKXKnU5ptbCImAeafyJtfs+yjtta7sN0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tgCfS2e/rBwusLubK4CG35hhnz58t2MnobbJcUSH4HJ6xIf3hY6T+R8td5w88PjS2
	 hyvJwjwX2MdKlBAXHtYjdJo/MM1Vnccp+Zj0cgdA8swSNbpqXK870XeI0CljxCaqyj
	 pVewsDuLP7enpTAyQan1Q0wj9JsW+8/ymOD201mfyypqju6JCTnGw8HRykzXGpH6Rj
	 tcoGpGr6MsK5dZiEmk42VMQoOGxW+4dUFXEAbLOPHxoWoYoIdJvfVAUrdqtK+U57iG
	 NwaQ7rHk3DEBdjszNCGidn8uM5CG6KSexya8Yk9yZlm4S+nfde5RWKbBn5vM8aTJdN
	 LO583yeGfhXmA==
Date: Thu, 29 Jan 2026 16:18:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Menderes Sabaz <sabazmenderes@gmail.com>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, dlechner@baylibre.com,
 lars@metafoo.de, linux-iio@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v2] iio: dac: ad5360: convert to guard(mutex)
Message-ID: <20260129161848.49b8a226@jic23-huawei>
In-Reply-To: <20260129161621.7900dc11@jic23-huawei>
References: <20260128113751.258219-1-sabazmenderes@gmail.com>
	<20260128153221.327987-1-sabazmenderes@gmail.com>
	<20260129161621.7900dc11@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 16:16:21 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 28 Jan 2026 18:32:21 +0300
> Menderes Sabaz <sabazmenderes@gmail.com> wrote:
> 
> > Converting mutex_lock and mutex_unlock to guard(mutex)
> > Simplify the locking logic by using guard(mutex).
> > This removes the need for explicit unlock calls in error paths and
> > simplifies the code by removing goto labels.
> > 
> > Signed-off-by: Menderes Sabaz <sabazmenderes@gmail.com>  
> 
> Hi Menderes,
> 
> Applied to the togreg branch of iio.git.
Dropped again.  For some reason my local email hadn't picked up
the rest of the discussion and I only noticed when I looked at patchwork.

> 
> Thanks,
> 
> Jonathan
> 

