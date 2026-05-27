Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676A31ED83;
	Wed, 27 May 2026 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779918746; cv=none; b=aXPuQhCqy6JhQMA8/DJ9GVi/ERf1eU85w1B+UkO5uK4Zgk3v6VxEQuZGRzZXF/Vz25KaBg+02q3mpDcswhxJgk2jhmlNQ9R5ofd+bT96vHoL22inA5I1rcVKkAt5dn7g0qobCYo0pLjrIiKfiATIp+P/v1D5f7P4NPKZKaakdic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779918746; c=relaxed/simple;
	bh=l1TI7slc1KwO5ZU4AjUoek5nkzdE+oZZgCK3UwUpkFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEgY8CTujFAsw2Nav0FRP5JkXQLJvu58C47CLK616etd+1NZek3UmYxt+3e+YlMiECosxlEbve/+LhcMVSBraGs3pl+6LzZVlOYkxpysU9Y6v0OCvIvK0IgqdNYhCKgHZiQJ86Q9Tp9Ap20faquRDTAvM4QHF/8jehagqUP38k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icnd6lgv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icnd6lgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E801F000E9;
	Wed, 27 May 2026 21:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779918745;
	bh=3JD+sRzAfiqLzSDOVCQCx+DS6FsbNsgq+YwT4VN58Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=icnd6lgvQ7QSQCwWmzX5VkoEZEfxBHjnG2xQkn0/D8wkog7MLyBUX0LhFs7k3jpk+
	 38QEpA9/nQmAWsdDHOOFbEKph/33O6KuLKIQqup/Mem+vT82dATA+5jVcpleToXrDY
	 vXAufKfpTz0SQpWn2bPiR+5CnAd5+L+z56MUG460/04pz2B7V6+s+7tQwqiPPhwbEq
	 xm2BpELt3aTuEfkReqkQcf1+g3JLdHEI61Yhfmon2YHU889Hl5fgVBJpG7vnz+eK7b
	 bGUNp7n915bTEgViwbIxd4JtaOVbfjLeZXg9pnsYDyYvXfM1WfSVzJBeC/x9GRy/fh
	 NCMrTilrHAspg==
From: William Breathitt Gray <wbg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	patrick.havelange@essensium.com,
	peng.fan@nxp.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org
Subject: Re: [PATCH v2] counter: ftm-quaddec: use devm_mutex_init()
Date: Thu, 28 May 2026 06:52:18 +0900
Message-ID: <20260527215219.508476-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527175758.7d65e9fe@jic23-huawei>
References: <20260527175758.7d65e9fe@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=wbg@kernel.org; h=from:subject; bh=l1TI7slc1KwO5ZU4AjUoek5nkzdE+oZZgCK3UwUpkFg=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFni6XUla9UKbs2daLV1glWnxmy3PZK697PPb2N82ZB7l MNjacj1jlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAiYg6MDGdmqE1w6Xh3Yr3S 7x93pn8KYZNa+bSl0a0ocsE64323CxgZ/tec62RIMbqhaXi8bHHTd6tP/6pPNUvdvdg/SW3O0u7 WK+wA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Wed, May 27, 2026 at 05:57:58PM +0100, Jonathan Cameron wrote:
> On Tue, 26 May 2026 12:24:25 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > On Mon, 25 May 2026 at 17:14, Stepan Ionichev <sozdayvek@gmail.com> wrote:
> > >
> > > ftm_quaddec_probe() calls mutex_init() but neither the cleanup
> > > action nor a remove callback issues a matching mutex_destroy(),
> > > which leaks the lock debug state when CONFIG_DEBUG_MUTEXES is
> > > enabled.
> > >
> > > Switch to devm_mutex_init() so the mutex is torn down in the same
> > > devm scope it was set up in.
> > >
> > > Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")
> > > Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> > > ---
> > > v2:
> > > - Add Fixes tag and note that the leak only shows up under
> 
> It's not a leak as such. All that happens is the 'magic' pointer embedded
> in the lock is not set NULL. No memory or counters or anything like that leaked
> in current mainline where the implementation with CONFIG_DEBUG_MUTEXES is
> 
> void mutex_destroy(struct mutex *lock)
> {
> 	DEBUG_LOCKS_WARN_ON(mutex_is_locked(lock));
> 	lock->magic = NULL;
> }

What is the purpose of the magic pointer? Is it just informational, to
catch instances where any attempt to use the mutex occurs after the
device memory is freed for example?

William Breathitt Gray
