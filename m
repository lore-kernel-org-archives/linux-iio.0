Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAFF211A28
	for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917804; cv=pass; b=oKHc6bmLqXuPbIVp1QhPb4UzL7XqeSOcRKPFcgKss945eJeBbncRSq5mwkNQMJ8y2/erSjVVVUbPrYJqCVon/AokmsoR1xAGALruDXrNW9bnUQmzsAdYNGx11Kmrl3r3Ai5B9M9AhhelOYSqFwonPo2YnfbeTh214KRQI4CF0HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917804; c=relaxed/simple;
	bh=3CjPaR7dXI70Ts3a0V/kq1h0g73pss7EqLnjg7RrflA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8/ughWGI4zk4W02VZhk8YidWxThUok7bMrBgCNPHW3E7RGkGyKCKJ9pPx1owpDJ9TrOIvQMtTMBxQyIDPVeX4Gswc8jJkg20XvtY866BF2m2goB3cATCtzpPW0PzsBWiweGY3Jh70wDcItyV9HgEZLe0lUUE8+xjQLGfi5EPTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTWdxSbB; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTWdxSbB"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8954c53259dso152136d6.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 09:36:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770917803; cv=none;
        d=google.com; s=arc-20240605;
        b=DowaJFOzC4sN1IBKFP6AznquHYAP2qqGkgVyaX6yabZYmPGBuEgZGeYS906JZQ5dg3
         L8r6xdvu50r67bwD3eX6Y0hmLBvhK2JvGuqsLzRlx5UaGQTwSUpjpWNUQevK1XnztfpL
         V7pSFnNYVDoXzShLVymsyptc1GzfQPUbf0XZg35e2zfORScFJJDhSYTK9vcxjRMKYX3R
         Roh8/XMbIXzC17VHeNtEsgd7OEzQsJMect+CHGmgV5ifMaDMeVT9hmmI/rpV6uy5gP2F
         FSPD0WiYy0ktbRGz8DjHKr5shxfdEnLWHLK0uI2WFF3N/Cm2xOh6GXOBwZFfQuctbnUu
         1vNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3CjPaR7dXI70Ts3a0V/kq1h0g73pss7EqLnjg7RrflA=;
        fh=3gydztCFDwlhgnF7nviZallwKdcdynHiaFUdA6chg8s=;
        b=dVAbt2f4sLQ9yYLIslqxbWqZ0Py8oJoVrZGKJgVcllQxFZpDL/uBizTFodQGxgz6kH
         4XykSbpI3UPtnv1XdP+bDmtYZCU59aje8ONTkpq55FtNVRiEdRXM0T5nIyMt/FteN78m
         T0g3CdZr/ArY4vdEeL8YotOqpz7lcnqTBfrnhm+hXJzZOPWWrr+klJNbZ/QdCLdS47In
         ZIZfq+s1obk5m7fS5QHTtNcbeC4h8/UoydY3TaGg2U0I3stxl/8Nh49wzrEFxNfwX03c
         rkaV7q1cJISU6cJDwA4qXls+GU1Cm4tp6ULSpU1yKnXEMaWTd5J/w65s3yathfTg9/fH
         mJMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770917803; x=1771522603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CjPaR7dXI70Ts3a0V/kq1h0g73pss7EqLnjg7RrflA=;
        b=UTWdxSbB6Ksgw/BmX8tTuldchaDHKxcI80e31SIESrAxVbSGZV7ftGYue/YA/NJFIR
         f2Cv9BBG+9QQTuvD8aGS7dEJoNwVK6UQKfS8tMpGDL9YyO0ktLyJUVNh5hsh58mva7Om
         XfyED+KGJYFfn13KTFicrL+05rZvoVSjpQWZ74gyAbS9XTocfavGpYS4858+FeFSsIO7
         Xick0uSflEy87+KsgkKmebWbF9CCcpLtIujJJoapFvmx9/OZ0NZN52kEw0Q6xtJx6WHx
         lGr64siwExnSTLNZPYzni7CP1FLQe6RD5uwm6MKfe0dw5dFoGFCayhM8e2ulCzNXV7IV
         iYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917803; x=1771522603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3CjPaR7dXI70Ts3a0V/kq1h0g73pss7EqLnjg7RrflA=;
        b=DsjUHNOD6QNGqttevNhcSiYZHIMLYPK1W0xajR3iT/a+7InxuOusOlSV8oB7qNkIzb
         +VnFnIIbsyVJsPlXENu7jSD4PeYfnkGvS+fUErLbHGFuFC0ioeHFDvf6dPhcaaTCvnCJ
         KoMwaBUzrobviC0SOKcaKjP+mFmkPs2UmYhW7j1e1I7k8x+6JtAldcUCc/ydSm/GkwJ2
         lDvO9P51EqfpH/qGQA4NaJmZ79Lqm40qn1kEn9sLkjzc2DDAfPkG9Ey/YyK00IiiO3LD
         8s0qPr69cG57pzN/P/fN9mXBadvi8CWXxLECOZp1uII+5aRf7y0n3b26kqAYiHdtqSID
         Z25A==
