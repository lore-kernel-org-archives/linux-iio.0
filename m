Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552203750BC;
	Tue, 12 May 2026 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598195; cv=none; b=syD2jq0cl7JErItgmtyR6y2vc7ywbGoUh6seCRU3jfl3sQzQ0+xtMOR4RsGM5DmiAwbkH5KIYvBAWtBpj0TUbzUZFsaOx6ZcP3MJ+dhFY1ywQubBWQQ79ajWvNx17SGsB9f1dL4e2kpKLn0E/WqHNpS1LD13Yqnf3LSxD4pcDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598195; c=relaxed/simple;
	bh=A6gczLsaZq3zBOhRjXwc9TdaKC8D3z04BguFV52hlNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiveIAh0E3stUokWc9pPkbaeVNnIwuiRAQDVfPss0cfgg2bEynOvbht42qQe3toD8t9/fxFyRHJes6gaPC/2eGaMdgU51r6t1ZFeOszMorpZYP1fkI3z71aMz1YeltS4I8jCcrRLvv0vXeVOI3Gf5jEjISfwxlY2Fc5Q6SoDImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAIeQU/9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAIeQU/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B22C32782;
	Tue, 12 May 2026 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778598194;
	bh=A6gczLsaZq3zBOhRjXwc9TdaKC8D3z04BguFV52hlNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QAIeQU/9zsLfrclnujSFoVSvvx+r8eN2Z7vl6wVh47nJhYu1+JKCBppTJ1LNwT+uG
	 yCjXN7o4ecbKud4fiQwpq1GVcv+jyuC9MYOm/Ouh0jZ8EodPuVv/ikK3pOYx+C2T/K
	 6h0TjL0XuBJT4ohtKVRRKKc9qTOUXk2H9RuAuI9HGwaRKhqEOHqVSwCPv4RTirqsah
	 uaqO966ALBLnJ6UhO1kFfCd30WWQMq+X2H2fJsTHpiRg4hRjmMASiJiSqYXwGHea5c
	 /OTfVZuCfPNnN4maMBb+PPGdT2Sf+Rn36m2q2kIyQ5cQ7ybiCrOpAtx1BZD8QjUt4X
	 rfzDQS6tUNFiA==
Date: Tue, 12 May 2026 16:03:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 4/8] iio: magnetometer: ak8975: consistently use
 'data' parameter
Message-ID: <20260512160305.0be0be39@jic23-huawei>
In-Reply-To: <20260511-magnetometer-fixes-post-pickup-v7-4-9d910faa28b6@gmail.com>
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
	<20260511-magnetometer-fixes-post-pickup-v7-4-9d910faa28b6@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 13:26:13 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wr=
ote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Some of the functions use 'client', some use 'data', and some use both.
> Refactor the driver to consistently use 'data' in all cases.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Note that whilst I've applied this sashiko pointed out some more
while I was here issues.

The one about not ensuring the power is on for buffered captures
is a pretty major bug :(=20

https://sashiko.dev/#/patchset/20260511-magnetometer-fixes-post-pickup-v7-0=
-9d910faa28b6%40gmail.com

Which is a pain because we have lots of cleanup on this driver already
and I don't want to rip it out.  The fix is pretty simple though
(add a preenable, postdissable pair of opts and pm_runtime_get_sync()
/ put_autosuspend() as appropriate.

So if you don't mind please put together that patch and I'll apply it
via the testing/togreg tree and we'll do a manual backport later.

Jonathan



