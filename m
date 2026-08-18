Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6E338910
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036857; cv=none; b=Z663roZ/OYOLx90IllTlFMpCc0U2iGDrpKF641lnw2SPVGgC7N6ySlvziOSAZGMk1HWhWKOTJUqGKhTDnyy2SXc2/yCyuR5/1zbCLwaTfW2uV8Yoy0bLkmItu1UEn3x08/Yc0mkRFlSmkQ7ndPEt/ujzqVcKRVIrvuYxDjBs9rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036857; c=relaxed/simple;
	bh=Ms5nh3bEIkhd5Ae2LTk5PXreByyl1W41AcBhmFO2ZuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUnMU8g31sXt3N3Q6QNszagDs3id3/yeFnl/iwwb6Dnq6STQ8KLzcsSOuPU2YKLnbtt/UFURsrLpM2/KLcI9L8PxS8qO465l4uyf0mmrQVu6jGUKz3j/wlSC+4ZTvuVJ1eptWhJ10Dw0DWQtr7Wz0/vRordbFxDj8v5HGsaNRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyyF1Wvc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyyF1Wvc"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so38533645e9.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 00:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787036854; x=1787641654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jCTfKcxNmnd0lNHyOIRIaEgpYL1CPAznbfU/uK/zoiw=;
        b=MyyF1WvcIYMkeDuVACYx3k1sOZPN/bO4ttHVFhJ3I6ObCECvPRQd37uoeRmRhjB8et
         MOV1GIRIn+2EU8XyMalSZp7oKuXufIm7N44NEsx2rZr5bFjEaObIvlhQfEbuNo5PY/46
         0WrhBr7YtdkIUxjOc2o9EcvnpeN0InwoXxkxNSl1EF0vzZE547yIub33TmnKbY565SFD
         +C219VJJElyj3+bBbvk2trPhJbm+CUITlv8xrHMZ4CELZgOAEsBpzYJIYGLz5jYkqa0n
         ANkWFZqi4U0Imdw8xhvNznmJaK+0X4Z4KtkDg4FRTuGeaJBJaLv61W0NSnaMekD++vEY
         qKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036854; x=1787641654;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCTfKcxNmnd0lNHyOIRIaEgpYL1CPAznbfU/uK/zoiw=;
        b=DuBnttSGEOC8ejfmQxFY5WZ2v3W/JkDMdj0gTYKgPrO3Ijh1/0oMBms9NWISq3y5w1
         puWFghCTGK9b4seJKO3nV4X951wNgldMauxw/Jm1gHqCtPCQ39CCO7Au0zzQv2eKszGl
         Y7QedO75+7lQSjjeAD3/Ka1np+vRfiyYTCsNuZYuxPMqnm9g9V0UcMoNhu/OkUIwJMCN
         Sc5xZrhD5SZfZTqgw+kV3sa5fszK/Rb+BxNonzqvv1DqYvbtKXuIuy50S3H/4FyFXIEo
         3F3ay0lyk3s+ELn9JNgOIglpxEOqtS2hUvOrNsY8kUbtGnohP0zS9HesdyjPye7pD6nM
         4ERA==
X-Gm-Message-State: AOJu0Yzboq17LVn5wvJjJuFdn9Sk4eZHYrxLpQfmJSnoDk4JYuJLOaPA
	9p692W9RCtBJKxjbioZMQOx7+sZ0CEjgJ52cKtDYtTNj1J6yxzVrtzMGLn9BBbGR6Nji8g==
