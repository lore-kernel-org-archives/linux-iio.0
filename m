Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405908;
	b=LatxVjJzPZgusyf9uEIFNsmysLOCZGUQfTDIdu/R87rMKVDr7fggRnQvyTUQa06w3ijI
	 OOP3E4phZjm7yau1DcI7f/ozRQXrWnb5M8YypRbz2gfrMIsIY33Fkp70b7YzZuGRlkbkt
	 G+E90tfFrEY6HCErfcfs+6oytE5e4jJm4psGb70Pb+9suD4MU2xC7jeeRcpM97bSO0uZe
	 O2wO9/iIn1/zX8EBg02Gt6h6pbFygKNm6q9hTHu9vAS473vgRxuAQLiNhAsGSxkYcEwI2
	 ky6iV7C54GIr3RPNbx//VwZxUZWvnRgBYlTIloMY66jdhMjYU3xCiQACusChlH00Hpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405908;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Fm73bZtZ5lSQw5yZwZ2W/Xh9a4g14zYHgQW4xmFW6yc=;
	b=WGEylFJbyDQrHybALnK8OQivr/NGS4Ru90ieqztTxsuLpNfsTeMpJzsLpFiQVBNwaGm1
	 J/oNCeRcWAyA3/unMIf5Lfc12xeQnw6Gu8CZzlyCmOR6sr/h1pJPMc6lngf23sI0rHL6e
	 E8mXtcxKhzmACyMqjtsazsjGJqSvG3TUp/zo5ubWN5gNSKIe8KNeysUrFygHbb9jUhIoc
	 redKiuNUGLh9nQbfck+fTa+f2KwxdJ4x51tQCKX+bHAERZ58QokXb6q7ccmYl5i4GSGDr
	 l0FNfgUUCHWIzScW6WhARNihGPZCtftPcZ43lxi6pZ3b5EZ1JzLRDM50vAJ1MQCmOAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jyjv6Rxq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C012A606A885
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jyjv6Rxq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156871F00A09;
	Wed, 11 Nov 2026 14:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794405908;
	bh=Fm73bZtZ5lSQw5yZwZ2W/Xh9a4g14zYHgQW4xmFW6yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jyjv6Rxqo0T3/LpI2HqWAUwvC+4qDR7ZivS/6JHFgqrGzTAlWNqSjD5iS9ZqTzc8p
	 LlvuNkxCf0QVVDfgJrtJ5dOhtap8/dU3jKITCpvJD+FZtQofBe75frO1WdoM64IH+q
	 wNJs96+hpdp8gAtZlEJ9cYoO6zq43aBRAsLD2Ngc=
Date: Wed, 11 Nov 2026 09:04:46 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for the 7.4 cycle.
Message-ID: <2026111137-defuse-voting-8303@gregkh>
References: <20261111030502.4b68277a@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111030502.4b68277a@jic23-hlaptop>

On Wed, Nov 11, 2026 at 03:05:02AM +0000, Jonathan Cameron wrote:
> The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:
> 
>   Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.4a

Pulled and pushed out, thanks.

greg k-h
