Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533737647F
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535472; cv=pass; b=unbKWdYkdsV4Chm4QHUnPKLOsd5hOMG2UU8WkPeXhfSD+EBT7OkRVV8S6pIBx7Xzf9LRY1YWW4q3I2bDw4q54Wf2hzl1D5UGKZNRIr9R98UmXZE09jTErWod734iVFqEEkvGUbqsYGMER/gtC3cEpYuaNm23KWeeOXAg7zc4qwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535472; c=relaxed/simple;
	bh=KOkr4UvGP3SIdHZ3Rp358aFpqy7b4pje035UoCxWrys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiErWjw2ugNQ2Rw5Sigzzc02u8PbLVKFxnmZLmWcMDB0u5NmM8+czlBRsiDZoJi6fFhhLH/P7kaLOB8LkByc4zc/p635nD8SZjFQ20mJ7kdCuQ9hvoCUy+VkPXRuU5jzBnwOZR2eLE/5lZHqrZmCwZXQHiVBa3ft/JXIkmzDbZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ2X459f; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ2X459f"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso277564f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 00:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777535468; cv=none;
        d=google.com; s=arc-20240605;
        b=jLsQ5us5BcpfEXBU0ZdufP5bemXk4TVJiqy37U3XcBAopeImUhn/jzY6xZG5xc7NyY
         8jVEvxkIgUXKTnRcqLsitsGvgIIVqPqbZT4i6mwfBeIQm9WGGI/atLSaNGbWCdGleA3P
         GXaL4+UjfteqOUGSPkwGMAtFpSEg3uCU6b6AoQNYJMcaIUoXRSb0mGNqIgzxiM1gjfp7
         6E4EBTWH/htlDG3ZrEJMDPhy3VNTStovFlTP5Q8TKm7k/VCtoUUXTUi7nHTpACItXpRF
         y+Qsic93sTot3eodxPYSK/K7CbVM6x75hnnkDPhO88ihm6wRtf9KM0HxOC1d3piTGmmr
         WuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/Dq2ZFomcGT6Fak8El1f1eShASezBLdWMd6SEVpcIBI=;
        fh=ysCpVBIzcGxkJszul2guA8tmjVqTYlVoriKB98FP5N4=;
        b=jFYXF1P6OsjkXmJ1nnhoec2F8Ym3TGOrbUTkWnQtr0+bx0a903V2YgO9/vbA4MDYc3
         cTmYTTmdSEq0ugYI3QWz4VSYd1Zr1n2mN+oUl3svliXbKz0NFzmE6ZRE2+WTqKdTEyQT
         peZkekJvZwcxikMsQm55IPwwcbdPeaD5WSusLJl9Tn7trnbZdIxjOXaQTnFWV9j+TNeA
         FgZMYC8z+yIcGBQ6JTCrDCH5dP2I4BOaEMJAXNAUeYb8xiXoqQbnKIF8TiOGueeEu15D
         u/gzBrDqvF80jD8fbZeJ5GSPvodvIeQAjWK8cIugH9yxZs7yN+QCrkAJE+zcd/tn67Se
         mqig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777535468; x=1778140268; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Dq2ZFomcGT6Fak8El1f1eShASezBLdWMd6SEVpcIBI=;
        b=IQ2X459fn4Aj4o9eq3giV1wjLcj6VIGiMcwolXQVnNZZJAH7u05wlxUjJDh5vbL/+1
         Eh0tgX5qxM//6pmtjH7QBFkbIHOOcQLi5F6htKHougM6FKpDNPCIw2Mm5wmTnOssfG7q
         4tK8fk02DkY9FjqZeJZBm8Fbd68x74Id1S5wmBzc3RIfM1/jTzTFHMDf80gPNtP2Omh/
         hBd1m6JDRT1SajD19xORRl6iFfCYiKunUyBH0GUdXhD4KrVewjhhq4dYbosk0o+WHOLY
         vJFd61OLyeoSMDixdNGhke+ud5OpMh4TjT2iE5VpOIpugLG5qZZeu4Dz/iyB34Vi2jNc
         Cccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777535468; x=1778140268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Dq2ZFomcGT6Fak8El1f1eShASezBLdWMd6SEVpcIBI=;
        b=C3m9N+lh2PrYHE4JkQnCSivmWNun05z6JFDfdlflUY8VUBznApIkWEDmsq4QRUt+FX
         +JXmnIADRWilNd22bLFIX5BwgiExhfbsx7B+v64cvLkRMNLT1wh+Hb7vuUX5IGOsTHbH
         HD8h7uMqy+ldHNfrJePIICeIaIS23yCi7xlu9kDeUhY1/xAZbOuzDzN+dz1jLeK5DiOw
         kvJqt3ylOgxVPfRJS5PPmxQ5cTGMOYhKUSXIAAxzsHwClEFQfBSDAq+fIQbdHiM2gs1X
         k/Vyoi8rwhTYIKlsWZlM/0g7V0FAJwHQwVEdvkYOlJuwV86BhYmdA11kjV9w0yRKGoWR
         2l3g==
