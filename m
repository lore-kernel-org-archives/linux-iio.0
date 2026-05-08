Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD6358D00
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230767; cv=pass; b=alpKewudxkmAc1OQmHjYBDs8M+ipht/iJCFOysW5NkYO5SGoCFaUUafBZgNfbR7XNKq0jLxwkb5hPEiAjrB+aLKB2Hd4DKV7dUYl6tDSb8gLNOj3MwAl7FObe7nBEadUdKu5yZzbQ9k5bCeJ109y1H68Ft++QhyiolRCsa7fFUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230767; c=relaxed/simple;
	bh=S27xcr+AKwTOb6B3f7YowcI+Jq6zDXhjtTI3ucdlaVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWgbmuxn87HMowSeSIfmPvBKfqrD3als5Qm8U5/wZ544km5QC1yWMJ8knyIrmcBo47/ueYzQ9/stztZiUs2M34u258wHEVnYbGknvrYQkiM7eEXy/GopX0ZVZwjcwI6Cx8vXVLmeZHLGgR6EnrECSEkCxAVXO8oK/+yNTpqwx+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqgbk40D; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqgbk40D"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4526a8170ceso982095f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 01:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778230765; cv=none;
        d=google.com; s=arc-20240605;
        b=Jftb7tDCdoRlUqtJb09w8NcQB1ciQOs+xFCegNam0jxuyahtcW6qWKhgI/P5h937OX
         KB/2qjs7DSEmmRgZLIizbFnqMgXK8qr6StZZVGmW1NysJyjxFswrNZjJPnLzj22emNY0
         4Uri6LE+CZUAr1K3BVthZ/th1lkB6cSICobZi9xq6v4bzm8u/kwaQUN1N+K/jQN9s+kh
         78PbZZT136KI8xXFtJQYjnI9weRZBZO8dftNAl2wVp63U3tKTagls1lZdjiCWQYuUBZU
         nafvNLurGGdJAlXG+xSU9DzEwntXDKO60tLkHQEG/EB5MPv21UWkO1e6oHKgvoQzVDFB
         0dNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f9Blrfbs57Bq7f60RjI+2NCiXLCZ4KpSESmXYbDP0zM=;
        fh=L861fFHxiwkhx+eLxmAZ56GbN1WpnwSQRyJ8D6PynS4=;
        b=E4jA7scTSH5NrX+LA+P4jJFfCUvc9oqk4byaKUlLPrzu9bg0WycLMIg0auFqmlObuk
         g37nFJQE2vXuKN9b1s+Hcc7Elth/vOz09qtPvQd2eYoWTTzg60+B/KnIrPp1pF1ESNES
         uuez3fOhinDy+QinUpxlYcoSAT+uXwAXuw2ksJK+bBAtbaI/ijcTB/wjd2nJSkdLKOHk
         JUCtKL9H1CwCY51nPZfCTM3y6byR79fAXxlbUsyyhpu2ZiGgEpcbrDcN5PdoRurSirjD
         4nNh5DvFnS0VE1nyr4ASLaKxCXYQvaOqpcF0W0RuNxIULAWh9GE8smZ9r68i/x0w3bYz
         LfOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778230765; x=1778835565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f9Blrfbs57Bq7f60RjI+2NCiXLCZ4KpSESmXYbDP0zM=;
        b=bqgbk40D+NBVhSkSykIY4ZCMKznaUktaYslE+Ukhu6AhEJJVzAz2mzkQbeGO8xQG3w
         /21SBDMjo3q8pBQP/G/pxVE5nqQ6HTXRGPcpeDPhyDsEEU1QT+KDTaqilzXZijNGWh1w
         7zmHWJWMNz9i4FpmNxYHT1PfIw9w8Hkv35QOuYGffO5JZYSiR2SaML9vUn1hOGzHpLut
         2pDS94llWYwi1Mx2VP8o+3E/9Jr0JSkUgKPPAEJHpSrokEZos/dpzP0q+ZOdlnReKB3a
         W5PSiwT6inqRStnygK/eS1u+hM/eXjnnPAv1uFxohKNCylyNnra0WiHk1pcw9ZhpnAcB
         N12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778230765; x=1778835565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9Blrfbs57Bq7f60RjI+2NCiXLCZ4KpSESmXYbDP0zM=;
        b=XFJDWVv9Rfabg3MRTE5jOUzex9N4tx7fv0rcg3s4YY7LqcbCjvmPspDNxwCYrCP8ny
         vxEUGEcdNUkIJ74Eg0/CHShj3FfidBfQsZNzXNG/l5GCsu3pCseZqu2AW7S0u3HsKgO5
         yyEGniHVoiEB4ObA+mXGYo1rMEWflE3vLbXbkJMTnYADMrkAqXwJPZuTOiOfHrTC4FI1
         BFkVzCOXxhRcfTSeRlrKtal8a6SSTJqPdoiuPGQ0NZz15OWdmA5brgCeMsloJAMaJjv4
         zhgMlTVrWd+H7KdWHOm1s6/wT1OfGWATVc1leEgh98Kyg4x1Rp24meJjrdt2ossY3pYG
         c/Xg==
