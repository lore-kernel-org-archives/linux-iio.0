Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5F39B49E
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781341078; cv=none; b=NtoIoK2dgrDAK/FRmzbNQU4tLNnVYrLbq0VNt32L+pTC90h6+3yejHeqinjGSFx7pIr3vRPOJpEW55eZf+T4yt9IINGgfA4xAJWF6KfAlcWKYcbSPlP12/AqkSrq1MkgPHOTVJgDp9bff2kljDBahImAPu2ORmfhnNHSMwvlNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781341078; c=relaxed/simple;
	bh=KxmEFsiaYYNkfspFB8uKNZ4vxVJa1iAcPyPU4pJgezM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yr8gcMd2oxkyHgbWVnxoPqRo6rmfieifMfBS2v89tILiZgzV/tk/dYFEAg5p7RzPBeIRR3EACaFFx+NWaHMyhQhvW3PoXAnDX8MJoHdE3RCpa1ku5wnbYMwQNB+C9V+JTVn6ECgLGA8XjADhruUP/dFT1i9paBLC4WBf19It8TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7e0aa486af8so20381147b3.1
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 01:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781341075; x=1781945875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8EVlQKkEG7RLm/aT+nw257EWmKYSXeMTO6xqdrR77mE=;
        b=c2aRKXxmNsDUIuWcit7ng+7Cw5T5L36kFdKMHf/L09Ul0BFpKyl4wkyTjqo0EM2WJC
         2xNI3CteJ7elxYpUbNzo7FxdluZfQMVtT1mwS8iuO4VJe847xqj2K5hI4qyWLmJhe1zf
         orEWXg9dPaqt6N1/lyEa3KclrVY2ddBA9axUXp+yyrnnpZqLLlCClpN1xknutCOuWSrZ
         g87mFANvEVr6mxqd6sOlU8MO+mBEHc1L67ojo5+DBhO5wk7+IslxCsQtQkzhka7wQ987
         Pokyk0z32dCwN8FS5vsLZQxVBJz2uke08KWjPvDIrcg4azIa84TRGOkMPNFGQsqpbrnK
         RY2A==
X-Forwarded-Encrypted: i=1; AFNElJ8Q8jauJMtI5Q50lIQS3jJNVztiR4/yBBZ4Uh06U03Df1Dz7e0KxghJqZfuE0RaqId0DkivyZaxlGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmGCHeifC+jYq1n1v7irZS23ZdM/HC/EDMO7BgqEFNGlQG+RJ
	15FlZkRlhKcu0g0teGU3mBY4Re1gvolu168fV/7VMj61GtDzXANMbkUBCBLkIqIq
X-Gm-Gg: Acq92OHSW+6ghbrsDfgohOI/XZogqDI9g4cI5fbObquwOUioFKkelEy4X1/PbRsw05i
	k7QrGmaW0HUYZ5AdBP7p1VoSQFZW68rJiKkjbiJTs/TdJXEjp4zU7ZWIaLhne9UII8ezstqavJr
	xKR62vyMr9+hRVVhgluRxg5lFqLxoJiZB3OQdvUrVbC2Kah0uQtdP0NUuOWwJbKy3hk24s10neB
	UppfSfMbrxDpNwH1CpG24Y3y4QUWmTl/3R7QxWw3CXRgNgmVhumyIa9r+g1GaOdFeg+LBjiGtE8
	jdRqcNA6XaRCMRTGU/XCDz5zavRSmtW4PXsNN62tHuCdVRO4spqD8V8uYsCouxmWwgu6Yyg8AJn
	EC/rAs/cEORdK1E2AMZLXW3eOWjjAsr5Y5TemSPcDD9iq5WzAgVuo1EHqVOOkI0RCVFa7No2L1n
	XZiVv0U7S9fomQgUPVew9cZVVBjzv5R0xotDFlwU9W9/Mk6azbRfCewxksQXm0YlWUlyvRw9Px5
	N/kd84nCE27YY6TwTIj+t0NQdL5KmM1LrimSJQm3Fj9AasqRhle+WL+GI23xNeRunhLX/y7UqUH
	d8mhZlUHdtQgFHjbFEex5WeZLwE4dLaZ2NEdEFL+BlPH8MLT0E91Os3EZw==
X-Received: by 2002:a05:690c:358a:b0:7e8:60bd:979d with SMTP id 00721157ae682-7f7ce3fd2c3mr47651777b3.23.1781341075253;
        Sat, 13 Jun 2026 01:57:55 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f7712f3c11sm20546117b3.41.2026.06.13.01.57.54
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 01:57:54 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7f015f87fddso19354997b3.0
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 01:57:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9HwcSJJHb/YTCMIOgRWbvEnHmgjZAtox1DRL5FmEu3uJ/4yCBsKvGqDgaz9kXt+NArVhV5WxYEqtI=@vger.kernel.org
X-Received: by 2002:a05:690c:4a0c:b0:7ef:e7ec:b6e7 with SMTP id
 00721157ae682-7f7988731cfmr51443407b3.27.1781341074163; Sat, 13 Jun 2026
 01:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612124557.13750-1-email@sirat.me> <20260612124557.13750-3-email@sirat.me>
 <20260612173013.64f435ab@jic23-huawei>
In-Reply-To: <20260612173013.64f435ab@jic23-huawei>
From: Sirat <email@sirat.me>
Date: Sat, 13 Jun 2026 14:57:42 +0600
X-Gmail-Original-Message-ID: <CANn+LW+OSfo3u+7wZu11j7tQd-PGyhrz3a9+st-FwjOLbT4NBw@mail.gmail.com>
X-Gm-Features: AVVi8CfkEVa8jbtmbQfja_oWdfvUZG5fvSdkCptWn5Mrht3KziUi5MBOh60cRjA
Message-ID: <CANn+LW+OSfo3u+7wZu11j7tQd-PGyhrz3a9+st-FwjOLbT4NBw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: magnetometer: add QST QMC5883L Sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 10:30=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Fri, 12 Jun 2026 18:45:26 +0600
> Siratul Islam <email@sirat.me> wrote:
>
> > Add devicetree binding for the QST QMC5883L 3-Axis Magnetic Sensor
> > connected via i2c.
> > Interrupt not implemented in driver but kept in the binding for future
> > addition.
> No need to mention that
Got it. In the past I was advised to mention certain choices in the
commit message. I am still looking for the balance.
>
> The rest looks good to  me.
>
> Thanks,
>
> Jonathan
>
Thanks
Sirat
