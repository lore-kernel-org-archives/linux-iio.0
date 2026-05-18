Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621740314F
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114149; cv=none; b=uxZxy/5SeDacCLz6QatpmYbAt0YjA4dL498kZUl1eypoPiCSh/yA7GqNiP0ZMTPSd8FDFhOfnnj5L5tIiuDnYunnXOU2CaAgKjFAGFUp/Vz3fuEYrVj61EFvtJDyXY1Pwh2o2H0489NtZFX1LyiKfmaSKE9uUbI+T/2GI0eiml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114149; c=relaxed/simple;
	bh=lj0oMVogwUQz/hG7+ZsO3x4R42MrwlzSQcq01bnWGzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uh2KEmlpgy53yQuG3nxCd8s/jSstOMaw2YiP7pcpOgQUmrHuDPsPrmGVslt18g8wkoQEa4ysIpwKK49oYGM7L2gPIkvx53BGIMdgRdBKSawVmJtEJjUvw3Jx6iDXSro8M+i0R2lMhisnYHQeDVi84LZUXxnpJtXIgKtov2eiH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITLhNpty; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITLhNpty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E0CC2BCB7;
	Mon, 18 May 2026 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779114148;
	bh=lj0oMVogwUQz/hG7+ZsO3x4R42MrwlzSQcq01bnWGzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ITLhNpty7MU2KFMXzuMc99CBGIAuIm/VCfYtRROM86XfNfsJMzch+2ytwOzff8TID
	 DvFBUExFanp51Etuk7FFyR35dhMKJ7uE46KUysLdJ/ftzSwjC/T1pGEEFP6oTHLUkv
	 MqzW+HVt340j6kT6gOLt+E5w8MfdzI+GQRzRevKdT+LmrLihLiVXLTL6zWkduzQSHG
	 hvu24RvhBRZX3wPEmS448GWHE+QK2ZY4YcrVcOF3RjjEy1OCgGnbK2aH1mV8aStzvD
	 IDVg/JZLNmH7zWeT9LFcVGGa4dsItYNL5diYs0171Ap0ZhgXLnCf0mNo9KplFPTSpQ
	 5uGuWtQK5E6tQ==
Date: Mon, 18 May 2026 15:22:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, Stepan Ionichev <sozdayvek@gmail.com>,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: trigger: drop generic interrupt trigger.
Message-ID: <20260518152221.57931c14@jic23-huawei>
In-Reply-To: <agrGvgYmFvEfTrCT@ashevche-desk.local>
References: <20260516113219.573610-1-jic23@kernel.org>
	<agrGvgYmFvEfTrCT@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 10:58:54 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, May 16, 2026 at 12:32:19PM +0100, Jonathan Cameron wrote:
> > There is no way to bind to this driver from firmware and no explicit
> > platform device creation calls exist in mainline.
> > 
> > As such it is dead code. So drop it rather than potentially wasting time
> > modernizing it (see #1)  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied. I'm fine reverting this if a user shouts - until then let us
assume that no one cares (any more!)

Jonathan


