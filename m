Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F23A48D7;
	Fri, 22 May 2026 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463388; cv=none; b=BRG7pv97Li9lxkQchBx6KKfivShrBLpQA7MUkQ3qaKO44XrCz7z6h7QZOQn6Gb//OAJNTn1EF1vtw74+YfQSQ9NcTIE584XLFhwrWhd+pEOnF8vR7whu2cdjil18o7UqN/LQwRCypTb4GxIY4XOVYyCt2+5uDpyg+2WD0YYk9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463388; c=relaxed/simple;
	bh=yAgK8fdZAEJ/1DYKPDdTGpqxwXbwtzTHpMVRYXWUR3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArGferaNevWCRwIiLJ53SBd+CovfMlhKOEottp3MqcWMXnY8Oj63rGIfaU++wgTxScc2+6b6BVS0FvixGqdPwBkI8S2q6wQFSfVgM6ZAjrvuDgDurah5/qhYUj957eggoJXhWPffl422WTvxbLu5Mh5/VFl6lMo9UEgPxPIvMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBgvNJrv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBgvNJrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354511F000E9;
	Fri, 22 May 2026 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779463385;
	bh=vOSEjEiWCsv4bbCSTWUUwhBFHiTJye3n/IVUO2pq8Kc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cBgvNJrvhFkoyXkpWAbzKSuqKNVPMOOaKx0ABYDLdX6nxM/XMUng4hkaP8OkUCjri
	 5OM25/CE/vjtz8bgzyd8eO9TK25Hw9cyE9dqsIS7t4X6gvjIQ+9/tCXMwdDUi9wQYR
	 bakd1XVvuQPb6mbJLDnUQNpA4t92l8H7OXFYZtSZvbUzsBKeLEfh2YU1e8STiIM2fU
	 HEPWWsDlpRrkQCoR/vrFk2t9TOFn7hBRCbJuSd4htWBdUoYht9rNdrwubKhuRN7vLT
	 bNrE0e18PN9WBHw0v2BpOHjbcBe6p+QNxy/hduJM1NA7KXqnOyzBGp1dgPaWrDYrNM
	 fgtk89qcka2aA==
Date: Fri, 22 May 2026 16:22:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] iio: add Open Sensor Fusion UART driver
Message-ID: <20260522162259.39d99626@jic23-huawei>
In-Reply-To: <20260520072843.3593-1-kimjinseob88@gmail.com>
References: <20260520072843.3593-1-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 16:28:40 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Open Sensor Fusion is a UART-attached sensor aggregation device. The current
> prototype sends OSF protocol v0 frames over a host UART link. This RFC adds the
> first Linux IIO receive path for that UART stream.
> 
> The first transport is serdev UART. USB, real sensor reads, fusion output, and
> production timestamp correlation are intentionally left out of this series.
> 
> The driver code is kept in one patch for the first RFC to avoid intermediate
> non-buildable states. The internal files are still split by protocol, stream,
> core, transport, and IIO code.

Even for an RFC you need to break it up.  If you do it right there won't
be non-buildable states.  Take a look at how any complex IIO driver is added.

Key thing here seems to be that we need some references.

Superficially sounds like an open source sensor hub implementation but
we need a datasheet / reference manual to be able to review this properly.

I'll have a first look but it's likely to be somewhat superficial.
