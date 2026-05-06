Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6437481AB6;
	Wed,  6 May 2026 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078635; cv=none; b=cm7I293nppo1190qrGgB0WWQC8dqHBYC1FZ92kUeSx0oorjL4WQvmOKIU6oXP5e9TzEBcYL+JL5Gtb3zO/TU440DsQhtoZbdHDlbOxm5C+7l8uSkoQivR+cMAYR0UWLhcoBzT/LLi/XHDXjpyOkB2N3rO8Nsxc/hrdw2sMwBHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078635; c=relaxed/simple;
	bh=EI80t/9t+CfPSVZ84bEGxWR/tM+sFJJ204rI2WjItpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwS/ODy34pzjTKxEevKJYrL+1AQDEgWjM0p/4KziI4Tm4v1fMoJUKa6sxPj6hvPVl6/s3Njr2LtpFr2cJLSl8kc/CDgil6FwjQHK+7lHInDV1LyRts9cYM4VgRRBKzOakKdHZGJ/yFD+7SitnYnf4i8xKUpqEbKJ7/7x1LQ7yZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCrHOiif; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCrHOiif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468B8C2BCC9;
	Wed,  6 May 2026 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778078635;
	bh=EI80t/9t+CfPSVZ84bEGxWR/tM+sFJJ204rI2WjItpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WCrHOiifur/DsnD1aL0ggVsR1HyrDo2895n6RPq6rYiRiS88uX9uCMtNOt6aD69p5
	 IKUUSHhMCT2l1rT9g76Wu0IVyGSSlQA4zZ1gKv7N5i+ndKP7VDsnlpT34uj4l//60B
	 gMM6JBpCjLjflcInCPGGLeqqWpsCZq3fJLweFvFVCdzYc5/QpjI+KEdpFWOrNjQRLN
	 fyw4mOSSsbx5Sxnf7+MUrnr/zxPEYwIWgbtCFIR0Oz0eDUTtTVl3pfPhAHoAt10Lqp
	 l+QeeYRtvrJY6zBhC4VHtfud+NHj8IVAngEWdGO+vk3IQz4eUFMrCcr5Su3BDn2aEs
	 +BHYVePeea8Uw==
Date: Wed, 6 May 2026 15:43:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 songqiang1304521@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "open list:PNI RM3100 IIO DRIVER" <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
Message-ID: <20260506154347.19e7d68f@jic23-huawei>
In-Reply-To: <CAKqfh0FNGsudG4B_VOv0nVa8qjZe03tzBEFkeebr-VY84syh6g@mail.gmail.com>
References: <20260430124148.11572-1-m32285159@gmail.com>
	<afNR1Apx86FeAcKd@ashevche-desk.local>
	<CAKqfh0FrKeAL7+guUMmsvm3EkjFZjEUXQUMHk=x9adU+ZWv1eQ@mail.gmail.com>
	<20260505134538.73b5fec5@jic23-huawei>
	<CAKqfh0FNGsudG4B_VOv0nVa8qjZe03tzBEFkeebr-VY84syh6g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 May 2026 12:05:11 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Tue, May 5, 2026 at 7:45=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > Applied to the testing branch of iio.git with that tweak.
> >
> > Thanks,
> >
> > Jonathan
> > =20
>=20
> Hey Jonathan, I just noticed that I made a mistake in the commit
> message, it says "Add new helper-wrapper function
> rm3100_guarded_regmap_bulk_read()..." when it really should be "Add
> new helper-wrapper function rm3100_regmap_bulk_read_locked()..." I'm
> unfortunately not in a position to fix it myself since I'm away, but I
> just wanted to point it out so it could be fixed.
fixed up.
>=20
> best regards,
> max

