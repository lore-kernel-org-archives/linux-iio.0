Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813384E8E17
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611125; cv=pass; b=Y/at6POhXNM7pYJvJZeca93chpUPugqqPyfm+57op9Sp6bhepgssgihETeVFewssy8rWjT0E9SrtXbAq+rEEGxiIBLVG4ZPXdNlgIMXDEvf7iTEYicrXEfFgVIlG6BMakx49cw0IA4icbK8WnzGGm2r9Mif6qM6Th2OGWq1V91Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611125; c=relaxed/simple;
	bh=RdJqioSCXAx+Y+b19ETks14A33wmF1LPgoEw9WF6cZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mighyQJblZ/x1QX2tLOG4HT/E+L9jooYF94PJ/UMii/geLr8cI2BgPRPz0eVk10gEacOhrwWwsl8nao/DHISW3FvpCn2w9Hr9tV8jnX8btdYGkCPw20M/xWMy4OhGjI7Io7Hsf7oZwVM/F47m50xIfbxfux6XGL/id8VatpgfNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npJbl+0D; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npJbl+0D"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a9edfc851so400371366b.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 08:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790611121; cv=none;
        d=google.com; s=arc-20260327;
        b=GFbMqK7FsKD4px8ZIn7leaImA6KDmQ0JxNZ1Kd5NNjgjvkEpJ6qofmGt4OiVR0kQLL
         f6xi+ZaBsVZ27OC1UKjyyz7PX54bP5ku3DmgqlrB15ytV5S8TfNsqRU0kPXobUIr7Q8A
         SjiGpM5FwKYRyPwMsNUhXyoGl5esv6FjvU8zQDzR7oaDS7vOtaykfKWr6WJmuC/QRKFL
         jBzDlpjHLPzjJ/A2rop+DDTW52cgNkpskrEaTl4lgcVGxHn6paWYzsZvS/M7rKAGaYDR
         cE27PEAr4CY3GinzwEzjXkLAYmxcGbViLXP8Iz2F0f/d9/KDcOta/QrTDb+scxzxA6Ky
         syQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RdJqioSCXAx+Y+b19ETks14A33wmF1LPgoEw9WF6cZw=;
        fh=MIeddZPDznHcDeWJPg5wrvNK3TBEkfcOmBnAc0x9zjk=;
        b=Hvl6h3EiMoxMOCJ7Mar77eET22fY1npz1RjysyFsn9IUQSoGa18aefzmNarvDI65Xp
         zhWVWVE4LNJSRHNJ7U6CyEmMGL3hF6HqrhnAlP/MfMqh3OG+JzWHPGcIWubwzEgAvlWb
         hVL2hA7kxPsk5wuIxLMvCcKGZ/7/TtCZ1snMNWFMA3JRDtdtYlQiCxcI1O8nqyHmNAAf
         cD7asiB7k4g1tnAKZ+Mq5/E2xmK3tuysSkGuOsbZQuIfFf9vRL5VUKk8T+VsCPBBWnmv
         qPdUx8YxX7H7cDIMigOhi4On1gKeaPl6ZrnMjX3mjeIp6/6enFo8/ewQcTlaSAnYzlb5
         jvsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790611121; x=1791215921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RdJqioSCXAx+Y+b19ETks14A33wmF1LPgoEw9WF6cZw=;
        b=npJbl+0DtGQolO3URSvafdY9yEV1RBqN5+NrZVZwrYFplstKglL1ITtLMpqrfsH8Z4
         NJ1aD9eHwkks25QtvRftrlkAnz5xVHwlU2nsAKpqMTMQkOatgYJPMsLQYp8mLtOIaNzm
         Rl8Ao2N5JEfxNkwhjJ7quUMH+TKDgqW03dGaLkBKgWwSlZ+gxBX1Kep0ceOa4ruDop1v
         uJqqe0lm56x13w+y6NoMnYt9F34wnqdiN0CZd0661YhW7b8wZUuDEqk5w1AKVVu1mtlC
         nGHFncOYXiCRPonCxlVqTuYFes+55DKrtWwBbkHeLr2zHIvdUjTw2TtEcWDaPxGbzW2m
         8+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611121; x=1791215921;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RdJqioSCXAx+Y+b19ETks14A33wmF1LPgoEw9WF6cZw=;
        b=UHmRKPfNrJyP/X8lcKZsPVukCJLZJ9qi4JzbNPWKvumgCO+TjXW4pKkSjcUwOXtX8n
         56rMBxtLYh5Zd+DkyFNpAWockSRBdB6JGL0ujuhVuohWg869qNEHwxk4408tTZQjYspC
         TYyBeKuYGZdXefs1Z0LsMkWvYESCgPhL6LgS6IZHRi7TxWRjdnzr6skrCkRMdRGydC00
         GziExor/UKg04npL3jxMgpenAdGGhjHrbqjpIyqZ6au1XNMps3diU8eK9oD9iQgXY5FT
         2M48Tw4bLTxmWnR1DDO3Oe7QIrMUVdKCCXy7MzZLyjo62zLHQkLkl6/+q3YU4yjdqAzl
         HMuA==
