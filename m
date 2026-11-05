Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885053;
	b=jqsgAMuofVRCxWa7m6PTsL7UUkulafa4jIIKTDo/b46bwLmiK+q672ycN2NJNaVvaAJs
	 g85w0E1LXgd7uhuMcOBCuhOL5d7qDi9DgK4sLJ0Dca5YSyVMIcM6BwwrasW+fhKLOdlNK
	 jAFvKKefQ+Dm2yMJ0iDdj9jdku8m4AztTNQg1ULUnclziZls6wbNcwDxGMkWfzA+GTshu
	 DiICDzgWOepGNeTmyP4saakEl+Op4bv3IIqyFqrKwm9y4d6I4/b8vYHFcMQFMyhDhLtJr
	 3MgAYZLByIOuh9giTnVcEUWc23YCUs48QexjuVJyQ19kEHhWfkTaNZ9DXJX958Vp/rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885053;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=cr7b357bQF9gcmhhu+T4xYlpo1IDNyxkNJbpgvGxS7k=;
	b=WC+IwIPPh/3T3Ki44sWaozuRXYPRDajAznQa226JhsNuPnjXb7Z27npYFT52uxO+n0S9
	 dTMibUVgsef1fZV7LWlViZ/De8eaPoIyN9niTvuxGcjc0HVIIMALUF8wXobQMBgcIEgaI
	 pbH8V4v8f8OIkJaEftPX6n3raB3FowIinB3ZmCswoJycdc3T1f93Vit2ZYI/Gt7PeKXqG
	 yf8DySk8B92Ph31leupBiikujX6poyw2YlLh2U+EGRpAy+WmfREP1qZ+SuzLigoa1yw5c
	 hK6lTui9tpccLNTUMKJa7lQWC/bgX7EBO1OMLTLR6n0oiPaHjz9scNP9vuy02na3MWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qd0I7Vod;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23528606A328;
	Thu,  5 Nov 2026 13:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23528606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qd0I7Vod
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jL31M2Q9yzKp4M;
	Thu, 05 Nov 2026 14:24:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793885047; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cr7b357bQF9gcmhhu+T4xYlpo1IDNyxkNJbpgvGxS7k=;
	b=qd0I7VodEh/YGmDacD0GpRjBefhw/+7TY4fYCETDCELlDau43W4Iv1ZAtJX5YQM/vD7F/t
	Io2f6fgGc/1F5ghEf/MwbMRYSvhnO23qAWB8qco1mS8wiPuKLqck7hVRtAjv9KvLCpRwsN
	5BDGlkKRIyCWuqV/u+BODFeuOQ9d5alieCuk/+Y6suKKqh7/GA3zAEMoUY4UorCuzThBnx
	RAoCZP1x6JKpPOjnRBqcV4hJHO2lbA1oGvP5u59rPEgEaDAqhk/4utGymk+LRznEokAtCo
	zHJ1rjx+Yg28UFnUB1y5TF6dTQ9YwzaheqekvhLUbhZMsDBU6ghGaQzycEEhCw==
Message-ID: <2fa6e631e133acfc7e7de1b287c8b3983168b1c6.camel@mailbox.org>
Subject: Re: [PATCH 1/3] dma-buf: dma-fence: Add flags parameter to
 dma_fence_init()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tursulin@ursulin.net>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Philipp Stanner
 <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	imagination@lists.freedesktop.org, lima@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-usb@vger.kernel.org
Date: Thu, 05 Nov 2026 14:24:04 +0100
In-Reply-To: <b8179edb-bc59-49af-b8d0-f62e39752f3a@ursulin.net>
References: <20261105113529.1989375-2-phasta@kernel.org>
	 <20261105113529.1989375-3-phasta@kernel.org>
	 <2f377d0f-2760-4465-ac68-b62210b33bd6@ursulin.net>
	 <005b77fd-5bd2-4ae5-a0c0-cff3f1f6c680@amd.com>
	 <b8179edb-bc59-49af-b8d0-f62e39752f3a@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-ID: bba065728d0df46fffa
X-MBO-RS-META: 6r63pcufosrhwuio4jrkztwnqgi8ttuw

On Thu, 2026-11-05 at 12:51 +0000, Tvrtko Ursulin wrote:
> On 05/11/2026 12:35, Christian K=C3=B6nig wrote:
> > Well one advantage of the Linux kernel is to avoid such wrappers. I
> > think having more than one function for the same thing basically
> > just adds more confusion.
>=20
> Sure we can churn if we really want. But as 99% of callers will be=20
> passing 0 it's not even very readable. Another option is variadic like=
=20
> kmalloc_objs so flags can be optional. Anyway, for consideration only.


It has the advantage of forcing the reader to think about whether he
wants 64-bit sequence numbers or not. In Rust-fence, for example, we
completely overlooked that for months:

https://lore.kernel.org/rust-for-linux/20261023175750.2979015-2-phasta@kern=
el.org/


Besides unused flags fields are quite common in APIs. As I state in the
description, this is also for future extensions, see my race-flag (if
accepted) as one potential example.

It could also be used for canonically setting the user-flags, which
users currently do with a manual set_bit(NR, &fence.base.flags;

So I think it's safe to say that it's the right thing for long-term
reduction of churn and maintainability.


P.
