Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F8311C35;
	Mon, 18 May 2026 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111190; cv=none; b=dYxkM0vvYI8WWrMghw6P2YJuIcTbJqiK916lFHkFsaEImerezcHFhfcRuOj01GWc5QIuMZRxQOqhBCEhkt/c8XuGEoGCFYDyV36XQqyrH4NgNLEmqx7a6TW0ZFErvGGHya6AYZbQyAh8kgy5rCXseDI1q35BDuv1p1T136mjELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111190; c=relaxed/simple;
	bh=mT4lOdzl+oj9spUStoiUmIGSBOyct1jRVIsf8kcF+ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2ZidD1CKSh0PRPXtdHamFsyLNHhRvIQXtXYjGt9BZ6lcyWZJybub70k3LBL4MwWfQ0vsT0yM8raqFafgl6Ty9SIfmdbF1+AR4aeNCVTGd2P9oFL1JF/5mQ2rXZ5LR5TsSjFA7vMopiywIj4+UjmKR99bzF2w1ZjsYpL3yVwzSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhBaVz2z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhBaVz2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFEEC2BCB7;
	Mon, 18 May 2026 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111189;
	bh=mT4lOdzl+oj9spUStoiUmIGSBOyct1jRVIsf8kcF+ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UhBaVz2zk2VR+bouEflyfP+cJGTqn8z/u064AKBaQ+ZK+qYgFcYjhkY4rFx/UxUmX
	 CyycVE5+e9VwuAierr9fUKSTGWCNBCfoeWnEEhvfc/Eb8FvSGPAeIpa5W8AolEK+h8
	 Uu3iUM/HJ8lojKtEuUSkTDUUdvTyay9xAKpdQr5gB08h2xKOnD/D8Mx0VmI+CAOoqg
	 RLI4lbB/5qCGS9wCFaNq5IKh73WcjixCappiOEE62fEnExre9rTuzcZFbWykzouyZk
	 vRUzwGv1rpZieTOY9T2fyl9AL8B3XqEFXKwiZDrPwOR7nqX3Ti2IgpVi8D4POUaOkr
	 PN8hjt2SAmfYw==
Date: Mon, 18 May 2026 14:33:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 christoph.muellner@theobroma-systems.com, martink@posteo.de,
 mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] iio: accel: mma8452: sort headers
 alphabetically
Message-ID: <20260518143301.75d509f8@jic23-huawei>
In-Reply-To: <CALoEA-wYNLdsn+pdH+STm=ym=cwLi=+Sh0QQK=Ap1z3qYdcpiA@mail.gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
	<20260505174640.3998281-5-sanjayembedded@gmail.com>
	<CALoEA-wYNLdsn+pdH+STm=ym=cwLi=+Sh0QQK=Ap1z3qYdcpiA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 11:29:59 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 5 May 2026 at 19:49, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
> >
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >
> > Sort include headers alphabetically to improve readability.
> >
> > Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>  
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

Applied.
