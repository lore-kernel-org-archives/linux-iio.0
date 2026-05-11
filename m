Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E344014B4
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513466; cv=none; b=G1STzpv37W3TaFTfBN76oztYiG3HDTZiOgBIeUXvyc2kOCy7UMg39pzHg47KamgCNAwLEI67lkLjnJrj/tfCtu9ILo+FZMrsR3QAU9GcIekFo1rhvxJ53mpmRwe730MXaWF+lpBZiglhP+10aIYEWw5j6NFqgqq2NrZvz7Yo2Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513466; c=relaxed/simple;
	bh=1VLl6umAE+P+6rl1yUlRHZHMLvBlVyzOUgCmwbPpXdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h210bTGovBDWppM1VquVQexbRK8ZSTKGBH+2OGFF7ENeFl8LkDvCd5kJEua8u5Wuv/NK1/eGacXZ88/53z4w/r9Tebs9CFjeSq6ka0kknFp0NVMjk4eAqkCjIEhjbuj5nu7sKsfMG8Y32H36CdsCmtFl6d+jw0LPSv0xx1WoCjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0U/Zk07; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0U/Zk07"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b936331786dso560378466b.3
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778513464; x=1779118264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kWZzStjqE2I91mJHHt3o+qyvptKZ/dRPtDvuD3l0QAc=;
        b=e0U/Zk0707EjXpLtQsfoYOQzUE88vRWXYdbmZ4ybJwx8wrZ7nIe2t+1tDmmA8Ionh8
         yb5CBza7D7xRMTCeqYiKjE8Em0b1BMaaV/cJsCVnThdkkAGoIJx2B9bVbD1n5bIQAcwy
         OCrlQjxPeXnpX1Ri/6w+/FtgcjqYIxy63SdBe/HFY4OyAVlTQMsw50vtpdU2KjGzI8li
         /h7xVuYst8aS3o5nVwfFDtQMAwV25KWoHwpoeDKSh7OoeKMQskgbu9ET3KG3cfyEH4oe
         HLmFydGE25QSrdag0u6d/v7jtMLIxMZ/otq1r31JZ/e4O8aj9NXg+E3ccP9bCSHeq9Gn
         E6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513464; x=1779118264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWZzStjqE2I91mJHHt3o+qyvptKZ/dRPtDvuD3l0QAc=;
        b=dpTCRBc89mI2vn2/o4DOMCEGeq4F84MMPWgMhoGBEPt0lJd+QsGL/AOJrM+L1Bgm/m
         ouJdVghJt7ZN6zE8oEqylbw+Ir8GRPGKCMDHqjkaEQiP563mD1+rI5t+BxAiCylcVpXJ
         jSEGHDoIilJsZ7Co/EoqTXPECaZXOYXabKuG77Ll6J70SdK+XA2fvsNH01aUjJgR2H4W
         wjMs1RoNQOboIfus73nZM7nW6RZmX3llritSHVL0YT19BAuNgXbUbVUdASEjq12JbP6K
         fQVuKBB/JK9aqeRQ23zAc2nSsJgiTuktrUlkhVIw5oTVF9rZ/LzpR1+Y1BPg2Lgu6/IA
         XHuw==
X-Gm-Message-State: AOJu0YxGevS8B6iZRYsQJMcJUdqiN5Tc5pgZmDZOiuv5Qj3i1cGdypjp
	vRzTvIdWomBmw9Mt44AyGnbAGFLH3vneCDed0+2UD16LeuEeqS3Rws74
X-Gm-Gg: Acq92OGJWBTwv82sfbVP+cb/LpGrueEcvwok4CR0QbWg21ggX8D9O+B7hRwx4jVXdeB
	E9dBxUyln8mnfqWdlqy8JI/6AxmdwGWmXHymzz47TCLyJWd24yI0vCUrsf+70erVTxA84Q8N4hf
	Ye+zeZe1mpkjICGYy293EvLk02TAeA0IcIKh7FQrCNZVYF8ASS/jmQdr9EkaRVQRcjgUwEI8Moo
	79Bx/VeoFyyQSc+MUtFjQ4hYjYjGwkBMk57zebuR0ukPkhexO8A1RTFneIFiXedyJwrnmSial/K
	H7u4MGPGYkqfUCPOr1B8T+z/RtQfnCB4psvJvJLG4LMyrJPmWXhVaY2UkwaVmJtCi30Bnl4Dzy8
	7Fx0rL19qMj9K3XROufFnkQzyOWPMxBumATDa6nJVo9RVSDZOPA/5Ss3EVPfV4LEXbnv9/RS12G
	xnV9nLYQxv3VPkZxXYJfJxGXTk8ik=
X-Received: by 2002:a17:907:e148:10b0:bd1:d4e8:42a4 with SMTP id a640c23a62f3a-bd1d4e84518mr109531666b.11.1778513458881;
        Mon, 11 May 2026 08:30:58 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcbb2b1c3adsm429487666b.35.2026.05.11.08.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:30:58 -0700 (PDT)
Date: Mon, 11 May 2026 17:30:55 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC 3/4] iio: light: add build support for APDS9999
Message-ID: <agH1u965gpFJDxbt@gmail.com>
References: <cover.1778491503.git.azpijr@gmail.com>
 <4bffb49a6b8a47037a08e728caab539fea6a88b8.1778491503.git.azpijr@gmail.com>
 <20260511132804.2d2c54b5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511132804.2d2c54b5@jic23-huawei>

On Mon, May 11, 2026 at 01:28:04PM +0100, Jonathan Cameron wrote:
> On Mon, 11 May 2026 12:14:50 +0200
> "Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:
>
> > Add Kconfig entry and Makefile rule for the APDS9999 driver.
> >
> > Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Squash with previous patch.   There are some corners of the kernel
> where they have a pattern of building up particularly complex drivers
> in multiple patches that won't compile then adding build support.
>
> We never do that in IIO each patch must build whatever was added
> (slightly exception for complex multi module drivers where it can
>  be tricky to do).
>
> Anyhow, short story is merge with previous.

okay, I'll squash Kconfig and Makefile into the driver patch in v2.

--
jose a. p-a
