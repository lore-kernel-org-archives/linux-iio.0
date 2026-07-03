Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9B3B38BC;
	Fri,  3 Jul 2026 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071867; cv=none; b=O0X0Ef6h5xUyr8+6WwjYRfFO3tEDV96tTZF2A1n3+qcUFb/2VPwrNdbKrOY4Xc16R5EbXkDSW/c8MIPyrqpI1oGqPzVC81p/iSH5fUDMbtfQjS5IzkuS6VG8sH76U6f9r5Bq/Aka9eE8riOZP2gQZHeAtD3d43R+yD3GzXm8eZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071867; c=relaxed/simple;
	bh=g84Zki9ut8BoJRtesayIjwjtg5cf3L/XXhsEbFb1vBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHFb+M9f7NyX9VXiHoEwCRc+i5rjdE7VtMN3TBsX9HlQFoMWqnB+ncfS4p3Kiw25fUkdycWra+BChFJhoYmtkperckJ/VkLXxsz715hOj47CP+UUql9Deb2pjw9YcHaTiJrqwvGrJTNO4bUwO3y79e8Y2WFQRqO/Jf8bPNnYmhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbNex+b9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbNex+b9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9881F00A3A;
	Fri,  3 Jul 2026 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783071866;
	bh=g84Zki9ut8BoJRtesayIjwjtg5cf3L/XXhsEbFb1vBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AbNex+b9+HGTx0UYbFnxDe+8LXC1LOM7a5Dp6ADn7Rj61dFAbJto4sQyu03tVXVxY
	 Hk2F5KAEg6raT3YLL4SsX2KyN41Wr8JHcrQQ6N759Sm3+jY2tqlPewxj8LfWGXsRd9
	 n14yC0imK2lizCcrEgGEyS8X/L4BPS02RNzTqsrDWJJgl+DSzFpmtVz2o+ZEinyAdF
	 YOH0aorEA+JlbDhbmXxiGRmd2G3R6SZCAL9kXf4yj51g5UZO4dQjlfXXadmgr0MKcE
	 NHB5XHQ+DqoS+NtHIcuUEuZnW233+y/5Ddi4qKgmpgkJgSvz17IYR+UfURGCk8yFJ3
	 d2KASztUXSM8Q==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wfaRb-00000000Z8E-2ewT;
	Fri, 03 Jul 2026 11:44:23 +0200
Date: Fri, 3 Jul 2026 11:44:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 02/14] mfd: lm3533: Remove driver specific regmap
 wrappers
Message-ID: <akeEd0GcHSqScGIl@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-3-clamor95@gmail.com>

On Wed, Jun 17, 2026 at 11:00:19AM +0300, Svyatoslav Ryhel wrote:
> Remove driver-specific regmap wrappers in favor of using regmap helpers
> directly.

The commit message should explain why you think this is a good idea.

Based on a quick look you lose the errnos that were logged on errors and
also the register debugging provided by those helpers.

Johan
