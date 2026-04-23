Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2930DEB0;
	Thu, 23 Apr 2026 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933858; cv=none; b=Y7b8AB8IAId8949CdH/G9a+Mk7FfYpfiuLA2b63fFn1wTOgC2KKxeUG9ffEG9pgYdQUm6URtKe9/hyDD01ZgtsmsBYhCatpJ2sAsE29w6EioVha2pCXq3mqBeh9RG2Zf+8fYhG3v+CK1YGrnixtOGUlXgJKESMoXaFMmNv6fvOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933858; c=relaxed/simple;
	bh=pHwvabiAhKAJux/pLYNPXT7SldHMZf7RmAC+iWfxBxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLvCokmazXA8bMAEbQb7H15ctDM0TqGxX48bqbyaI3sV5h8mEGO3M8n7Q4TI9PAzWZDpQYM76fo+lIVoAE9n/juPBlDVxM2+4ULIItrOYSL6s6Tq3pE58YSEfXmRW/ht5JR5vTJyyhs9XhmZpqcQdxGb6XZtgPzxDw7yNwL0eXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tP4OQ6a8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP4OQ6a8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB073C2BCAF;
	Thu, 23 Apr 2026 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776933858;
	bh=pHwvabiAhKAJux/pLYNPXT7SldHMZf7RmAC+iWfxBxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tP4OQ6a8qmhhqxUiAmPupPU3qTG30xWfPeaelxAa/hhKjn2J7BWl0jtW0mySWD5cE
	 dCVWs8pdylkVelZ6ezHTkSkV25oQGIroK8RWboG1tIRXNCVYkzCCymUHe1ZZmngxkl
	 1169JHaPavKMcd212DK3bLnufl5EOVZcvQwodhZN+WAg+GkSfbTYNyihisjZJE2zFt
	 87ZVxBDkW9ppTmsg+YdJHPpDUNkPk+oJ+py7b1gkKdV+47HKSgjYB7p/Bqk8f8Q7Zi
	 i6oamUwdixJrC2+uufMXEAjfUg4gcBk2LGQgXDkYrwUOiU2SAiTvRcAcN/ETUYELcz
	 EgUysuH4P7vVw==
Date: Thu, 23 Apr 2026 10:44:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 00/22] Extend device support for AD5686 driver
Message-ID: <20260423-tacky-trout-of-fertility-3720d4@quoll>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>

On Wed, Apr 22, 2026 at 03:45:34PM +0100, Rodrigo Alencar wrote:
> This series adds support for multiple nanoDAC parts, adding triggered
> buffer and gain control support to the ad5686 DAC driver family, along
> with a number of driver cleanups and fixes.
> 
> Initial patches update the device-tree bindings:
> - Add compatible entries for missing and new parts;
> - Add GPIO properties for RESET, GAIN and LDAC pins;
> - Add missing power supplies properties.

It's merge window and you just sent 22 big series targetting one
subsystem. Avoid doing that.

Best regards,
Krzysztof

