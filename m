Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39630D419
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786494189; cv=pass; b=djn65E/0DhdL8QwLWAp1PwznUjL8Fk1AgDCjLcW0xsF/rrH1Qxp60GSMc6LcBPygk80+X2FiMC8OypIM658N/ixlWdqVCtp+ILnGFDAF6ZBYcXqvPJkQgk81ztdDGbJw9//n/T9h3hVGxcWA6Frty6IKLOuJJGhR6i7VkZpINYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786494189; c=relaxed/simple;
	bh=Kx0mEm5X0QVHJI5AbZIOT9Q+Dib7c7rN++VnaJlyeIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpD1a41oCrSai4KGHImfUG7HouGzTwBoSTksQNSLYT6nC9adjxEX0J46snWx5Fk5f9c2ZTblrGP1v3V3ILB0MkjSfkXN+wpGmgfsw7v7Tm333jYrvfNDF/1Y4k8RE0aVlRc3+xQsItoOAJ919w6tP5A7C6yyIW2wMRuek1ZfEvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgQfTtwW; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgQfTtwW"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d319b84213so1065305ad.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 17:23:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786494181; cv=none;
        d=google.com; s=arc-20260327;
        b=L1zBx+38zJ2ez93ZdGO8a+wlY3xAqFrmO5K27pHioVq4I25QqkzWyYLql8r0hMpfxF
         12CU5l7kykhWxqjEAyijHBGm9CALAKgetoOqmyuA8p4RdmOfSppgbi56AX5HgawCNgHD
         HelQxIhv5mGqhnYMbGDR40QhrZG//nyKRf2DGzzubUF5mT4i33Az2mXyoho4lvqZ3VLQ
         8nRkpuTyP9NQNgQcaDHZsjt59P9Hq689fA902qck/AGQmdeNcOhq0rKldySn4XmHhtDr
         YP27SZ8P08mWYGs/8mDW613CiFRfYGf/m9IYTTpLMVV/dhtgebT2IKQxIu6y6cf3BlNi
         bo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/HRvFMhuOk+3VI08vIpvJQGbNRD3IvCKhZ5TbbOGdyM=;
        fh=lCeBLDM+RddHlk2gPxNt3561NFzBCRVCUMBGhU+htKs=;
        b=L1B973rhFTEQ54stY859vtsjbKbvo5+ZQaQh8195HEerbIRy478fyp/QSTy3Eof1WW
         N2/idqnGDtTtulMGoTvc1YjJudQFapcNU7sf3rSp7dykayIiegvyiODbG4DAmeQ8dXOJ
         DL6vNOHvpuLySaF1iA4bOvsd2RG5kF20CKxiMmA40IlaLaQEL6/hxi2x1ujLCtd3xf1X
         dzi7b6zYOZ7bW2MgF+eU8zI1pxP9yNRybgDpIGkjrlmdJ/AGIYdJROaG9u1EWP3iwCYh
         ePsRpOi0PBWOukNJqOd8i2PBPPkEaS4O0+mCQnjuerbYWUDBzN14/EgnAMczJnyrdENL
         7K8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786494181; x=1787098981; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/HRvFMhuOk+3VI08vIpvJQGbNRD3IvCKhZ5TbbOGdyM=;
        b=RgQfTtwWxvNIFpvSosfvcPwd4reqNcXvRN/CHClfTxWzXDlcNeU8MMhMm2kDJeLyHQ
         4Gqd2m85mKP8qfUzSsSUE2baQxc4I2+MAvuEuhzqHHjvnYA0R1ZYO7qCEFgu3zZDVZpb
         Ya7A5RjAUbZPkdu1RP0zk00IQKNDaKcFVcgiGgQ7Sx5QBjDxNUg9KEDcLWhjEaGsm0Cq
         noDgO0QfyfyrvZksqOpUHEID48z1uOg63N7P0Cfa4/ZYE7i98RbKpiZM8S1V7RVDmcZG
         nktrKZCHUgEFLM+MHz9kk+ucCoUgL8xNr4B+xb32SGdrLLDkwtiyVA2KaOYsHLhdjm2x
         9mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786494181; x=1787098981;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/HRvFMhuOk+3VI08vIpvJQGbNRD3IvCKhZ5TbbOGdyM=;
        b=lrs6HDs7RiqngXYCvQPmUC0zJv4kFt0Ab4R7tDvHa2uPyp7aO3VXplLXPn7UIXToqF
         hJ/1lcjNZhTk/Nkxd/w4w9FHlZkyeXitoVN/rhNax5pePJQnpc36YRS4sNRw4JbFI7JW
         VsqFwgtFCJFuMxOXieGAy9BWHohYQTarZ7TukTEERZL3cMawfzIMRaER4kDlmwGejyip
         MIK4t1d96op3NwQ35VKhRFbhy9L9vt17gWFMeY85IQ7tMbVww9bAGrpZgh+jUUmrZDl5
         ReCruGvx6USQ1mtTDiYN0Bcdh4tMGQBX9O+lK6F0D1aANOSjN4cQdsS360whGqUcwXpA
         K7hg==
