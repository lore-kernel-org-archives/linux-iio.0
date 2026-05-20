Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95AE3D9DAA;
	Wed, 20 May 2026 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275651; cv=none; b=RUhgNDJzfyFFD5y5pkP53wrqr4wNCfSt56B92aIcC95FGPYoyouwAojLcXoDdLRT0Obv/0YZykcQ4NVGM8aNmfvJxC+jOB57Na2YV+mLwFmzgRmKcUIptN4o4sPinO6eZnVl8tBZPfTjambzY3z99prBOqqhH8KzLqYWKZKl5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275651; c=relaxed/simple;
	bh=ZsAeQ9bjPRfraNRCQXzWI0rgnC+KfrS7ipmN9EqDh1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnNjnmsRdYk3syOk4y7BxW0799EPY7XiYc2aHMZpeLW1wizngHam55ihIc6fdnBC6jGYy18i06B6P1lgBN9PHrUOgsB3vLtGxCaMNunfC/4uDxUjGn2mrqdrl4gDHBclEW1uw816JIlVMkO1anoDguFaehxYZ61kHkbR6RWER64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j65MoH5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j65MoH5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C291F00893;
	Wed, 20 May 2026 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779275650;
	bh=+Zgk9V7Xl6u4I3nUqB9SSH81vPkss0P5/jrHvLinOh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j65MoH5uqk7hIA38BCiXT01k9UHNtFZsglj3Z6NPKc42WNN1Ut7BY41gOelouJ39v
	 8LK+2s14SbThL5we3UHdTPgdszlpsgOO1XEPIPn8Wok6QDvU96YxaMfwyGbsDbx9Yw
	 6YaE5x8/qBCxRYgAmPYNoGK7IyQZB4TMITPKy/DKDxG04CAP0fZ+5l1KJH/spUkeiP
	 FaF2RZkXx0HnICT31TD4lYlRLaFzqhKKsj5sizxEjKSRhgFZHdhz3aMMOPHNG78zdN
	 qfOZtedcAChr5l1mUKXvi/B+w2TL6ndULkddhGYnUJO8NCFXNHRoBmqzfoTnuoCuF1
	 5CHpEK6+fRuZQ==
Date: Wed, 20 May 2026 12:14:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: j k <kimjinseob88@gmail.com>, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] MAINTAINERS: add Open Sensor Fusion IIO driver
 entry
Message-ID: <20260520121402.24a423d8@jic23-huawei>
In-Reply-To: <CALoEA-zx4pwxoz_a5X6yBMtNsf_Kp_Bip83HOVCWsk_3GePcDQ@mail.gmail.com>
References: <20260520072843.3593-1-kimjinseob88@gmail.com>
	<20260520072843.3593-4-kimjinseob88@gmail.com>
	<CALoEA-xOGAGb=-uXBv+Q2QC=viPCGUESGZw=rfoBHdEJFCkEAQ@mail.gmail.com>
	<CALMSewJinjbnHT_sOgWmHVeThv3su_E6fioyAjEWKzf7uROc2Q@mail.gmail.com>
	<CALMSewL560vBTut2=_x3KVvdoqMo3Lmg3WF9jr-EdncCFNW71w@mail.gmail.com>
	<CALoEA-zx4pwxoz_a5X6yBMtNsf_Kp_Bip83HOVCWsk_3GePcDQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 10:22:05 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed, 20 May 2026 at 10:14, j k <kimjinseob88@gmail.com> wrote:
> >
> > Sorry, resending in plain text.
> >
> > Thanks, that makes sense.
> >
> > I will fold the binding-related MAINTAINERS entry into the dt-bindings patch
> >
> > and add the driver path entry in the driver patch in the next revision.
> >
> > Thanks again
> >
> > Jinseob  
> 
> No worries, also please don't top post, just inline your comments like my
> previous reply. Check the mailing list on lore.kernel.org to see how to
> reply to messages etc.
> 
Plus for future reference - if you agree with feedback don't reply at all.

Thanks etc all goes in the change log of v2.

Saves a few seconds for a bunch of reviewers who have far too many emails
to read :)

Jonathan


