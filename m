Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069F83DA7D3
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278175; cv=pass; b=pKJHTNwLB+17qhlcJCn+0dgVzpZWuZtbFDEnD19RzLOeLu/+g+EbSmIfJimAqKk1GfE41ak4UlT8uK4IhRp8xFLrpMJRAyqL/hKdz4T/UjXMqYolX3xzLV4ARdNe1yhPRqcb3TOrV0lEv7nAY+R9GNsdUyahPPVLuKiQsgFUnz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278175; c=relaxed/simple;
	bh=I4SvhXPS8Ge8iiszZsgMBFDfyiyXtqJH1BB6jNaAL3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqnDTvxDXhaLwY/qfHhOjkjIUuHC2x0vspYb6bLKyttbsOlY5wtheM/IfYRygIca31KoSXKkGe8FKsJH+bkHU/7obyhrPoNnhy0UxvJbkxOpGCyXz74dpPtET4jte8B5l7AbSHqlOkVSftnHIng6Lx8cQd8Lrp0uuO3ng3m3Mw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxd/z3lQ; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxd/z3lQ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bdb3fd39045so42070666b.3
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 04:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779278172; cv=none;
        d=google.com; s=arc-20240605;
        b=TVjkXg+chy3rIeumoFkcPgMMGauhvdft8zICyKZB90ZLUQ5cDgGmwsjRC+o0eh6Y6Q
         /hEDxI1h20SEoxp3uTXCOWfcwlOj46uDXAvyeTPnp0CIVvd5LefrNpTnyFFvh8H/rOKv
         pjRuJtnyAUTz1gg+35cFG3mv2rZEq597DW1/BeXkr6r/FdzAiqEDYYsm0byI4BDqognS
         i4Zeay7Ncz8u4GozBVPQa7aftKUfbgufbL5a+ih3Ucp3D+CcaD9TfsAlzYK/y2cBT+ah
         00SMp1uQBCAVs483LwLxnFn3gXwYjYeBvWwc07rFgoDSCbOWl+qVvxxwL6QhHqUPyD9T
         41SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6I/A82YX8z6OO2krWYOPssthDRygskaDMocR9Ah5D0I=;
        fh=V0HhjucF8wBqkHiHG1TTjeJZuTbRDHrL758CM9E/DME=;
        b=bE77x76VFKLSDTzh5hjpaJfJLaD0akEGKn+wS0WoQl0FrmlKyMcR57f05+CYrGjX4x
         YWTuXZWpzK+RCqQQh2LjUZF/sGx1TUyLJvX3PFpHugdvDYKlhjuMqiAdxie+xYpcVYTx
         jh1GOUYHCZ8DgwFvF6ajWV1jr4CzrBlzazuLhGtdHBQ4pq7iujSiPReHQdMChAncHhLa
         EGZlVfFOJcX4H+5zjNYT3odZTZiXeVuM13uhqfdZ+KLEMQqI2eS6Qtz+fCMq+X3JwUcH
         p674wgnuR2hQQNBxFAezJQnFzSFIQ8sZTvUjDTo6RtF/J1fMf5tgucN443jTBx4Jznjm
         0URA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779278172; x=1779882972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6I/A82YX8z6OO2krWYOPssthDRygskaDMocR9Ah5D0I=;
        b=gxd/z3lQXG96sL7Nf7KKBVK7kAW8W+4+L1VThP9fABVfZWixeJoh/mSStTcNFc1tPN
         flv/5gzaR4V0FscaJvWiGF2dnUdbkn5HdusybpI3r5AHcCmKxo5OACkaXKytwQ+GQa37
         W0gHCsIGT65F+XV8Yw61nsQUozH2p+RvwThFHXTbbzEhD5DYJeR98bjhdK8sUATee5MY
         wkglLAQz7Un1flTLxOrOzSf9196ZpJtHrI/1Gu7u27+e4yCPjvVQ8RuiqwKyWexfKWbX
         XC7wsthI/YAdEducWokQWS9g3Jn9426pm8+OcmpBATqq2MG4GExQ0QquDHXapdgxrueo
         SZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779278172; x=1779882972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6I/A82YX8z6OO2krWYOPssthDRygskaDMocR9Ah5D0I=;
        b=cJ7J+PU1FEhZ+gLcz5y4M2e1/U92BJ2hC/Qj+MRwt30zds6BnFl8dfF8Rd2bqFWzrb
         ncKyGV6h5l51Tq5sX9Q7zfxZI/zwp/L/igQHi27I5KCLc/+h8npfV/vMMEOjIMMKJ8d5
         MChfWuFuI9mL3zx+1pc438gZhkeClW58Z8s2stU0TFht/A5ccJD2lIINX6dFOTiG055Z
         ZrfcBitS4JI6Zvk2RcWBTnFZp20E4LhWW7OJsp82JcAUZFg540/aSi8YsHws13xOverR
         iKvQ1R/ZgLgGJ29hSX3l8fXi6n7bDMlQxzOYnYYkSDWDifYxgoAEGsRHS7V/4M2ZR06o
         yFJg==
