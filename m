Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF8370AE4
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920933; cv=none; b=PJARYWxGT4Imsd9Zghyw5vIHk5yP9x6JKOec/NLkEpxdZsePvUuoBV1doHA2PPsfgxnhrJuoLRhWL9pjgsqBASEBgtgSlzEW7Jgp846HBYXZVHcGZ6W9piNu5fDMvwZwxhBw+DKSW7rqvghmP9dFySMxqF0JLfVjGWgMMy69/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920933; c=relaxed/simple;
	bh=6pIVlUaGebknt3SPtWJ3Y5JVklajwnERGTgadc5keb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+JB1+j1iyiRzmp87R/2oez58ENnfz+j69u5VFy6kA1R4KIg7jRmYfffx2MSChiJ4HH2XHfivUo+S1DnvoGqUxvdgE0OBCGtal4qdIc8I3uYXi1S7VFd92kGioX068P9jNoqLWAzB2TZ85ZmNoN5cOjW62b9O5RCSpnmWgDnuRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7e16f05fd79so42962037b3.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 05:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920931; x=1781525731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6pIVlUaGebknt3SPtWJ3Y5JVklajwnERGTgadc5keb0=;
        b=eJfAwTYB1aS+Dk1W2dTJOGw8RPx4SeVBtvsCUV0GD0f8kPPead2O5Ruz59AcVxZkNZ
         oUamTsVZazVUpeUdC/1BnqDbVNdX1Mxqv5UqdpACoECRAb1ndcnglrHIIhB8Gf1Ibdow
         Q5GMqJP0uEfv60hq/OcNPqFKLzQw0LQ1pcgONmKHMsQlq2M7C7+j7fy1loDMYFsbXTa4
         J8U//ah4Uao5ivWqkjUJksUdkiIHc+RJDOaTSj/xazv9iN0ilmxImKj0a4a9ed9Jt7M1
         HF2H+RxDFV3Kb19M0adR0X0WM9FsiGSNYvbUjBZvoigo1/uN6r9JvtjjaRM3FeqQP/ky
         bcYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HU6/0ePTJfj892xZlGZi+XAfE6tSwysbmvvwMFqwPvE2Kfjxa/vZTn+7s8z5u1lVhYgFq/ItXeNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFSTVyTPUteGxIQ1ijkdG++3wI+eRPznvMciU1fQzL1DCnPC/b
	fVwvFBXTedncfRtdtCKLAAJxIn7wiI1xd2Qpozt7CyhBNEJdm0b1bOBVG6J0iNZu
X-Gm-Gg: Acq92OEpIXwg8uNS3O2yGSJrMuz3/u5mnAf61h1wZ+gqsOSQrE7kWsUmkXSURCqtNtW
	B09Tdp9TpzOurlImBLYp2rkMTPax7aIbzCbNaVXXcvzi5F56hhaFWUJVndOYGLHQAGozXX+a6it
	DwL2zigZy2YmjKUa0WfgcUpsk+c5LkXi8NFTZh/BaNLLHr4v11y1WzaWnPkbxiQdASzxFkF8aYR
	LMQmXbD7HxtZmYNkyEd90pCdeHlDBPrDAQZn2QSr2ki57kcTWLY9pifl9wE/uyxenMBK1tQs0/U
	l/ElxQFxXwUGQrXl1sUYj9pRhEWbTf/0enuW3frbYIzeD/HMJlkHhLuTXcYVf0fWH4sC93KdOoT
	+Ck4H6tvW3XmZ0+LuaicfTAFo1XSRY1ABHm9sTg6alhJ/OWmUkycyX7drDSUEyPEP2SH8x1Cy14
	eQKYslNb9e9z/rYdDwcA/jJNmKtqRBi6Qbqu8hZvpo250NAQWGi10uNjYJ1ufDUw7g7HBzKtC4V
	xsFCA+07q2V75Ku053W/hIl/Co/zbVIhbu2i+0GkqyYRpFDknrShHrzrSSl/jF8finkPM5oRYf1
	e0t4HmW2Of58
X-Received: by 2002:a05:690c:d87:b0:7dc:a5a8:8a8 with SMTP id 00721157ae682-7ed0e57661emr144358967b3.5.1780920931013;
        Mon, 08 Jun 2026 05:15:31 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23591b26sm81819987b3.31.2026.06.08.05.15.29
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 05:15:29 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7e16f05fd79so42961307b3.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 05:15:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Z+nMiKOL+/9WtcqG7WY1/4ed1mW91yTHkgWH7AbDyUFPUk12t77JQ5arTvBnkzm82JY523UwpD24=@vger.kernel.org
X-Received: by 2002:a05:690c:6181:b0:7bd:73f3:7a70 with SMTP id
 00721157ae682-7ed109c657bmr141533827b3.32.1780920929050; Mon, 08 Jun 2026
 05:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608033218.26514-1-email@sirat.me> <20260608033218.26514-2-email@sirat.me>
 <aiaqAEMj4mX9un--@ashevche-desk.local>
In-Reply-To: <aiaqAEMj4mX9un--@ashevche-desk.local>
From: Sirat <email@sirat.me>
Date: Mon, 8 Jun 2026 18:15:17 +0600
X-Gmail-Original-Message-ID: <CANn+LWJkOnWoXrjjqECMJgJuXOcXPUbH2U6TV1T2A=tMBCe=xw@mail.gmail.com>
X-Gm-Features: AVVi8Cc4abFKp5xaHNmaVkn2H-uT4dHna6_npeCydL0TG1OTBZ3ZIwsYapSIRQQ
Message-ID: <CANn+LWJkOnWoXrjjqECMJgJuXOcXPUbH2U6TV1T2A=tMBCe=xw@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio: proximity: cleanup fixes for vl53l1x-i2c
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 5:39=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Jun 08, 2026 at 09:32:06AM +0600, Siratul Islam wrote:
> > - Sort register defines list
> > - Extract vl53l1x_wait_data_ready() polling logic
> > - Logically split regmap_read_poll_timeout()
>
> You may want to rephrase the commit message as in the current form it fee=
ls
> like it has to be split to a few patches. In practice, it's basically one=
 with
> small amendments in the code that may or may not be split depending on th=
e
> Jonathan's preferences.
>
I will rephrase the commit message to be simpler. It is very small
change and I don't think it needs to be multiple commits.
>
> Also, you don't need a cover letter for a single patch. The cover letter =
makes
> sense for the series and rarely for a single patch.
>
I will remember that.
>
>
Thanks
Sirat
