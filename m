Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8DC17A2E8;
	Sat, 15 Aug 2026 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786832600; cv=none; b=ELKCFyc6veaUX58J45ZvERWgNTbu0Q+pgp8vCm/Gw/1CZ7n7WuWSBoEfnTtItJQbAFpFoNfykvNzKqyzE7eWm2nbgaCCtn6f29OTsqxdqNj1z34xBM4gI03jB3CPtMIicYIItiiNA4vBsRrZBzpk1EaU301XRzj9mjC1CQSv2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786832600; c=relaxed/simple;
	bh=hcTWXUInAL32i2BXjj8jhdRWgdJWQuTtO32XFLfbuok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbl7GgP0AJFoFGDG+YWRhiVgYVS62J/1TGUi81kCbzZ1BrtkV2LlFYzfau6INoFyjka5Zr57SKhYHuqynoQ3elQybJ+1nwX7w/ycmgRDu/c9stucKUoC3yBn00HUoNS0ZDAphvFHnE3qBx+3GQ3uMjZn/7dpi/vtOSHt1N5Pvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLpDmPZP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLpDmPZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52B51F000E9;
	Sat, 15 Aug 2026 22:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786832599;
	bh=ye7iJSqfq3Pinwl5nqESeEIXP9wgz5wLHBB7+tCZbt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lLpDmPZPqQS4XqUDmEO3jE+aPZA960H4oMjsfw0IyfzXU1ToEyzyNfoJpdv4vdDOR
	 vHqw6oKHfRCviVhvwsqPBtL8lf5gPvvC3+2o5/Sp2O/z/5S38nqWdVy+EcaQufJo+f
	 74upEOwG96D5ceCbXpgjZSQk+THEn2dR+DhrseuH9cmRAAQw2dhcFaztrWOh8isHBD
	 v0XLl9up+cFj5K9WN77rt8aAhroN6YGAMGlFBVbbAF3jk++mEAjdXqZZrsmHgJaiXZ
	 pZSQFuO8/lcewOkbS5jCDr8oxNnRV0ayoGWpuUSeQ1AHUsA5D+jj7K/Qznoy4dclHI
	 uKj7a8tLzir5A==
Date: Sat, 15 Aug 2026 23:23:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Beguin <liambeguin@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: adc: add LTC2499 features support
Message-ID: <20260815232314.25093084@jic23-huawei>
In-Reply-To: <20260813160139.70000-1-andrei.stancovici@analog.com>
References: <20260813160139.70000-1-andrei.stancovici@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 19:01:34 +0300
Andrei Stancovici <andrei.stancovici@analog.com> wrote:

> This series adds LTC2499 support on top of the existing LTC2497 driver.

Just a brief note to remind you to be careful to ensure patch
set versions are reported on new iterations.  For this we have
two versions 0s.

Thanks

Jonathan


