Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD162D8DD0;
	Tue, 16 Jun 2026 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608861; cv=none; b=G8/hVWwqALUszYA7ZsoF/VOUK8eTSKGc539N0cBussNxZF/QXUON0Oz+PvuOzjJs+dWYbrziqlu7qsOi/X2odmb0oCLM2HAHi5XSR9IPDDjq0i/Jo5s26525zuYzTCynbxVQgeJQKTXxNnL9nmqqSxHSXVazYq76M5t3QIl37sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608861; c=relaxed/simple;
	bh=X8T9Tmlqf3XGCnobtfauvJdva1tl6CNngz7OPS+hfgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kls6OLyZ9TbAQnpFmAhW1OAH8vFfnYl+l5mujJ7QILcPTKJVVUFiW50lcqFakqK1sRJCPCA2N6aIocy1alGHIMid+3IxhQyl9VHIh/Jc56GEvAZqRxQAw0MEYMtPhxXAhyCJcqQrd38oh1mvt5SBlL/AOUcdH+DM2pbQvaCuIY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=li8jNUFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="li8jNUFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F3A1F000E9;
	Tue, 16 Jun 2026 11:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781608860;
	bh=c9rCYmQcNWYh6GYSmzGVxgSn2ykLJf9JNCx9twaHgz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=li8jNUFEyjHLFckFDMpqqZccDysxcK+C+3L1GwvUjrW9DniqCp8k0PyQmA9t7HDso
	 zBjwE9/q8AnJykykOUXIL3trcP6UO0SnpL2bvlqvX0PpYZdxO/8EtYvExKDoNWz1Op
	 FzMIZmHISOQF0deJY7gzA+skvIegQO+v/WKMYZhMR/3Ydt0JXVyJzZGaEwyLEDwlD7
	 YQyRYpc45gS8PhPOldpCplHY64l5imN+En43/R318yeHEyZDHC6uC5CqA+m7/j/7hM
	 g6oU+32dpVw+42e0mCsXP71PS6LBHl6jz0MbnRIsIXAXFY6elxQSN+Zl/wzFPgNxyM
	 zXQ/QGaRSZnIA==
Date: Tue, 16 Jun 2026 12:20:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH] lib: math: test_mul_u64_u64_div_u64: define
 div64_s64_rem
Message-ID: <20260616122051.462c48aa@jic23-huawei>
In-Reply-To: <ajD9wGjqFo9UHGed@ashevche-desk.local>
References: <20260615-test-mul-div-u64-fixup-v1-1-ea186d825745@analog.com>
	<ajD9wGjqFo9UHGed@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 10:39:44 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jun 15, 2026 at 04:51:15PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > 
> > Define div64_s64_rem to avoid multiple definition or exports.  
> 
> Thanks for fixing this.
> 
> > ---
> > Recently added div64_s64_rem() is causing issues in a the
> > test build. This could be a fixup patch amended to:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=adebf76278116a06166d0b5f8b4112ad5dd6389a  
> 
> I agree with this. Since the testing branch is subject to rebase on top of
> -rc1, this can be also injected before or during that time.
> 
Smashed into original patch as a fixup.

Thanks,

Jonathan


