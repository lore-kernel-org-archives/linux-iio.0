Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DAA40B6DF
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659535; cv=pass; b=VLxgE+R+vHDnkuD7sX77snnZowOBlrQSMfNPT868v15aOZcwKJ1dNXmLOLxKzU2WQuocfD9WmqDC3pOpRi+HMijCCim/CmGaulhsPiFSHVuVdRh0BK5aUyR5f8craKz8H6HzkUs3AcF52Y4GONlqJBkua/HpGcGOwYzhtiGYyRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659535; c=relaxed/simple;
	bh=hUsOB/td5KUt60+B697yCbfSH3LnN4JGaeq1zWoDQS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrKf6iamrKlF7y/euhIQHsOO7D9jxUh/fgl/xZlMRUJnui4NJCeQuv3wr198m4Vm7MC9CXImk4+UL9nUWCxacbZdM8eaINl51PK5uylrdgLuit+Jkq7D94qiFgBQHIRLnVxqT1pVJrrN98SX+1WORXJ9iCLdBKpBTr4ysRq9sQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmyE4CM7; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmyE4CM7"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9358dd7f79so358058566b.1
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 11:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777659533; cv=none;
        d=google.com; s=arc-20240605;
        b=gfHTN+BAvOnw74gKTDoQ3dnbrnLtwlcmUa7t3pZ8KjyQwKy6QXwfLMnDQoOw9OeU/p
         8HyOSJKQ3ii5i9gYmkln7+xYjM7qsOz4nH3hGIwOQCSRkTjDaHIsPyJL22KnsSwZSwl1
         3J23ah0sB0Z7irx7JZLp8mQUtGPf4qMKaH+jl06UZVwncQvIt1T2ci7B9g3morCXzExx
         B+VM0ccOpNII4kCzMPf6jUyqKuQ4PnqwR5rMXmVpPGjzouQ9CosLDfqejBNbC9Sy9q5u
         QUYioLh6DN+/cw8ryRfZ8b68AzkiFryRiAK7vdFz5/txR1AKozKBR6mQllsELzRLA3JR
         wlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hUsOB/td5KUt60+B697yCbfSH3LnN4JGaeq1zWoDQS0=;
        fh=gUIFybcs4vEqooi0V3F0dwQQAtzhOWZTruSE1dwtrls=;
        b=BaDmuXHoI8thAeY5aP79N/ZHONyQMV4x91rhf0JQnj4fEYoUkWF5BosU8zjcoHQr+y
         GeNMkJs1tzQoZJYib+D4j7HjmJl0hqWex9TgcL6KwLT4WLz65R7GJKQbzXBMo9nCdY2H
         JMCdYDA8vy7KVvTqZ0FGjGJq5Mk//DMyQ7q/GxLEMsk0ALDPcUEGnabHRbF2OUetO729
         34DNn/Yxl+c2eGsn7j71H1HQImYhFRbNhzQFYJzycK05xezUbSiRWg+wup8z0+DFm4tz
         kV5trCrecyRQP7sJ6l3BnfjBaofZvFCWvD/vWXa1EgmIEMhV4uqnEBmdYcEYaI/qQdX0
         3qxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777659533; x=1778264333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUsOB/td5KUt60+B697yCbfSH3LnN4JGaeq1zWoDQS0=;
        b=ZmyE4CM7msbqaJ3UdzQsSqf89pxdLjLZfrOvmoWTbiZdzhMgCdyHLRek6Da6Q3BThu
         SuSJyyfBpYFL0avy6oLELMC6rPhnruihG9/sfGnVMb37wPZi77TX4zxjcs2AK+kzcOhZ
         6+wdWFJaNHBnTOhbn4Ui6i6vIZPqwswEl4dgWlWrA6GlFIf+xTG58De/f+u5cIuKm2CP
         4u/NovqiI/8zn6n25Gl0NSLEGlLx8X5BOeN13IQOnixs4VUWrCWnCbMv6oE9rYXTObmP
         OZj4plHOerUW9wRFowftrBVy1+QijJRD0tOMbQvasiG4orEiWFDIikq6WxUUqOtKHRcg
         WCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659533; x=1778264333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hUsOB/td5KUt60+B697yCbfSH3LnN4JGaeq1zWoDQS0=;
        b=r9vuD9y5OANoYwTaBzAY10eMrkDv/edxkLL7ic7BT4b0HxmXxcdXwpiHpfKH1hSGTl
         rjs0nSX0Y4a1CQ7ZG+2x8E7sm3fF3RNTeF7ZqA8WY7H0PXJ20QU+wwl3ir4V+yOsoj//
         E8Mtk9RX323XwKyPWa8fnsveuAY71jZ56jP3huY0y4eyt/TTC7M9q0JDYvgmA6VdyOOU
         4x1oWaXQV9FVEUlzzXPbOzBd1iB284V7GoKozdWUCrZrx0LSPNREIkVCLR1qE/oQQdli
         Yn3oqWHXxqPFQhXDOaXskwggYlBnZZ38bYviE+o0AbAq7JyN1hXjdpuBcTLLgI0ZQppk
         yrhQ==
