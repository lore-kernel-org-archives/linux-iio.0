Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1EB34FF46
	for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398909; cv=pass; b=uRLaKeFnHU4ngUrWXUaZ4Rkt+hdLuYfkjDoYva+NPLlBjCEAN33w9InsaOW+QJBEoKRAGDu3da1VbLyOcT0znBAd49oUGWSeX2h6j5/prMSIC2ZTN2Uvg7azYH00wTtHWXm7fS3+k+w89aHjMow9FUZuztNV6ME3hUgnBrB3n1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398909; c=relaxed/simple;
	bh=NVJ8+tcWOrnG2BZb0ni/WUdkoiT4ZKsuQ7I4PKTu8lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtFmK/y20Ef8oORgU6IJiyqSKu9wXydwUH68wFKyHTi1PUhXbD9S6gjp0cwCkqgUYcOtdGGD26nBASp4VHFhRzp/JTb0VI/NGgdJGvwJzSJYmFIu0lns1CEZLNmHGu221Wx+L1GqJxa19p2Ji+VffEaK28yee6bkK2gRrPY3qZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QB7X+l2H; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB7X+l2H"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so2972390a12.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 03:48:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773398906; cv=none;
        d=google.com; s=arc-20240605;
        b=eotIHXzNXsTtD5IL+8ajP+KqSFeOPG5CLLxFlolNNGf1zKCyIm26NpFfeuUK8Vhi3+
         K5hych8kKTPzut6LfoVqJDPBuorEFbPjhBaA1wU647A0oSET7SW3QDq5eVWPpJsuvEIY
         p5QOoNn+7MLJjaRi02kMYzrZ7DNs4FyVGBrfnIMeSegqlq/rJ75yq8S9bkOOMKOoEG2t
         q63cI31qi9UEdMfGQa7sH5tMeQOZ6a2yGNNJ6GlyWbB9RIKHd/0ehji/N0a4Y7yc5PhR
         i99HsXWUhV+46nUOFJ7N17K2LmnRNIKqKCK1z2gFFoJDpU80SBs5ySv2/mXgle+kJBTY
         hbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NVJ8+tcWOrnG2BZb0ni/WUdkoiT4ZKsuQ7I4PKTu8lk=;
        fh=dnUhT55HiqL4NWLE4DHD6WW+O428IVxpiCpknILj1sc=;
        b=YKlcoaJqu1C9S/pNhFF/onz0rw2/RCHYQIEPQjVVbC8h4qT5sPcAo0nIFsHEHYxg/Y
         hlXUubLIPUkSQoVGrJN6LF0CD2yfI/nFHkpV0eWdEkAtJZB3PTA+ssF/RJmyDIuq7owp
         EZU3AGbmTIa9ZLPGiLqcBqNW8v0LOaWB9iPHdL8TqAwHSOBLm3ul59UVhmMD+7ptbWRS
         KWRBBHfvCgP0FoC7xSNVizRiFVJSh516VmQWMSNkiFNnyfGbl9dWOFOAxu9Rh2qnJc9h
         D1qAKqHIjGIEYDh+hliEWDM6jDPxYUd6prEpD/072sa5/CKBb8KpuAJwKQio23XbIO2B
         IY4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773398906; x=1774003706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVJ8+tcWOrnG2BZb0ni/WUdkoiT4ZKsuQ7I4PKTu8lk=;
        b=QB7X+l2H5QezjMA4pPQmUNlyGEueh4QytLJ9n0Pt9Nr4G/8X3o05MuT5j1o1gGu9/g
         GDG0VgkAoyJojmb86BFQCfbhHK3Z4HcxxNmsqZwf35zyhKSVauzHRbD189C+6dSdl7f6
         Oc90b/m7d6h1fT9ForokNs6mc+y8UQK5EsWEX2kk6uoo8oSHEIfIwVsHOvQE/cLHeUPR
         tT4tQlr90c5FY7jGY6qy+o/18R4ZsAj2a9Ep8/zuI1rbWDS1hr02qaj7nqnP2bO+5oaz
         ++Z1IBRhGQpfM3m7a8Vu1/O5M0Xs8AM7YFa3j3ArRxNCgiO8cIjeCCuy4Pic7rNRUFQ1
         /PhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398906; x=1774003706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NVJ8+tcWOrnG2BZb0ni/WUdkoiT4ZKsuQ7I4PKTu8lk=;
        b=KLJ2XKdJDkoPwcxniqPUrARTY3ZBPLdvHTzAkASFwSw/TjoEEASrDOxKj51lYoW+wc
         eFtxWDKlIeLk5dn28Yl+EStTBK7W5w5ZD2LJK+iaQdfzrSb8NsMFKe3TYQBjdbaqHdX1
         gJdPCJj2tt+cSJd8f1hqyR26eK2Mcg3Q0nVaVZFSNHDhcSNubpTPEYymYKjpA4h6m7sE
         e5NzO7mZO3hqtODaQII3dZ3eeJ80UzC97Qd8HLhByacggQ1YpJJE8IisuBs6hItBXIIY
         9u7IAe/KbLgmA3FmJWsbRYqpWXT3G2nSm+fYRIkTDZHODw8iq3K/QFmSbwKfeVFDdTAl
         S/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSM5350hIKI9iElRnhC+O6lnTR957mHFuNBkBdcK6/Q8k8XWKBxw+5xb7sIsPItBm5EkSTFtfSzk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRO35LQ9qmeTAj7SsrDWV+wOCaqM1aR6S7tRSwBjHV2Yji13I
	ujyblpSXRR/+/2vkWkTP/G6fWqXtqlFXKF7sLjmKOoTgPbvuP+/78KIwCHBrrn3uSwN5N/kvbPk
	OzpJWBfvzIy6jAo6Rw86Rfe8QmzQ5qhzQYg==
