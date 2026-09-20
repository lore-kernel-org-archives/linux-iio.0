Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B923393F
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 04:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789876898; cv=pass; b=InZNpoeb/UDQps6sMvTFGujc8AvsKwHT+u5Snu9kTYM9m4bfl+PPqGb8A2CJ2oljReZ3p/+nBH09/Z//JWVQMMyrXLnONJ2UVcTfTZCrbAUsdjD/gLLspHU1pCwY1lSU46Dmqt+qGcBx4D8AJSj+jdz+UUQBcua83L/jC7nzp4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789876898; c=relaxed/simple;
	bh=8MRsJ4ym5BfLS+pI4d5slk5a3DzlZM37ogJ96KDiTjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGeFJXc2t87H8vXREZ1MckuajpvWlZQpKMtlPsHY7w/Naj7weEGSsEabgjFyfoMjqPZpruRtOgO8ad2rn0ap3fkhvPzSG6b8zgCidYumucJM6/2DJeAtzFPy0j4C7eSe318f8OEkCJHitvugBalHhn3gWWgxeP4yf113PTxuJ/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oukYNOiT; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oukYNOiT"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebcb8d7so606652a12.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 21:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789876897; cv=none;
        d=google.com; s=arc-20260327;
        b=D2/8ABgfWAyRAbY5zLOH9scFvsGqYlj4KpKLlUgLEwb1NCD5H5wwYf3LjTlkB7eV1a
         wYleQxUmKwUCPXiNYY+hosgjqvtI08EPWJl6wWtPX6QAas8xRMZSjZDUspV4zGMrUa0M
         pf4HsPruRCCCcpmWMogzXBY5tEt8l610iXOY+oJeV7IKJ0LTFl83bZNlSl1mLbLuN8Xi
         tfY27OFK3JJlXRiyFuqoMC/mg8pmfBoTqS/LL+FVPo/gBPm8rVqRmcP6AtafwUkfMqux
         fN+Xad0BQmwogFXB0GbGZRgz/PIicQA/0xFuDufV0XGZtmzC59BH+Y0HTU8+q5vOQKb5
         WJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DzSJZtQqS8qgid4iKiRla6YWv3q35ndUXzYa83ma450=;
        fh=SS/yhfOMBubnvlk9ISa/nQP49IC4RfojwqubkQZRFIY=;
        b=K5cNy3ZnVvK/Ku3OWvWUmNKeMED9nhxgTiY+dU1nGJzGrm18osN6JrSq1z6mNsooUQ
         pOE8rewA8wcJijsx2xM5qqgg2HP12YpkDJms7nj2W2n4mcjgg0aXtSKrJaUCyfGCoLEG
         nhnkL/OqWCbu9GaYbsjVvK8XPWXCQQZuzuItXtKkoMt5wpm4KzWN6ILGLGtDsUJsFKoP
         AWt+1sFh7X7cFe1JdmG/oXi56x4aGnvae9c+gywKuRKRsvYPdcKgsyuIPahr1gtCxGQv
         8oZ4YlXQ21axA/GZlA4uKkyM5rsphHzt3a/7eVJeWnSlx6Yui1O3/QaE6gYZ4bGT8j9Q
         DjpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789876897; x=1790481697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DzSJZtQqS8qgid4iKiRla6YWv3q35ndUXzYa83ma450=;
        b=oukYNOiT2lGJIwhN98PhBCjlGi2afFMHWaR4BmV7cRi0jlz+YuFpYfnqkwH2fzParu
         8kraYOC+3pkCMMjZ2hZ3HyXQqsVI0B3Rymz0m+Op0vYHqVRZebBe04lr3utC7n5Dwo6Y
         /wvp0uhmDaocXYqVnIdqa6PYkQNCoj/PsEGB7pMci1dr+b5Gb9m9ppwyS0Hs/dFwLsu5
         ZD2HHlr2z/RYModYKS/j08ZW//6cpnTjJKnkB1eEaQFkYCJur86yTnyJ3pTsA0xQZDbC
         6IEGE3AcUFwRzG4hQrf5RvfzvkLChDRoXpKc7qyX4GfaG9uArK8X3DoZt3OgQAf8kLJz
         Cxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789876897; x=1790481697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DzSJZtQqS8qgid4iKiRla6YWv3q35ndUXzYa83ma450=;
        b=DDq4rOYJepC4bDQ3o880Hs4lCoHaJhPjYO6LDcKi9U9blRL9iGkqcqQJbKQixdoBAw
         igMFYi5jFdVP+DJjL7AM1ew8gqDXLVD4LBjauAfOHmzLYDSNCWUTW3WH9wl9ubxLhK0L
         LomX1ph3coaKYAIvMY0y9rhYBoViw+tnXg2KHvDWp3xR7BW5A5gcnXcKNIIySew/95Lf
         g7KbtdWmlOEwdaiJhmRMu/4emR8eRpT86P/rZUGe70t5w2ej9+e2KDyY5u4g0JS9yaPD
         OJNJMvyYFqRnjjbHSdYbcUqC3POmLbaaV2sqL6NKzmbYIksU4NKrthMS7PtR4Cg5Atff
         QtGw==
