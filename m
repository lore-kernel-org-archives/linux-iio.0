Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF6230B521;
	Fri,  3 Jul 2026 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102398; cv=none; b=vFJdHKIRsNuhdxUsZopcW2KWcGRJYkFArtTGPjrARoxgckTzHvQvyp/UTYUUMXy7zS6k87lX5oZFSL13rYLMAPenQE8q9piUJTqDgkVvxehsJDeX/5L/ka4cbScf1MlaBbhzO+T0KNbdZ7WQz0yeDG5QVR8ClD0I4m0yUGdXHxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102398; c=relaxed/simple;
	bh=Jgin/Up43+rF9n7r0HbdVGmg9CyUuwJdU+EeB14yaNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqSSWKyoURDdXi+oIXoTVg5C6vDlmPOmszq07vmePYmY2yez/yluOsG1lMiz1oo4pNGAM5RcfEagXzJj1pLbemdtmgx5TqMbwlypAvJzdhO4qkUYfgXysVxngp5P8q3d+/PgudVkc+OmOxGiPQ7gU686g/WqQGTjPZD67/nf/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nil4zVL+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nil4zVL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B372B1F000E9;
	Fri,  3 Jul 2026 18:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783102397;
	bh=IVx85WXWWwgHI9VTL+/1tSl/8fEO7XaO0adc8WNrdqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nil4zVL+29wlQCVZtxOXW7KMhvTHsLPWXDqfC9i3qJACoP+rNURuo98lzLlTkrYJT
	 UP73oNqNUYGqJHbEIC8uVY9jopV8F/PKrtInT1bNP8jk2noY2evVf20a22KUiWnBWI
	 OPWcTcZipQfnKmDVTGMec1d7FSgEXOJoGHHkPbUwhC9bHUiDhf/QEYQz1gwys13fls
	 zxJHYVpPyTK+6F1ZIlBGA44Hp5LKQf7h9iUfbFocMSUIcbJDQJeOdw2qnpszm24LyB
	 wJGMfghlQKbvNcAqmdGRX8JBR8xJi9nhcp4NcNATxzmJSb2ulIOMIetBH9qNo4sl3o
	 2hAwEGDJ8QgFQ==
Date: Fri, 3 Jul 2026 19:13:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 15/16] iio: ABI: add docs for ad9910 sysfs entries
Message-ID: <20260703191310.0731e237@jic23-huawei>
In-Reply-To: <20260618-ad9910-iio-driver-v6-15-79125ffbe430@analog.com>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
	<20260618-ad9910-iio-driver-v6-15-79125ffbe430@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 14:27:31 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add custom ABI documentation file for the DDS AD9910 with sysfs entries to
> control some parameters from the Digital Ramp Generator and OSK engine.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
This looks fine to me, but I would like to also see ABI docs for the debugfs.

Thanks,

Jonathan
