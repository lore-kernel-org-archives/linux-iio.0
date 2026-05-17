Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C330F934
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041187; cv=pass; b=PBePkZZBDZIoFtZ0Zilge7bWkREdQxID5+metY9i5OqEDigFbuIPwMgcy3xwfuUZ0QkuUOxAnfnf8j2622Fku5V67B4DgzILGnH79b7Q+vRB2ol2oEjRLiTWgb5Hh/4waO/eDdAo8RyKTWHKe5PZMKdcPVIn9pXlJ0KMh5KTrCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041187; c=relaxed/simple;
	bh=H9GqYBpY5nB0Qh8HL53p/YzwyYeR43on70Vb4XQEMgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sY2TIDU9r/PEWh3lBgk54C0Cg0I5gYN45yjSB18sLUPIR+2Yr3SgIBShjSI2FWQWsLip0MIWYDbCkHQHUKuBkVJk5rdCMTGS+ykzhywKToH3HA/6JBVitBIf9h85LQ21/xymvPx43OUZU+wn+pWucJCutGldlWeBS/AIRcfPCuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyeFwsey; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyeFwsey"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-654672a6d68so1618169d50.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779041185; cv=none;
        d=google.com; s=arc-20240605;
        b=bqsYxjUJjY4fYp9B8Rj3svfUZtySffM28bpmB5Zr275qkLae0mkCUE+PDSHQoHzT5+
         fZP7OZPA011eJQTvfk/LyOvR4ajbGFavNQyMZRSZMFqjEc0r1qSVdYwM34HlP2QHEWcz
         SMRGxxle7TWbMKSSrK8rS9kSsVXvbA7+lFqUxXbKxecUZ0wFMIoLduZ5V2JL+naGwVwM
         VhAPOJ4oF0PkbDw5FNgyPRCXyPOOFcxTCYlWcQY4Y488R3rXAVK2S55vRsOaZKbH++Ck
         Sv7u/vQyOeb7ayc92nVXW14v9N4xnhINwM8suYNJcGLKqMORzMQCXEnw4tx9eBZJHA1y
         XXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p2jozFurG15oqS4RGkYlCCaBohKdo6o3NihM6Q/faNc=;
        fh=CdWcTDcc+L7/jYBmMBDQW1JaBJIEkc4JTHARiikxV3c=;
        b=bPukr1eINEvtBvCB6Y88JsdkDN1KOktrYqcwsX7jKMp4ztkBNDZV0KN29dqoTQB6k+
         Z3FUWNy56aBucsx5AgK3h3ym9gpTTkutSeL83YShAlaDtOlcNV6nnjaxnMV7pZEWr7R/
         5/1zDe/T4/dajpieKFvuZ63hS8X3GcPlpdnbyCuqXTeVOq/tEnN92RCVFvelCRlfr8C2
         Xd1Pb+AghahyOpMCUk8xpFae5tby05ejKszh9csL3qb0cOpwa2QMgGlzD+TrGgFiUIPN
         5U7Vgv0sk2Y/yhYzlg37NFSYg+ojlWLxrj/cC5MaCPdlBeb5EJar57ZT4lasG/sQaLa6
         FtMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779041185; x=1779645985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2jozFurG15oqS4RGkYlCCaBohKdo6o3NihM6Q/faNc=;
        b=gyeFwseyu6A5SquAdCvhQAUl+DAfDsoxGNSzzW1rF/ziZSk35ATo9liF6row70Puh7
         3PM+BB+79fwpcoXB0LGxuH+5L/Dh6ppgNHHJNcQrrh/sOVXkSoVMpHnoyeRe85aNfFr2
         fMQVZkKsynDWDPpozcjPMuQUAKJzWrL3ttfTi79hUg88IQPKbRcYx1382szF5ChYzp8j
         NkUMc6rOzvRo0Qtq84PtmI5VfMt0H0VrVVS6gtTAcSZWSuK/bMl9lWu5LR9nc/MStvMw
         lCWyEzL2yXS17EvK3ffJEUwwmh18xUoRUlkY1VEhHdCZBtkgz1ttbbBNKW8u5HHvqviv
         YaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041185; x=1779645985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p2jozFurG15oqS4RGkYlCCaBohKdo6o3NihM6Q/faNc=;
        b=XNk6CIIwJULpJr0rd0pGFDCuaawVGhXVE6yxSLG7mNH+sJGSNeZEW8vIZ0u/1Ds+Ye
         AsmMPvwbX2dh4UagXh9rVly3eixd3vmLnakzs/eivtydJ2rWorIFwLoAU0YP8w8f4pNz
         2S2IHdApZ8R/BaMvsgccY9WE3ZXfcGHa3nZpcjO5crPnBnA3jkAMIRc0LE41IjdHG1QF
         hLl/8dPEsGb+UZoR/p++ikx6tzMm8cjvULE49oOmq4dcGeo3RTuDCQ3fPTiR+FIrk5Lp
         UR59yarG1fN4rRRILNp3RwSIY57QTW7iXYgqFFeSNcVmAh5/tuJ5LHnyjqky9SqMca8N
         /wKg==
