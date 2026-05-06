Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADAF2459DC;
	Wed,  6 May 2026 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085388; cv=none; b=X5Y7k2pb5ig0jCiIgHs6VHJyqCOHLDBeZGEKf07IK1E6GioDEiGOxxDaUcJiu+elgSHN1qBn8P5t78E5D+M0zj2xYU4zol6HfUmE15DNyft540liJrr8QoZxlCsABYrAa4wR+Zpz/ElOHkR57fVZ2FuAe0G21IHR5c9Ga7rRIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085388; c=relaxed/simple;
	bh=K6SMr5oQjG1Sb6WGHxXPFrlTXZk0fm3HpLmYiRw5UTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQn6+zZF6vPD+U4+M5cFCvRYe8M9Tf6Ueft8Ry0S2d5b8pejx6rq7vtFoSbwDV+Dimm8sK7FbraYj274ffDA0IHgoQDoE6Hn0+bYRtjQEY96LcIfiYQleGS17q8aMI3njsQOiU6kjH9+8UNr8Lj840MRmaQMFTuv4CSfRrCZipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlnbdTDo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlnbdTDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B40DC2BCB0;
	Wed,  6 May 2026 16:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778085388;
	bh=K6SMr5oQjG1Sb6WGHxXPFrlTXZk0fm3HpLmYiRw5UTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZlnbdTDoE7UfX651sPW8zk9WnVSXx5uO3kkdjkynqORpRGiq0c7C5QkFeCMHwWnen
	 RIhPP7uKG7Qzz9AxCgU0zwWWMwVAtU9XqC/IOwc4rwuCBdpWSoVLMgDJds8fsSt0uM
	 GiaRZLYL5I12YHb1AeCPc4BAwSUESmpNlhgZby3aP1BOMRMkagHGGMkJzs0pSkDbls
	 zWpqsK3Y35L4FFVBbMVKdpQYZMSPYf5NwJ7SlNot/vQp/sE+ewSKkHzKSZrA3LA1kh
	 ENuPUoJ/b6mi5BxW69Q29Ntm24ewuQu7CRIo62fikt7JfusFFjOwwevCPKm+mcYZPL
	 NdJkXuWRU5ePg==
Date: Wed, 6 May 2026 17:36:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/18] iio: magnetometer: ak8975: sort headers
 alphabetically
Message-ID: <20260506173619.25baa71a@jic23-huawei>
In-Reply-To: <CAKqfh0GaEmCcHb6pMiJ6rBNMmhMJomN7KCzOw05sOE2ksBeqqg@mail.gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-1-831b9b5550fc@gmail.com>
	<CAKqfh0GaEmCcHb6pMiJ6rBNMmhMJomN7KCzOw05sOE2ksBeqqg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 May 2026 18:46:15 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Tue, May 5, 2026 at 6:46=E2=80=AFAM Joshua Crofts via B4 Relay
> <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
> >
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Sort include headers alphabetically to improve coding style and
> > readability.
> >
> > No functional change.
> >
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/iio/magnetometer/ak8975.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > =20
> [snip]
> > =20
>=20
> LGTM.
>=20
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
>=20
> best regards,
> max

Too many patches floating around so I'm going to pick up
the start of this series at least.  Applied this one to the
testing branch of iio.git.
