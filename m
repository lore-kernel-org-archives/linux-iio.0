Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED76421223;
	Sun, 27 Sep 2026 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536958; cv=none; b=gEz7uu6sf7gworF8NzJIn0JYVm7/aeiqdBL/qUOduhuAQ272rVT1R+sofyASbV/iEx+P/eh4dsXHpSw0Or7WoQDGcGFRXTjhYv99up+w2NR2nvnADxA4vxkbCBeQGv9rfRJA5jhBNocX48TGxGyxV1K7RNlfOyGf95Dgxy6B4eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536958; c=relaxed/simple;
	bh=kFWZ5Nu3vD8TJtVATEJTvLep5f7OpdCSwe4FRMQ9eNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Shc20+xOOeo/BjGlbW2J+JwkYdNIV1Jes7iEv/qRF0WOarACcLZeOVk4HORoo+OhWxjrtzdPatq+WMoWCxYViXf5KGhla5t/vA5f9rs3T+iZEJT0XE+foJfvprbbldFBIlYr/tpj9xTQAcaBr8I2/3/JRcKG8/oFK4eL62Ucx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWYaHeRm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWYaHeRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A932D1F000FF;
	Sun, 27 Sep 2026 19:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790536956;
	bh=zS2EJhC6N8IKJRLoDaYxskRRLRPRm+OaqBZEaM0RHmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LWYaHeRmnk17yyG4gUcRWnG/WdxMf3sNGww+jbgzVFx3nWzfEfJec3d3PH3ogKDbt
	 A3p7HOtf7dA62palmtA/Kk+60tpaG2wZ8ftuqLXjdBigLYicMTVGL9Jn2VY0428NDc
	 rHMViA06mA0tIu7HNKPC/Qb0mUatvH2lBeT14yy6LvGkMlEqqR00SwhOQKYYqIDy8v
	 namsH9LSXCYyh+2F3vdvKB7taX3MepLR9+RTajX7QMrCXTAaesvO0YtaHXgn65TI2V
	 P1VIFNfQ/FNuAEjO1rS0rjIudUtsf27upXuh5QZWnZ+AbGOB17dKxB/I5ERUkfN4Nn
	 I+JrFeebfYpSA==
Date: Sun, 27 Sep 2026 20:22:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Joel Stanley <joel@jms.id.au>, Justin Stitt <justinstitt@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v8 06/10] iio: core: add an accessor for scan_timestamp
Message-ID: <20260927202231.4a28dc66@jic23-hlaptop>
In-Reply-To: <20260921183132.233136-7-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
	<20260921183132.233136-7-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 21:31:28 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> indio_dev->scan_timestamp is __private, so a driver has no way to ask
> whether the timestamp channel is in the current scan. Hide the
> ACCESS_PRIVATE() behind a read-only helper, the way iio_get_masklength()
> already does.
> 
> The dps310 FIFO patch later in this series is the first user: that
> hardware does not timestamp entries, so it refuses a buffer with the
> timestamp channel enabled.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Applied.

Thanks,
