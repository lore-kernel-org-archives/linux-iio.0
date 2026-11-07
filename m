Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794084038;
	b=B0jdewPAZy4HNwwviQIpM3NJbaX+S7BnFAAimH5OACN+dAX2zidGy+shXSWZRp2dvmOe
	 BUInvZ/1DLGdQCpP6+QAF3cD9iTc69kVw9DMVcRz2FsosM5ijfAFIlSDwVs5o+Waad0mn
	 5tduMpNhcYyl2IBdYUPKm6gzj7U14zMhL4DFFIgmGkDfjjwF5sKC5BQJHdFxCnf5Cgg/1
	 UMLodtoJQSI8JjP+BOzzaoY7YDG8fDtsdGGCIZ+Qzptj1B7Q4cpOkLcL4hjb2BXgqXQps
	 T7wT1GOTV7yNpqTYoWzUVM8NQ8JumR5Ai3ZBxXCrCq8aZhi06DjdB+FSf+KYVuHjYuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794084038;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Li2bfveIePoVmgO+L+lVSSps1XIwzNsXlobYk20vC9Q=;
	b=n8VuxsUMYPh+lNGNyQt0vVAXrz0BXoWbNWm8Dvpxbi5EhlctVP773sYXc5PUnSiqvt/5
	 OaqQ6ZnB31jUcxBWaBflSGg8fpqInfL7lJFuAqUaZRWYGyKCRQKtSp4OVC0ezadhmQqCw
	 rqoSnE2LWatBXTmy+8qs6tTM1jsUp+VBCxt8HB2a1YFlD53II2cZFY6ceQXdMm0wuDph2
	 /Tu/dFWMaV2WeErTiXbOxddZ3m5ovFQWMWSHRgQNST+vyTGMC5AdTrDx2DgJH5IsAXUAS
	 JQhMptODYNTIoABFOZlmZHB3p2boBMGmVQSKA/5DIFodZpGVqBg4TtvTcD3DIR6xvTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1eBz3ZY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F374606A32C;
	Sat,  7 Nov 2026 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1eBz3ZY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6BA1F0089F;
	Sat,  7 Nov 2026 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794084038;
	bh=Li2bfveIePoVmgO+L+lVSSps1XIwzNsXlobYk20vC9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l1eBz3ZYvg95OTzcFr4ofM7CXQzymWtAVOw9pKweFwbkhOjUJvJx1CMrHQalCV8Fq
	 zUpSCFg241zXkJKaR17j+LrVrMaghlQ7CAyQzwOyTQ00BANNbq6RYyD+MS2bQmTd0c
	 XYRwN6YNbQJPFGIOkrJLJWZFQKIJ8kKumUoEMXXG3AuyC7+0RTV7iOx7vmM1hXkWrl
	 u49Gefmn5rmCXQ4Cn/ThZEnijhITa9nD4dZN0O6e6IoNSb2OTe64ojTq5kkgu9GWiZ
	 24YKFbShJGIxrImUTSIK2JfS+Diw8EIiwYxDpRJsQVGQYPG4/EJ4NJUwihf30GQK0b
	 hDqNgC4XgWFWw==
Date: Sat, 7 Nov 2026 20:40:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Gwendal Grignou <gwendal@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9360: use an int array for the
 sampling frequency range
Message-ID: <20261107204031.4ea3e36b@jic23-hlaptop>
In-Reply-To: <auuqD75_H4OVHqva@ashevche-desk.local>
References: <20261104175608.205872-1-kapoorarnav43@gmail.com>
	<auuqD75_H4OVHqva@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Wed, 4 Nov 2026 23:56:31 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Nov 04, 2026 at 11:26:04PM +0530, Arnav Kapoor wrote:
> > sx9360_samp_freq_interval[] is an array of struct { int val; int val2; }
> > that read_avail() hands to the IIO core by casting it to int *. That
> > relies on the struct having no padding. Declare it as an array of
> > int[2], like other IIO drivers do for their available ranges, so the
> > layout is plain and the cast no longer drops const.
> > 
> > No functional change.  
> 
> LGTM,
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Looks fine but will have to wait for the fix that touched this
code to make it to upstream for non fixes.