X-Forwarded-Encrypted: i=1; AFNElJ8+mqfBF1RFmJK5ThU52dBEnZqlbDXxBpYI0W6dko6Guj+Oyis8ozH1Uz9sksGPo9EY9WEzemnomIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOV+eu5MqMw3xOl3ljopXkFMF/5yjoJ30kq3//VQbokrOmBCO
	oRe0KVMqWf7I9VbFumpUrWyiKTUX3Te5dY+p/9Af8W8ZUYUsHGuVwQ4UQZTQBYaOmhXP7xcQIfK
	37hsF6xKxyCWhYx8vJUtMSlp6de4skNY=
X-Gm-Gg: Acq92OH4pHpR9oE0xvXwvuQC7cYqmsLlE6xXaEoxDt05fWARgXebUByaKnj6tPLlJVL
	vj8dhd1vWJEitIwOkQrnT/cE2GC24z0BQXZ11BsvkZBns/HDg/izNXYVvzUUyK5Gwyb3QGIi2vH
	y7XdPVNpOlzLcJWMSGtoNGp6TYtGhU0taxrZt7m1A0fUk5zgK7cL7lYFR6anbByVmn0sgNGKLWL
	cF4+iEJZ0q0ijZfNqHSnHq9ye8H1iaJSnpsGyMN87/WU2jOmpdvoLjXtDb9wFcuQw28jdOsXzBJ
	Rzdtc3y3aeuUaW8dIydKIe73Afzq+zGB5JXy7wkIVAmjx3mzpueZAzMB0IHynMohJ2ffOc8SkeN
	+/qTa7BDA
X-Received: by 2002:a17:907:d411:b0:bd3:897c:7800 with SMTP id
 a640c23a62f3a-bd5177ebb17mr1398529166b.15.1779278172121; Wed, 20 May 2026
 04:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520072843.3593-1-kimjinseob88@gmail.com>
In-Reply-To: <20260520072843.3593-1-kimjinseob88@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 20 May 2026 14:55:35 +0300
X-Gm-Features: AVHnY4L4aitoKa_0WRF4H0ViCogDLK9J7rRSZAZRx-vweqx6tym1NL58_C8VI1w
Message-ID: <CAHp75VeHif8zzYg-4qKxwA=q3emszTzyoQEtpoK7QbcwDhQZKw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] iio: add Open Sensor Fusion UART driver
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 1:47=E2=80=AFPM Jinseob Kim <kimjinseob88@gmail.com=
> wrote:
>
> Open Sensor Fusion is a UART-attached sensor aggregation device. The curr=
ent
> prototype sends OSF protocol v0 frames over a host UART link. This RFC ad=
ds the
> first Linux IIO receive path for that UART stream.
>
> The first transport is serdev UART. USB, real sensor reads, fusion output=
, and
> production timestamp correlation are intentionally left out of this serie=
s.
>
> The driver code is kept in one patch for the first RFC to avoid intermedi=
ate
> non-buildable states. The internal files are still split by protocol, str=
eam,
> core, transport, and IIO code.
>
> Current validation coverage:
>
> - STM32F405 test firmware OSF protocol v0 UART stream at 115200 8N1.
> - Raspberry Pi 4 serdev probe and receive path to osf_core_receive_frame(=
).
> - CAPABILITY_REPORT-driven IIO device registration.
> - IIO read_raw for accel, gyro, magn, and temp samples.
> - IIO software kfifo buffer userspace read.
> - scan decode helper for buffered samples.
> - dt_binding_check pass for the binding.
> - checkpatch.pl --strict with ERROR 0, WARNING 0, CHECK 0.
> - W=3D1 source compile/link phase clean in the staging kernel tree.
> - modpost unresolved symbol warnings came from the staging tree missing
>   Module.symvers.
>
> Known limits:
>
> - The sample source is synthetic stream data, not real ICM-42688-P or MMC=
5983MA
>   sensor reads.
> - The IIO timestamp is Linux host receive time. Device time correlation i=
s still
>   open.
> - Runtime capability removal is not implemented.
> - The staging layout uses drivers/iio/opensensorfusion/. The final direct=
ory is
>   open for review.
>
> Review feedback wanted on the IIO device layout, timestamp policy, bindin=
g
> shape, and driver directory.


>  16 files changed, 1706 insertions(+)

No.
Split it to at least 5 patches (as far as I can briefly see it's
achievable): base + feature1 + feature2 + =E2=80=A6

--=20
With Best Regards,
Andy Shevchenko
