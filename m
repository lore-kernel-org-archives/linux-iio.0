Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87BC282F2A;
	Mon, 21 Sep 2026 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789960805; cv=none; b=BtsqfmSVlgsulUMQAxh1coob92NzziG4M2WFpXW/dHdbqGzvh05n6sj4aqhmCh4YOFdw30Use69EioIuR9tbfk90jsT5KgXIL8cqUCtZgIcO5ZoUWw+ICLZtVYpsqK3/L+xs2O32M/4GQtjiZ52AuGcMR0WJ+mm9rPAkrlgShS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789960805; c=relaxed/simple;
	bh=rPGGIOpZ59OynQeltp2E3fFxaKxBAZF815TMqu6Cllg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfAIlb6BevizjwT+9a+EX9PxnuH/JJt1Zs1sYgiK3UBtB22zfVoIS27YjWJLLbbZD+sBSSUfn4GOtQz8ivnHeR+xmaiiF8s2fhBFIOTj/pS30tms+OEpuk9UQ0VRdBjOXU7cR/BJfpDObIORe8O+hb6ztlZH3GEXBYI27omuJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HivVIxTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HivVIxTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21FC1F000FF;
	Mon, 21 Sep 2026 03:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789960803;
	bh=Ftm1F7j/THscrEYnzHViiTYpJfj7RcigXEN1nosu8yo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HivVIxTq2MMtYaIVCxBKQm+UGZYNJ9jCeDikaISe3iSmciCiwtRgQk/XNNXm1DdDM
	 S6xjHt2catrroO94Tdki3zVplNEqAMFOJalZywfeP/YH0SLtKWCE6pj6kFprhmFkij
	 l/gHX3YpTMMQwb7LYTWd+uuYH0Xrf1P5LijVRw8+dih1i4Z+EBXOXm/DSlY3IYIdXO
	 CMqZuV0spYwZVwuV4VNDphfMyo6XYPuWodYIHTLozZU565C8B8LiHcLgkOPSje6Qk4
	 vSSzMWlTC5qqkFy2ajaOJ+klskohW0wGcip/kBe8UHdrEqmZn41SFZ/Za6hcUEtH3/
	 YAFc+HN29ZVLw==
Date: Mon, 21 Sep 2026 04:19:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Maxwell Doose <maxwell@maxwelld.cc>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Li Youhong <dayou5941@163.com>, Li Youhong
 <liyouhong@kylinos.cn>, Brendan Higgins <brendan.higgins@linux.dev>, David
 Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 0/2] iio: flow: slf3s: fix and test the vdd supply
 balance
Message-ID: <20260921041957.25b97f64@jic23-hlaptop>
In-Reply-To: <20260904-iio-slf3s-pm-regulator-kunit-v1-0-5ea61e6d6db2@gmail.com>
References: <20260904-iio-slf3s-pm-regulator-kunit-v1-0-5ea61e6d6db2@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Sep 2026 21:24:24 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> Li Youhong reported that slf3s_resume() leaves vdd enabled when the
> measurement restart fails [1].  The report is right, but the patch and
> my own Reviewed-by on it were both too narrow.
> 
> Andy asked whether the regulator refcount can go sideways here.  It
> cannot.  device_suspend() sets power.is_suspended only when the callback
> returned 0, and device_resume() returns before the callback when the
> flag is clear.  So the two alternate and the count stays in {0, 1}.
> Please drop my Reviewed-by, the reasoning in it is wrong.
> 
> Three things do go wrong though:
> 
>  - resume enables vdd, start_meas() fails, the supply stays on.
> 
>  - the part is then powered but idle, so it NACKs the stop command.
>    suspend() returns early on that error and never disables vdd, so the
>    system cannot suspend any more until rebind.  This one hurts most.
> 
>  - if regulator_enable() fails in resume, the next suspend disables a
>    supply that was never enabled: "unbalanced disables" in the regulator
>    core, and -EIO.  Unbind hits the same case.
> 
> The original patch fixes the first one only.
> 
> Patch 1 tracks the supply state and drives enable/disable from it.
> Patch 2 adds KUnit tests with a fake i2c adapter and a counting
> regulator, so no hardware is needed:
> 
>   ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/iio/flow
> 
> Four of the eight tests fail without patch 1.
> 
> [1] https://lore.kernel.org/linux-iio/20260901025010.356735-1-dayou5941@163.com/
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
Given a few outstanding bits on patch 1 and lack of discussion of patch 2
(which doesn't need to go in as quickly) I am marking this in patchwork
as changes requested.

Thanks

Jonathan

> ---
> Wadim Mueller (2):
>       iio: flow: slf3s: keep the vdd supply balanced across suspend/resume
>       iio: flow: slf3s: add KUnit tests for the PM regulator balance
> 
>  MAINTAINERS                    |   2 +
>  drivers/iio/flow/.kunitconfig  |   6 +
>  drivers/iio/flow/Kconfig       |  15 +
>  drivers/iio/flow/Makefile      |   1 +
>  drivers/iio/flow/slf3s-kunit.c | 734 +++++++++++++++++++++++++++++++++++++++++
>  drivers/iio/flow/slf3s.c       |  35 +-
>  6 files changed, 787 insertions(+), 6 deletions(-)
> ---
> base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
> change-id: 20260904-iio-slf3s-pm-regulator-kunit-43ee079b36f0
> 
> Best regards,

