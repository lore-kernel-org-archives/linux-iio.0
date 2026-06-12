Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CB39901C;
	Fri, 12 Jun 2026 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285711; cv=none; b=YRwd1+A6wDliC6P75q9KpRHZC2uSNbOi5ZWwx1EXG3Qf4PbJ9WA3CJ9z1LVFe+2jXqGl9Sx7Og9Ic/d34Ji1wQxjp5gq5zS0Mj65CBectYE1Zfoi18Qj0n8vAYTAUPAR99RyAM7tiDJCIqDJiwECjyMlOYOedz5lYabEt3s5rE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285711; c=relaxed/simple;
	bh=B8tR8PYTXl/zWhI2S9VabBnfK8XjWoeCCONyO7XL+EM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2FYIIwFolm0FZKIq1FhepXEecV8IjyGQ8tWT1k0Eqo7cIdgci958GCyxqs4wdsP13sU/hzioTNeVX20qu2baTn3e2Xj7ci6av0Oqpl5IHytHTAI5HoUUHhsckuoeSlLMh3MFSc1KDo48eAqOWn+sI2KzdGLPKyWyx11YKUbkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq8PfFNE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq8PfFNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D761F000E9;
	Fri, 12 Jun 2026 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781285710;
	bh=3zwmPsZ4cGvZFo9zkzVNqr9EitMg1+IcWApP6E1cLXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Sq8PfFNEU4a+E09SKNmv79xSAIVW/NP7btWUSZuHFgucAnZMju2ixBwfTmauMmb1D
	 2CewdMAI7RpthclGQT9idn00ZznA2bz6ZlYVg7Eirlhdz5QQpVIsv5iv77DOGXxCDQ
	 3xSCODBItjhz4FOirjwbyKV46hJ+tE1Luf94YuECtTP4ADK8xbk5kWlvZ4wjeVmmVd
	 e1oQUjHadDlFatAyKGWRrwk0KPsAdlmsZY9GcMkqHChslGf3ld4t5TPFqGRsNMQ+fX
	 CUvekNrpXrZdslsvmQoONtRoGaL7uU/0jEhj1Y84umH3LLX50UdWLY4JMR91++z93Q
	 4S2oD8BBaPjvQ==
Date: Fri, 12 Jun 2026 18:35:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] misc: lis3lv02d: set default click detection
 thresholds
Message-ID: <20260612183501.2c35df29@jic23-huawei>
In-Reply-To: <CAD++jLnK7uMo5U4S5B_5_p2tNbV87AeHHfv_RT=rhS58AAtHBw@mail.gmail.com>
References: <20260611154105.3727-1-shofiqtest@gmail.com>
	<20260611154105.3727-2-shofiqtest@gmail.com>
	<CAD++jLnK7uMo5U4S5B_5_p2tNbV87AeHHfv_RT=rhS58AAtHBw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jun 2026 16:21:56 +0200
Linus Walleij <linusw@kernel.org> wrote:

> On Thu, Jun 11, 2026 at 5:41=E2=80=AFPM Md Shofiqul Islam <shofiqtest@gma=
il.com> wrote:
>=20
> > Several upstream board DTS files use st,click-thresh-x/y/z (the name
> > documented in the old lis302.txt binding), but the driver reads
> > st,click-threshold-x/y/z. As a result those boards have had click
> > detection silently broken since the DT properties were added.
> >
> > Set a default threshold of 10 for all three axes immediately after
> > the platform data allocation so those boards get working click
> > detection without requiring a DT change.
> >
> > The DT reads for st,click-threshold-x/y/z are unchanged so boards
> > using the correct name can still override the default.
> >
> > Fixes: 6a7740c7f5b2 ("lis3lv02d: add device-tree support")
> >
No blank line here.  Tags must always be in one block with no lines
in between them.

> > Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com> =20
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>=20
> Yours,
> Linus Walleij

