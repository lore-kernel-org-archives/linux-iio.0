Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1108C3DD871
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 21:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792357555; cv=none; b=b0Am1fBY6Jr0KXJGKKBZS7NZk+rj8OYHfsQi2nssX6u0q/ydze9ueFG+OAGjegX8xvtXg17BttjsEBXVR7SvkMfQkaqfZmf2vWtqFZG6tB/JT8AAmeun9swUpxdenJz4BXioyG1jHo+Js/lXec38WXv/HJzg6KMInWRzKLdFFyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792357555; c=relaxed/simple;
	bh=X9w/uTIz8mCO7IVavpsOU4YOnHgNhjn7Fq0V7BdmwrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFQaHw+4ZOTuGGCyzLUxc0QhzfvejM6Vve0whA52/Ke/KlAu89zgWelwqR3maRBO/HOSc8xStJdZh4SGQoNOI/PbOGR9ViUAa0yi3f81Ypcq0KAmzixq5ucH7wz0vEVwpGQoBF4qhIhngwcHZJYrb5o0ZUh0uXxqS+AGc+VpwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nsivr2Tj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nsivr2Tj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFF81F000C5
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 21:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792357553;
	bh=X9w/uTIz8mCO7IVavpsOU4YOnHgNhjn7Fq0V7BdmwrI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Nsivr2TjtLpUhqtcw+3h6AEh8RlosvHydpHJzzW9bzTF+abxNY7WM25vHaaNc05o3
	 dqN79/aHL32zYkTSa2MiEZN5xcHJeMdtTatqQlMMopeXkHvAWlB3FgMQ8WYsqbT/d5
	 3mcFfNhY7fzRjpJOtyIrB01FqG27yG7es3IwjKDZmIE3dAouIFwHU2J4T/UVAK/gtk
	 xjdeSL8pEJVWJDdVdBB9R4En++x8Jy2vWCOkmrCHyMlKArUoGXWu0exBiI/IirPp9m
	 o6ZIedOH+9R3ZxyxNKbLOzRnZxT1J0pebk41Hn/9uJhR6SUe2nb1b5HL50FzO+lkfq
	 E1XU48CUdkGBQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a60cb94b80so16135971fa.2
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 14:05:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwGi4YRN3bU+QzeuE0ff4OZAU9s5qqmcW2tIpNpAasUbRQyTpwOrKk5Yed024dALY2YLbymxwTLs7Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIry5r/1E7M+5ijYNDQrkF5WfQ7cvqB1xas1S0auilQWU+SfPCC
	OsVa7Sveq/l/CG1X+I6OlKPI71ur/UgKvDueFQ7dnwdDtPhnq4JoV3FydBXNFwAD1zbI1NOc5Fe
	rlNJNeinC+K0ybapwJj0n6QqAO68dpkY=
X-Received: by 2002:a05:651c:324b:b0:3a7:6b27:260e with SMTP id
 38308e7fff4ca-3ab28f486d3mr14469821fa.2.1792357552633; Sun, 18 Oct 2026
 14:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com>
 <20261016-iio-light-gp2ap002-v1-2-7c93312fa8d5@rudorff.com>
 <CAD++jLkSjbMRV_53rjpd1D+vxg=OVVWzVwiddUL0eqmSBoONHw@mail.gmail.com> <3ef190ac-eac2-4c0d-b3b2-6fb627f086ef@rudorff.com>
In-Reply-To: <3ef190ac-eac2-4c0d-b3b2-6fb627f086ef@rudorff.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 18 Oct 2026 23:05:38 +0200
X-Gmail-Original-Message-ID: <CAD++jLmD3ARRtwPZBsCOmUS0icP6yGjaX8GL+vt0qqnmBj8Gdw@mail.gmail.com>
X-Gm-Features: AclHuK-JCU6Jc0xQi6Pc2hMskCDXFXdAnilG6QWxPy75OSiEz-MjrNHbVAvTZnA
Message-ID: <CAD++jLmD3ARRtwPZBsCOmUS0icP6yGjaX8GL+vt0qqnmBj8Gdw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: light: Update DT bindings for GP2AP002
To: "chr[]" <chris@rudorff.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 11:18=E2=80=AFAM chr[] <chris@rudorff.com> wrote:

> > My datasheet for the GP2AP002S00F clearly has only
> > VIO and VCC, enjoy:
> > https://dflund.se/~triad/krad/GP2AP002S00F.pdf
>
> That's the paper I'm looking at. Pin LEDA wants power!
> See page 8 "Recommended external circuit"

Aha finally I got the design through my thick skull.

You're absolutely right.

But regulator supplies should be named after the input
on the package so this needs to be named

leda-supply

And in description write something like "LED Anode supply."

Technically this should be Required: and the right supply added
to all existing device trees.

Thanks for hashing out this stuff!

Yours,
Linus Walleij
