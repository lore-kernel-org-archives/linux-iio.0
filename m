Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519431F98A
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375460; cv=none; b=Wc1XCt9l35pLw5jp3Mt/TvMlXV4yretE2hYFZyPDQBoooURCYX3FDSoEFxvmePQM5Jl493VbMEaGFMR6/snorei9vQygbhzd0B5LCNvaGO6aRmK3BTBZe8Y2N9lvf2WznaNy2orwIgjFrhoOUPm9UHL/ah0hzSHJo8X4mUvgHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375460; c=relaxed/simple;
	bh=DqpRarMkcjYJnQFn7d42wtThvbJ7HIf2d50RwTXnK58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwWdv+49eU7RzkFTGqr9DvHdiQ1Qm8ARfpGrF7byG79dFE81aeRk3g1rfJBB0A0WQtJU+laivbpmq37rMM0SsdF987n8WdPJ3/7REXttt6Agj8t8h/5+hpAk3MN8/8saiKrOAmmfnNppdAn7PacNwqNvro2x56nDPIpOk1SQ4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a46260385so17719697b3.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 11:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774375458; x=1774980258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DqpRarMkcjYJnQFn7d42wtThvbJ7HIf2d50RwTXnK58=;
        b=BrSzu5mn1NKOUIAzmr+Q12XAlQIXxj3TXTQwh5diwlzbdFNWhBw74w+A3pelgOdtxA
         GizbuTm5I48Sl0Ygaic/J3HsMGbvClAJuwXzWXZuVnGhOnvQgitHHNziiPV2ThbdN8iI
         WGdSt6f3Wytkt9WA0JNsa9Q6v371OmUFL5ly7p6gh1Is8neLIZvhWkTYStho7Kn2kdPs
         7/w6dJ2lg7XuXUvezg75TReaNgzQVuQKqlaHwODLQsmP33dznj3rWLgDbE/cY3ns8MkJ
         LF5g/Z5LnTXLHn+x01LYfkY/ajf8WN2Uk0CfhGaLTJH7C6gnO7+UF4n4bPnnFSGLCdjf
         SWuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGvVXcfmPNlo0Xg5LTtR2The+tKFTkgu0P+b2d5mBF+wr2UVPakg6ebrn+hSew2HDvk78wK8CWSVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTBtKlTIjgXtuGQMjLObBv1CRwM6XwWdonLc2QsrR2A5UpmXw5
	/dZOrTyN4Shuv2+xi23qCpGzgh05K1K7cyz9SlWH7KzdeJnEfo1VikG4EV4mr+by
X-Gm-Gg: ATEYQzzTEfaKH55KXk8T2fleZq6vNnQLDenLGOE4b1bgHoV41P3BbNZFKTHzj1/UGTV
	NpjUg3Sn2fmWbvLCoQqnfGF4PAwsZj8aVqXEg96gj8GyFFZMDlHCMfOnm0Sh74KTeuo/QlQ5Oip
	samRzvMq3Zdn0NasIF2QHsPAZQ1EoIGzkyX/6M5K/zepv9DuGEpLiQmvSUGJkY7WaPXYDx7zU3A
	ltGG99BGkjzmk4oAUwczNdKXgQTZzXza/tvBYh0cvJi0bLIE4gvVbz+Q7ajxElPY09F89bn1ivW
	sjFgn9s+BzMuK2lI8Nuee2UzCoo4eqwkI7Mih51ht7IMX+kaB5r/0Ut+6967Bq7Q4otDN+pWeCZ
	WPvvkjXPwqy6ylQOxq5xsw+yAnIkpvIiQ+qKRcEGePvY5uFblLq2IpkiA1QKOlL2zUtj2MNSpeT
	M6b7ZROJV/23ytA7UNq7ZTP53hcvLjpdgWpCmtWzIt0GnbpPpOfDAvrueKf/C1XivETaUHXM/+m
	pIr5k5LZWGnyw/6iRTUbIe70GPkH56xVQbsRxRZRg==
