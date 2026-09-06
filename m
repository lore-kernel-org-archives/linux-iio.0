Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8DA3597B;
	Sun,  6 Sep 2026 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788731375; cv=none; b=MDsFgY7VOvcVeKL0o6sGNimYds0DUgyEhr3xhnU7EuS7WRcnAzXUO5X5BRE+QYaGIM7LHvbANevL1SqQLDIYycLITJJN+lqfV09F4tZoKSIytQYNLi08CR7WktxQ3QbKB13rRsEIQzke3XBsh7hvcuxQY87DLSTNGIFKJAX3QaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788731375; c=relaxed/simple;
	bh=cuU/hElpIzA7Qxsh1V2fz3N1ouPtc/bKe2SbtVduYtU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIiQhI64U9wS/ZkU96rd0DX0HfUgsnoO0MpNU9l0cqyAE9ojJzoG3d8knJwkjLZuzqkMOBVHjpNJ+XmSvWW/+R2WqNpxOjinjbFUjYBcypb6sVhjJGsR9vJLJ8WorU10V7G7/sRIO0/JOJzxVcRgw8BXudxJlfA00H9uJnB5yyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2YEIPJg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2YEIPJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56221F00A3A;
	Sun,  6 Sep 2026 21:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788731373;
	bh=crhmRGN8S5XLwNGGPtLnqk5m7s26sqJwFP1ACxGf/2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L2YEIPJgqBuZASCrkGiXJE6pw6Q5HMjkrY7JP1Ar2LfJCsYOzjkLdcs95RP6zTIx7
	 iwSPIZ1tdTyt/O3plvCpOKL86pQV+cIWy/tiJKEujOme12cb030wqitHmRU4pG2cvp
	 31fCoUJfOold3kq/Paq01H0XvujXc87XqOEy3O9mswZcKhXkM5WsaXdCbZwhufLE5j
	 Q6I7fMbeA8Mqyvy08rcnJqfOFnn6Z78nVuV4QutJpDnPiLUseHl5OA911pGZ4knSlf
	 RwDPJFUu/pKnQzaLMQ/RTHn6wqVUZFUrlI6sraYQgcDzQ5pg7OnqMiKIsn5q7j+WE2
	 93HjOEB4f35yQ==
Date: Sun, 6 Sep 2026 22:49:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Tuna =?UTF-8?B?S8SxbMSxw6c=?= <tuna@tunakilic.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: dac: mcp47a1: Allow full-scale output
Message-ID: <20260906224928.4e24cb8b@jic23-huawei>
In-Reply-To: <20260906214420.580dec27@systembl0wer>
References: <20260906045428.4f03494b@jic23-huawei>
	<20260906090802.1282585-1-tuna@tunakilic.com>
	<20260906185942.595251a5@jic23-huawei>
	<20260906214420.580dec27@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Sep 2026 21:44:20 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun, 6 Sep 2026 18:59:42 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Sun,  6 Sep 2026 09:08:06 +0000 (UTC)
> > Tuna K=C4=B1l=C4=B1=C3=A7 <tuna@tunakilic.com> wrote:
> >  =20
> > > > If AI had anything much to do with generating the patch then
> > > > a tag for Assisted-by: LLM is appropriate.     =20
> > >=20
> > > AI was only used afterwards as a sanity check for the datasheet,
> > > in_range() semantics, and the final patch. The bug and fix came from
> > > manual review.   =20
> > Ah fair enough then to not add a tag.
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> > >=20
> > > Thanks,
> > > Tuna   =20
> >  =20
>=20
> Hi all,
>=20
> sorry for the testing delay, did some light travelling this weekend
> and didn't have the hardware with me.
>=20
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Tested-by: Joshua Crofts <joshua.crofts1@gmail.com>
No problem at all!   Thanks for following up.
Patch applied and marked for stable.

Thanks,

Jonathan

>=20

