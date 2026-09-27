Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E70171BB;
	Sun, 27 Sep 2026 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536720; cv=none; b=uWwN0i2b/X2zEv8+zCK0m3xAcTPBxhEbxKre5TH86IGI/bHmBGki02FbQrdpxq0U0nWwFJlVHHohAkhC/Tc/LA5/KumtFRQRoVnzyU4/Ziik4IiNBsuqtqQeuiSS40cYvYqlO/CNqMcWgBBmVwddbHEgu9FOvvTE7JWhaf69CzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536720; c=relaxed/simple;
	bh=Xpjrf46fWTZAD5L8o6ZpwPZ4z6eK5msMIHXNl/SDXCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agXsMM9yiQv8Va7RdLYZSvBNUJ5CJrkzQR3TQDe+WdsbD0puKXHz6t/GnNok2PM1hd9HO71VL1ooKm2qBCqBMjFM4YQxhlQsTI7cAdnsvM+7lMS3MIWACsSBC/0YlmAXiiFV+dRX0XOgIih55FzVgtN8SGY65YWbGdywVR+sTgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSHPSpOq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSHPSpOq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C661F000FF;
	Sun, 27 Sep 2026 19:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790536718;
	bh=zvTadPwFsoFLGxNCy+/F7+qRUqyjZSwkmSe4b+eAGGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GSHPSpOqrJ77uox2A3+42oa80x9UxCH3BpU9FYwKoDqnk2WTHgxIMGskJ3x4M9Vaj
	 TXXV+qPbffE2k/oNxx0ochb94YCBRrY9NaWYpMdi8+P5tz+k599c5G5lCJ8uo3qXBH
	 TuTngvzPHgPxDDWSmiFtotEYV1GcqB5ocU1zhkP8jFPnHEMBydeIvLZdmYgtl9hRiz
	 9o3J+TRY4DXFsoG4w5Fa4RO9fqlgwA3i7L5hHj1s9YnFPrGDfaTydJ/yuD8OxNj08x
	 BPgG+ykJr28KL3T27aHFPXGX8lyXbgKpIN1CTGcF5ZzQHZzT9DNO5qxAVSPQB7Y4s3
	 YuwL4p53QIDMA==
Date: Sun, 27 Sep 2026 20:18:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Joel Stanley <joel@jms.id.au>, Justin Stitt <justinstitt@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v8 03/10] iio: pressure: dps310: use
 get_unaligned_be24() for the 24-bit results
Message-ID: <20260927201833.694c2814@jic23-hlaptop>
In-Reply-To: <20260921183132.233136-4-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
	<20260921183132.233136-4-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 21:31:25 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> Pressure and temperature results are big-endian 24-bit values. Build them
> with get_unaligned_be24() instead of open-coded shifts.
> 
> The coefficients are packed into the bytes rather than byte-aligned, so
> they stay as they are.
> 
> Assisted-by: LLM
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Applied.
