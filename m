Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE8226D02;
	Sun, 22 Mar 2026 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774177409; cv=none; b=OL1uBoMk9DQtFkBsA2WweeYZuhP1QDIILArHwq1RvRfujz5a1mK50h1Ejm3ZoCRGYWlhuWArQq/eIGREGAIQe1d606avd9qwB00i0nk+FCZIWPv84MBHyBDEfVLegJm5VbVa9Cj+nfeBH9uDW7cTtlZTz7VEUj99LNpuzCEEuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774177409; c=relaxed/simple;
	bh=hn8/vfejfcSVY3nOh3VQo3mhPIdf+VP8rhVsppTD938=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trml9p6gWqODYqU7meIFs/sxXagwYNBcCyv5FG3NFyYoM0RCkn+Vfk/Om5VQtlM4oTZ4A7KNXVFtCAwojoClgtfcPLexlE49J/4eB1sQSadYjkLkGndLFqGi6BzKdhsMAViP98yD+LLZj3b0Zf59Y7Qm+pz8vTt5uKqQvI22sFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAc6GVIj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAc6GVIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F983C19424;
	Sun, 22 Mar 2026 11:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774177409;
	bh=hn8/vfejfcSVY3nOh3VQo3mhPIdf+VP8rhVsppTD938=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FAc6GVIjTwSoCeGLusIcwzK2Bpt+cXmOGV9Gq3FvVONrvpqZ/mA3j82xxZcVyoJt5
	 ywgY5/SKJ9mxk9FWHKEDpoilEVoGeHG83pnDUwLZD6QmoLYfq+QpwvCPtV8ZrmZr+E
	 dPLz6Uv0kgRJ++L2rtKDpl/zHqhy0nGGdHo5p+OvHybU9uaTHWGIcBnWIzsCd6QLvA
	 gWUNoMtdgS2puapiuZxJunyEzWUEWbkLzZd/8LcAESaJJbxBra12D362vC0emy656D
	 e255GgmKwVSR/alws6mUE9E925t2t0u5JJDTibE3roD1euj13yI+y+lJgcFs9Rmyvn
	 7Fbym8dCivjTQ==
Date: Sun, 22 Mar 2026 11:03:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Sirat <email@sirat.me>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <20260322110319.7d7558f3@jic23-huawei>
In-Reply-To: <b1da32d2-e1f7-4fea-82a7-a40e8073a100@baylibre.com>
References: <20260319190738.151614-1-email@sirat.me>
	<20260319190738.151614-3-email@sirat.me>
	<8502eb51-53c9-4f1b-92d0-21b06fa4802e@baylibre.com>
	<CANn+LWJEJJoGQU7p2P2GrOcA_g2x7jEnvjcTJYG1hDRUnRw3UA@mail.gmail.com>
	<b1da32d2-e1f7-4fea-82a7-a40e8073a100@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Mar 2026 19:37:58 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/21/26 5:39 PM, Sirat wrote:
> > On Sat, Mar 21, 2026 at 11:09=E2=80=AFPM David Lechner <dlechner@baylib=
re.com> wrote: =20
> >>
> >> On 3/19/26 2:07 PM, Siratul Islam wrote: =20
> >>> Add support for the STMicroelectronics VL53L1X Time-of-Flight
> >>> ranging sensor with I2C interface.
> >>> =20
> ...
>=20
> >>> +
> >>> +     ret =3D vl53l1x_start_ranging(data);
> >>> +     if (ret)
> >>> +             return ret; =20
> >>
> >> Why start ranging here? It looks like this is controlled during buffer
> >> enable/disable.
> >> =20
> > The VL53L1X (unlike L0X) does not have a single-shot mode. So every
> > measurement requires the device
> > to be running (Autonomous mode according to the datasheet). Starting
> > ranging once
> > in probe allows the direct read path to work without any additional
> > start/stop logic inside read_raw().
> > This keeps that path simple and low-latency. The buffered/triggered
> > path independently controls
> > ranging via postenable/predisable, so there is no conflict. =20
>=20
> If you do a buffered read, which stop ranging when it is done,
> then how can the direct read work after that?
>=20
> Can we just start and stop ranging momentarily for a direct
> read?
If the latency is high, then worth considering whether autosuspend
and runtime pm can help. That way a burst of reads will see low
latency after the first one but we won't be wasting power when
no one cares.

J
>=20
> Otherwise, is seems like we would want to have ranging always
> enabled.
>=20
> >>
> >> =20
> > I will address the rest of your review in the next version.
> >=20
> > Thanks,
> > Sirat =20
>=20
>=20