X-Forwarded-Encrypted: i=1; AFNElJ/0MAm6sPpoQmVYsWkKo40XFoXSXNxnAbIG3APkidtgIc3bojilT1AeZq0IxSrusnBy6bszmwTiwXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQQmGVKIjAzcQ9chy6O8ujCBD5kbAagXrLtxJyhiRbTmk9Nc/O
	Tpmi8jPSJHVQz1YQdUfdTOVNwjySQ7soC7/eNWG9L6Qz9Zjy/znylkqW5chFUlDpOyGpxD6BMsC
	lRHDdi+PKAfel5WHSnuUUH6mQnHU6FI8=
X-Gm-Gg: Acq92OE4kV0wg6kyz1q37P6Uf3oQSFelnUyDKeRrFpzzzsG7qMHST9cREySFauzzO02
	wG/3XlgMCsc3yxKH08EG6LRhxllFHGxlPUn55t+0l2XHi5Zqie7PJTerPu06Ieuf37i81mQEm8g
	aSJTD6HokZOsEAcd6V3UIHODwV5ftChmGGkB4RoCfCMrb4Hl4WLBVmHM7th7AOZMyjiY6t5fRwC
	uujU66bU69DKCW6MvHk7KTmXfXAT3b3LfYPt991EggZldkMxat0oToqw9IadhwiElMInss2e1GY
	PpmsfBs0x64FKVlFnJaAXxKoMbrftoFssMPBOcJq/OKku1g+K6FOsdaI0VM1hhH3S8KM++MLXyw
	oSNdaKTBxuOjadSyH57pSPCs74lzBBzaImS3aWh4NJFC3KbHqaWWeWhMVTMfkwbPGSHsRBGlfiQ
	vnOq7Lx3Mp5MOq33PR5V9gkQUGVoH2jbpqjcKu3Sd2ff11dvWDEg==
X-Received: by 2002:a05:6000:228a:b0:44f:d9f8:bb9f with SMTP id
 ffacd0b85a97d-4515da9781fmr18143607f8f.43.1778230764462; Fri, 08 May 2026
 01:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <af2TFa3qd_7tcxeR@ashevche-desk.local>
In-Reply-To: <af2TFa3qd_7tcxeR@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 8 May 2026 10:59:12 +0200
X-Gm-Features: AVHnY4JmQLAWvCElxGlNg8RbJITLZxWIolOrJ_InIepq97xqlHS6kq6C_33lk60
Message-ID: <CALoEA-wUdMm5gu=OhhgYV1C3o3MHEzfC0i9gjjUz6CE4B+xw1Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] iio: magnetometer: ak8975: driver cleanup
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 May 2026 at 09:39, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, May 07, 2026 at 04:35:49PM +0200, Joshua Crofts via B4 Relay wrote:
> > This series is a continuation of the previous ak8975 driver cleanup
> > effort, as most of the patches were picked.
>
> It should be v6.

Jonathan said to either do a v6 or a new series, up to me.

-- 
Kind regards

CJD
