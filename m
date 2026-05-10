Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDE136BCC4
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404939; cv=pass; b=BHc+XEZLjPAyrgjE/HGmrpqTejpaaCvh5y4rDZB5Qd1GZPogyAYDW5IJlZYFCfEjtVQ+BMUiUjTNiHT3HOTETk/rfv21m8tmWctSc36ds6WadZ0KxIev97m/9/b0RWs2j+m86ArqVPcz6u4vH9kY+9HTW2xVbO9ZgS1aBWwjyq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404939; c=relaxed/simple;
	bh=kFLwjP1TIMQ4ZwyBaJRta17CrS1ym9WycnflmwHVa5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFXQkpf79BT4JGFSEGEk72fEI9O3+RVQN8wSajq4GW7y+7OB7ufwa1dhhw4pKarrFSltFx3jKlYISwd/39IbE0aRA0tP3uVsb1YADRguxNTQ+KrLtGyK32SNe8m8RyE6HpEpfZEzybfaeKn43MsYjlj9sf2ksqQj1FYlvU5qri4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeHRXs1f; arc=pass smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeHRXs1f"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so3430355e87.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 02:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778404936; cv=none;
        d=google.com; s=arc-20240605;
        b=YN89hHlRvwSUAWx496Y9ZcOlXmmt2dKhsUs6hN3JLoi8p5m/9pU8auqzmlX55AkEVc
         Gh7TEPuiKRqjLFmjv7S0oOyklWksIGbUIExfUT2S0zPvbelXNPOq4UQRE+0LR4fXcP7o
         fOR5u2BGydK9aEbXDSrXya0ktYEqnJqajxxRufNVrmdnC+V/kU05kELHx3qQtg/+N2Az
         68DVgGhcwHl6OEcJUDy3rjmUL0fAwTxmjUjNi3eDLMUex9c5U9J6F03XD8aVC9C3s9RT
         By1Aidt1JWPSp6NF6D+ywTyCE4k3Rd+0YZ+iC0711zwYfpbGryjcOaZGUsu4hbTHLSYg
         rZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kFLwjP1TIMQ4ZwyBaJRta17CrS1ym9WycnflmwHVa5Y=;
        fh=J2AtAPLfYYK7gePJBCMXIEY1RT56qbRlDGUUer3MzNs=;
        b=DD8Rypu4zrDrf2kBFtSkWft6QGgCdk2Dy/ANwM4DXCw4AfIMZ2eXav/Vs2r4gLKgEr
         Hxso/hNe3oSZOB34iGDxXaVhFzUlGAkRNjyjsKS67DlPzVWi6A87HFHRqphVk7GMaOfu
         zgRqA6AwZtTk0yCALslgArU20C82RJ8LiTxKeGdqrpBmGx5pGoas3pRS6YgVfLTDEj6o
         ur/FrwQM+w4mJo01Rb1SzWr6Pl9eTl4Bpm3kNqwNq3cI5cxbMBnQzEyiOLWi7s+RxeWZ
         iuIjFi/5R8Ly0vx5IbE3ZH1IemTfDvlLZoWJmDIRtUwPkNwfiJak/Y6rrJkyhTOaaT3X
         z/+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778404936; x=1779009736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kFLwjP1TIMQ4ZwyBaJRta17CrS1ym9WycnflmwHVa5Y=;
        b=NeHRXs1fU9J6iEazwaPHOQ3vMLaUYQ3+RebtxJj5/AsDxiz8tRBeCQLTNq/0DIMlcw
         +aqOPARqVBCJmrINEgRKJzNGHP+6CptmDJDs6f0DXm25xrT9AHNtYG6vOx/lkuWLQpni
         siOrF1V86LWUc3MPVYlf3GLghlp5GYCsrIelbc6m1CENuPDRUcCuEoFYaMx3s1jRoiv7
         laZNixr1vbq2F0dS3kONu/0sk13/HsI3vhvRZL2/7N7HXnTxTeOOySRVEO+RMVnkPB5K
         VuxoqLrmcdS6ak81RVh8nACsu4il291XHO4M0v+vvJhvoGlkJAbk+hSLpRBJhZ0IGQgw
         aobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778404936; x=1779009736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFLwjP1TIMQ4ZwyBaJRta17CrS1ym9WycnflmwHVa5Y=;
        b=gWrDqMOwwlOO2DTTpp1z5DDaDush8EJnusd15+zvUK9Y5UIM1q2NNqC3cpNlDb/dzx
         saaTJoA/+QISTwyGpsr+dtdpA9V/MAa6UGnIn8OaVmg4bn3odgiXo65WTF/flWq7rdBs
         JDmnHYBIccOMUEkTHyTh3EvKfm7H0YcScLp1Nzn8GsT+S0r4NKrMa2GYd+aguTCoVRoq
         czPVewUQPaOA230HuqfbItJxBtZ2eZAefk47uDjY2hPyApzdZrbNfXAIDJ0/8Oe4BlvY
         DPPES3p6dCubAZA5+x/D4M+kBgiEpHa94dVKe+1Nrk+MT4bhxWUPbyNLNkmWaXuYOjpM
         0YKw==
