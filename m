Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C8E3ADB97
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789284513; cv=pass; b=MKgg88TuF0kh/yoP0sM7TbMGFmcGnAyU+Tu24fLvLAeXDIwFsTfVVHmPS/28wO94STxopL2NLRNpz+faYfXLpJMw5+Or7UQZmV6hE1oJREsVoBpce/4nKEA5G4zf4dhoYa9rsm8Ok8CsSyifaNgWUv06XuUN/hi9WTJW4fXZrd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789284513; c=relaxed/simple;
	bh=p2soD2Rf2OOF+LUQb8CpDj5kTsG2MF+pujWfnBktrnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjTQODH7V68uFP3cy3NV2yq2XeukX01E787+H9P6DhK7UNaT25wlLhvl6aVIVaxtB2dc3tt31F8GziDNoZVbKcQl0Kr0g4HjZlkVrR0GOt2nzyHvdM7u4/R4qdeyI/JOsAzuWPriyiCJSAZwpYd/e4Zw64dEGNZ4j5PkETKf76o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViQrhRB0; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViQrhRB0"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-398e9698a70so2370413a91.0
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 00:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789284512; cv=none;
        d=google.com; s=arc-20260327;
        b=MFfnJ5ldLO7qyoWR6UpMGV3lya4XViU/gfkPy4PfjZmwLlPwkemic+Yd1GpagPcz7L
         RLUz+S7sv8RYWGHMpiTRNz4uVrxHpq7+f5mjBP4wOHH2rUGpD+6bKFzjmSCRC+vGgXsE
         FNzmQLVpxDey18uLZObFS4UDaNDRagiNKSPXnCm2E2IqpqxJeudONK/H8VJvaGvIA+rP
         tEcOix6MwmzH5QqmuiLo/KMpkWZ1jCwQj7HVX4HCu5ZdWaG8aXr38+fuW8GiNCTwX0gO
         gfrVqYKnuX1YUqy9Olydb79570GlV0LIb9DhHO3ib96zhQ0kHmGF74Em8CGajcMphU1U
         pOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t9KdgDPH4/QtIY2XZ0YGTbjGCPHiA7KxT6UVJQtqV98=;
        fh=cwu3czL2hMNmBp24bHYnIOVLYlTbBZHbQ6Swu/QZWP0=;
        b=LmCf/QJdr1FKO55UrcIiDUNWaOgHurwOJwyXAECh66sq4IM03jhA1zpwyZhT/3u9qc
         tiEcswiCcrr0vMKkQZi6f/fCUXC7tkUxkgLozmcZE9EOsAlCbn4R78KaJl3T+OLa2L47
         ExfhR64RdH6QJyNFVfw7H0dPdM5SagJJxpyZxkCbKLd1xktmKvgRNiiBgIFYMXkwOiXd
         b/A2cpxIsLsu3Oapq47LqJK8IQ/NlW/AWUwwelgPY+Sii9a2RbFKX2z4WCnBHAbmOwgS
         8bSkjELQlLAfgEyKRpFBcVm8OlDoWvqI2v9gYEEm5upCwaxuCvlktWufa54Bkjbjpknd
         fXgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789284512; x=1789889312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t9KdgDPH4/QtIY2XZ0YGTbjGCPHiA7KxT6UVJQtqV98=;
        b=ViQrhRB02slxwxYgNDAivKcv2CGHVX5NwhyNfHNuK4rIMbqZEcylply6gVS5WXYPkW
         JCPbxKryRJ/IrIvlsyLxjx/oMPvEqfdUluAk/nZLX93uVI8Ck7fbte21VrNlIiMCSc7W
         7DJvqjg1H2/TA0O5aVwPnJGSQorvde/mMqwaDI5TmyLWCB5yBnsKXMegom3T1dpS8QsB
         n3tz8pC/Omy4h3lUTbH+syAOIZcjbN8FRikv5N1BmfcKTwTwLmYG+s3g9wYY0X9gHBv/
         +Dd5GZssyieK0QmlIvlTSb7LX+B0UktdIfNNtOT1TFRI3E5dHHPlAzlgtR3xxKQ1fwRz
         +S8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789284512; x=1789889312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9KdgDPH4/QtIY2XZ0YGTbjGCPHiA7KxT6UVJQtqV98=;
        b=MeKQyEpAG6NQs+WaK8IWsFOiJ8D27v6srys+Q6aGJVjJygneTnybYntA7C5zFqCgDX
         Hk4myHPTuiUI/z4G0tgDyfj2OendwP/TCPaCJhKIJfhNf7FiyShWSQ3yccEowBrk4H+f
         eMkJYgY6fXm+vwKMvt72MDIK5EaNX2s0fErWIeqJrySXBxgrZJWN268oBH9Y3jkrF6xh
         oGuGDaB7HDTx3JLGOpFk0MnKn9XbjplgliwauGhrmeL5Ij7ZwO+WHor9XukFNRihhQn5
         dxKQCmTliyouk/ZgUutCoO6u5hNEgFGtguhT8Sy7CV0800f0FtLFVdcpz+1AoSFuh8y1
         sWvQ==
