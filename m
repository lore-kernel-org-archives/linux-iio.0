Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702FB377AB5;
	Sun,  2 Aug 2026 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785675549; cv=none; b=W/AXapwbfpAYJ3gpLxKFRvWG/tP50WtOa4Cw+VsCmDyQg2Hdn09g9UNcm2vo+XRT8QW3R3rgpmQlAZg9xzPebcO9lItVeTUcHGQ/DOiiVMZPpJa7NpKBBjeGG0z/iKzldmUfQJE09TY4sYgcwevfVQz9mKn6/y8uUNbUl1iMVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785675549; c=relaxed/simple;
	bh=EVFaThpNzizNCcGMX0Rm+5kts/IDge9pX1XWDWf3IRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCEHa6DZzkhwMB4sm+mM8QvqbCCN7nQRdoq+kzKErpym2oP7qdo+iwlv8BMFggYPWRm0taMkPtNCvN6gRe2HCLtBya0jgk6J3bHZw/p5vzeF7d5FBzuBvzy1+NSQRVS7yI1ItQAv/vQsTONe9dk7O9H3FnHPU71gDtiyTPjhSyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hy+FI/A/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy+FI/A/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBDB1F000E9;
	Sun,  2 Aug 2026 12:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785675548;
	bh=CN7MFTWTMPHzTsAYcgW5BxUDMO1hSVvd58BLl7Vja20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hy+FI/A/Z32GkNjA7nwc74ctNKsfLmaQDDsnUIyA0y0wRfbzISEqc6D1+rHjlNnW+
	 3obWyDDaNNaI5HHFQ+YxTMRpujWV6C9/wYeDHSoJLoghVvEncKXlxACTe7heHySSeT
	 8NMwGfBeJjO9ED/4Ne18Ys5cAQfJRRz1oODWJsjRrAzq0kR8cLctI3RYSRns6axKtm
	 nA6ln5n/q5BDEq286Litxr+4GVTcHlrZjU0MmUE2sW/VjTyfssYYjRvuTfYWdPswgR
	 4gq8EDkm8yFwTvU0qP8N3I0gUNZBJdhndqQohTCCr1i++CgBq6UClSXl4UkjdaXx+F
	 ShEAX+lR6Uzhw==
From: William Breathitt Gray <wbg@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	m32285159@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] counter: ti-eqep: use devm for runtime PM to fix probe error path
Date: Sun,  2 Aug 2026 21:59:01 +0900
Message-ID: <20260802125903.1425262-1-wbg@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ah--yK0SXW4TC2xC@ashevche-desk.local>
References: <ah--yK0SXW4TC2xC@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=wbg@kernel.org; h=from:subject; bh=EVFaThpNzizNCcGMX0Rm+5kts/IDge9pX1XWDWf3IRs=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFn59uxWfQf6HEO2/BFdVZG63Gnmw12H5zILlnhd3tHAc P5x2kSJjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAi0ZIM/2N32DwwmyQ8m5+b 4Yq9dTZLQGnRKW85nahul/r4N6VloQz/69zOpf345CV5RtW7vYxvsd0y99tLFWMDgo/7K+l2+L7 nBgA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Wed, Jun 03, 2026 at 08:42:32AM +0300, Andy Shevchenko wrote:
> On Fri, May 29, 2026 at 02:58:34PM +0500, Stepan Ionichev wrote:
> > ti_eqep_probe() enables runtime PM and takes a reference manually,
> > then returns directly via dev_err_probe() if devm_clk_get_enabled()
> > fails, leaking the runtime PM enable and usage count.
> 
> > v2 tried to
> > route that error through a manual cleanup label, but mixing a
> > devm-managed resource (the clock) with a manual pm_runtime unwind
> > is itself wrong: the devm clock release runs after the manual
> > unwind, in the wrong order.
> 
> It sounds like unneeded detail (because started with what v2 did, which
> is part of rather changelog or cover letter). Perhaps we may rephrase
> that in a way that "Manual cleanup via goto will mix the managed resource
> allocations and unmanaged that leads to a wrong order on the release."
> 
> Also note devm-managed is tautology since 'm' is for managed.

Stepan,

Do you have any disagreements with Andy's suggestions? I'll be happy to
merge a v4 of this patch if you rephrase the description as suggested.

Thanks,

William Breathitt Gray
