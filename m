Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274813A8741;
	Wed, 27 May 2026 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901085; cv=none; b=j2vMyhtJkFql/W4VQPxo6iyR0JfKG4NzBeP2t54D+vIld2xKoOxz2Lx0a4hq4HTSDfhGqujHljlRDXppszZQcyZGPfL0pfotwDjB+gBqoaZsY4x1TVAU+U4CY9oo2jutYeUoORfzu8ewuieJJwvWUh0NQHgseTQEu58FICu0jy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901085; c=relaxed/simple;
	bh=2PI16Ws9WSXYHmzhu350blCXNC0ZGfDBSTMBTJBaY7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hjd99hHeThAu7auf2EuFaXZctK9JcNn00HubI9VO17YmGh5qIpTZ54LD93de+478Ou562peANHIvsi0jptjBSEFXfjoav8gg3PhEeFFNZQ5FTVIK1qt5sSws2MRYAYDYMac9ZgK/bfoXU35bSeZn8ibscW2//ossJFN7QYeJqcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C98+2jD6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C98+2jD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCE71F000E9;
	Wed, 27 May 2026 16:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779901083;
	bh=J8UFoMiTfbdoIFTlICrbsQ1qAzwzc/9qZx1io1tT72o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C98+2jD6VIaS73OtZfyPUAdXqW0C286kgatAQzEDvdwwnih+tIMcZmMQUNWtcfDGs
	 K0ybFnLJdk2RKxq4LxKFECTV6fnXj+BdI/cerlllju7b269doz4eubq2FplYwpITPa
	 FYdQ8d2TLdIDXmvWsdsDL8inYdm6srMu9cS4mH6HDEBH5xgZTY90vH4D08sJtZPYxE
	 /OjKdOb73vrclmny05bNTVVKNkcDjOx7W2oG4eS6Lp7FYsU0vMJQb8BO1/TrNTaK7J
	 PQK2dfLnNWacZWStp+8+1yPpBSKYRKDnVHNxV52K/IJg5xKB7O9yydLskLkdv6WTEb
	 6o8+9fkzJodXw==
Date: Wed, 27 May 2026 17:57:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, wbg@kernel.org,
 patrick.havelange@essensium.com, peng.fan@nxp.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, andy@kernel.org
Subject: Re: [PATCH v2] counter: ftm-quaddec: use devm_mutex_init()
Message-ID: <20260527175758.7d65e9fe@jic23-huawei>
In-Reply-To: <CALoEA-yfG6TvhpR7hWq4wfY3Eznys7K0-ee54H=0NWGu5VJ0Gg@mail.gmail.com>
References: <20260525151240.7258-1-sozdayvek@gmail.com>
	<CALoEA-yfG6TvhpR7hWq4wfY3Eznys7K0-ee54H=0NWGu5VJ0Gg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 12:24:25 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 25 May 2026 at 17:14, Stepan Ionichev <sozdayvek@gmail.com> wrote:
> >
> > ftm_quaddec_probe() calls mutex_init() but neither the cleanup
> > action nor a remove callback issues a matching mutex_destroy(),
> > which leaks the lock debug state when CONFIG_DEBUG_MUTEXES is
> > enabled.
> >
> > Switch to devm_mutex_init() so the mutex is torn down in the same
> > devm scope it was set up in.
> >
> > Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")
> > Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> > ---
> > v2:
> > - Add Fixes tag and note that the leak only shows up under

It's not a leak as such. All that happens is the 'magic' pointer embedded
in the lock is not set NULL. No memory or counters or anything like that leaked
in current mainline where the implementation with CONFIG_DEBUG_MUTEXES is

void mutex_destroy(struct mutex *lock)
{
	DEBUG_LOCKS_WARN_ON(mutex_is_locked(lock));
	lock->magic = NULL;
}

> >   CONFIG_DEBUG_MUTEXES (William, applied from the interrupt-cnt thread)
> >
> > v1: https://lore.kernel.org/all/20260523184351.7567-1-sozdayvek@gmail.com/
> >
> >  drivers/counter/ftm-quaddec.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> > index c47741292..8455f16d6 100644
> > --- a/drivers/counter/ftm-quaddec.c
> > +++ b/drivers/counter/ftm-quaddec.c
> > @@ -292,7 +292,9 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
> >         counter->signals = ftm_quaddec_signals;
> >         counter->num_signals = ARRAY_SIZE(ftm_quaddec_signals);
> >
> > -       mutex_init(&ftm->ftm_quaddec_mutex);
> > +       ret = devm_mutex_init(&pdev->dev, &ftm->ftm_quaddec_mutex);
> > +       if (ret)
> > +               return ret;
> >
> >         ftm_quaddec_init(ftm);
> >
> > --
> > 2.43.0
> >
> >  
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

