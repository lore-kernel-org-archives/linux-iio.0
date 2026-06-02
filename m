Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C203E8357;
	Tue,  2 Jun 2026 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408525; cv=none; b=h5UAin6mP6M307gsP/MMkQU4TYxwf/8uA3SvzFW7KZC8oqAjRUMKRLxUr3/CO3QyP9cALbpaDac9PoiPycuBo9DYRkj9cdg6Q0txocKAGHDENUclt+uFFJii8SrYKi0tOf3nPRqkiFLQGAESpdleby5ZAHAFkOpsGzR/zfT2p8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408525; c=relaxed/simple;
	bh=sljko7EGYJT4k2cGwdNNUTr7psxvYPFJ2CYPrG4x8K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXqTNjjoeed45l/cqZdsYo6gwUx5MnP39pzT3EbltEdA3WchsQuAV9yqiOyEgs5CElfktSkFpHcPj83KSqoDpyzbWdHgzKJCLmu36veXN/Z43JHuoWJuLmS4LCvXbGdiaSNpqqdVUDOMvjAwKVusDRTPJWWu+Pne5b1/WFPmeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDtmw7I1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDtmw7I1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F1E1F00898;
	Tue,  2 Jun 2026 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780408524;
	bh=sljko7EGYJT4k2cGwdNNUTr7psxvYPFJ2CYPrG4x8K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SDtmw7I1dRJY72MHNFC/5ewuFKIusLhI+OZIs2LoF8eqkO/svskqMP9rsjmOFCSMj
	 Tn+EBLjNbmqFtujEASxcouZVZSsAACAfqrmLjsg5rYelX67jTrETWuGTonTcJ8eGWb
	 Yn0HJod1OLFTedRuuLEOANxcpH/nSB7QFSGo8mPh9HOV+ifz0MKmmBJJ3JpZ0EJtha
	 wTNSuMqq5MF+TWdy3n0qEiwxnUNA/OR7ckG1Ki9r1/EPx/to3eLCHVK6ScEvdxqxxc
	 iXPG6CtQZDEo/QRcIJglZqqc5nyxFRBcTox73A/4j33KHB1ywZn4DSPHYIHjLPi0nK
	 ldx3E8h8+0BGA==
Date: Tue, 2 Jun 2026 14:55:17 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 08/11] video: backlight: lm3533_bl: Improve linear
 sysfs logic
Message-ID: <ah7gxfiJn6wLRoA6@aspen.lan>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-9-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601151831.76350-9-clamor95@gmail.com>

On Mon, Jun 01, 2026 at 06:18:28PM +0300, Svyatoslav Ryhel wrote:
> Simplify the sysfs logic of the linear property by switching to a macro
> and a ternary operator.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

With the change to regmap_assign_bits():

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
