Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0856A274670;
	Mon,  7 Sep 2026 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747193; cv=none; b=MQkgZSk5dTUNTBx9t69dtCHBBvQ1Fag8IL+UpmQ4oyIBjvKhlrEtNDCZo6iPKE4jBwp68t/LTG0K/tO4IOQvd+qwt3V/Ff6gLgiQQjMjXU6K6PqckC3ReSqhZPAcExhNF2K8iIqizDNgMrn9QIV8WQNoGd3dVvhDTh0F14c9mO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747193; c=relaxed/simple;
	bh=xEcNYkBK00/oWpEkT0xCsOe3EXTyTevbxHH20ETrMYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z136teVxIxGbXh3XpNayjBA7zqfisNT4ftxnonj7dMYf0i+OQ1JA7SaqnEkrps0FvcykahGY8pySVCbc2PZ8cCXR/hjUAWWN2opVE/9qD8DbL1mmQbPWr2YCx1iSA8NDOu9zrPQm608pTT355Qzti7fRoHKc1qAS8vm6St2oIe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIzs6I/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIzs6I/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC631F00A3A;
	Mon,  7 Sep 2026 02:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788747191;
	bh=r5cekxgZ/xtLcd85zQj5wrurZMQnEGCLc6L5xLlG0PE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KIzs6I/r9kvutWaAVtJMNkqHXLwJjitsRQbKzWlvrEDnqJWhzU5obTfXXJbyL1rAZ
	 x0bqU6cV8/imTYpgaNz9uibCM7t9Q0nJsTTtAMxAW8xofH5yWF8qS5lZfHH4qmmkMm
	 vTQ1lddN5DLqEJodwcZUsFEP+b3FguIi4Kmg1O+mJqUfJ+LsQhDdNFW8LQsSw2iTZ+
	 izQX23kkD+72IlLulHx8EyxzlFNyKiuwZSN7bvT2xylrvzaQebB8MwtaLcUmQli1G1
	 6nLNiwV96cRZb7DIL9m6DHkv+fWd8jyVPz7BD3fFmzpRtoNgCp9oHjsenveUD1ghNO
	 EYFsrZfver7zA==
Date: Mon, 7 Sep 2026 03:13:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=  <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: vcnl3020: fix ISR bitmask check in
 IRQ handler
Message-ID: <20260907031308.060622be@jic23-huawei>
In-Reply-To: <980e6203d73cd05429ff0bcf48c192356e349616.camel@gmail.com>
References: <20260824042908.8887-1-salah.triki@gmail.com>
	<20260901022731.10771244@jic23-huawei>
	<980e6203d73cd05429ff0bcf48c192356e349616.camel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> Yeap, definitely mixed ISR/ICR values there for ISR. Now it looks fine.
> 
> Reviewed-by: Ivan Mikhaylov <fr0st61te@gmail.com>

Thanks for confirming.

Applied to the fixes-togreg branch of iio.git and marked for stable

Jonathan
> 
> Thanks.

