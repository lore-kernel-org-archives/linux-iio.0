Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3295C320CAD;
	Tue, 12 May 2026 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602060; cv=none; b=uUWG3TltRHmet8zueA6eXP37c8hpYSG2RnQoGDkBKg4q/UUF/VNw6LOwet9Kuwccg0IrNuhGCeZgnMROhHWLInl7X0L9rpS+KYfYrR8WF0L6fJ/dovV9Y37DB1xMXbOzccNuGtdsQjNkynKqzUNtniwXotRuKF4XpA/6Qk3gQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602060; c=relaxed/simple;
	bh=A3AZ3UwRROF1/9EvAFuMvm52ozhwNC0d0HbbzFf9W1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngcNXDVaYtmRAAa9nxPFYHNPXARIPRx2fH3Jvpzs/ceH+hdLRUrd4jon37nhXF8PX7XLVXqIaEXMkkyktn7nrgJnmG8BR8edsdGzlxgHjhDkIxU22vnSQmK5qekSbKCpx4NzHr3aV2ws8DpoWrf2ecDhfczoYxoqJp0X8DRYdTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQavlAHc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQavlAHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BCCC2BCB0;
	Tue, 12 May 2026 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602059;
	bh=A3AZ3UwRROF1/9EvAFuMvm52ozhwNC0d0HbbzFf9W1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VQavlAHcGm5fGKNN5D3GI0FxzIkspSiLci0O/f+WeBNTGqtlGuXLzBOXG4W+8d0ue
	 DMyMCfrffzBLG+sWDnTP+FLQBM6wkLD0kq2WFAPmWNkm/8MV+FkgFcL4aRXlGtDWz5
	 zikTbvgK9k/ZwMy23R9XFk816mR//6He4Z1OmxStdpffRabv5tzlywsNzYeh/0dQKL
	 UvGy+qv2HiL7m4wmiK2FNBy2ta+UCtNl3RyGpTxtxjxDZDKrZCiPUL8ZJoci712Y9N
	 pbp3fqYs0FFoEa1CJYwevw/wwYmw5GlVFrxKmKE78MSmBpv46yopoSVP5/l02pL/16
	 3eHvvWbs38lmg==
Date: Tue, 12 May 2026 17:07:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, m32285159@gmail.com, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4] staging: iio: addac: adt7316: document SPI interface
 switching sequence
Message-ID: <20260512170722.73bd4b5f@jic23-huawei>
In-Reply-To: <20260511140641.86389-1-dennylin0707@gmail.com>
References: <20260511140641.86389-1-dennylin0707@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 14:06:41 +0000
Hungyu Lin <dennylin0707@gmail.com> wrote:

> The device powers up in I2C mode. Switching to SPI mode
> requires sending a sequence of SPI writes as described in
> the datasheet.
> 
> During this sequence, the device may still be in I2C mode,
> so SPI transactions may not be recognized and can fail.
> Such errors are therefore ignored.
> 
> Add a comment to clarify this behavior.
> 
> Datasheet: https://www.analog.com/en/products/adt7316.html
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Applied!

Thanks

Jonathan
