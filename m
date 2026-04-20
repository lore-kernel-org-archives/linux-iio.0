Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA993368B2;
	Mon, 20 Apr 2026 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697043; cv=none; b=b7mjmISCI9f2mPsWOjtPcXgXOnrF8FFkMt5rvJ55WB5VmX5Ny29epjGw5iNvxbYGp56Xp//GEHCYA1gUWIOo6ytG1+sD6LMBbw9r4ZF7DdwMSgroD0WtZxPVhW5IZOwUTZc5cxd+dr/yelclLJlR7IRBcFQUuOMDvnYvc/mzGt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697043; c=relaxed/simple;
	bh=I24Qq1ph8NsV0u92+8v1+IBInIKbAakPbHjOMJMA/A0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4B1Dt4XPdJUzCBudfC6r32pa5MsPRvnaFyruu4F69+tD4rbyOBgZnoaC4+RXQ6w521EikRIMRvK/Tst8G8ybSNAPb9Ro20UyT/cISa192Hcpa8m8rMUb6o2CsFLf0pFgBevQmKtkTwlCslZ506LoozseF373Ha7mi+b6oXARAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi1Jji7H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi1Jji7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442CCC19425;
	Mon, 20 Apr 2026 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776697042;
	bh=I24Qq1ph8NsV0u92+8v1+IBInIKbAakPbHjOMJMA/A0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bi1Jji7HBtHjG+5jAywMAoR24PshU1c1Rp5OOqzQoyrzjdzxssDxjDi/ahZjqS13t
	 EGZEQAgFPf3xcX10QMSEJMEmgYkqi0l4vukp5Yl5uTOeDaw7szi047IgyPlSHg5tHZ
	 KfqCNCc0NvbMzrchGd1A5wIZa5uaqTjn1M+rOJwAAkW/xGriWq8W5Ev6ee96cuSKbQ
	 gC4JkNIn49mFHhqBd51RN/Wj7ADj3Xz/Ulm4/iIVZrV3nxSLL5KOn8tkL8R/J5p9XX
	 JRKFNmf8KXFKkHxGrhO+q9/KH8JJ5nEou7+Cr9eVp/z5FKx0ImO/8eQHrjlv5UXUnO
	 swYaaPmM4E6bA==
Date: Mon, 20 Apr 2026 15:57:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Jonathan Cameron 
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, James Nuss <jamesnuss@nanometrics.ca>
Subject: Re: [PATCH] iio: buffer: Fix DMA fence leak in
 iio_buffer_enqueue_dmabuf()
Message-ID: <20260420155713.18c30f12@jic23-huawei>
In-Reply-To: <5fcda84716176de70b6ff968458ee4e4101b36ad.camel@crapouillou.net>
References: <20260401-iio-dma-fence-v1-1-40993adbfa96@bootlin.com>
	<5fcda84716176de70b6ff968458ee4e4101b36ad.camel@crapouillou.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 01 Apr 2026 18:16:10 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Beno=C3=AEt,
>=20
> Le mercredi 01 avril 2026 =C3=A0 17:24 +0200, Beno=C3=AEt Monin a =C3=A9c=
rit=C2=A0:
> > iio_buffer_enqueue_dmabuf() allocates a struct iio_dma_fence (104
> > bytes,
> > kmalloc-128) via kmalloc_obj()+dma_fence_init(), which sets the
> > initial
> > kref to 1.=C2=A0 It then calls dma_resv_add_fence() which takes a second
> > reference (kref=3D2), and stores a raw pointer in block->fence.
> >=20
> > On the success path the function returns without calling
> > dma_fence_put()
> > to release the initial reference, so every buffer enqueue permanently
> > leaks one kmalloc-128 allocation.
> >=20
> > The iio_buffer_cleanup() work item only releases the temporary
> > reference
> > taken during completion signalling by
> > iio_buffer_signal_dmabuf_done();
> > the initial reference from dma_fence_init() is never released.
> >=20
> > With four iio_rwdev instances at 240kHz and 512 samples per buffer,
> > this produces ~1875 kmalloc-128 allocations per second matching the
> > observed slab growth exactly. A test with ftrace confirmed that the
> > dma_fence_destroy event was never triggered.
> >=20
> > Fix by calling dma_fence_put() after dma_resv_add_fence(),
> > transferring
> > ownership of the fence to the DMA reservation object. The DMA fence
> > then
> > gets properly discarded after being signalled.
> >=20
> > Fixes: 3e26d9f08fbe0 ("iio: core: Add new DMABUF interface
> > infrastructure")
> > Originally-by: James Nuss <jamesnuss@nanometrics.ca>
> > Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com> =20
>=20
> I had a look at the code and indeed, it looks like it's not releasing
> the dma_fence properly. The fix makes sense.
>=20
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Applied and marked for stable.=20

Thanks,

J
