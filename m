Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B053B42FD;
	Fri,  3 Jul 2026 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072642; cv=none; b=Wu+lN/WSmzy1V8pCRk8F8/depVc2Az/taR+W/SvXMHR1Vn0jmSh9ICbuK3NAFAo9TjT+PJC7R/zGNHttTRX7CadXljsXMxUevZMomR6UrL4Qfj9i1mKcAdD/ghCrtZMoipESQ74DSFTcL69Sz+XfM3Y1KtQdrWQYNG3SGBbZetk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072642; c=relaxed/simple;
	bh=B/+ZhFAiwNqtyruFpGe8RK10LPI08f58/qvAauSKt6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocbcMqnoLCbOoEO8YP5bCSYu2CknEirXOFbf/tgu1iGVSg3D9rpmMSgmW86yuy8yrOdCN3J5klGYzxMnHoj+Cb4vBLs9KvN98S8VoEe1SNHrO3lyHQ9p7FYuaUJG7WgMHVxcQqRSU8qTw+/clj0dLR8opzsT5fTq0q3P88ozk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWluniAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWluniAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFC41F000E9;
	Fri,  3 Jul 2026 09:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783072639;
	bh=B/+ZhFAiwNqtyruFpGe8RK10LPI08f58/qvAauSKt6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GWluniAe58J2LgwEA+NCudTqAfLwinS1hgxERTFFOUxhynpg6iOHwko/W0wy+aWZ+
	 +ehMlptLnTJpqj9P/k9DYnniLjB1+5dJBuXlbxQ3sMWh2FXTC1hSfiGA9CrVgPp5vp
	 URGO/rHv9MF4oIaq7TvYxp0G7FipyDNvLpRhZBZhb0H5dUA2lQdTzZzznF4NLlHtFy
	 my+7bbwnvq75nh0YGbCXkM9nDNA6EvfJu0Vo6ZezjPMHM6OYeJk+7I4pPENY8dOTox
	 rlG++P62SLr4jNhIJlwHXOR9GL3cX+hMHq8IvNeAzBe/VyTWL4B/LQQplWpdV59DUt
	 Q0UVTfA5rXXxA==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wfae5-00000000i2b-0qxo;
	Fri, 03 Jul 2026 11:57:17 +0200
Date: Fri, 3 Jul 2026 11:57:17 +0200
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
Subject: Re: [PATCH v5 06/14] mfd: lm3533-core: Remove redundant pdata helpers
Message-ID: <akeHfV45fs_wabFl@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-7-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-7-clamor95@gmail.com>

On Wed, Jun 17, 2026 at 11:00:23AM +0300, Svyatoslav Ryhel wrote:
> The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are used
> only in lm3533_device_setup(), which in turn is only called by
> lm3533_device_init(). Incorporate their code directly into
> lm3533_device_init() to simplify driver readability.

Again, this isn't needed. Why are you removing abstraction that improve
readability?

Johan
