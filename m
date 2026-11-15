Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794736683;
	b=xu0T8g6JNTXrdfVZvgYjtOeUMmm0qcQwr+t51nB4eddyGdk5lRqQIuN3dZHKvl46dR7X
	 qH9V8eIdRzXBqFAR5Jj8eP9Y+d9XFIQa3GAUtaCQ3lBPL5E+KSvKD7/fvrCc00L8+y815
	 JY7u6ecoA1LZ5DMSSeZQVoKUTr++lc+bn1s1zzQ4yYxsFU05apedaPOIzwxkAB3GAW3yC
	 D2oMxPWrUyK7PAkDnUhTsvbJSNqYSwKTs8FcN2sJE1gIDaNF0WcBx5rQ2Xce4qrNIifS9
	 3Ao39mFncAcKYTzu81ACGoYqjZw+txBzeVd6AdvkWo0v69fe30DQiHFPctdtPifqhPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736683;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=COD171vyvKxxKpwb5czI8gQ1mbPD23UlzxgscZ3Oayc=;
	b=Yp+hPmMCxM1FPJ//pLlcgI5y9+GPK7Afzg02IfITdDO0btjFeRswNLSUMUMb+++d59+g
	 DuVcGAa8lKSuMZwFwhLgTLSYszovlctWVVeywNlhmsu3LZL35sFL8hZ55yszAdFnLXuI9
	 cSqdmUy5wFxJjbTZi/JcZ0Kfu8DTUhmL1deQ5fIfGbqoljiK76hmoMYaXucUJvKIOCGZ9
	 gv6oj42H5qXoOwiKaNpRnTgDqGvHtlLzdC2F4pW2CPkue0fRuuZ8rmJVXOK9Xa6TT7LB9
	 TLfNASgsiwKrC4SJhdAAIF4UkmDJA6m9B1PIRQbtTJ+FjDI/4T7FLf8p0CKviJxf3JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=maryasin.name;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4CD606A880
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 09:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C4CD606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=maryasin.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so3756594a12.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 01:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794736682; x=1795341482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COD171vyvKxxKpwb5czI8gQ1mbPD23UlzxgscZ3Oayc=;
        b=2ZIQwcwMIIF0gm5+HdFjVDYc31YkqHtgskPSm9tDMhk1WJhfc+ZXptc7pThDbmTnLD
         RsFVbfO8jyKp2Hn8kIfWYLfZo3RKdZWoW9SPzCNYjRFd7kbGnFQ8MtVqBBtqmOyNufPP
         Eq4p8UywxGEU3XU+JU06qy73NEyhDAq6Er5za55z6PDWZOiGCcqxmmsb6RwygG1pdFN2
         bUe03wLW0+YjzyjNjML1AEgpeq1GxvV0GavB7lgtA+hUMgkgLCwFlX+R2zw6HV9n9rzg
         HSXdEIvMulzaU+K4EtsmWIRnc+Y63ZDlFJFCmadBWJVml9mk6odhWzKfdiSwMDWbx06X
         58KQ==
X-Forwarded-Encrypted: i=1; AL+hErH4gZ5CrGqbhD6selGs2hVFqGX2KZKGA1bRMgAR+KpOZaZDVNHfOGD+4Ix7QL5HklfQPrf8Pwt6mfs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rIAy4j1pgxL89ExBrSpdqtrAHCpURw3iPRplh2Gge2K7yUwqw
	W/5gtXprnMLWBpR87PQ+Inllz6Pi1F2cKQG2s3OkDsqpSWe9yRx/Kd9ygJZQHwcxoLY=