X-Gm-Gg: ATEYQzzQMO503eqQ91unIzkbUYylAxxgD4A+9S2lK0oZoSlRlWiPMuDhjQTQ8PmYjvk
	jvnE53yJc/NZ4h/tj9gp/STweHXhL6OpJuhM6SW4eP+11209rrHHsgWbMqY9/UXy9DvrpioMY+/
	wLKlY9VGn3lKsywjRAOZVjdJsYvh+ffFuT1bDTpH9fk0ssv8S1O0LPd++On9NMtqHlEFDBI4mfx
	aDNJixrDvS9hhBp8+YY8MJMIQSPYrYFvXnfFy9oObgJodo/ezDVfSnoTOMttlkyBdSHPhnNxhBS
	Rdm9ogSlqbnt8QIav+FLOohdjIFSRxzyq2gdrE5IMy70WZLpJxfMPlQyrySNWKcpK4Zq
X-Received: by 2002:a05:6402:2805:b0:65b:f342:d1a2 with SMTP id
 4fb4d7f45d1cf-663ba0e7f8emr1609780a12.6.1773398906047; Fri, 13 Mar 2026
 03:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
 <20260312081942.23858-2-rajveer.chaudhari.linux@gmail.com>
 <abLLap9bN3tTXfD6@ashevche-desk.local> <CANS1UbjkAEhaLYWoDRFenBwrW91ttzo12cXS2CjtmW7Sz0pP3g@mail.gmail.com>
 <pndikb1kn9n.a.out@axis.com> <CANS1UbhMH_z=e5KrmxQv+D9=_7YQL=g=qdxv9e86iRjZ7LF=uA@mail.gmail.com>
 <pndh5qk2fd9.a.out@axis.com>
In-Reply-To: <pndh5qk2fd9.a.out@axis.com>
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Date: Fri, 13 Mar 2026 16:18:15 +0530
X-Gm-Features: AaiRm52_L4nFX9k57YCAVK5OvhW6mFLXlVgdPpAMRp5IV-2N4_MYdfhHW9t9sGU
Message-ID: <CANS1Ubh-O98hmD8UFininuJDduLg4g+muCPea6X8m8A52HBEKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] iio: accel: bmc150: convert to guard(mutex)
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linusw@kernel.org, 
	sakari.ailus@linux.intel.com, harshit.m.mogalapalli@oracle.com, 
	antoniu.miclaus@analog.com, andrew.ijano@gmail.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 3:58=E2=80=AFPM Waqar Hameed <waqar.hameed@axis.com=
> wrote:
>
> No worries! As I said before, it's not always easy navigating the
> different sub-systems in kernel development. A future tip is to see how
> most other drivers are written, they usually tend to follow the guide
> lines. If not, one can fix them on the go, just like here :)

Yesss got it!

Thank you :)
