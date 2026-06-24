Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074E1FFC48;
	Wed, 24 Jun 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322467; cv=none; b=gGzhH5wVxsmdHbFxVAyh5W0uQTdNE0dqhevMW5rY7dQMmEVLWl+HGOLhGXl2hdqc7E82025+3wGrvI/3/k7oXQblE9G4q5IUQqkxvxlychihxppz+zOB2Tte5tie+I/ZXQAg/q+jcoTQNeUU4eaOkH9JCHwMeZhNULkvh++/TV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322467; c=relaxed/simple;
	bh=b17eIvt24Zmihpai4+HJm+Spij9I7I8QVyO+Qv2eG4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8Ul24uekvYNRm9ALnKbNdkv9DKr+0CQAKoqvj6Iei3EaA5Cs55xWYLw2th9VqTUU9tfXXd0HynWJRMx9UlOInzjX++6/RTlV/7oztJdBRSDOWZB4MeWw/DXMxZojCNREfqhH6WH+H6KoOQqGpE4A2GSJ2k29S745WHWrADis6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTWj0mqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTWj0mqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34B91F000E9;
	Wed, 24 Jun 2026 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322466;
	bh=b17eIvt24Zmihpai4+HJm+Spij9I7I8QVyO+Qv2eG4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gTWj0mqTIePoC+GoYf8X1nmvbk8fZzcnE++xNZEr3ewTBhCQdkFiOpec7ydhRIowp
	 78yj52OPHLj51wb1EYayXsw+CtwMVSJJx+4EvPeN0hCZ+mnTEz6c2erF7ddep1pbkf
	 bwrAH1ZFv0Jj4fkCll/SFXVvKWc+nsNUBsO6hW+Jz7uWjdKu6z8rMyWoDuh2+OeIwx
	 G/mho/tok0Y9LpGVY5b0TqfKsWdH8PxpWJiiYwtdL3Bw5xLxvKkCangr6QHeu9stoC
	 B7GkFUJwr3fbks+TvqpQGEC6NCdiPHnXsU/5UeA8zQSZdVSsVmxZdZR0xrdWm+T35N
	 FQicwJDEb+3ww==
Date: Wed, 24 Jun 2026 18:34:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Vladislav Kulikov
 <vlad.kulikov.c@gmail.com>, Kevin Tung <kevin.tung.openbmc@gmail.com>,
 ChiYuan Huang <cy_huang@richtek.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/13] iio: Initialize i2c_device_id arrays using
 member names (part 2)
Message-ID: <20260624183417.4af26519@jic23-huawei>
In-Reply-To: <db01a5dd94c1086bf39c99f798901d33c8cabaa1.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
	<db01a5dd94c1086bf39c99f798901d33c8cabaa1.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 17:54:29 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> This is a follow-up for commit f68afce8e8a7 ("iio: Initialize
> i2c_device_id arrays using member names"). This previous commit missed
> these two instances because these drivers didn't exist yet in the tree
> where I prepared the respective patch.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Applied to the testing branch of iio.git. =20

Thanks,

Jonathan
