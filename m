Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B11548C
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016384; cv=pass; b=ILAkN3U2/fZKkZtIIHYYXGQXZbgNdbum2MrVB7IDewee01ScG465ERh+6FBSuB1i7E+8QhamgTTKrMFe05sIjyz8NjpOP4eHcoZpuBtWre5XMmYwcW8O6RpoHVsBROT8ApHALU1XkU9HPSVX+UW5PVdPP3lDMMwnEzJNEPvQF1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016384; c=relaxed/simple;
	bh=OQbY1RoJ5rrruuZL02Hf55qSA2374g3gDMhWT2uliQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cl1+6Kwv08UabKWMxKwQjxRdtYppKP2rzoML9c7YxJIUeEpYNEzdMTNd91F+FfP1eg7WJ5JjG9zXpxOv8SYeuG6XrPJdgT6MgDtGff0nzDCfja9ueyLGoUVnLcbUtfOEPYFX+O5XdBCwxuM8Ol/UemeRhyrRHaEd3OjWgm1a/bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqhrq7Gk; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqhrq7Gk"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso41280395e9.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 14:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778016381; cv=none;
        d=google.com; s=arc-20240605;
        b=kqW8ndfUiz0rtQ3d3J+XfjXJKiR/x4Q2oqDYSeq6jf0mAzAgsFtSEjsR6aSXvhfLrx
         dKBZ72hEnIt4WO/6uxf8CSQaqtIDVy/OUBgxmCt2vA+E4mCPsqLI77Fd96WNptLXYx5R
         +hPqzUMhIRVc5Yfd0BipqzefqV9saZLGxsxPxb9elddqPTrKTklP2+sbeA5vmea/85zc
         HS7HXsgrhMcOGZotiydN+PnoN7aB6mhzKbLKvIZFyCjRLMD7er7HpGXtK8Pwbkr53YQ0
         P0W4k4TZxS47kcQxWc0fZSDADUpHMhR93ftClWYlraFMBVUFdwXw5gjpcGlQlaYkbwS5
         V6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4xBOydDnbz6whiZJLksbRXNzAiyzQFjk8S58xmjWi1I=;
        fh=4MR/enhx23yqfeRuC83hG1L7/bPX193+RBn1ndBD7lM=;
        b=E67mBZXjwrv6g/LeCTj/DV1nSgxsWPjONKsL2KOt8ao3yN5wWPMdLOVYs01oC2I/Bz
         VzKCjDxnHTkD2U4WcPR75TRC9f4c59bbP0q+WOWcSCigk8XsBmI5RJiIdOtZkipka8nP
         uDf/M2m8YPaA/fNlVxpuCXaP2HBi+GpkHZBEvBbjoSvTGF9fMpJLxxxQVzIgB85sQez9
         jJ56bwXO/zc7G5saNK1LhZJ8b/r/j4SIO9QSc4luZMs+69IxemmDpGeD0DEe876G7OVx
         aMP6Wl2jvlW5puqi9i0b18D5ZMb3WRNOi6T9WYuY7EUpkEY+p/3gj8PsDYctOxFMrTin
         qH9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778016381; x=1778621181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xBOydDnbz6whiZJLksbRXNzAiyzQFjk8S58xmjWi1I=;
        b=gqhrq7GkstTMeFx/JVljM92c55XIsKRgGgJcp3JKl42fA7LQFtdIfGGtJmxjl95DZE
         jnIgCYn50TujvGwE4Uloc96CtmPBHqOGt5fIBncRGRm5CYPSN+H5jDFyMCV51lVpIQJ+
         6dv7bSHFC2maCJnDC8YTdk2Qzx7PqL62QWs+jEGzU4dLLAoD1NRDl7+4aIZHJAhPkrig
         JIfmU4GPtKwfzK+95weydjHe3BgOZ85A/p2RteGtXSDqpWcY3O/1tV1hYPI76m1bqEP/
         grApIUg4imTduTX4zaEhUlINmqbwpeqU6aNhKnbbSI/zZNgI+a2NWSptlX+LUhhf+i9H
         rX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016381; x=1778621181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xBOydDnbz6whiZJLksbRXNzAiyzQFjk8S58xmjWi1I=;
        b=sKhPnFhhOW7j73C96iKgdjQcGZHzKejQjwPPgmm6JdxB+T233fZJkqSD8DlQu4gYoa
         4K3Cxj7p3LwUpnHgh0wuZLCl8k/DtVDkNw0hdcsTOVirU64qYUHgAN8A3OZOwJGI2K11
         M6eSyKFK+Fhky+SupzuPtOTvMFd3eN+V5udVUk5rJH7zQOY5Akp6sWGIolDIFy0ohOn9
         AZ5ioEyqmZIJwiKBJbXQPQ5KgTtdsOpEXVtHdt7zgAtRSXrUwxIQsprOU/TORtl+thDW
         YebTasvAUyojQu65xs/778T/zuPL9ERF8cfRFmqGzThk1U/qImsqyLtHpju8WndLpdOC
         XGzg==