X-Forwarded-Encrypted: i=1; AKwUvBzGX4tduCarN2jsX263X8Yt1KTLEyR8xel/KqZDBOxrnJTg1fN/J1723VFXsoEe1Iwpw7Eq0MERwAc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLgNXx645dgXI5q7niCvqROhJU/M3NRKfrjbv2LogAnEeAnh60
	dsBBG69QoA2WUHv7opmXm+jEArgUHBeH3g6KPVhgW+y3JsjpHFAbhazkjUxLsNeMKxM2XtA9Fhy
	DRGzq9ibqqQ3sgBGEKqten3FcFiRNyXA=
X-Gm-Gg: AYBFou1NSpps6seGfIGDa9JXLD11ITg7LcKnJTFfNcmbZTVCPvFrjbHdfzdXSFZDDzf
	UNpkytTZ7WtfFh9+nyQyd7v+pgksEmSjmNKE7H4pspkQCW4o2HfKM9YA+D1pCrv0RyK7h8340l8
	WVeB+E2Q3pe5jIEr8PKNr2MJNhjaXBzgG+c8sIYqCTAkVsp6sxjVjQQ879WsVcp2eUL914OqL58
	AJu6MlMp4qpfn+Qi+2FqkXqNuDSQ6Fu2bTfVt08LGZxr2RNkEZFaLX8WC0BHqBoabdkyNSTCu4k
	xTnJQnL2/YCxdaXWLGjNjnKmyHR712Sk0q0NuUIHLMoNIaDiik54Q1Qjmz8dE0bkE9Cg5fI4UbI
	qKwnhemqyJQKxycQNcr4j2SJD2jcGnIgy9FFobIsyiFp8UsqyJ9mDEsrEFps104gIXiSLzyFJZt
	nIrehtWPBuXL4zv8W+36RzkQKlCptlaGg5rUOvMOdOLw==
X-Received: by 2002:a17:906:c102:b0:c25:64ea:4d70 with SMTP id
 a640c23a62f3a-c2ae97a023bmr784804966b.1.1790611121053; Mon, 28 Sep 2026
 08:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927220559.24169-1-jwuerz@gmail.com> <20260927220559.24169-3-jwuerz@gmail.com>
 <arovrVYSgU64DM5o@ashevche-desk.local> <20260928152901.69000-1-jwuerz@gmail.com>
In-Reply-To: <20260928152901.69000-1-jwuerz@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Sep 2026 18:58:03 +0300
X-Gm-Features: AclHuK9Y-mQrpqdnPfxDKMs0buPBbsakfcCbWxtZfim6Ik9ewJ3k4lJ6Az-T-QY
Message-ID: <CAHp75Vc3M+57123mya20i9LNCkcveVbMFj2m=H-BB2c3YD0ZLg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: imu: st_lsm6dsx: Add ACPI ID SMOCF05 for LSM6DS3TR-C
To: Jared Wuerzburger <jwuerz@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Samuel Dionne-Riel <samuel@dionne-riel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 6:29=E2=80=AFPM Jared Wuerzburger <jwuerz@gmail.com=
> wrote:
>
> On Mon, Sep 28, 2026 at 12:13:17PM +0300, Andy Shevchenko wrote:
> > On Sun, Sep 27, 2026 at 05:05:59PM -0500, Jared Wuerzburger wrote:

...

> > > Both I2C resources describe the same address, and the driver uses the
> > > first one. The vendor-specific SLA0/SLG0 mount matrices are not parse=
d
> > > here; the accelerometer orientation is handled in userspace through
> > > the systemd hwdb, as for SMOCF00.
> >
> > Hmm... But is that wrong? I mean does ACPI provide the correct data in =
mount
> > matrix?
>
> Good question, and it made me check more carefully: X and Y are right,
> Z isn't. SLA0 (-1 0 0; 0 -1 0; 0 0 -1) matches the Windows sensor
> convention, which reports the gravity vector (Z =3D -1g with the screen
> facing up). SLG0 being identity fits that: SLA0's negation is a sign
> convention, not a mounting rotation. With it applied via hwdb,
> auto-rotation on my V3 is correct (that only depends on the X and Y
> signs), but iio-sensor-proxy reports the tilt inverted: "tilted-down"
> with the screen leaning back. With -1 0 0; 0 -1 0; 0 0 1, a plain
> 180 degree rotation about Z, orientation and tilt are both right. That
> means the systemd hwdb entry that went in today [1] has the wrong Z
> sign; the fix is here [2].
>
> So the firmware values can't be used as a mount matrix as they are;
> reading SLA0 like ROTM, as v2 did, would have exported the same wrong
> Z. That's one more reason I'd keep this series to the ID and leave the
> orientation to hwdb, as was done for SMOCF00. If you'd still like the
> firmware data used in the driver, I'm happy to look at it as a
> follow-up, but it would need translating from the Windows convention
> rather than usingit as a mount matrix.

For the starter just summarize above in the commit message in v4. This
will justify usage of hwdb (IIUC the case).

> [1] https://github.com/systemd/systemd/pull/43935
> [2] https://github.com/systemd/systemd/pull/43941

--=20
With Best Regards,
Andy Shevchenko
