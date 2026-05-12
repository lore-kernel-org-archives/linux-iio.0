Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B643B840E
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600164; cv=none; b=cck7pXi7OvHyed1cWXVbArcOKfD5UslbzRssMmfcmTEBXJOxnj4wGVvMvS0cCoiWZIwZTf0QESx+B4G4PDSuEgTsh/SEZ3r53SM7oGd0YVjXM9dQQzg/JbXo4P3yp9/4xaw/fMWkzV0XPUrXVpCj5WIVJMj1SHMa5TSLRjIDNNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600164; c=relaxed/simple;
	bh=gDWzC4y7x8TzNrpLYlnHloWbt2a+j3So8giBK9XgK5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8HP/c6qq8ETJkI40vGdphq4Cqqwa5bAZuuvXwzNLg0U/PU23gsqQ9bBo8JMmOZPkWZiZ8nTRazJorBOxg3TSryvPUkXy1l+1OoDe1OmPbP6KY5jdhCxpjj0jPxk93lsqfMJEG5oVQ0oa422SHUyepEQf4ZLkTgvYu3zTqT097c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=RwKVjtRy; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="RwKVjtRy"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7de44ed7a11so4561200a34.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778600161; x=1779204961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mb5db91tQ+COT2wwgeDAq4Be+yhOzSwg/V/uXAcag4Y=;
        b=RwKVjtRypmA4W5bRnMyaZBDpCnuoVKDpmMCcQBYM3l03X3G38RY8RVdk4dgGedjM/d
         c9BK2DTHJFqffMUPRBTovaIW8mwCyC31DtVzFS3+jRe8QKEL1hTPoF+g87WOUeQCMft7
         mGQscAgTFgM1BCGRutyCWPMz//oAtJDra5r9en6wfC/D0+xAM7QlhinQY4MW5iPGGUqS
         Hfek625VGOD0Ao0bmoTBQLVR5xAhLvNWCHqs6Oz+VG3sgkiYj/3WVfEBUnmJPQfok1KU
         B+ciFAHG4UjOyEHvaVYu/jedUesRCV+3h5dXtfxEA/vHUnhI07siMcHOH6uykB+7Geg9
         teoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600161; x=1779204961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mb5db91tQ+COT2wwgeDAq4Be+yhOzSwg/V/uXAcag4Y=;
        b=gi3S0CpFeXotztGFzne7MNH/QhBJf4MrPZHcCIg9PHJp6yioU9UMTVFez8D5XHms1d
         DyVNvrbxQeq68kt1ZON/TItMoOL3K3KwLLMvwiyhyjb8TdhM6c5ktlWvHafePHbT/JkU
         rSyqnHu9i6BMqFio/hW8rQk0LD6G3l/D822U1xUPynIgfhoOBcaLpndFYgM0gbCa5fPP
         xT1CEXRc1nppDYpw9cupq2ufo0Au9Sm9JYhZ1nmdP6ZMh5Szgj0V2bldZuzdMS9aiWAQ
         uHV4qTDshCim/jCG5ahLLdw16HC5GUnmbAFtNYXZRM6q2M9uMTQxg747LEUWoUUEycxT
         OUBg==
X-Forwarded-Encrypted: i=1; AFNElJ9QHKLyqvXHA3vzDdnasslXWHK1Vi4C4b7tU5OFeCRjBdTz5xWH90RpsuhwE6MKCiN+AD+RFgHITaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpRlxSFOm2hv7AgkctRdEztGxkpUwwjPZmSPMPnNq1p05wQbXd
	JPqbhk96wMK64VXPizyKLKp+Xp/sTsgi9E5OVxvtlJafafEptY11shjoP8JmS1DQRCg=
X-Gm-Gg: Acq92OHqjg495GmZt3jSWyp9sUR1XopKx/gZQtPM7ZvPA7Se7HkPo/4/vHnujgblIS8
	xqWKAnvL3I9v2S8Kivlq16R9IeL27/zk2q6VqQOkAFHYMCA72HbDsrissl0bBj44mxX73HCsNR7
	BimaYE4aEQKLIVSfojiIZxjA5xnH5UDaEzOqzDzLeJY0ePVu7pbONXQKvsCOGXcBHwrJtlVa2KS
	TOEsxh6DbleIhd8l/8SrgtXVkweTmfaFpXxg2h827pieKCgVwHH4uOHLWcC/LsTXvEDSBg5KejE
	KkXCIuQLZvAYjyFSdcf1jZbdu8OEpWmMRJca4Gc99nuYWTd4tv5dfprVTwT/BwUN0hWPY1a7G+c
	y7FWNNKq4v/n91dYSJ12fc19ExJr/TnzcBHfbX0RSlt6Ci1Bbr7gTSSQitRWh7GfgtZve4keQY5
	ydVcBifTf/l87qT4ki+nXVbiHkL0tzYfIkFtPoUUVEWwraUu8Vum3fLWDARcX3HStvXOqqNKgGA
	A==
X-Received: by 2002:a05:6830:608b:b0:7d7:58b0:7685 with SMTP id 46e09a7af769-7e3666ccc61mr11422802a34.13.1778600161338;
        Tue, 12 May 2026 08:36:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:baa4:f7fb:528a:2457? ([2600:8803:e7e4:500:baa4:f7fb:528a:2457])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d90148sm9413517a34.20.2026.05.12.08.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 08:36:00 -0700 (PDT)
Message-ID: <4742ea18-f3df-46dd-aad4-18d1e5f03f7f@baylibre.com>
Date: Tue, 12 May 2026 10:36:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: mapping file for include-what-you-use tool
To: Joshua Crofts <joshua.crofts1@gmail.com>, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260512073505.1310-1-joshua.crofts1@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260512073505.1310-1-joshua.crofts1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 2:35 AM, Joshua Crofts wrote:
> As promised, I'm sending my IWYU mapping file, based on Jonathan's
> version with a few additional tweaks by me.
> 
> Other than adding support for more assembly file business, I've also
> experimented with individual symbol definition (see BIT() and GENMASK()
> in the following file) - this is to prevent issues such as the tool
> wanting you to include <linux/bits.h> when you already have
> <linux/bitops.h> in the source file (I agree, doing this symbol by
> symbol is tedious, but BIT() and GENMASK() are symbols that especially
> do this, and they're included in most, if not all drivers).

TBH, I would favor rules that are easy for machines over rules that
follow existing human conventions. Is there really anything terribly
wrong with including both bits.h and bitops.h other than "convention"?

> 
> Feel free to improve this file and pass it on. I wouldn't really fully
> rely on IWYU as even with the mapping file the results can be weird,
> but it definitely serves as a good starting point when doing driver
> cleanup.
> 
> I'm making this patch an RFC - this is not intended for merging.
> 
Sharing it is nice. Automating it would be amazing.

Not sure what the best way to do this would be though. I've considered
the idea of having an IIO linting service that could run iwyu and some
other checkers that catch common issues, like spaces in { }, where and
where not to use trailing commas, etc.

At first, it could just post the results on a public page (like sashisko).
And if it ends up working well, it could eventually automatically reply
to patch emails.

The hardest part would be finding someone willing to host and maintain it.