X-Forwarded-Encrypted: i=1; AJvYcCVJ95WEyAHzscE7waIw6TulqwF4nP/EqvdwkWerbwM6/d1PW9u/N/ece7wiaBS1oS6N2Fl12eQX0KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsDt5SXdybybsG8l4X9eS8otmoztsrau8ig863d8RMv2/wyxn/
	tsuPEHiz7crQAdywehy8/0vjYAuqRUe7V0chp0ASVX7cXKE4rAVyCdtIOAd7Ucf8hzT39oFoDt5
	I11NT656WfdvMZ2LU7jQAxxIEwdNA3Yw=
X-Gm-Gg: AZuq6aIRcU2ipBopNEfqacGGrDdI6PY9VQV6mX5txplwIKLyHpnFI/r95Rd/u7SDWVl
	1qq0Jkta19QTHrj/B8M6zZqacRD87xQNSYkixePmj0kQ3t4436wWLPsNbwyuCwKphJnvsAsaOc2
	NmH5vpnQNU1GmU9W5sva9snn5K/kJkCgtkgLisZKomFI23Kc+7KKb4l9YG3H4zJHDmOj1pmKMSM
	E553/4fcqGzKsgueGwVj3d9kEJjCyDGY+RigoQJ4iBdkyFilCHBfwDTa8hKWQq9WkjYgRfkQ7v9
	FsGm57wriG+alKl2zkpNuWzAnDrHFv5IMYW2j2XGuVkAucnS+CFXgRlA9iMcth3rS/EiYaUKKns
	ML95RxXQ=
X-Received: by 2002:a05:6214:4841:b0:896:faba:623a with SMTP id
 6a1803df08f44-897334e73f8mr3987776d6.7.1770917802728; Thu, 12 Feb 2026
 09:36:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
 <20260212-upstream-20260219-v2-3-2b28fce5d09e@gmail.com> <20260212-spiffy-true-porpoise-5a9e86@quoll>
In-Reply-To: <20260212-spiffy-true-porpoise-5a9e86@quoll>
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Fri, 13 Feb 2026 01:36:31 +0800
X-Gm-Features: AZwV_Qg12vM3aHX-Jn3bTTB5OYmvRWOZRlFMVgVkibwekXFhwFtDublkvtAqcRU
Message-ID: <CA+NOmz+1=CcczM5avBqBVzFDbeOSbvPit_g3T1qvaMh75hRUnw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: proximity: hx9023s: support
 firmware-name property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 7:23=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Thu, Feb 12, 2026 at 02:26:54PM +0800, Yasin Lee wrote:
> > Allow specifying the firmware file name via device tree.
>
> Nothing improved here. So again: Why do we want to allow it? Why a
> device needs a firmware now but before it did not need? What changed?
>
> You already got these questions.
>

Hi Krzysztof,

You are right, the commit message did not sufficiently explain the
motivation.

The device has always required firmware; previously the driver assumed
a single default firmware file name suitable for the reference design.
What changes here is that different boards may use different electrode
layouts and mechanical structures, which require distinct calibration
and configuration data.

I will update the commit message in v3 to clearly describe this and to
clarify that the property represents board-level hardware differences.

Sorry for the confusion, and thank you for the review.

Best regards,
Yasin Lee

>
> Best regards,
> Krzysztof
>