X-Gm-Message-State: AFuF++nWz53uLMdsP+rEyKFpQZzmFPbD42UI3b1S4+gFVrKYYoKFsCJE
	aObSpepjX8BFtUpLhBSShYLO471lkdw/i7qp9T45TvOuC6lxNpBmf9IxfWOdcevlY3LufIcl+0Y
	WOQhdSxMFxNsQtkYXUULZX6jO7UFvsMg=
X-Gm-Gg: AYBFou3uaihytdJ+zhwiteoqaoudo2VFUE70MmQhcVpXTGtpHmqvU+NPWyNhdUzDJUb
	DTEoB86ZAATN3CxFYc5QI/aAdgKoVaEELIQqwsYKairs79G7+BXFd4TMGKrIV/o2XoH1BmVL01M
	LZAQfkKY1Xanvo8zFkx1hfrHNOmVImAVRa2pxwGZh4Xg4ut/GjxmPnTRSiRAXcyPLjAiisIthFE
	AtznHnNZEHXI7jlmDa0Kp00mE7uqJG+PB/Ee7JzhyBESC5Ny91R9U1C8kjyc6/WuUFPkCTMG8hH
	/i5NodaMrxOe58jPgsJxGWF1rVLXXPguvFjLS2nHYqkmSSDDI3Y59MQJDZMcCISJTBbmmIyT2UP
	rVP1yxCaCTH/zHmgEmlKDz8yvLz4WhK8FDO8rS+9o
X-Received: by 2002:a17:90b:3885:b0:398:c794:ca26 with SMTP id
 98e67ed59e1d1-39d9c3944aamr19707975a91.25.1789284511690; Sun, 13 Sep 2026
 00:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820050608.5440-1-kimjinseob88@gmail.com> <20260821033334.400af4d3@jic23-huawei>
In-Reply-To: <20260821033334.400af4d3@jic23-huawei>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Sun, 13 Sep 2026 16:28:19 +0900
X-Gm-Features: AcwNN1XcNBJwG8gWKMDEIRzhlwe-EM9NIJU5D9mnXUFN01Obu2gnIbb9GqvbVzc
Message-ID: <CALMSewLdDGApqiJZGdTjKdj7RqLKahf66kjrJ5nRHCpj5p+V5A@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] iio: add Open Sensor Fusion IIO driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-kernel@vger.kernel.org, rdunlap@infradead.org, 
	joshua.crofts1@gmail.com, u.kleine-koenig@baylibre.com, julianbraha@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, grondon@gmail.com, 
	devicetree@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan

> What this cover letter is missing is any info on maturity of the
> specification.  Is this at a stage where merging it to Linux
> makes sense, or are there still elements on the spec side that need
> to be resolved?

my intention is to preserve compatibility across firmware updates by
keeping existing message layouts, lengths and field meanings, including
units, unchanged. Incompatible changes would require a new protocol
major and corresponding driver support.

The remaining specification work is to reconcile the draft differences
on reserved fields, extensions and magnetometer units. I will document
the agreed rules and compatibility policy in a versioned specification
referenced by v10.

Thanks,

Jinseob

2026=EB=85=84 8=EC=9B=94 21=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 11:33, =
Jonathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, 20 Aug 2026 14:06:03 +0900
> Jinseob Kim <kimjinseob88@gmail.com> wrote:
>
> > Open Sensor Fusion (OSF) is a physical sensor board that reports
> > measurements over UART.  Add a serdev driver using the generic
> > "opensensorfusion,osf" compatible.
> >
> > The compatible is intentionally independent of a board model or firmwar=
e
> > revision.  A fixed wire header carries the protocol version, while a
> > capability report discovers the available sensors and channels at runti=
me.
> > Supported capabilities are exposed as four IIO devices: accelerometer,
> > gyroscope, magnetometer, and temperature.
> >
>
> Sashiko has one reasonable sounding comment
> https://sashiko.dev/#/patchset/20260820050608.5440-1-kimjinseob88%40gmail=
.com
>
> What this cover letter is missing is any info on maturity of the
> specification.  Is this at a stage where merging it to Linux
> makes sense, or are there still elements on the spec side that need
> to be resolved?
>
> I'll take a fresh look anyway given it has been a while since
> the last version, but others may make their decisions based on that
> statement of how mature things are.
>
> Jonathan
