Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ACC1E9B35;
	Thu,  7 May 2026 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170199; cv=none; b=WHZaaf9mj6iqGLCFjH840gAj3gOgLYZx2d/W4nMAVXhHwY3Fw53l/1YjDsYbEC/KW2J5exk6itGvROUTRNrVOq3iWriFoR3y9USPvULjFvMQiTJg482jDejVwSyf2HZZ+IegJOr6FkJ03734bCpkGt6HaDX6omOmF9gpJYXY4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170199; c=relaxed/simple;
	bh=M0BeBoEuthrRCQts98ElcpTMr5ZIOo9byw/jwPG2e64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTWRshtqZ7KO0cgG2FDlq40Mj/VmFs9yktwOgCjGcnHGtpusF1u78hCAjqImZVMYbeeDOSn2fGJ+a+dRsFzFKvPSWMnr4EajsVh/gc/kJykHOYbIlrzIolAAY9WD4bStWMgtjvJUkcvJlQzB5Sf3tgFlGs3uEjEpjt5x75pbpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3zT3Sla; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3zT3Sla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD72C2BCB2;
	Thu,  7 May 2026 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778170198;
	bh=M0BeBoEuthrRCQts98ElcpTMr5ZIOo9byw/jwPG2e64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P3zT3SlaKhvVD3aMaAATkT2rkAkSxgAr+uJgGEIk303R8cuh+W73wnOhon80Axf73
	 dJOou9doEnwdRFsX+ESNazC/41awVpKdDwSFB1w77p9nQI7TxzReZulWyqBeeVw00F
	 G1YdnUgBr0ffHfJkz4mZjJoUuJRK6uAZKhmBF7SvzHmniMb0BbKEscEKSvBX9EgFqY
	 g/ccnzVWjnRdFJF91PjhKv3LGU+hxn+8As9oG5lmBpxXlEYPefxN2O3eFvcNnr6qxZ
	 NM7IN8UB92b9iyfqKBapTM7HU3zW+LivcSJWotwLqTq5enltbry72sE/ANtIvCxQRA
	 SUu7vH6Po1+yA==
Date: Thu, 7 May 2026 17:09:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: scd30: orphan the driver
Message-ID: <20260507170950.37a46820@jic23-huawei>
In-Reply-To: <CAKqfh0EZ_Tku4DK1F-J_UNTDzgmKshbOQS889Dpf8sbChm-LrA@mail.gmail.com>
References: <20260506182931.494-1-sozdayvek@gmail.com>
	<CAKqfh0EZ_Tku4DK1F-J_UNTDzgmKshbOQS889Dpf8sbChm-LrA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 May 2026 13:58:46 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Wed, May 6, 2026 at 1:30=E2=80=AFPM Stepan Ionichev <sozdayvek@gmail.c=
om> wrote:
> >
> > The maintainer email tomasz.duszynski@octakon.com bounces with
> > "The email account that you tried to reach does not exist", and
> > the author has had no commits in the kernel tree for years. The
> > driver is in practice maintained on an ad-hoc basis by the IIO
> > subsystem maintainers and contributors who happen to send patches
> > against it.
> >
> > Drop the stale M: line and mark the entry as Orphan so that future
> > patch submitters and get_maintainer.pl no longer try to deliver
> > mail to a dead address.
> >
> > The F: entries are kept so MAINTAINERS still describes the file
> > set covered by the IIO subsystem (linux-iio@vger.kernel.org).
> >
> > Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> > ---
> >  MAINTAINERS | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > =20
> [snip]
> > =20
>=20
> Hi Stepan, Jonathan,
>=20
> I saw this was getting orphaned, and I was wondering if I could step
> up as maintainer. I think it would be an interesting challenge but I
> think I could do it, I've been doing a whole lot of stuff across iio.
> I don't have the hardware but I'd be happy to step up to keep this
> driver up-to-date.
>=20
> best regards,
> max

Fine by me.  It is a reasonably easy to get part so if anything complex
comes up might be worth getting one.  Feel free to shout if that becomes
necessary and you need help getting hold of it.

Jonathan