X-Forwarded-Encrypted: i=1; AFNElJ//fOIrwwEbEATanyUuopnYHva6uv2dmGb5p6tkyRysZwSNDYHrZOTtF/NbW+6dt+8qRXsasdxThoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3tLroRs6cRCPT/wn+TTRbj12fSLZZlITtFz4cxeojz0Gyp31a
	mixubYe2cqdhYdLgFp+tFcnXXev4wPcCO5xTxZHfJN4zv5b3RNzXbtKskI4nHLIwR37/EKmgzgo
	a2Xvsqdctc+Ox0qAitvg4woql/DgrNts=
X-Gm-Gg: Acq92OFc419WNeB55QbdDaDJx5TBDWaCf9iqA107a1DLIjheUtqh+qOHcNON2mGjYPr
	rRQExyNjq/h9FV9t8f2g4rgKGqWTGDuRu1WL8/f8rw+E9Crt/KBwT3kHA5klbIaZsJD05CVsq/l
	TRUN55xPaCOu6q445BZ0Vf5LcIhESmNKgRou5IcOL+gQblojurR6zZVEmzBMPeYYEi2JJ/yDa8C
	96Y4GQrXzYQ3Y8tJZ60NViFz2mTq94GZZmJeVJFio+bBPi3ZorDb4lgTlheXuKqMSwoFfnYlYmc
	BC4uDWuDP5BTyk54
X-Received: by 2002:a05:690e:1301:b0:65e:28f3:4a5a with SMTP id
 956f58d0204a3-65e28f3509fmr11142962d50.37.1779041184799; Sun, 17 May 2026
 11:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com> <20260512-opt3001-cleanup-v2-10-8018cf3a8a0a@gmail.com>
In-Reply-To: <20260512-opt3001-cleanup-v2-10-8018cf3a8a0a@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 17 May 2026 13:04:57 -0500
X-Gm-Features: AVHnY4Jl8N6kNDXOEaZ83QkFYkaG5l_aoyvurS3H1K64gciAAh_OStljljMFoy4
Message-ID: <CAKqfh0GbMtsxVixf4tPuRB4mwWLk2T1fwr=LS2G_KuBnpQxWLg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] iio: light: opt3001: add comment to mutex
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
	Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 5:58=E2=80=AFAM Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Add comment to mutex per checkpatch.pl report.
>
> No functional change.
>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/opt3001.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 1319e5941b66bd82e4dc2badf5ea27cacbcfd54a..81afee6993d08b1126f07b1c6=
3c3d3496d8b380c 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -104,6 +104,7 @@ struct opt3001 {
>         struct i2c_client       *client;
>         struct device           *dev;
>
> +       /* Mutex for ensuring one executed command at a time */
>         struct mutex            lock;
>         bool                    ok_to_ignore_lock;
>         bool                    result_ready;
>
> --
> 2.47.3
>

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
