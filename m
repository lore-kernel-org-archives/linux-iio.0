Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB63CF952
	for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790550510; cv=none; b=clXwesVR1i+KR3KDvNu2P3nged3dPYACRt/B/qjd/ewxRsZ5fkD8g+Rds8ZF01Sexe6E6DWr2xhuGDO7fcn45CQwBE84F3AiMO0V0NpvEgUwH1rA/D1pBSQQDZB9VdQ7rEMNrGMIJp3WGGNXe58YmMNQe12edeBtlAtSuyYubM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790550510; c=relaxed/simple;
	bh=3zUULBbfrp8xbNVjlwHhugfbYg7QtsB9cP+qnWfLhF4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=G26Tl9YXnPYOH/mQ0vmzcyx2zuGsxz2dKuy3r7GMDI7RQLTlbRbOBrGFPs24nNHeOgdyQ8YjS3PYm57sOjwKB9J2Rv1LHtJvO/+pSjwJ/GK1M2+93gOLCOgMC2LvLgpZJ1AedXT9QPRjiHnPTgYuimAy4c3Z7Po3rJIP2KVd6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joVFnYFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joVFnYFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2615F1F000FF;
	Sun, 27 Sep 2026 23:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790550509;
	bh=7AFisoZQdotfnFb4YgqfF5oZMqG/rmyrtKwSsCVH3bo=;
	h=Date:From:To:Subject;
	b=joVFnYFWYo7kW1Wsppmyy4BfvOEmXxjH8i1LxX3Yna2ManGMe4HRcUo0jo7fGV4Np
	 po8nA5y7yrY0ZUnewG4rcnq9L1zqNBD3GVEiBtYR81S5jieIwofcOLc0PGMrzPSmVJ
	 8YBYHHqlrch+JMlwFndvx9TROdvQQT0EliKE8ItxyVPYH0DdJuwRD6eC4ZqmZv3xlt
	 IsQ1EwXE8tAcpE40EYN8P1LJZvlgYrA3Zgr87Y9mmRjBlovPv2cyxz+pl3ykwOla8Y
	 SXbm1th3DF364qpNuefh2OoZkt8zfTtWlGhH5vMz5Q+7J0jyfRwVrsisIX3tV50gIl
	 bXChok2rlfkdg==
Date: Mon, 28 Sep 2026 00:08:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: IIO: Likely disruption due to travel.
Message-ID: <20260928000824.0c58cd8e@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi All,

=46rom the middle of this week onwards I'll be travelling (rather indirectly =
in
both directions) to the Linux Plumbers Conference in Prague.  Hopefully see
some of you there, but it will mean that my available time over the next 2
weeks will be a bit random.

My plan is to send my main 7.4 pull request to Greg before I set off for Eu=
rope
and possibly follow up with a small one later (all subject to Greg who may =
also
be travelling.)

Don't look on this as an invite to rush lots out in the next few days.
The first pull request is effectively now closed.

Unless it is already something that is in a pretty clean state I would be
unlikely to take it for a second pull request either.  That will be about s=
weeping
up things that are just waiting for minor tweaks or an Ack / RB.

Looking at the stats, it is another big cycle for IIO :)

Jonathan

p.s. Feel free to email me directly if you are in Prague 5-7 Oct and want
     to grab a coffee.  LPC is a little crazy but there are always some gaps
     and I believe it is in the same venue as OSS Europe this time.
=20
