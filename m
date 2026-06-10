Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B803B992A;
	Wed, 10 Jun 2026 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082599; cv=none; b=cvZ2SxeB6JIm1oPxMirAN3uiDyWfkHwPcHAzKNf5MFOIZdOFC0oqCbaTZfkiHM9Fca+ZuFA9c10iab0JxGcmozuU5HSiIeqJfl+LhNk0EV4PRSyP1XPZ/pdITR2bSohZEOdXXDiJrAVdFC4oMVj/CeJ9I6L+46P4AsY4KV83n/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082599; c=relaxed/simple;
	bh=v4v9Piyk/z22bG9iWAufISTcgnS9atBg5KHELjUqw+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bcr6JF3ad3HoEDb12gZ8T4iXPvBwDoUucPhnJliqeyMby4iqt0jRLxgoI6UxiBT1yXGYOfVeXTwKYn8pyMtcuqTmI9Zjs2RqFx9JwVCuaLPfS0gHktpionE+KbO4MLYP9yCJDNSHK6aH/CYkhY4vPYQmpVVTncgZoc6/QjU+RJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Je3bodaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je3bodaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A571F00893;
	Wed, 10 Jun 2026 09:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781082597;
	bh=v4v9Piyk/z22bG9iWAufISTcgnS9atBg5KHELjUqw+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Je3bodaEzY29bvMUA+mMoT2JBKGxljxVE3h5Uv1FgR3yAzQzWrEJtfgQz/Ym9IJur
	 KR/5PW4Z8TxuuyQfEOjMSSN8Ilk0Ry0ps88ZyusmCAjzfFEmHU/u+2XhmDlDIGExi5
	 1fEXoWG8ClIc+xJSxAVv6alicS7z0P++08F1yTfsTnzAcH7weGXrzdAIS1JgaZcNBp
	 /wXKU2BTwqJyO812T6Rk2kPyM+nd2ZP0l9HgjjdzIIiox9m/zgB86OMU9Lkp2+7xAj
	 +3cifBEELQy/GcDhu+lP+kGc1kWViqOz1UY6lJcQD7HBRuEmfFiHUrrncfmdXXhuPV
	 3LCpTM1m6jUbA==
Date: Wed, 10 Jun 2026 11:09:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as maintainer for PMS7003
Message-ID: <20260610-pastoral-dark-ostrich-5ca3f6@quoll>
References: <20260609160326.45123-1-m32285159@gmail.com>
 <20260609160326.45123-3-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609160326.45123-3-m32285159@gmail.com>

On Tue, Jun 09, 2026 at 11:03:26AM -0500, Maxwell Doose wrote:
> Tomasz's entry is no longer valid, as he is not active anymore. Add

Why is not longer valid? I see activity in Feb...

Best regards,
Krzysztof

