Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794218664;
	b=TBy0kvTPWz9Wqv8GcoRdr4JFsO39crkRxWkUkm0ihZqXCbRp+/dWpzYOD81TNfX8s59T
	 tYWNsYsxwbls8ihuTKun+hQGvmJJuWMpjHiWVpDfdHfchLO8BggCTQw/QqZPRfGZyama6
	 So7lHmogUq2yDOwz9s9lvWYlUul77hjXHK0l/XKlft8CrnojQbvrE+B1Gp7QYdIP6bToq
	 rDdH7LZuFIcBVkgvn3rdRHvTKiAAfmJ+/R3V2k91Kk4BZrz6uNB3X9Vw+3DNou3qxClqn
	 VOFR7rl/HLg39kbgI7XofIkECJ1y/jM8djg8cURj9I/K/BCFe89Ik2NiJ4f6gSuwSPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218664;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=caIIRxITMqgnCqMmXIx5dUtk9CcAnLsfPhW3eo3DWTQ=;
	b=zD8JNJpDI1fzVw9I4tkRmQkhYizPZrPjvAaZYtehvp2ZrcpUt9bkeCgCD9nG0lel/58O
	 4+zs1nC8sevP7Tx3zErN9gGU+hnEX+RH2EB3aGNd4gzJ3+dRHIyxDhViGsFfq9p3tAY7w
	 wTS5OwGW2e00HDF+JUy4iNpP2SJU0O9mFqEBe8lyHiPMpPjpy0bmQJRVPh8iYl86ate13
	 t7lQ3lPz/5kAGEXdMxndOdnT0FHKWo3+mzzTz/xrgX91XHIPe/kdEUyXk47p2mPA3K2IY
	 MoQQ1Hu+VEPV2zvo6//jrRtBTs6gwLfZ3DQwB1tJyA8Tol97UNUDAgvdDuJ6V9ciPdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TveDsyb2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9F606A31C;
	Mon,  9 Nov 2026 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TveDsyb2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794218663;
	b=rwZbri2t9qw45xIqftBtkqp5A27me8G4KGj2bdLGFcj7GbgJ7frETKaHQPBqzK0hjtR6
	 SjG2KqY/GEikVs+Nkx7/91VV2ZFvY/4NUl0Ny4RpVcCUXJ704aUc7H7R+uqq9k3ISFjFr
	 hQRJURx2b25ONYksHLu/Z27HJgmxxalEBvDYaRVlagzqeEV8cbWbPlB8PhnLjPI2LaTNi
	 wW8+0QbPhKkBOhJ7T5+Ws93dr45LLYDBybqnzUVvGq0efJr11zXrZLkBq132PXamRK+5U
	 a9fFJ9+iduxVY7NBwF5MRPLkXC59PTIuhJqiKnItqfmOcuTahMjhiWue4FVRoxTVueQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794218663;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=caIIRxITMqgnCqMmXIx5dUtk9CcAnLsfPhW3eo3DWTQ=;
	b=DjltnSu6PpXKuin+5coIdbKJESMYCX3J3UVYSExR74QOWHv0h6UH09C5Gb5mmrvWKVMw
	 GF6YXTv7l6+Lo8rYdszgwMHPpHj/6GMMCxtaJMBpUqqrIXJoa5M/z6qvSY7dRiK4GvG74
	 Se28ojOhGYfJDrwUB38wyP/JjLR+5mHo6sFcB/4DmMxbD0UNHfbCkqG+EfyZbIm+cBHig
	 rsL+ngC0LvXT+RryCVNlwRAcHCBqm4pYPXuUev+Qdjao5J+4q/6r/t+CA/M/N4UCO0rdm
	 ltr0H/AcgmVYncS/g/cS+UE+nfB7E5KKFycurx+1skkjArX/fNlbGRRevQqTwYSllVg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 94C491F0089F;
	Mon,  9 Nov 2026 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794218663;
	bh=caIIRxITMqgnCqMmXIx5dUtk9CcAnLsfPhW3eo3DWTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TveDsyb2ZtPyNGbI9N0H4sHsS0dxlJdqVQsTH3xg33zRoXWgt2j1gigDpLl5mT/UZ
	 6oKKfLhjfvWEwwAozmFCZu1Zvd28L0FMiwURQtSK40i3YcNurq8A1YvBctGOdYAxsj
	 qd/ioRTFYs3OVOv3V3ESdrgmv7Yy/Jj4wyBOCJswVn+PXSmtPucDeMj41gdOQ0Rfnh
	 TiIiMis0FYlklFY4osb2uLXvHkbya0BNwo+29gecVytUsOq3DXKhaQCXQAZKE428PD
	 QMk/hwM4m73ffL/x3qKXKedG1qroDGWw2KLwASL/o/jv7IwOE0gOj4bMwex+uYdTPq
	 poJTxzsDi9R2g==
Date: Mon, 9 Nov 2026 11:04:12 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mcp9600: Bound thresholds before
 scaling
Message-ID: <20261109110412.00004f20@kernel.org>
In-Reply-To: <20261109093518.5418-1-zhujun2@cmss.chinamobile.com>
References: <20261109093518.5418-1-zhujun2@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Mon,  9 Nov 2026 17:35:17 +0800
Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:

> From: zhujun <zhujun2@cmss.chinamobile.com>
> 
> mcp9600_write_thresh() multiplies the integer part by 1000000 before
> clamping to the supported temperature range. The multiplication can
> overflow int, so a request such as 3000 degrees can select the lower
> threshold instead of the upper threshold.
> 
> Clamp the integer part to the hot-junction range before scaling. Keep
> the existing final clamp for fractional values and the narrower cold-
> junction range.
> 
> Fixes: dea750f8015b ("iio: temperature: mcp9600: add threshold events support")

You're missing a Signed-off-by tag. Without it, your patch cannot be accepted.

-- 
Kind regards,
Joshua Crofts