X-Forwarded-Encrypted: i=1; AFNElJ8JtV40Q+JneYa60mTYXoEkOCJ28/URNkP7ci8WqBrW3DAHYq+CtLwBsCZivihLikW36KhWhpF1iEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXqHmx9/3tCS3B4DdjU3nbNZRYTojv8RvitA4SpCDsBr2Czfm
	a1bdWMyrxnoxMmyzYR4riajY1vnT0eGP1S6YBzt8OlYbhMuNhKyA0iFBwoWpmcKjJhL9C9Te3S4
	8chIWmvKst+CO04NMqESfTvVz0gDF+fjbJKF+
X-Gm-Gg: AeBDievdCwUGoPI01EPRdpvakdlWZR7MbHFNPzHEG9GgkfatvQYkdqNd9hTdvHPrd77
	ycnS5lOq6wQc/EkiY0eC5czJtS0xFw6zkmTSNIBv0vX3p9IZ3N/WO9PJCj+FmZAgfz+MFgSNnj9
	4nCn5/UtKXceav9rYdU8ZsXBmj9MCPOnn57Qt04VPTY1F05nqy9qgNqpUXqVd7HyY4uYg4PNhv+
	vdvhDZkPmpj6dG/1XQ6qtPm8dvE9ya9j/JDsNmas7pfwkip3dvo0qShaRxb/O2wVjMA3W1PJSJY
	C6cXXsO150ASjOjbIHEsFqM4YQnN4BYU+uLnkXO9JpPAEEN1ygp9YdZv9xyoxR6xVM4zE1pITyx
	zDMwDKsHpuW5nf4uAe9n2IwpDHBP2fYCsGECV6mmmBMD4v/LMrXBNIlekpA6nuoaUrcz40fNkx0
	YdecBM+2chyso/+wUzp/uKEj5P0JI=
X-Received: by 2002:a5d:64e3:0:b0:43d:6f0f:32fe with SMTP id
 ffacd0b85a97d-4493fafa7b4mr2653282f8f.31.1777535467978; Thu, 30 Apr 2026
 00:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
 <20260429-si1133-checkup-v3-1-469f21d960eb@gmail.com> <afJYorALBCO0eXu8@ashevche-desk.local>
In-Reply-To: <afJYorALBCO0eXu8@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 30 Apr 2026 09:50:56 +0200
X-Gm-Features: AVHnY4L1SnoG4EXW8KghGnF9K_OCpX-Z6LCvZNYv1FMRybYqRFGmwSMrGE4NlBw
Message-ID: <CALoEA-ybxrYqPvC7dq-bHVeFmpAaE5074kA6ub2OivosrCnBPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] iio: light: si1133: remove unused macros
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 21:14, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Apr 29, 2026 at 05:04:49PM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Remove unused macros to improve readability.
>
> Perhaps needs elaboration that these macros a purely Linux ones and has no
> (direct) relation to the HW.

Sure, will add a more detailed description.

>
> Suggested-by? (I am fine without that tag, up to you.)

Credit where credit is due :)

-- 
Kind regards

CJD