X-Gm-Gg: AR+sD11hLjJBPwzrDJ3Nc2T4aEsELh1wVL/vPGlr0ZIEJDb9fCuhHu+PLVg9I/UmkPp
	psWBzT6FgVZV6CpjWCaDvNgp1wRmWVF8+p8FGl2px5+7FtUdDf5yqF39x5IQt9vfTbhui90AjMG
	KUBOOXpBF+jPpJ7WyY97Ae/0UPJiBhTIxPnBA0BFLWZFt7DXsrEEOu5gQR8+DJMYcxOPIMFK4mz
	iq6MD46hYnjfknOzwASAQBt4K4PbCbVaRe02uP29iKDsJfqiAQKyGI3a2DluZ+ALwfD0XCYOmQ6
	eRLof4yv2MV/g/c9noYgJhHPaY++oR7hmrEpYJH8Uai5rIXnfn+k9JMVYpof92tTzbOBnz4v2KL
	FGzRA8ciGAeIDoIvHD5RFceRg7kg1R4Yq6wMN67H52qJR/U/z8OYps/r4gPIMqbOjh4++m6Vjbb
	7U4Yax8PBWQKcY//6Jugh1AhcAGgoCoELV7uLC4efOrTanAiIftB+hJ1F3YaZgG3rYy+Oa7SzZh
	Sr7FMt9mlrFUwBKJNe2V7nVGbqlh6EPQbLx5F1MpnE8R500Fif8s/bCoaKnUyRb8N7HukeirNJT
	SJVb0hQXoy1/PM+PfZMyTrwAm+jqD9hD2BjAg4KounETfyf1rJ+Tw3e9s71fzByCiqNJKUY1VV+
	iJzaPQG8EHnvhaNTAo2GWkbzL4uTgnvqdbtjhObz1aw2EPYNJloczqF8qAy/k/TzweC/K67NuSe
	RxfHP+
X-Received: by 2002:a05:600c:6290:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-4998e074297mr418747635e9.10.1787036853915;
        Tue, 18 Aug 2026 00:07:33 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996100073sm261152575e9.3.2026.08.18.00.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:07:33 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:06:52 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, andy@kernel.org,
 nuno.sa@analog.com
Subject: Re: [RFC] Maintainer entry profile/contributor guide for IIO
Message-ID: <20260818090652.000020bc@gmail.com>
In-Reply-To: <cb1937e9-c2fa-4d8d-bd95-f53423d88077@baylibre.com>
References: <20260817111825.000063f6@gmail.com>
	<cb1937e9-c2fa-4d8d-bd95-f53423d88077@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 19:31:45 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/17/26 4:18 AM, Joshua Crofts wrote:
> > Hi all,
> > 
> > I was browsing lore and checked out the ksummit mailing list, where the
> > topic about guiding new contributors arose [1]. New contributors tend to
> > make the same mistakes when sending patches, causing reviewers to point
> > these out all the time over and over again. For IIO, this is definitely the
> > case (I myself send an email telling people not to send a v2 in reply to a
> > v1 several times a week). Other subsystems have a "Maintainer entry profile"
> > that contains subsystem-specific process info (DAMON for example [2]) and 
> > (sometimes even [3]) a document describing the code style of the subsystem
> > (this would be a great place where to mention things like not using
> > kernel.h in new drivers etc.). I'm happy to create both of the documents
> > but it's always great to hear other people's ideas!   
> 
> I think there are plenty of new contributor (to the kernel) guides out there.
> People just don't read them. So I don't think we need another. Nothing wrong
> with trying to make the existing guides more clear/easy to understand though.
> 
> A subsystem doc that has our code style quirks and idioms would be helpful
> though as I don't think that has every been written down in a single place.
> Especially useful now since AI reviewers will read it even if humans don't.

Yes, but it shouldn't be limited to code style quirks - I highly doubt new
contributors develop against the togreg tree of iio.git for example.

I'd propose 2 documents:
- entry profile - documenting the review cycle, patchwork, point people over to
  Sashiko, relevant git tree etc.
- code style - the TODO is fine for existing problems in the subsystem but doesn't
  point out idioms we have in IIO, i.e. not using (the awful) kernel.h, preferring
  devm_* functions, not failing on a mismatched ID to ensure fallback etc. This is
  stuff that appears a lot in patches.

Whether new contributors read these is up to them (from my experience if you write
decent docs people still won't read them and ask pointless questions), nevertheless
if we suspect someone is new we can just point them to these documents instead of
reiterating the same over and over again.

-- 
Kind regards,
Joshua Crofts
