Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBD3A7839;
	Wed, 29 Apr 2026 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454374; cv=none; b=oL/Ku9nckM6V21jw38p5TUM6Z2Vv/7HmOmrmAFI+bGXuLHQdo/1r3yMTYn4OKWblAkOhODvB+ffwr5WVJzk8QdeD1iwj5egyjHbeGVpsfgWdFTwWgvT33UCtkoPBTvTjs/5HHTdj0I+GL+s0ymtna1xe1ln4ZraWFBcKuRma+sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454374; c=relaxed/simple;
	bh=XyXgKLeg2OtnJotVi4PvW1X1pAxRSV60sTXuJ9iWtNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwvSuiLvha7rQI7JflPVA5PH6q3JobvoRZL9j/1BONxVJziElPXpQNymRok0gSsFR5yV0xMQpp6IFGQzGLJrM9/w91ix8JrFcMD6JUiNdFi06sgHaXXwkWvZtJeSDh4br40DrW6YBdZq1xaGJbNgCUbL39tHJP0wGE0Cp09JF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmCsB5fZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmCsB5fZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458B4C19425;
	Wed, 29 Apr 2026 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454373;
	bh=XyXgKLeg2OtnJotVi4PvW1X1pAxRSV60sTXuJ9iWtNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lmCsB5fZIlR2NHQWwTzL+mqK8ZrkgsMLqoXfUoQgPUvmU56MRxPmkAQjPTns534Xc
	 PMCXwaESoAI1nr6Rj+HrDAVLi1He21keQO20O+wGF+ZOEdTCJunDhxoMcDqPY2wTXz
	 nL/ePsbx9MtCDyzaHEYle/q9WkFTdLVS5C5f57rwIr5ujY07W4tk2zGwtc5mmmJTQb
	 c5Fh+P78wUwTK+0z2d/D+/oKnMW0WAlEEuTc9Jh9ukiE6+tcEy9AtI0Ikogd/V9e1G
	 d7s0oLXYfJTOSHR/t1twzz3ncg8gsCbJ3A2C2jDAVWYFw//YUpz0XGZ8FI9IBN2B75
	 Skx30l3jid7vw==
Date: Wed, 29 Apr 2026 10:19:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Miao Li <limiao870622@163.com>
Cc: andy@kernel.org, dixitparmar19@gmail.com, dlechner@baylibre.com,
 nuno.sa@analog.com, waqar.hameed@axis.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH v3] iio: light: stk3310: Deal with the ps interrupt
 issue in PM
Message-ID: <20260429101925.158b2bd9@jic23-huawei>
In-Reply-To: <20260429071402.209438-1-limiao870622@163.com>
References: <20260428192213.7c5c80e5@jic23-huawei>
	<20260429071402.209438-1-limiao870622@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 15:14:02 +0800
Miao Li <limiao870622@163.com> wrote:

> From: Miao Li <limiao@kylinos.cn>
> 
> On the Inspur HS326 laptop(which integrated with HiSilicon M900
> processor), if the STK3311-X chip's PS interrupt is configured
> in "Recommended interrupt mode", the interrupt cannot be triggered
> normally after waking from suspend or hibernation.
> 
> In this case, neither disabling and re-enabling the interrupt nor
> resetting the PS threshold register can restore the interrupt to
> normal operation.
> 
> If the interrupt is disabled in suspend() then reset the PS threshold
> register and enable the interrupt in resume(). This resolves the issue.
> 
> Signed-off-by: Miao Li <limiao@kylinos.cn>
Hi. 

Please do not send a new version in reply to an old one.  A few reasons
that most kernel maintainers ask for new threads for each version.

1. Threads can get very complex if there are lots of versions.
2. Many reviewers who find themselves with a few minutes look at most recent
   emails. In a threaded email client, a reply like this one ends up pages
   back so attracts fewer reviews.

I don't have anything else to add to Andy's review.  However please
slow down a bit on new versions to allow people to respond to earlier
ones.  If there is a known problem you have noticed after sending it
out feel free to review your own patch on the list and point that problem out.

Jonathan