X-Forwarded-Encrypted: i=1; AHgh+Ros8kq87u9ccJX5IT4DyR3eDJfRaVG8UDQUe0DZwrlIqnUVrtPJzIZg501AbnVY6aa/w115XtM9g8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOZRYnbGCcDo33GE73o4UxPoNkLPuNuxwRUDo9K6t8l4uYzX7g
	1cCaBWpU2VtpLlp4kPJFW7D3gu+SmuVfNN4Nb3cyCsXZvpMHTU9rWvIbgJItnvGT0l/+TDqiUon
	RLsDjDna88Z9+Ld81xkz0kzV85RnLcY4=
X-Gm-Gg: AR+sD10KhUTepqkUEvkEU4YA/E8dNlmeeakFMoGbDeeq0f5rjSY3IKs/Ady0NoX4/W8
	udENkeYzgi/XndDfvG9ITfmB9rTQbPLzNzNlyAn9yCEiZDd8gIoROU/7/Rp3zMkjCaf1z2s/7N0
	rQpn5WqCkNrFDQ+YzFo+SqdDiRJeIbJ3y916wtfE3KqfXEVPYwxGtf81//LGi3Xrx9cbSsI+uRw
	zbXu3DgTm7wmkL6IP0XOyKELPXKaMufy7Cdw6z+ZVqS08hkKZ0LhPRMfk0RTw/KeKfJNrP6R+7b
	WYubYmCdgvOXhhF+3VtK8PwXuvt+g2FyvzVQibtjyr0=
X-Received: by 2002:a05:6a00:929a:b0:84e:d541:6402 with SMTP id
 d2e1a72fcca58-84fb549e66fmr759614b3a.2.1786494180585; Tue, 11 Aug 2026
 17:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
 <20260808090026.34187-2-adinata.softwareengineer@gmail.com> <20260810010943.014d8db1@jic23-huawei>
In-Reply-To: <20260810010943.014d8db1@jic23-huawei>
From: Adinata Tan <adinatatan99@gmail.com>
Date: Wed, 12 Aug 2026 08:22:48 +0800
X-Gm-Features: AUfX_mwrrryz6I5WKRMN5uOXhp8xlN4BudeZxWVyCRL38f_V_T8YeYoNNAN7wn8
Message-ID: <CAG442=sRDMfdVZB5GY+f6Wud7Vx8xR3ORN0GWVRVV8NKLVX29Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: humidity: hts221: report available values via read_avail()
To: Jonathan Cameron <jic23@kernel.org>
Cc: lorenzo@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Thanks for the feedback. I have checked with what Sachiko is saying is correct.
The custom attribute was in_humidity_oversampling_ratio_available while
the current on is in_humidityrelative_oversampling_ratio_available because in
industrial_core.c only has [IIO_HUMIDITYRELATIVE] = "humidityrelative".

For this humidity case in particular, would it be better to keep the legacy
implementation while adding the new read_avail()?

The other case declaration will remain changed.

> > Replace the custom oversampling_ratio_available sysfs attributes with
> > the standard IIO read_avail() callback. This lets the IIO core create
> > and format *_available attributes and exposes the lists to
> > in-kernel consumers.
>
> Sashiko points out that there is an ABI change in here as oddly
> the driver uses
> in_humidity_oversampling_ratio_available rather than
> in_humidityrelative_oversampling_ratio_available
>
> Which makes this an ABI fix.  Therefore this should have a fixes
> tag and be moved to the start of the set.  Please check that logic
> though as maybe I'm missing something.