X-Gm-Gg: AYBFou292M1Ygna49aiulFwdppHb6Fyjco+jNTnHBL8pZZ+8rP1uSBK+tqaFsmcQyiV
	XcdS7O4e6jD+k52gaGAbFC/kh5CJ6RmYLmHZkcttsrgMuARDognr17Ay2IBd9+8ehDzEfhdYO1/
	GjonEKFMJectTFsXrMuS0SAuyQvEbTDbi0JcoxMqEASo8ycYPI98tN0prPGB6LMRtA8reAzk/xf
	BW2cynfL456uPc/ed2a03JB3lgQA7s7F/uMmdLX/bZm2b26lFd0RS6EOlRPTcV+JhC2LWylHlRw
	chrYG1f7oW5DLCNT9BkM3BpZgAfLvxZVr0kgOPgaXcFYUEWfIr1bBhDCs7jBhFx8QvkGOhP48qy
	42bMvO14Wk1QKy3QXcEhEkMeOmemFzgCmfLlva71qUpf1GGwg5Dsp3BGkjJPqNEciIABdkYBKzg
	aHKeAbQFByathvqGKjfMj5c3yDXNIamhvMtJAu3zhfLnE68fLZYwil5kKymP8gTU9W4uUifaPwv
	chD/BpPoDgV96LHcXOGo6Jv6Y6LY7Fa7naeNaWTvtG6rZFsG3xUQ6MhNA67HSGpeVUH30HsNml9
	5+F+aHQQEGI4fgJYJuvlFhOYY/ZDepgvVHOSngdswA0HKgglcBmygPhIGeWDnM+NtJxaI7f5dMt
	SaNkNcnhHSZEePG3l6DXxrDA+s5c59EaOhVfsw4fiyFlj8LwMz1GsV1brAQMU1C1nHFh2uw==
X-Received: by 2002:a05:6402:2b95:b0:6b5:4f5c:cb8 with SMTP id 4fb4d7f45d1cf-6b7c0d1c91emr5519893a12.44.1794736681677;
        Sun, 15 Nov 2026 01:58:01 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c235e605sm3283059a12.11.2026.11.15.01.58.01
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 01:58:01 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b7bffb5b8fso3250262a12.3
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 01:58:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGqefwP8l8YCWEyulTqXZgZW7CcYKbeQuD8fJ02PFBRTWEA9pwus2GvtqLX3/Xb6jk5flJ/WdDZ7yo=@vger.kernel.org
X-Received: by 2002:a05:6402:c892:20b0:6b4:21b3:a407 with SMTP id
 4fb4d7f45d1cf-6b7c0bd9233mr3786660a12.22.1794736681074; Sun, 15 Nov 2026
 01:58:01 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109195949.384888-1-srinivas.pandruvada@linux.intel.com> <20261114222827.4213d48b@jic23-hlaptop>
In-Reply-To: <20261114222827.4213d48b@jic23-hlaptop>
From: =?UTF-8?B?0KHQtdC80ZHQvSDQnNCw0YDRjNGP0YHQuNC9?= <simeon@maryasin.name>
Date: Sun, 15 Nov 2026 12:57:50 +0300
X-Gmail-Original-Message-ID: <CAM2dg7fDiAwbyJ6MdmbEbzCORWOvw3M8PA=DizDVW9dqJ41YDg@mail.gmail.com>
X-Gm-Features: AclHuK8YKYYd7hTDUaScS4yR4PzTj4mTm3WbiHpGDDzYY5tPmdTHWffr9PweY48
Message-ID: <CAM2dg7fDiAwbyJ6MdmbEbzCORWOvw3M8PA=DizDVW9dqJ41YDg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] HID: sensor: custom: use-after-free after remove
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, jikos@kernel.org, 
	bentiss@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lixu.zhang@intel.com, crofts@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Semyon Maryasin <simeon@maryasin.name>

Works much the same as the previous version. When I do `rmmod
intel_ishtp_hid` under an active reader, I get several Timeout errors
in kmsg (8 this time) after which the module is unloaded and the
reader reports "No such device".
After reloading the module, sensors work fine again.

> kernel: hid-sensor-hub 001F:8087:0AC2.0004: timeout waiting for response =
from ISHTP device

=D0=B2=D1=81, 15 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 01:2=
8, Jonathan Cameron <jic23@kernel.org>:
>
> On Mon,  9 Nov 2026 11:59:42 -0800
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>
> > This is v3 version with changes suggested by shashiko-bot and Jonathan.
> > Also rebased on top of 7.4-rc2 kernel release.
> >
> > This patch series is essentially the same version that was sent to
> > Semyon for testing.
> >
> > Following a feedback review conducted with various AI models, it was
> > suggested to break each change into individual, separate patches. This
> > makes perfect sense, which is why this series now contains more patches=
.
> >
> > Additionally, these reviews identified issues in the adjacent probe and
> > removal code when active sensor instances are present. I have addressed
> > those issues in this version as well.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>
> Thanks,
>
> J
>


--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=
=D0=BD