X-Gm-Message-State: AFuF++nQS2LM/yDo7HU0ZyLcU8nql8PxRTfosUPvCW3gzUNzxOONCmPf
	tQtVxclpqSFnc7HsrAn7RP+Hpg1iqNXaSyIa1U/jP3o488NyyyPSTc51cJqK2q9bftNdpl09WWv
	0ccfLDSSFAJ0gZ6EtQWXy84MX99MrVjk=
X-Gm-Gg: AYBFou2e9WAVTv/bFbwxHKjpj9aNV5GLLjajThxo9Bq0qu34Ac0Bt3mUo2+wSzcviyC
	e5UiHiXp/UUTuDC0fB1QTbPCCG4XVzPpwOclq1e6pP8WZbyxz8D0C7jt8awUu8nOEZbrPdwGPCd
	ok81M0zAFNCfgTexfnJLyzxdQncDx/GKeiguSfUaw/e6lSqgEoOSWCWzDM0pJXftKnK11OBGahz
	nCYHwWgwaV+eimawqtxaZcC5BGbb7kDjunkfxbO1O4hg7PnHWC+XOASDVwlsJUrlzLfinzoW7VX
	x8zMXN8zeRm6287WfFlvdhogLB6HrQO7O0JobHBxsnBtx8ANE39Pjf1XQ4KyJxbizal2b7WEKfA
	j8niJqPlvrYJt1rwibEVS+7cZDiSSiGPXeOOdMOgr
X-Received: by 2002:a17:90b:4a11:b0:39e:6c68:fd93 with SMTP id
 98e67ed59e1d1-39e6c68fef4mr3902020a91.40.1789876896633; Sat, 19 Sep 2026
 21:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789753020.git.kimjinseob88@gmail.com> <499ecb38dc0b58b979ca1f38d2d30b4ef56cf825.1789753020.git.kimjinseob88@gmail.com>
 <20260920021420.5a13622f@jic23-hlaptop>
In-Reply-To: <20260920021420.5a13622f@jic23-hlaptop>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Sun, 20 Sep 2026 13:01:28 +0900
X-Gm-Features: AcwNN1U3rQwmlJbg_g4DdTUrrpMfiV8bKNCMI7xb5i2BgcHIced7B7DCzX82g08
Message-ID: <CALMSewKJ0ejyGi3KFb-uz3Lp1E7=8RbrYpOzP9z8-9yk8bnBUw@mail.gmail.com>
Subject: Re: [PATCH v10 1/8] dt-bindings: iio: add Open Sensor Fusion device
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org, 
	rdunlap@infradead.org, joshua.crofts1@gmail.com, u.kleine-koenig@baylibre.com, 
	julianbraha@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Sashiko raises a reasonable question about what you'd do if it turned
> out your current OSF GREEN doesn't quite comply with the specification
> or needs some additional quirks.  Does it make sense to have a more
> specific compatible with a fallback to the generic one?

Hi Jonathan

With that in mind, I agree that a specific compatible with the generic
OSF interface as a fallback is the better model.

OSF GREEN is one hardware variant in a family of boards with different
hardware capabilities and configurations. For example, GREEN does not
include RTK-GPS hardware, while another variant does. The firmware
still exposes the common OSF host interface and runtime capability
discovery, but the underlying boards are distinct hardware
implementations.

For the next revision I'll describe the current board as:

compatible =3D "opensensorfusion,osf-green",
             "opensensorfusion,osf";

The first string identifies the specific hardware, while the second
remains the common host-interface fallback. Future hardware variants
can get their own specific compatibles as they are supported, without
encoding their sensor inventory or protocol version into Device Tree.

OSF0 and the protocol major/minor will remain runtime wire-protocol details=
.

thanks,

Jinseob

2026=EB=85=84 9=EC=9B=94 20=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 10:14, =
Jonathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, 19 Sep 2026 03:24:39 +0900
> Jinseob Kim <kimjinseob88@gmail.com> wrote:
>
> > Add a binding for the generic Open Sensor Fusion host interface.
> >
> > Open Sensor Fusion devices report capabilities and samples over an OSF
> > protocol stream. Sensor channels are discovered at runtime from
> > capability reports instead of being described individually in Device
> > Tree.
> >
> > The protocol version is discovered at runtime from the OSF frame header=
.
> > OSF GREEN is a product identity, and OSF0 is a wire-format magic value,
> > so neither is used as the Linux compatible string.
> Sashiko raises a reasonable question about what you'd do if it turned
> out your current OSF GREEN doesn't quite comply with the specification
> or needs some additional quirks.  Does it make sense to have a more
> specific compatible with a fallback to the generic one?
>
> Or given this is mostly about device firmware maybe this is fine.
>
> Either way - would be good to add a note on why that doesn't make
> sense in this patch description.
>
> Thanks,
>
> Jonathan
