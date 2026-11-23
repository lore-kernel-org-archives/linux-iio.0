Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420509;
	b=q2x8wgiA66K221Y8lAYAvADvG4XjuTU9rvUgW/M6v7z6Zvf80B+Si+Zj6NE4t6le1AMt
	 1nVSRfEaPImVer6X3bI7ls5kt8l5dikBUY6F5JhrHggcMYNbMCNIe73rwfnuYvukHkcrs
	 AoESULduL/3uDEaAAhVCH2wVn6gDmtckoFdQeckdfdBO+Loxs9mSnDg+he5i8/XQjvq8N
	 eI/O1RHzj3W5OmBseceGavtEuOeLBAd5WKkWgKd7p6ccRVLvvvzaL5tjwlgRZeYpN0iJ8
	 GvgsHFCIPNuCzymavcXPpp48S+ywNbEVwj7NDTJ/NM3/kscA8n/J+xI3DdgCb6tugyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420509;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MFtS+X6Xpozvsy7k0lb/HTdWvxM3I3CnfCZATCjvav0=;
	b=Gy5gyidunJq0NnVUNKO9Yi/jWyzyzmnZYYpvjONdFDbU5hEkE5N0xry23dfde7fUPbnx
	 vI2WK4vmjJDweSnu4YCii7bedAVVMsYx382GTCTfpT0UZVkHTTCYlOr6WxbzhkgNk5mIb
	 ooPyzF+GDhFi38lYKCk6BPSNt4TL3jftFf2mVqUcsYGs/Fcx044J5zhNnJIlhIcGUfk6Q
	 7T1E1VIwF/oegDj1XUInFTocsqTuovFyF4EEdyRZ94zhwParTCox1L8TdczPHK3KcJiwI
	 00Tp5tVDmwYiqz/MaXSfaOdJsNeuMBQzDxUEIPHWYfna69yX5fBtatC3ntGe6yqmpZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAKROXVq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0593606A31F;
	Mon, 23 Nov 2026 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAKROXVq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C024E1F000C4;
	Mon, 23 Nov 2026 07:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420508;
	bh=MFtS+X6Xpozvsy7k0lb/HTdWvxM3I3CnfCZATCjvav0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UAKROXVqvSHTREB2yar0kzYn4O/8P0H9yk7j0jP+4ER3Eed98TnmEKCnHDnUhU2UM
	 XXMUK/CoXhXkssKT5YuLx0JWC7Vf650XApstPU/6tJ5nFZn74KA/EjhxudIB0TXS6k
	 gX0XyKtSzn4B0c8+mBV3zOyUmwTKVYiCU4IeOrVaPHrRc+cjFAxa/6ssP78RoDBB1b
	 z+SA/pnk6U0JQMZ22cqvOAMK+llAHnELYqWH6lgH5rw00drkaNe7jK2tn/uVvTN/Ch
	 NY577KZMl12SOxzHRdNIpvLvAcvmypw1BLwgmrj5NUIUYubhHVC1HnKiLkW+o31OIu
	 n1sP/6ezE4feg==
Message-ID: <98dd960b-721c-47d8-ad85-7828b8ee26c9@kernel.org>
Date: Mon, 23 Nov 2026 08:55:07 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/8] iio: adc: at91_adc: drop duplicate IRQ allocation
 error message
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>, jic23@kernel.org,
 linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, giorgitchankvetadze1997@gmail.com,
 amin.gattout@gmail.com, antoniu.miclaus@analog.com,
 gregkh@linuxfoundation.org, mripard@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
 <20261123070101.53868-3-abdelnasserhussein11@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261123070101.53868-3-abdelnasserhussein11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23-Nov-26 8:00, Abdelnasser Hussein wrote:
> devm_request_irq() already logs an error message when it fails.  Drop the
> additional dev_err_probe() wrapper and simply return the error code to
> avoid reporting the same failure twice.
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts

