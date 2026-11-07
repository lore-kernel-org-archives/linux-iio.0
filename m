Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081858;
	b=E1DlV++bJWQ2TplWkFhRYLDoiuO2Z58WUVC7ozzgcZ3pIknh5oUS3/QbawCu0fHImy+y
	 KRVqlHB/7ZCalztkMBW8TPHC2bVehxTLmJiWny8lKRhDUUkzKnOO8LeN1/5MxEPpiKCYB
	 wGoYE8D9GWZpAm04ewt6uk0mqnhMO2oIEJqZvaojvYjJNWlHRVU0DEdz76WMY4SbHHej2
	 JW5lj+th0vXNBBnMXd7Uw3DK9/i0ZvyPOe10bV7nWrnke7WVpgDWtGzfWF9ONiJCVzXTU
	 6g3mIPVr507zJLc/0NrgSxE1hA5KLzc1jOHxv58btM8E4KgGxmgEhGjUZLzuDHwbKng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081858;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XcCQW3UyOP8aWJHC96IWsCCnVyRPHeoCNPMs8q03Lv4=;
	b=YfCEGTKX8WHmFy/hBv+Yve5zSAM3rbh8n/sBwoOo6GfVX/X+TuS6yQW6Zr34Ijs7Qz6p
	 9ePlQSqc9wTU5FfJV9m4uxrmXFfBY6sxFXr8vfy/Iix/lpiP+kEgkeEwl3lyIj5NcYaQw
	 sYscvrI6ov2rBVeXkmUfecVukLpA5PP2WqOUhwPpv/xToHlKXmVnOojbaXEBnI/2UOvdo
	 kI4NtnSvqqBfimU+lfBvwQ0zEO86+BElKgNAl0A054yFSIAT7bqyMTiubhYJWc/GJWl//
	 V5HcO7QtF3qW0P8VrZw4Kt4qRM+PwMwKhQekjgIKjQyHCOLQ2Vs9hPEPOe5ToY1+OtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OT6SSsBA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97845606A326;
	Sat,  7 Nov 2026 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OT6SSsBA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FC61F0089F;
	Sat,  7 Nov 2026 20:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081858;
	bh=XcCQW3UyOP8aWJHC96IWsCCnVyRPHeoCNPMs8q03Lv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OT6SSsBAecZiK5duvFqam8E0nNHIvOu1QL3+A4aHqvngXiimH+X1cxu4ni38SSyQY
	 B0Dccr+4i67aujq68KjnNOdOb0NcJvU3I2FwOBvWCutjtRVWUDrv5howQ9VfXLa2gj
	 CoJESSHO9fIrTERLzH2EaT/OCuI7wseL6QRgFPrrHWII5jj9FJ/R2tHSOTA0ijjLz7
	 UKBaNwb1BPd9RiqSt8do1V61fuLUO11cGKQcDdIZA4Oke7oy9+plWNIxtEp8Qr5bB0
	 FXSeojxIhYbxZj//80bq6xkHjkW/3VH1R6bZ2E+jrk7Soe77PLouOBZmt5FiXjXyge
	 +a/OGxrW5xd2A==
Date: Sat, 7 Nov 2026 20:04:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Chen Ni <nichen@iscas.ac.cn>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] iio: adc: ad4134: Fix duplicate data_read mux state
 request
Message-ID: <20261107200412.572956f6@jic23-hlaptop>
In-Reply-To: <20261105141846.00004e3a@kernel.org>
References: <20261105033120.387616-1-nichen@iscas.ac.cn>
	<20261105141846.00004e3a@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Nov 2026 14:18:46 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On Thu,  5 Nov 2026 11:31:20 +0800
> Chen Ni <nichen@iscas.ac.cn> wrote:
> 
> > devm_mux_state_get() is called twice in a row. The second call's result
> > is stored directly into st->mux_st[AD4134_DOUT0_INPUT] without error
> > checking, and then immediately overwritten by the first call's result.
> > 
> > Remove the duplicate call and check the return value before saving the
> > state.
> > 
> > Fixes: f12ecb3e147b ("iio: adc: ad4134: Support SPI 4-wire mode")
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>  
> 
> Ideally your Signed-off-by tag should be the last one in the tag
> block. No need to resend however, this can be tweaked when applying.
> 
Applied but with fixes tag dropped. Those aren't stable until
a series has gone upstream and I've long given up on trying
to fix them up as the tree evolves.

I tweaked the ordering though I'll note I normally don't bother
too much on this as any review tags that come in after the
new posting go after the sign off anyway so it's a subtle distinction
that I'm not sure matters in practice!

Marcelo, this one looks obviously right but please take a look
just to be sure.

Jonathan
