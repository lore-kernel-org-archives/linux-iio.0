Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2A3C457A;
	Sun, 11 Oct 2026 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791718301; cv=none; b=ghdpZSC8tSDHZgyJqcJHiJKIW6DJ5zjZlvvUN+gCzA+qsSXgNgK8JbtTvjR14igFBu0DadWuH+73aPZa/H6LSjMy5BRBqFCc+46ELhuw7r6AE6M4b67xvrHqeC3COCcJSjuHigGCkr1d1pVdLqa9giGnXUbGvLRPaQWR0WVqwE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791718301; c=relaxed/simple;
	bh=tdSqMDB52cJ9C+T1aRzHCu/RSYtrZIETUM4o1f+XbYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAb/vXK8hi+REgqflI+xeJFDL1ekTfA5lJYLKaq3qnr4GPrIAB9QzGs3jwmY+qVhzHJeUyXS+hvi+xnzJDMBlONVF055JIxHrYtf4gwtjL5+EzN96KtHS5+rZ/NzVnWwtT32PPTVW5K42ys0tchQ23sMVFYNiIkyJPIHwHyHbBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqfTzMHF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqfTzMHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DDA1F0089B;
	Sun, 11 Oct 2026 11:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791718298;
	bh=cyzezBk9xTdwskUjQjEuBmAsHkkQ+uNt7mKFZeMsUN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NqfTzMHFdSsdq73snxJcJBUd2IN6Qo65CBH+NyaKQ79MSJSu0jWxQnMmF9Q9nPQ2M
	 QmuwpsRbSnu+6CEP1LrCmrUEw9RnQPc6tSretdw7nv+hn7FJL3oNce5Zz/4bl0TQuQ
	 tD6Dk9M1t6ojOkZoIee7CD1WSXCgugCgCrZADFqfWTeA17S4esRZAHLwM9Qc2c/BXW
	 0Pp/bobBb1Z/PKGtKtkTF9Q4lY0fppWnEpjWAW8buBPcjPsqp1wFojkzNjwGhdZhMY
	 ahxN1meeP4SLFYP2PS/DG7PtP6ILyD9eaR8AB3CowQsfp/I1/WIGLho3KlZV2sx+cF
	 iGIHsxwT9HVfg==
Date: Sun, 11 Oct 2026 12:31:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "jiale yao" <19888972804@163.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, "Takashi Sakamoto"
 <o-takashi@sakamocchi.jp>, "Siratul Islam" <email@sirat.me>, "Maxwell
 Doose" <maxwell@maxwelld.cc>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: kmx61: reject duplicate event disable
Message-ID: <20261011123115.00d77abd@jic23-hlaptop>
In-Reply-To: <1024d805.7930.1a0e722a587.Coremail.19888972804@163.com>
References: <20260925141006.2255067-1-yaojiale02@163.com>
	<araCxIGnZK0zuUSS@ashevche-desk.local>
	<20260927182031.6d490331@jic23-hlaptop>
	<1024d805.7930.1a0e722a587.Coremail.19888972804@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 16:30:02 +0800 (CST)
"jiale yao" <19888972804@163.com> wrote:

> At 2026-09-28 01:20:31, "Jonathan Cameron" <jic23@kernel.org> wrote:
> >On Fri, 25 Sep 2026 17:18:44 +0300
> >Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >  
> >> On Fri, Sep 25, 2026 at 10:10:05PM +0800, Jiale Yao wrote:  
> >> > The IIO core does not filter duplicate writes to the event enable
> >> > attribute. kmx61_write_event_config() already ignores repeated enable
> >> > requests, but a repeated disable request still calls
> >> > kmx61_set_power_state(data, false, KMX61_ACC), dropping a runtime PM
> >> > reference that was not acquired for this request. This can underflow the
> >> > runtime PM usage count and trigger a "Runtime PM usage count underflow"
> >> > warning.
> >> > 
> >> > Return early when the requested state already matches ev_enable_state.    
> >> 
> >> Same comments as per previous patches of the same topic.
> >>   
> >Fixes tag needed.  
> 
> Fixes: fd3ae7a9f21c ("iio: imu: kmx61: Add support for any motion trigger")

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks

Jonathan