X-Forwarded-Encrypted: i=1; AFNElJ/qTDCV0Bhph5O+3PtCTs8ArsQHMV8RZ1a1LvKEq9PffG12sHyDOs3h0l5Z4v574htoJLrULqKxv3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ20zs4FJKA9tFVku6oIdyKSYqWypHdIsOxFx3Zs4x5IxhsT+4
	RMxmi3rDzvYMdo0HdX/0AWb0vy2VCoBNeBh2PHgPVNcj1ZWdOFm3WSIMFvuIHAzJ2vPAvW11KVQ
	SbqKCws5pKZud85yh0vpbF+5srf7HHm8=
X-Gm-Gg: AeBDietCnAJxaT2PHx/Hv4kw/OiyA+kSSalcvaKthrvkc312Adz+irba/QJajsULre4
	l79bLLTOmIpmzpWc/qGe64Qatx2qju8iYl8Dok3nRE6uCWZoioZtjZ9GMPCLOGFsfwP/Vayrm3Z
	wmC9KaKHY5iPMjXbGR1MComVF35BLDGGSDOO/Gsn5Ulp3+js9nt27jv+8AK1MMfYBLVhpPnxmve
	dBKJBLT+0+mqKF/N7wId85vaigJ/hcv2E2YeAcqr1P4t0a5NBCp/INfX1IXOiv/AafrnVDH1N7i
	d1I4fTJQKTUps+cNDXptB6Fk/kBHQvWv+wh92hWkv7QjVtSGB/sOCpKkhFRBTWHLKpq+v2VVrXg
	eUHd/lXnoJOpmAy6k2R097Ah/8vY9iPfiBgIXyxppdAckBvPy5Jt8EWmqafIe5CfaMou76ci3/e
	mi4K4R3zQ7guFLKzy0ky0uoB9J11CYr9D5blNVR0w+jWwGeWmR
X-Received: by 2002:a05:600c:a305:b0:48d:361:4df6 with SMTP id
 5b1f17b1804b1-48e51e19680mr10462915e9.9.1778016380742; Tue, 05 May 2026
 14:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-3-831b9b5550fc@gmail.com> <CAKqfh0Hz_zc6+7m2ca8uY-kPNs=ttOh=qni7MdrwFwThEx69TA@mail.gmail.com>
In-Reply-To: <CAKqfh0Hz_zc6+7m2ca8uY-kPNs=ttOh=qni7MdrwFwThEx69TA@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 5 May 2026 23:26:08 +0200
X-Gm-Features: AVHnY4KC1F9WqUXyAFaQNCfk46mjl7nWOvgHQmA441BwYhI5cJ-wV-ILKrV0fKw
Message-ID: <CALoEA-xNCjBZ5xdEzEC1zoXL36=Zq5Bfwb0zwP0cU5W0Fs6Spg@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] iio: magnetometer: ak8975: replace
 usleep_range() with fsleep()
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 May 2026 at 22:30, Maxwell Doose <m32285159@gmail.com> wrote:
>
> Hi Joshua,
>
> On Tue, May 5, 2026 at 6:53=E2=80=AFAM Joshua Crofts via B4 Relay
> <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
> >
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Replace usleep_range() calls with fsleep(), passing the minimum value
> > required by the sensor for hardware delays.
> >
> > fsleep() automatically selects the optimal sleep mechanism, simplifying
> > driver code and time management.
> >
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/iio/magnetometer/ak8975.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> [snip]

Hi Max,

> Looks fine overall but has this been tested on actual hardware? Just
> want to double check since this touches the set_mode and power_on
> logic.

Fair enough, this series mostly concerned code cleanup and moving
away from older driver programming practices, so it shouldn't mess
with the functioning logic as much - however it would be more than
welcome if someone had the hardware to test it.

> Also I will say it may be better to keep usleep_range() since
> it's more explicit, which will likely be better for the future to make
> it obvious. Also, I was taking a look at the docs for fsleep() and it
> provides "maximum 25% slack", which means we're stripping away almost
> 375us on one of these calls. And besides, it would eventually just
> call usleep_range() anyways.

I disagree here. If you look at the documentation for msleep(), you can see
that "slack" is actually an addition to the delay time, not a
subtraction. fsleep()
will always guarantee a delay of at least what's supplied as the parameter.

About fsleep() translating to usleep_range() - yes, you're correct about th=
at,
however not only it's more modern practice, it also doesn't require the
programmer to add an additional arbitrary max value, fsleep() just
adds it itself.
As for explicitness, I think fsleep(500) is explicit enough, as described a=
bove.

--=20
Kind regards

CJD
