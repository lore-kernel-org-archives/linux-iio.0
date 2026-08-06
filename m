Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C04231832
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999679; cv=none; b=i9OaX5TzutzmCn0bB1O1XuA4uZEL3h7UvD3tmKO0G/VD4hOoTDOmUPshscBOCthIGVzlNAfw2fUOWpNzX2POXDp+e6lY595JuC2WHkVM1sPcgN9oAXfxiy+9qHdjS4upQOzahQIxqULsVYik4ncWHLcDvodBPu/Ir46wL6kuRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999679; c=relaxed/simple;
	bh=FUr7+8XCM9C5LQXFrSAbnj32rYDp2mpjf3Wil/NUWOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iucGrj3M1bf13ORLz+X4XSnzCwjhclKraAGmaaoBRpfqOhwG9cqGYmSzujBTUgQ8CT1q3y7mnqerctdwa9Gt3zujAAxpG/rkKj+5/6tiZDhnjmr0AjtGNFe6YOHND90KzX+JefjsnQ5ltOmFptE/RtKeOOvqwewAFPUX8p8b8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPfppkF8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPfppkF8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso4090385e9.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 00:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785999676; x=1786604476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JHCjuqA116INNULVQeMYQUxLnjzVId5qnDvtMozvW48=;
        b=fPfppkF817BmEWc6e+IgcHn3Op7T50+Eu9QJSzeOaQbcD+Zbbrv6WtX85PHi+/DYrn
         ePMie01YBtdF+WuGWde9xdlD82toRfXPGC0glG/lpgoNmA4126DzcrT0uhMvtim+Pix5
         lagHY14/hjdXPHNPxiStGGXehYnwR2tyq5js8Iq0Tq7bRXqxbszIWbx8MqKLY5r+P6W0
         qgeKAMvf6nHEDsHko7J6aMUc1ZTayBDKz9VaM/0Nfq9zNuF58aQfIZJPLX9scDD010vJ
         3cijRQ1F7JahJNJRpUs0SU0i2talE+5O2OVWvnjav5AgvwfzYYisuUMjdppviIXz522S
         g3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785999676; x=1786604476;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHCjuqA116INNULVQeMYQUxLnjzVId5qnDvtMozvW48=;
        b=DQFHV1cc3R7PcXM/3Mqr1m12f03HyXCzQwje8zdE5SSpmFZOcdWI3EYdzjAktqhjsP
         H1xo+tj3MhnXheosrCJO85IDO7jRLbXaUxQ6tvcW53SWpP79+FWQ0lDaAsdAXc+xeFcL
         Egee00HDjsONuNJzl3UR6sOzF/XR2qpNEtfAA7FgK/U+z3QJBLf0w8gBryMLS3+fEB2T
         7RrShorTmk90Uxit6R9jCIZHC2qhsTZcLd8GuZ6OCNPNmoz3aPuuzqSUxPg0jzXHRQNw
         7ZckUXsbGsVCPbK+J6U+RBJNiQv33vnjyKUgl0+OTLUk2gC51rs8HcH6Qg9DTN37zR0v
         eteg==
X-Forwarded-Encrypted: i=1; AHgh+RorrKP7MXJFC5CWzirM9vwOUpm8PmZKDRHr86eWOlIh7Lc/ugSjufQHfQk9Ian7qyaWqQqur/9UsRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweqQYfJDawcSdwDCvxAFWqqmOhv5eSV5L4Y6qL9O9hC5rINFQa
	NTIJuFWIshKJm7CFE3a0/iYXmQbn29EauYkM6FFSCvAvLUV819ohXmdZ
X-Gm-Gg: AR+sD10eavqkQlnpcHYA4SdOyAKPIp3PFpJDlwf/IFkgqKQQZ4R8ifB4GeimUXIBcZm
	vBMb7PojGSCDrMJo/51IiEEbDHf1thhEvZ0P7YvnPhr/eJOBqopZxKhRLc2RM53llYXe/lKWMeW
	8cD1R572OPopuLxJG7Q2+N4kUy4/4EfsbQlKz472mGuD2UZo6lgU86k0Jy7NXmCsM51VtMeG5/6
	itulT0oW8HvLrKF3MgGHu+LWj4ZO8cu3Qqm5biIm6TG+hVBlivO5DAVATRFvlRkbKvZROwSDPtJ
	QTfqDOqiIGU2i3eg7rTINu90thUgiU1rHjD0U0voGCfSkhWNVz1jg4aajhJu416oLAsTn1nW7H7
	Z335K7fUlg3ubSosqehuGez5v8wRhGGXlg8Wq8bsvnDytls/O8+ltYE7OqIRgpER2+NGgRiW4YP
	ugidA/x4wO1XE1EQpGj5tcAiMoMbw5lE/LfZD78tkGuNam00NHTvRz4DgIFGNT25hyyhlKNknx0
	9l1oZAF1WhgdiujcmLROUQlOk+nI7ItunnV0xzzDrrnws9PZ0BEy96IvX/T3+JbIZEzU4LIH38Q
	YOldJLQQdviiDN7CRKlv5aJKfBBE7G9WA/4g7dcsSUK4q1G6uJ5hqcLGqiOb8q5R8rX9Gv+X/Gq
	Krko9KL3XXfyLn373MgZ1BAZi7lXjXmXoYw29fqM/AG1hKMlVSzOA8Mwf
X-Received: by 2002:a05:600c:3542:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-499553bccc0mr21135755e9.1.1785999675699;
        Thu, 06 Aug 2026 00:01:15 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm36121895e9.10.2026.08.06.00.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 00:01:14 -0700 (PDT)
Date: Thu, 6 Aug 2026 09:01:11 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Hui Su <sh_def@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: fix out-of-bounds access in
 sampling frequency lookup
Message-ID: <20260806090105.000059c9@gmail.com>
In-Reply-To: <20260805074127.473731-1-sh_def@163.com>
References: <20260805074127.473731-1-sh_def@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 15:41:27 +0800
Hui Su <sh_def@163.com> wrote:

> The sampling frequency tables store each frequency as an integer part
> and a fractional part in micro units. num_sampling_freq_avail is
> initialized to the number of flattened integer elements because
> read_avail() returns the table as a flat array.
> 
> bmp280_write_sampling_frequency(), however, indexes the same table as a
> two-dimensional array and uses num_sampling_freq_avail as the number of
> rows. This makes the lookup walk past the end of the table when an
> unsupported sampling frequency is written.
> 
> Convert the flattened element count back to the number of rows before
> iterating over the table.
> 
> Fixes: 10b40ffba2f9 ("iio: pressure: bmp280: Add more tunable config parameters for BMP380")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Su <sh_def@163.com>
> ---

LGTM

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
