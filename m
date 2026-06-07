Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B2F507
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 23:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780873381; cv=none; b=Evl3/KsHfzQwefj1xuW7Vj321p/skQng1PPHXqSOtpBHvjFRNJvFwngo8dx4HD9J+9nekhL2ExJhGyQPcFPJuiapvkCM9pfAHcLkVagVTH+EALaqU+pnfsHaBd4NNbTqmKK1XHLidm0suxi6U57k03h714MrcXMokslEvasM6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780873381; c=relaxed/simple;
	bh=Nu+S9Y+fWAo6CI8bS9lMtQggQhbTHvd61bGQZiEvmlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lm1BRd6kEpsgDdtol2CMeuIq2VMf34linorO9KudJxKQYy+W9XOT/wsR9ozlSWUUavZAXvIK778WysmCzgoDNtBvRKvPLG+ZYhbuEGLmW/TMkM3Y5YUJujrxbREGbv+iU5/V8GXj3YJhSzrURMNbtX655m7jR0V5xd1ilfTANb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhlsHBT+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhlsHBT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6EF1F00898
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 23:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780873379;
	bh=Nu+S9Y+fWAo6CI8bS9lMtQggQhbTHvd61bGQZiEvmlQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BhlsHBT+ri5Fza6l1gadIHtF2lZavSTo2XUxNLq60JLjlPV+qzNrp7yE24kOqIBxq
	 covPHdBQPaKyZ0C2nKVPdPowgItTkPFkJNWdLw/m9EC7yvi+rZyYctjsSQRSre19mW
	 7c1SRLraWIRi2NHIMjNs+1mBkn/KdW6lF/+foWqdlJhn3qo/al/u86O6ftMFxwxsC3
	 DYZE/cA4fT4n+LzHGuTU/Y/jWckV4uUBTnVdnnnUCmyPNsNPmF6bABqjkqhzAn/bdJ
	 wBb7e6zKRBiMEWctJEP25fRncJBrJ4Cgi5RydTLqovbUTnXm5Xy+SsO42EOghIubct
	 PVVb0IYcIRDug==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-396775c2720so33844981fa.2
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 16:02:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/UBWzPmVIGVZcgJ9eUT+yZpAhkS+rGHxeZ4c72xZjThM37mGzhMurC7Kxi7jUJ2vn8V2F+DDdWMTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6t8oyF+62lEL6bgLAU4WBXildCerd6Rv17tmcfz76KvbsXbR6
	CLOTbxoImoRS+BPFik8AmJtizSYXXJ+7ukXuw0nhmTMc11Ewn/pHFFXIw15/449SSesWULxo86X
	vlhr1ik/0zsTgfK4bSv9YYJrcEzpIN7I=
X-Received: by 2002:a2e:a591:0:b0:396:b398:5956 with SMTP id
 38308e7fff4ca-396d094c5e6mr34804081fa.16.1780873378606; Sun, 07 Jun 2026
 16:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780648724.git.github.com@herrie.org> <81c02804b9ae3bc194ef1da95f58da4c5e19b609.1780648724.git.github.com@herrie.org>
In-Reply-To: <81c02804b9ae3bc194ef1da95f58da4c5e19b609.1780648724.git.github.com@herrie.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 8 Jun 2026 01:02:45 +0200
X-Gmail-Original-Message-ID: <CAD++jLmApyrZzfwNJFbvPpzJhJL1j8hwwfZbBMCS_n1LeWzW9w@mail.gmail.com>
X-Gm-Features: AVVi8Cfr43sLJCD3L7mNbOQV2zOl9NO-o4c8OHvf9LGecs2E0on6wmbNtJ56Gj4
Message-ID: <CAD++jLmApyrZzfwNJFbvPpzJhJL1j8hwwfZbBMCS_n1LeWzW9w@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: read gyro samples via FIFO in IIO_CHAN_INFO_RAW
To: Herman van Hazendonk <github.com@herrie.org>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herman,

I think the others are onto the review, but noticed this:

On Fri, Jun 5, 2026 at 10:46=E2=80=AFAM Herman van Hazendonk
<github.com@herrie.org> wrote:

> The direct gyro register file (XOUT_H..ZOUT_L) returns stale data on
> at least the HP TouchPad (apq8060):

Is that the Qualcomm APQ8060. Do you have graphics working
on it?

I have a stale branch for enabling graphics on the APQ8060 but
I never managed to finish it...
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git=
/log/?h=3Dapq8060-dragonboard-graphics-v6.2-rc1

You might want to look into it so just pointing it out.

Yours,
Linus Walleij
