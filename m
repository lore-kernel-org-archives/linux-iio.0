Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741C047887C;
	Wed,  6 May 2026 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778087761; cv=none; b=Yshs/83RiboIxuH5TfLsvH/8sElLfgQI5tGLnGT5XTCU5PD+GuWHmDqxajNyct6R7lOZQxd+YQ+FNj5Bznh1/eXFGwWYLEXm18/1X/PbE3AWCkfqbrYO9BenLBKHBjaqc9dcFSvPyFG2ZjYgLonmH8s8Er1LSwZiBkx+iCzFSUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778087761; c=relaxed/simple;
	bh=GJou+VeqZ6emfeqlIm+BESd8C8qxVr+qPCCJ4+p2BmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsTnd+D+3wN6Amkz8WIZ2vUG9q4NmttG1S65rG5mzxGbgUJt1pOY8ied99+4eyPShFEhmrU266LNsNrctXTYy8yOwfPD+PnyLF83/bW3g9ZWND93RVlReA/kre/MwjuB+iSeAM3wMcgY9j/G6X+LraNXbEAaT+zsm/HliBrONq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR1Es8yG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR1Es8yG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403AAC2BCB0;
	Wed,  6 May 2026 17:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778087760;
	bh=GJou+VeqZ6emfeqlIm+BESd8C8qxVr+qPCCJ4+p2BmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OR1Es8yGx8ALO02XT1fSj/A8OaVJ/z5B21eDLwp1lnXPNtRqC3NCi5hztfVf4lRtO
	 zlLMiv8uGnAzuvx6Q9PJ24qDXp02Dx/i6bmR97BGUweNEsFzg54fAfYc4RfN7dASuU
	 vHWLNehzYUUcX3HSl00IZ+9F7tZvhsiIR2D82ZUzVg0KW/ZVo1NFuhHTAulpVg2NZI
	 LWGDl3DJbKMAd/uGZNvu1U0O0YnAoxQWR3nPkb7fjr8fb7PdwnokTaMoN4BmAEMGUg
	 PYomG2i3hPrvbkt6XGRVkOX+vsMXq89NiyyBJVM1EO7Ats1cMF2+PO799X4j6wJXyB
	 ZCLTIbLy2gAxw==
Date: Wed, 6 May 2026 18:15:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Maxwell Doose <m32285159@gmail.com>, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: magnetometer: ak8975: Add missed
 pm_runtime_put_autosuspend() call
Message-ID: <20260506181552.667ccbc9@jic23-huawei>
In-Reply-To: <CALoEA-zyp4fjF03hn-sH-jOeSmLCZoJorVts7JDNp9rqv6p-4A@mail.gmail.com>
References: <20260506082755.860523-1-andriy.shevchenko@linux.intel.com>
	<afr8ibUy8lNywq-5@ashevche-desk.local>
	<CALoEA-zyp4fjF03hn-sH-jOeSmLCZoJorVts7JDNp9rqv6p-4A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 10:45:56 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed, 6 May 2026 at 10:32, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, May 06, 2026 at 10:27:55AM +0200, Andy Shevchenko wrote:  
> > > On the failure in the ak8975_read_axis() the PM runtime gets unbalanced.
> > > Balance it by calling pm_runtime_put_autosuspend() on error path as well.  
> >
> > I hope Jonathan will take this soon, so you, Joshua, can base a new version on
> > this one (otherwise it will be a conflict with one change).  
> 
> Considering this is a fix, I'd say it will be merged fairly soon. I'll
> fix the addressed
> changes, and then do a rebase once it's available.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

I'm going to be a tiny bit naughty with this one because I don't want to have
your larger series sitting around for longer - my ability to keep up with what
is in flight is failing me this week so I want to trim that down!

Snuck underneath the parts of your series I picked up on the testing
branch of iio.git.  It can get backported after next merge window.

Marked for stable.

Thanks

Jonathan