X-Forwarded-Encrypted: i=1; AFNElJ8IqOAKk6m8PqY7d8H75W5TPoFdYNrPQVUCPr2evmFQ9acm/nP1XoHHW4SYggqJtytmmSS22JDGYSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/0Vcu5TZKWSb1CiINimZMAQGTaZEnTIiUGXrPKDPLpFWKoSw
	L3bfhBt3t3Aqz9xppePvT8t5FiTROzzPRRCHjVZjKrrf0F+gOrOv471iJtipu/LGcMnkQNBzV73
	oDxtqK/74K8bzi+UOnbSXrEsvqpaJ5Bs=
X-Gm-Gg: Acq92OHwD5TK7eOl5rV4CbhYpY8BUkFJYtkLeLXT4HXa8YhVPObiAFCN8/4SyIzpcrT
	T8l5ZoD7DGGsqDkjnwm0s6inu4d+bCRVRDrTPsQHt3obOPUKRii4ZlxsbS4P+WVJYnEOGZTv21R
	cNZi7l60KuS+swmPcwcTWnlmgr1ZJXE52Tu+IkEJVyGrPX/jdBGWGBlrApSoGVQ8Rf7nb6zR/J2
	NeiyW9Evp4pm/Bm+FVbCn6ldWl78Vjq2C8tDSGjhWbdFHIH39LVSzbNAoQQwx9TyCHrn94SCH8q
	cU+5JKgMXYAciAgTif706JG/nXwnoo5tPK/aKIkFIQ==
X-Received: by 2002:a05:6512:1093:b0:5a8:918d:5925 with SMTP id
 2adb3069b0e04-5a8918d5ddfmr5405295e87.26.1778404935666; Sun, 10 May 2026
 02:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510081041.85880-1-dennylin0707@gmail.com> <agBH9QqHW-cJN0iQ@ashevche-desk.local>
In-Reply-To: <agBH9QqHW-cJN0iQ@ashevche-desk.local>
From: Denny Lin <dennylin0707@gmail.com>
Date: Sun, 10 May 2026 02:22:02 -0700
X-Gm-Features: AVHnY4IBY-wtNtpdEn-Etp9fDvwplpcUOdSf20wINDew5vGSv0M8n-zlGaTe8pE
Message-ID: <CAGEkeHf_wueMkwqQmQ0m2drXQ_m9UsvcFwqu5RVvg0WsjAJW1w@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: addac: adt7316: document SPI interface
 switching sequence
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is still odd. Please, put in a format
>
> $SNUM "$STITLE"
>
> where $SNUM is the section number (like 2.1.4) and "$STITLE" as currently done
> in this version, Ideally the datasheet also needs a versioning.

The ADT7316 datasheet does not seem to provide explicit section
numbering for the "Serial Interface Selection" section, only the
section title.

Would it be acceptable to reference it using just the section
title, or would you prefer using the page number instead?

Thanks,
Hungyu