X-Forwarded-Encrypted: i=1; AFNElJ81HsY0VqftaKkZYsDXlPP5GmS70XDcX1RudqtKgitEyFNkDIswDQITlpW8Xy9Pvc/NqJ6khNqB9JE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOHwzq5jI9N2RuB8fkf4esEGWtTWHRFmzGq8fwIPahiOALP3tt
	fCAYMy+JUpwHcNNTxWCFMbjeNW+5dqwN+6qsiotc6lsivv4djk9h1BcC1tiDr7mVf/XarBG+M0R
	O7qBdmWBijJV/8qPsf7KnHE5RbZ7p/QU=
X-Gm-Gg: AeBDiespGu1kRVDcgerNiIECw53xY9y7KAv8CnrHcdlJ+VG6n/Cbilx3v/zsA1ExteI
	rHoh9o5IF9ekRVWtdHBde2xRGdpyabWdNbjBZaZcfDbnaQwYVOM1lxXioUO4P+SppWOjoIgam3a
	BwnWYCFJRd4p0j01ku7ePu6JG4Nm42zJhrhG7zRAUJebJ+I4RCc4beabeLh0tJlNFg1FPbpzkGy
	lCiusFq3ENh4V5Bdbe9wjGNyA5y74SkaH9qJlZGGeb9Vu4Kg6dJxoMrd4qhXeSVFl6+QreHJ6Eo
	2+yvAxt0+J6Cu0hi4UV6d2naJPMZQ2j0weA1QxCIs+V7IG2AApIsBuXCt6rtpqr6ooXxuW9X22N
	aCUGx1utu+6kNrF7yXQ==
X-Received: by 2002:a17:906:9fcb:b0:ba3:8a04:7688 with SMTP id
 a640c23a62f3a-bbffe0cc792mr8266166b.36.1777659532153; Fri, 01 May 2026
 11:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501011548.15369-1-santanarl@usp.br> <CALoEA-wzsykL5V675HFYNn-xZpuCa+XEOa-LbJ0KqrVSR=ZUnA@mail.gmail.com>
 <CALoEA-ycuys-pNg_HWZVrkoiAXVToWouS5LV0GX1UsWz5G_Mvw@mail.gmail.com>
In-Reply-To: <CALoEA-ycuys-pNg_HWZVrkoiAXVToWouS5LV0GX1UsWz5G_Mvw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 21:18:15 +0300
X-Gm-Features: AVHnY4KEDFcmlmQMBIWaakUU6l3rmd8BAnlGHDUSbJIuGS8lKVndj2gyMuZRFpM
Message-ID: <CAHp75VdQuy1P=jiK9vsCVP444hUB-1aNDCtmoZK1YU9gH0yTDw@mail.gmail.com>
Subject: Re: [PATCH] Replace manual bitfield manipulations with field_get
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Rafael Lopes Santana <santanarl@usp.br>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 5:38=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmail.=
com> wrote:
> On Fri, 1 May 2026 at 16:34, Joshua Crofts <joshua.crofts1@gmail.com> wro=
te:
> > On Fri, 1 May 2026 at 03:17, Rafael Lopes Santana <santanarl@usp.br> wr=
ote:

...

> > 2. you're missing the body of the patch message - do not send
> > patches without a description of the changes you're trying to make.
> > You should describe what you're doing, how you're doing it and what
> > difference will the patch make in the future.

The main point is to describe "why?" the patch is done, what is the
benefit of applying it vs. not applying.

> > 3. the macro used is FIELD_GET(), therefore all mentions of it in the
> > title or message body should be the same (no field_get in the title).
> > It's also preferred to add parentheses to the macro name to imply
> > that it takes a parameter (in this case, FIELD_GET() does take a
> > parameter).
>
> I made a mistake - you're using field_get() (since you're not passing
> compile-time constants), so lower case is fine. However, adding
> parentheses is still the norm.

I am not sure I follow this. Too many parentheses is not a C language
style. It's not LISP, and we only do unneeded parentheses for the
cases where it's not immediately obvious by operator precedence.

--=20
With Best Regards,
Andy Shevchenko
