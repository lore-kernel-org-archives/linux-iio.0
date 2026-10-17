Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE581397332
	for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792268420; cv=none; b=tagGLzRmvsriCX9SwkkWcy6BgR6z7CMdLSOZsyn/3sxFPdmQbI0u84MNlfc+rMTZ+MSlRO644ltDrLoWEJmHsdATxKGcYs+O5mEJYypkgU8ltiPSXKAy3ahukzgbNYCqUDLsBqRQ0FoV3i6yMGSuJDTAy3t1aEtyn3EUSWRxOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792268420; c=relaxed/simple;
	bh=iOj45D9QjveBgDHXCRQAAzL9Yq6CKk3ChsV5jSGC1lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDXUS3CKe6gBf17M/coLuYHdbTbDYpIPsQdnya6FUXKeOCVOKnShFiJZjuChzdOAPcH2mOJwxRP0PL+iXmRNLQqATAoGJQhD+0j6Kg/nByFTIzSzML+K/3JauhC4ED3zvcH4AR2eBGC7ctv0lbq3z/x4H2aGrW7sSsXvvD6bDcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YON0DWgG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YON0DWgG"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a16bc2278aso7871595e9.1
        for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 13:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792268417; x=1792873217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gzxrQpRqiMxGfds7uvrOMz2fXfxEw8AQx180UBPaRVo=;
        b=YON0DWgGN6Mfi/4sF/8gI+tiuKKQL22E6m9fR0MR1uDgCJjG6j2gehScbJDJ6ECg1h
         dJoswkdUm2OV7xS70Lc5l8flzlAUMDEIqvzpqGS0vL+V8sHD+K4yc+dChq0SEDz5AhMK
         mh1xZqKLKU+X4NlrfuAL05HuWUads3T2UUG53H/aezXaTPDdnI3N5ygaLQaiRRHK3jal
         O+pxju9dYWCG3ehYGImy2+gznGREl6isRRhPII8zpRqBpJKtXJKt3az5+ixmZvGSE+Pf
         n9Sl8s31b9/kkoWLwe/fUq5dDpkjUY5phbgplNPL8Klt5MwmeCdvbHCrH5bklReC0i1I
         uAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792268417; x=1792873217;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzxrQpRqiMxGfds7uvrOMz2fXfxEw8AQx180UBPaRVo=;
        b=2kuJ6XzOM7LH/J2+C07jRXmHeT5kpILU26EZfPbYMoREpkjlMylnruqn5u6lLDdUBw
         Xm7M3vAu0rqfCb4Lo+Al3WEt9hhUEQ3zfkT0Ajt+cLvoo/e52kVJjVEr7ien55+QDoR8
         H3S5paeWwDwgyoOk32/9OZKN/qdzuNt/sJXVSMtZ+KYf9Rn/HggZ/4hOrxh4uZQgVvqd
         XPtDRUj9+hWhZMovoUaAZjeuUUerXJPQj3TmKLBouak051d1rKWMNJ+iwXJbkP8KlPgD
         7Sx1a+GCS6h9TJ2a4eEqzEaGQqhyvRlbfw1l1ze+QMPdyCHoYwRGpw2WT+yzDXJinYD7
         VWFg==
X-Forwarded-Encrypted: i=1; AKwUvBwWvT3Spj94lTSnTXTYZvlO1kmpckYh0UAaV5QCa6ry98yO2s6zsXFSM4PMXgihXl8iSU+OUA2wGxk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtwAgjPxENG/NRjxnOdvn5Uk961OLjKiirVCFLQgcpd0FhcO9C
	8Mym/VvpvaNE3RrUqRufHTg64NPsqhvZ4X+r2itQzV9sHHu600RyhFks
X-Gm-Gg: AYBFou0REPUsDteYhDf1vhvDbdhZsYqdN0XMlSzEsw70V7HZr3ufB7sPDTDNivFNykj
	WE4hJVBuNhK8cc/ysZWWjY8b4uVhCxO/wdieZ1GDHLQ+TulQh7aYAQCGF/GnjXcMa2kJ8IiycOs
	u82Rhk6bRgiOWS0PzAeJBcNmcPY9vPRPX2aVyCvwverXmDL3Kmz0+cwn6Os4rlH3uWMdP5JRAgs
	PITxC9fjYWKBfDymfP/dnEjgSgm+zw3oHYzOCMxC3qEmxhNS6a4tkjDr+XImJp4/Q/n37A3xn4V
	6P6/YjRhznxYWWDs7TbV0VW2hEdcdMN7vTCjf432+qx5NjRbjEVJR/2Tg+SiGGORRbpVu9Gn4Qb
	aFEPoQAZjrXxA1c9FuWiJPDtfNTDoGbGsNOrR5dfemb1RywytxaaoKJ09/6Kv+8YinvPp35rhjD
	k8I6Gi8SFK466frkS735kGPRYEPHHIbwYw8NvkS3VUv0SvrUl3OQK79q1au9RChAWU9EC89Nj1a
	pd7nsFj/xa9Ba0GSN7dppGPDL5BnAhVfKaqPifq00wGOHqqWgsQ1IVJYKFv9GqmYANmwl9gKaRD
	1Ia27so1CowZjww7hxUUfrs4tXhPP7kCzCsypWPg+VZYXQXflI0uFFK0WzNTPbHxveHps3tNNij
	n+xRYpvqAkwaRGPvychRDuXt3RIqGp8x1RPjQi7RkABR9zuPX
X-Received: by 2002:a05:600c:4f42:b0:4a1:ddca:8b66 with SMTP id 5b1f17b1804b1-4a1ddca9066mr49709165e9.31.1792268416816;
        Sat, 17 Oct 2026 13:20:16 -0700 (PDT)
Received: from systembl0wer ([213.194.212.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ddde4esm191084495e9.12.2026.10.17.13.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 13:20:16 -0700 (PDT)
Date: Sat, 17 Oct 2026 22:20:13 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Dingisoul
 <dingiso.kernel@gmail.com>
Subject: Re: [PATCH v3 0/2] iio: gyro: mpu3050: add missing trigger cleanup
Message-ID: <20261017222013.3ada690b@systembl0wer>
In-Reply-To: <20261017192151.15986386@jic23-hlaptop>
References: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
	<20261017192151.15986386@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 19:21:51 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 17 Oct 2026 07:19:19 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > This series fixes an ignored error return value that causes the device
> > to behave in a weird polling state and a subsequent use-after-free bug
> > reported by Dingisoul.
> > 
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>  
> Not sure where signing off on cover letters came from. There is no need
> as they don't form part of the permanent git record so DCO doesn't apply.

This is actually done by b4 automatically when creating a cover letter.

> Series looks fine to me but given others have been actively responding
> to previous versions I'll leave it a while to pick up some tags.

Sashiko had a remark about there still being a possibility of a UAF so
I'll have to check that out either way.

-- 
Kind regards,
Joshua Crofts