X-Received: by 2002:a05:690c:c50a:b0:79a:5164:bb1f with SMTP id 00721157ae682-79acf374b17mr7098117b3.7.1774375457615;
        Tue, 24 Mar 2026 11:04:17 -0700 (PDT)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com. [74.125.224.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903a5ac0sm76314957b3.9.2026.03.24.11.04.16
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 11:04:16 -0700 (PDT)
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so1747492d50.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 11:04:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwGly53EntE/95n4qnRktEBlY54lX234kPYSdylBTmic4emEnBqk1mZ4gkEAYxXzbE9qxEmTC/1DE=@vger.kernel.org
X-Received: by 2002:a05:690e:434d:b0:64e:a30f:e67e with SMTP id
 956f58d0204a3-64ee6166545mr392009d50.67.1774375456606; Tue, 24 Mar 2026
 11:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190738.151614-1-email@sirat.me> <20260319190738.151614-3-email@sirat.me>
 <8502eb51-53c9-4f1b-92d0-21b06fa4802e@baylibre.com> <CANn+LWJEJJoGQU7p2P2GrOcA_g2x7jEnvjcTJYG1hDRUnRw3UA@mail.gmail.com>
 <b1da32d2-e1f7-4fea-82a7-a40e8073a100@baylibre.com> <20260322110319.7d7558f3@jic23-huawei>
 <CANn+LWJwPUiCkz_godEeBvZnXEXzNmCW_-ou=wHL+kjfn0zF_Q@mail.gmail.com>
 <CANn+LW+OPP2riP1d=zZKz8MnTk2yo2CL3qn17_LYD=1SmCAQgw@mail.gmail.com> <c1d99a64-ea4e-4cd5-9b1e-0972a5e0d61c@baylibre.com>
In-Reply-To: <c1d99a64-ea4e-4cd5-9b1e-0972a5e0d61c@baylibre.com>
From: Sirat <email@sirat.me>
Date: Wed, 25 Mar 2026 00:04:05 +0600
X-Gmail-Original-Message-ID: <CANn+LW+aUhGRMJUmZ8um2uf=a+b1sUx7P3nruxeUbK7Z9ezOFg@mail.gmail.com>
X-Gm-Features: AQROBzDXT9oI5nYjcAVZ-dcUoSSKziBDDF9I0zkXnoSwc36QQZqLk-uB4ApvdCs
Message-ID: <CANn+LW+aUhGRMJUmZ8um2uf=a+b1sUx7P3nruxeUbK7Z9ezOFg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:29=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 3/24/26 10:17 AM, Sirat wrote:
> > On Sun, Mar 22, 2026 at 7:52=E2=80=AFPM Sirat <email@sirat.me> wrote:
> >>
> >> On Sun, Mar 22, 2026 at 5:03=E2=80=AFPM Jonathan Cameron <jic23@kernel=
.org> wrote:
> >>>
> >>> On Sat, 21 Mar 2026 19:37:58 -0500
> >>> David Lechner <dlechner@baylibre.com> wrote:
> >>>
> >>>> On 3/21/26 5:39 PM, Sirat wrote:
> >>>>> On Sat, Mar 21, 2026 at 11:09=E2=80=AFPM David Lechner <dlechner@ba=
ylibre.com> wrote:
> >>>>>>
> >>>>>> On 3/19/26 2:07 PM, Siratul Islam wrote:
> >> ...
> >>>>
> >>>> If you do a buffered read, which stop ranging when it is done,
> >>>> then how can the direct read work after that?
> >>>>
> >>>> Can we just start and stop ranging momentarily for a direct
> >>>> read?
> >>> If the latency is high, then worth considering whether autosuspend
> >>> and runtime pm can help. That way a burst of reads will see low
> >>> latency after the first one but we won't be wasting power when
> >>> no one cares.
> >>>
> >>> J
> >>>>
> >>>> Otherwise, is seems like we would want to have ranging always
> >>>> enabled.
> >>>>
> >> Maybe we should go with continuous ranging then since it's the
> >> vendor-intended behaviour.
> >> Since there is no hardware single-shot mode, by design, I think the
> >> driver should just behave
> >> as the hardware intended.
> >>>>
> >>>
> > Just for the record, I'm dropping postenable, and keeping predisable
> > for only the cleanup.
> >
> > Thanks,
> > Sirat
>
> predisable must clean up anything done in postenable. So it doesn't
> make sense to have predisable without a postenable.
>
> If there is something unusual going on here, it will need comments
> with a clear explanation of why it still works when it is breaking
> the convention.
>
>
I was thinking about the drain logic. But looks like it is not needed.
Dropping predisable too.
Thanks for the insight!

Sirat
