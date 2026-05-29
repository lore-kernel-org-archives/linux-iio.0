Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410835B634;
	Fri, 29 May 2026 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780020515; cv=none; b=LjP8mDrTx/x1a8gOUuBmgKB7Tdt2/7BUk6vInwYwFhAWFen1gA9ovTs+H3I1rV7vCKam7mzEALQyWUm7KHBZBL7DOQJ6IgtslfB4F1TN4zgL7uGoP18fnrvPRFpkxx33Oj7VHX73WnVfBctW5b9kM/k0oJ0o2qirLVj6VpDP5T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780020515; c=relaxed/simple;
	bh=kEzW8hT8wQFiBZknHN+TOAuUrnTCN1XX/ZwyChu1vLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnqBpOZRotT7A6LJb4KJmn6DnenSOjG1tPnZ87LAMVdAKtnVeiaFNq3PT2bkt1CVq4WLWqJG3xBy6sKjcSiPfSyFI6mkDuuSbgDnLaEkIPGbDPn5yXZEGrirYBGy+pMJXJdlJiTdt/CoCOu/kHkXjnTRcU6cgQiz0Yy+A9Ylb/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4mIppbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4mIppbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F031F000E9;
	Fri, 29 May 2026 02:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780020514;
	bh=ETMQPjncFlckJ5YgQOSifPV4HhJj2LTIMcT33lWzNY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O4mIppbNxNzZAIfoXT6X5EQTDqLLcHe2vii0tXdfrp24vXyHzLBe2MDPmrD9WyvZ3
	 yRm53J+GCHK/Vt0CEJqmFgcL+tAv5WSWoNWRuGZlZ2fUbtGE0ABbgYYdYnF+aIJjKl
	 F6FUQyIlDuDjiO2hCpDxwRXak7Hrdt2Dla5lqE90sgPJhdj8JprHOC/j6iMNHx8Fhy
	 jO5FpWUaq3VJXMIpbqqrKoPOyC0o8Lwjf2Enib7BLXyQhGsGFfKn0AsJrlPRczQadb
	 ZHKSWCh3KJ449yJWIc45yHh1Aih3nbUZB6/mSTsk+lISEKI/Fvc5S9AgfCjuwMxrMS
	 rYU9w6vakCxLg==
From: William Breathitt Gray <wbg@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	patrick.havelange@essensium.com,
	peng.fan@nxp.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org
Subject: Re: [PATCH v2] counter: ftm-quaddec: use devm_mutex_init()
Date: Fri, 29 May 2026 11:08:28 +0900
Message-ID: <20260529020829.613952-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528140745.033560d6@jic23-huawei>
References: <20260528140745.033560d6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2016; i=wbg@kernel.org; h=from:subject; bh=kEzW8hT8wQFiBZknHN+TOAuUrnTCN1XX/ZwyChu1vLw=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFkSX5l0Nm7YcbE9eXuo1utft2zaOFP//tUI6nzlw7pgo Z55NZ98RykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCR54sZGdbWpK0O/Pwycuoj 9yccV8sesded+R94pXr3NQ7mF6/6b2gzMsywLf2xyESvNCL9wHyn17q/JIU7ZhxfWfzt0hHlJ1e msXMBAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Thu, May 28, 2026 at 02:07:45PM +0100, Jonathan Cameron wrote:
> On Thu, 28 May 2026 06:52:18 +0900
> William Breathitt Gray <wbg@kernel.org> wrote:
> 
> > On Wed, May 27, 2026 at 05:57:58PM +0100, Jonathan Cameron wrote:
> > > On Tue, 26 May 2026 12:24:25 +0200
> > > Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> > >
> > > > On Mon, 25 May 2026 at 17:14, Stepan Ionichev <sozdayvek@gmail.com> wrote:
> > > > >
> > > > > ftm_quaddec_probe() calls mutex_init() but neither the cleanup
> > > > > action nor a remove callback issues a matching mutex_destroy(),
> > > > > which leaks the lock debug state when CONFIG_DEBUG_MUTEXES is
> > > > > enabled.
> > > > >
> > > > > Switch to devm_mutex_init() so the mutex is torn down in the same
> > > > > devm scope it was set up in.
> > > > >
> > > > > Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")
> > > > > Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> > > > > ---
> > > > > v2:
> > > > > - Add Fixes tag and note that the leak only shows up under
> > >
> > > It's not a leak as such. All that happens is the 'magic' pointer embedded
> > > in the lock is not set NULL. No memory or counters or anything like that leaked
> > > in current mainline where the implementation with CONFIG_DEBUG_MUTEXES is
> > >
> > > void mutex_destroy(struct mutex *lock)
> > > {
> > > 	DEBUG_LOCKS_WARN_ON(mutex_is_locked(lock));
> > > 	lock->magic = NULL;
> > > }
> >
> > What is the purpose of the magic pointer? Is it just informational, to
> > catch instances where any attempt to use the mutex occurs after the
> > device memory is freed for example?
> More or less. In some cases the mutex life can be less than the structure
> containing it.

Stepan,

I think Jonathan is right, so I'm going to drop the Fixes tag for this
one, and pick up as well the original revision of your interrupt-cnt
patch without the Fixes tag. Sorry for the noise.

Thank you,

William Breathitt Gray
