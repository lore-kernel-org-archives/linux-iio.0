Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D8340929D;
	Sat, 17 Oct 2026 22:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277718; cv=none; b=YXtDLTEhw43iJ3LFYyEvJdYPosz29K5yLA77U06SFBjEnw0NZcxebVe5RI/Hv43tvruOfgz5dPNAERUD6uIxWWKGAPsM/SQRViDy1c3i7Z8mt/N3QEJ7/3IVQ+IYdLRRyA/Pysx4wcJiiiq+oZ5NcrqLAXVkrzt07vCRh7Xrf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277718; c=relaxed/simple;
	bh=r4IjDHQpIGDL6vZfaSHVeE5vTF+KdNtloeqtNxRKBPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9O5gVHXqh24TX/1yM82VcmVc7Bj6QKbVy7n3Y/Nf7ww3HhVn19UL6+kEzV6j4pdp4TSmzF4k/MYRiRhXwl0ikSgTzBS0RtLikcPWyMKY9dZ1snE/41r13Ev708yDc1S+LSlPDtuWCx8g1aJADANkiLbyFCDSNzwqG2LFqIgpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3+mO07+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3+mO07+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C071F000C4;
	Sat, 17 Oct 2026 22:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792277713;
	bh=lR+KoHJ9C+Urok8W42onutXbD3keSLhbgFBSUg9J+ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N3+mO07+DZCHrAbjyiEE0H/mE4KLCbbYo8Q7giHJ+Awr7ae/UruSDRjDxOSXNJiUj
	 CpmGHK9dOxDjXb/52tu0VPcjmg3FOAv7jCYgVGSYlLuZQx1cM9q7MiyEcerqznUOBd
	 tTSAoeRlkfqKJju3vsYeTFs/ZHDP8P6JS2MYV/AHww/m07JyJNNtliQheLPKPk9IjG
	 cX7o61Crm4rKALfD+elBOIyYyQ6bbDs45e905KUXZ6RCu024ZExp48t4u/P6rQL3d8
	 2RBSy/66PkPGzDfNvOnKkNnl0PXFzCvC5NbOJP9jpuzSA/baBfNVMucao+bpRHGOMe
	 4eaYzkFdc3+cw==
Date: Sat, 17 Oct 2026 23:55:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC v2 4/4] iio: test: add kunit tests for channel info
 writes
Message-ID: <20261017235507.2ea30ee3@jic23-hlaptop>
In-Reply-To: <20261013-e-notation-v2-4-d4adb5e193fc@analog.com>
References: <20261013-e-notation-v2-0-d4adb5e193fc@analog.com>
	<20261013-e-notation-v2-4-d4adb5e193fc@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 10:36:47 -0300
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add a KUnit test suite covering iio_write_channel_info(), the sysfs
> store handler that parses a channel info value according to the format
> reported by write_raw_get_fmt() and hands it to write_raw(). The
> function is made visible to KUnit through VISIBLE_IF_KUNIT and
> EXPORT_SYMBOL_IF_KUNIT, so it stays static in regular builds.
> 
> The suite uses an unregistered iio_dev allocated on a KUnit device,
> with stub write_raw_get_fmt() and write_raw() callbacks that select
> the format under test and capture the parsed values. Cases are grouped
> by format:
> 
>   - IIO_VAL_INT: decimal, hex and octal input, decimal fallback with
>     truncation and E notation, and 32-bit range checks.
>   - IIO_VAL_INT_PLUS_MICRO / IIO_VAL_INT_PLUS_NANO: sign handling,
>     truncation of extra digits, E notation and malformed input.
>   - IIO_VAL_INT_PLUS_MICRO_DB: optional "dB" / " dB" suffix.
>   - IIO_VAL_CHAR: single character input.
>   - IIO_VAL_INT_64 and IIO_VAL_DECIMAL64_*: 64-bit values split into
>     val/val2, including the S64_MAX / S64_MIN boundaries.
> 
> Further cases cover unsupported formats, the default micro precision
> used when write_raw_get_fmt() is absent, a missing write_raw(), and
> error propagation from write_raw().
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Very pleased to see these given our still somewhat complex
parsers!

Thanks for doing this.
Note I mostly defer to Andy for review of parsing code
as I've messed it up far too many times in the past ;)

Jonathan
