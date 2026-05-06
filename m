Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A062F25F3;
	Wed,  6 May 2026 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092282; cv=none; b=fDO8ROKig9cQb85U6CU2XMEtZsVaVWNp1lIHTubTuRbVOsIbKY1oZ8uh8RcF9ssxuCZ2+z5V4HP8GTsYk6zkbjLHT/ttb+yI0hjPZYmkOVtXcM22Y4lgrSwZYPE6roj8VK7y3L9LMlP9FRwAEmPWP/tfLMzDqwpIMqd7Gs9d47c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092282; c=relaxed/simple;
	bh=asqF6vXT54zSew34RI2oLujdtMgmd7GrJI3BuKkIidM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQT37rvDAiy1iooUB3SUMV6nE/iW5FDsaBUXtBoHPKxNJS2k0u/IjR2hENbClY2ld+SlSX4BD2Ohf/I7gS3YN5DvBmO64p/l0+VQIaE09jYkGtxIqa5r6b5RQIxP498SRUG7mE4UYSpXrBnNNApnT5YvbuPX9uT9W7T74RoM7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQHMA26+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQHMA26+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5EFC2BCB0;
	Wed,  6 May 2026 18:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778092281;
	bh=asqF6vXT54zSew34RI2oLujdtMgmd7GrJI3BuKkIidM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PQHMA26+nTrTCOiB5AJUQQFXtqsUtRksOArvIIV6jBefxJyySoozSuSuKlJL85jR7
	 4s5wj3jNjuYlaM65dyvye0ao/Y/nOg6KWfpd+spP/Xni+3ggVXWZKzASb+m69XM1NH
	 WrDecl2bD+YbFhdP8ZRQBz6SEfOt6O4l4b0dsPybMxN6csX48Z41UnUhZQofas0ze7
	 0wqNnq7uHlXGWIGoAcv0UXtf7ZkUvZgBSi/1tvEWWBycl7u0R2E6LuM7Hmw/U2NjMa
	 hDlZlFgvYDDCVLzmp9RiftbMo0piPAZ1w/U4dToPZuPfY1iRMCPRY07hvy5Mq+goby
	 39YQwrA8ip/Mw==
Date: Wed, 6 May 2026 19:31:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Maxwell Doose" <m32285159@gmail.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 <songqiang1304521@gmail.com>, "David Lechner" <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 "open list:PNI RM3100 IIO DRIVER" <linux-iio@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
Message-ID: <20260506193113.77f25df6@jic23-huawei>
In-Reply-To: <DIBP7X7GR2EW.15FM732PJ1WOX@gmail.com>
References: <20260430124148.11572-1-m32285159@gmail.com>
	<afNR1Apx86FeAcKd@ashevche-desk.local>
	<CAKqfh0FrKeAL7+guUMmsvm3EkjFZjEUXQUMHk=x9adU+ZWv1eQ@mail.gmail.com>
	<20260505134538.73b5fec5@jic23-huawei>
	<CAKqfh0FNGsudG4B_VOv0nVa8qjZe03tzBEFkeebr-VY84syh6g@mail.gmail.com>
	<20260506154347.19e7d68f@jic23-huawei>
	<DIBP7X7GR2EW.15FM732PJ1WOX@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 06 May 2026 10:28:29 -0500
"Maxwell Doose" <m32285159@gmail.com> wrote:

> On Wed May 6, 2026 at 9:43 AM CDT, Jonathan Cameron wrote:
> > On Tue, 5 May 2026 12:05:11 -0500
> > Maxwell Doose <m32285159@gmail.com> wrote:
> > =20
> >> On Tue, May 5, 2026 at 7:45=E2=80=AFAM Jonathan Cameron <jic23@kernel.=
org> wrote: =20
> >> >
> >> > Applied to the testing branch of iio.git with that tweak.
> >> >
> >> > Thanks,
> >> >
> >> > Jonathan
> >> >   =20
> >>=20
> >> Hey Jonathan, I just noticed that I made a mistake in the commit
> >> message, it says "Add new helper-wrapper function
> >> rm3100_guarded_regmap_bulk_read()..." when it really should be "Add
> >> new helper-wrapper function rm3100_regmap_bulk_read_locked()..." I'm
> >> unfortunately not in a position to fix it myself since I'm away, but I
> >> just wanted to point it out so it could be fixed. =20
> > fixed up. =20
> >>=20
> >> best regards,
> >> max =20
>=20
> Gosh, I'm so sorry to keep bothering you, but I noticed a stray change
> here:
>=20
> @@ -7,7 +7,7 @@
>   * User Manual available at
>   * <https://www.pnicorp.com/download/rm3100-user-manual/>
>   *
> - * TODO: event generation, pm.
> + * TODO: event generation, pm.da
>   */
>=20
> wishing vs code would quit messing with me,
> max

Doh.  That wasn't there in the original so I must have messed up.
Good spot.

Fixed up.

