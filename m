Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E003E3C41
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099966; cv=none; b=UAwmyw2Tadu/8s55w+IK3hbaiKzqQNBmfssoUvElzXswJ1Ef8bUfub1uW+brYYGA6ZxkwT6XEXFZvAg/wgOSgKEmWsWhk3XVBzdggYhnRgPGEwThNQKjDNVMEJ5eO9RY5DvvMbmxJPdrF0GABmFdDrihDAn1LFKsv8pZ10B+pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099966; c=relaxed/simple;
	bh=t1Vx0WWczc68f+U8q9DeNEAnrtMP4GtI8eWuzGkkt/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cb8+1y3wA86pycQo8Rp/M7093d+ouIA0+L4zXEUUS3IMj4T6juuUJWSUkc02yuJLTogN84stoaVktMdYTYGxVU+vfnZOAwPR5gbEMP9aSaNDWMgHjSO0qwuXLFkD5SHAIOJCkdzQ8ml4wtzSOGnO1nB191Nf6vMZcHwad0CbG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXZo2n26; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXZo2n26"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so60539075e9.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781099963; x=1781704763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F9Bu27zhLAQxo3bpwCcfJfzXxxZFv8Hb8JSD4aipxM=;
        b=UXZo2n26mFkwC1lTed07AlrKxix9tRTk9TbBMKK0hkw5/B0LXWOKzdFC3xnHUelz2Y
         FDKAte/+bDepp7TlVLSRaF3yeQk8xS2H6ERmz+QOtHG8iXfr3QmHQINGZwFi0AGH1Tnk
         NwVXB9cMfnDbUBF2CkP67pkJXRA8Hpf1dTkVC0kXlo0eSBIf/Lfg7PLdD5ZFHmI4/kHC
         uPBMa49tewgYsFvDPyrR1Z26KG7wIuGFW/C7MfQVxoJc1p7O3HLaYmUqPceCld9DG1Ca
         pdvftPYPJFIECtKlEWW9J8vWEVN9EHmev7CKZEgjNS04WQztDxkFF0SI1qCeejORznSk
         FKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099963; x=1781704763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2F9Bu27zhLAQxo3bpwCcfJfzXxxZFv8Hb8JSD4aipxM=;
        b=m9nr4oCEFl9u55wyle91JbYlUrSUIdvfJGSSTrwjuYL8yisVOszeXk6Kh5sqcKsyBq
         MjcXRn2c/tqKffbeetNcShSmUg7VWMbXkUiHBjMFGJMH1uqBOJEd9j4z/GUKv1IShId4
         9ZQnWhlsmd03b0Nn/qwGfZslI5YqiJDN1VtnukPY4N+qhSZx5iIKURUUJo2fqyAu9E4Z
         SJZBjD8u1hXIpIU1tFx2O3Nxps1rrc6A6x0PCdERzr3JJL6Tj6tlDnDrGeAnRbEJ+vRZ
         hoLHjW8zp07PeTcGggBHW93mXn13IOr/fjkFtrE/Ej8gr5IBpSFDCPK9KrWy6nvaBpcr
         mm8w==
X-Forwarded-Encrypted: i=1; AFNElJ8D4Lk7xzz8Rx9xOU89VV0PgjiHv4E8XECfmyUyOvQUsXVYpoxGCCOQ8cESm3i70nwP70LjKS3BIWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6Ekp6OMbnjNMdaw1izSLSUEwtctuaetyNjxP/vKnu0gpHr/X
	XNkt+q2NV2wqOOgoOmGWllO60ckUMmNN4M6chrn0wi4mWh7QMgayG0Qw
X-Gm-Gg: Acq92OGdmzphm5txYVCoLa881TURxpetoVlzKCie9uDDpD7HHaiPaRpY4zwhkHonCft
	NUuyyag+Rw6b5JUuhSi4+aEvl1lC/ylMlulfpMSv14Fuy7dmDNHQhwsrD8zwBsa8T4saKQxRim8
	3OJqm08m3RaqScNm+TLMVNtocT0eOMKZQuroHLSImTEHmCNXKJtqWwAv2wUhX7Slyc4Q863gScs
	lK/9Obee+mnAd8+Mpv0tXCiswcSr/9JigdX3xsGyMztY22GzZl72CC5/hfc3rgVytxkLPCKPjGt
	9kpEzaez+yxyQk0Jt9+l4RNoQ/eEEpgPHgi25hubhorlpWgSsEY5adJlLFbcn7Wol6t6f3p9K8c
	z+3N7zuYLsDkqC259zmbJrLjizp/WQwvEV1kBcYG2IdXJGHVcP0bgw78X+ZRvhHsZX5tymdnr8e
	8zOqiG2qswthkKATXxz2XZUmV7VLRuzDVclIPyopiBaFUMc2ZYLsbhGz4zMvFdBH+j/rPkpIGhh
	Bl79j6I9TT77UC6qXAKbrQUFmkjeZhsGTrFXZgX0CfAMDkGTluEIXjWHs2FuL5pg3GPPQrObYe0
	8FzLXtU3CisBgsFOEYZXEYPBI63RTxDAkCEhrot01+UrCKi/F3aQZr61Ld4QzknjOlVkY2y6h+B
	K
X-Received: by 2002:a05:600c:3b04:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-490c2cdd2bemr336741045e9.7.1781099962639;
        Wed, 10 Jun 2026 06:59:22 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc0f8sm559386445e9.8.2026.06.10.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:59:22 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:59:21 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>
Subject: Re: [PATCH] iio: core-trigger: correct CONFIG_IIO_TRIGGER macro
 name in #endif comment
Message-ID: <20260610155921.0000655c@gmail.com>
In-Reply-To: <ailpoosKZwGskxUo@ashevche-desk.local>
References: <20260610040501.204967-1-enelsonmoore@gmail.com>
	<ailpoosKZwGskxUo@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 16:41:54 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jun 09, 2026 at 09:05:01PM -0700, Ethan Nelson-Moore wrote:
> > A comment in drivers/iio/iio_core_trigger.h incorrectly refers to
> > CONFIG_TRIGGER_CONSUMER instead of CONFIG_IIO_TRIGGER. Correct it.
> > 
> > Discovered while searching for CONFIG_* symbols referenced in code
> > but not defined in any Kconfig file.  
> 
> (Btw, did you do that manually or using some scripts?)
> 
> Wow! This line is from 2009
 
Perhaps there should be an award for finding issues this old :)

-- 
Kind regards

CJD
