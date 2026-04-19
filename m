Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730212DECA8
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776619205; cv=pass; b=mXSC4l/Zz3rECRPMTwHDXhch7i8gRYbQDdo5rcC4RSGvoRiW+LZdmnhTWTjBUUliTeGjWkMz3LMbnOId5ts6vD+gpuRtH04TBQNS/q+5AkEAuHQklrwW097mKZEhFktd5r9lh5aZ74+cwkn0qXQvheUx1OO5zStWDKw5NHjfzP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776619205; c=relaxed/simple;
	bh=oLK6ChAZ1wI3QuD0mBMnpkIVIGK2pl0MDjhtTIRnhP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOSYgoQK/d2Bu5OHjAj9KkDa6WefD5XKKLulU5g/k+ghzVkv7ZnqY4n1HDLiOVNrZgz5WWrFxBfcKvjohyhvF9Grf0t2DghmXkxKhSQfYDnsT8IGhX8cWln1HqqUyRvlezm54BkEVAQGd3hfpxy51sa+6MBpvOBcXgB8XyzEfQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8XSuZua; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8XSuZua"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d77f6092eso1501566f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 10:20:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776619203; cv=none;
        d=google.com; s=arc-20240605;
        b=O9jrhacb3Qag6tEJD2TOh8b0XP9q5i5vnoM6boxUNm+O1lD7KpOcbuCJRr4iG0qFim
         jTHvGm49FnsVQReW6loLpFw9YCmYwwI71bfVwXo6y1xIF1I4fvGPgE+Hbgj8yRe2upgR
         U/Rry6PtqN1VHPJJMO67yL4b+SURLFAcB9qtZMx2WL7N9COgkMw7eKNXhOGGLDFSJdCC
         6/dfIIyME/m/Jm4jqJXA1kYmDV28mz7pUYbVdgVcPzj4sYHGDXtV9Iv3tpMQpcUiTO5+
         gIqOtyV/H/+kqi2lOPvwT8ClL5Z53+I+edxy7BNVrw37eGZmhdD/APaRiYvRBCt1HW6p
         CEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vHgQrG1ZSlLeaqJdipykM0N8qMj8Ms1EGiwCLGnePIw=;
        fh=IKo+s2XWzSFjBvu2tLF1TwjRk072hNJUiglggUPeZHI=;
        b=JNMwlq+3+4/3QzgKdDgaM0ZRgzHreLffzTdnuY9bNrEm38fuy9GJ7uKNsZWmPu31Zl
         vS7u2VRuCI5VxfLOCRSNjx5rxb1r0KXI33Izq77INKj7fNUJ6WaETBHxfs3DP9bLaIVY
         KmYgNd5utTz1TyA+/cmrrb08xZCqWstu/qyFWdL7a47jgi1gIvnmIt373QhxayscemtE
         ePoE+cFc4fSr8z6kGSEdLwvDWWHwh/9ycd+ugGeb3SEsh83QVy4fVt3R1TeYpVO3ynxE
         BL3Bk09T3NBdmcV3phEZrmukRUaBVIpCemzYDMRuCyjla0Y7CHWXu2mT4GnpK8Gqk5Is
         MEgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776619203; x=1777224003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vHgQrG1ZSlLeaqJdipykM0N8qMj8Ms1EGiwCLGnePIw=;
        b=M8XSuZuahU98xPCAeG9iBXrwL/SzSxMNiUMuHcnybKpB7nsrlNgf2MhfPexL6TpBFX
         tR6tH3qiWOKIs7IgE+2Ttx1diawC0IeWzx9K7/hcC4QXVfr6lQ6a5Mt/ias8REO3jhtB
         oKcpUV03Xgr0HWkung24CFiBRNZ78bnivtz+xv7GsjWswFWnUcVnVR9K5CsXwVJT1dyG
         MJUXea7+ldhSYwjV0uqzyqtA+GiuFm0zTNEJo7Tm2og9INtqGCIYlhWrJM6HLPw2X/mP
         NcpKNXWXr6V1sGEqM7i6NElcqI495gE8JQY/fQmh0AnDzY2XHSm0ZZvAjrr/qIHlIPj7
         udpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776619203; x=1777224003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHgQrG1ZSlLeaqJdipykM0N8qMj8Ms1EGiwCLGnePIw=;
        b=aCP7LE+dJ28vH1+vZKRJcT0M6I91i6SKEshciPfujK1F0AWkAmcOQcvIJoX6yEBPtB
         Qgfd6E/aDJTSZSTWDLG4rihFBynsF7rOvmyVwcFJOql2xrT25NHTfO4PNCNCE3shBoWu
         7JAVVBgB2B34uCct0tcToZAvvENylhZ+bSr6v3eotIPqusYk2CzWwVicGjG+UL+Z+3BY
         YqnbmdfyReidx9F09OdG4yXZ23WYHa3lSz0PoJn/EDy8qbLwARnLequBIo+ajAZMta/B
         autefVWOR1ImlmNB71TlhQRw04nNeSS7B1YiTwgk3L1XTXA0/oPZBQ9YERK9kGRZ+DUk
         /ENQ==
X-Forwarded-Encrypted: i=1; AFNElJ+gFUAiuwcpqQT7Ip5pzwFybpKeZ18tkodkTYsKNEq6vJEktNr/YoKT8sFDjkI88AXoygszEAv4t9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPUo3JNErX2UISjSltbWh6LyErgJcsiZW4p16Viwd6RxL2pBGF
	vIQbOJWRXaiKpNh/zio/C88srfzikk+TjQTD+dNgoA/pPaZ5sQ+L1UIpI5H+uziKekmPuT5e3MW
	PJCTea7bhl4NfQxxaYaee28jATz0yZnAYABYfbGA=
X-Gm-Gg: AeBDieuOWRE0PqIq1ASxm39E2KTNtRq4QIa2HT5yd6kxR10EyNT7COqnug9tLI3hTSK
	DQ6fKTF1QdEHSuk6CFymhsv+yFs4CBQ3a9MAnrUDRjvsTZOiFimZuetyQmMG2RobGKhh4WcIMc1
	tdfo+eZhwopNhFtihVL5CWHQkmgWIbWi2CxBXbx8MOq6donPCow1rqREdVMmMQmkT37XRvsfhze
	NyUk5IqAjpvg9D1cDGw8TFvYt2vmk6Srpw9Y89CpYvQsx5odzobRErGr0IcK+eDDXbLesoBpImw
	VdD+uEbtoRVTytz66ySoRWfO7nH0aLKyjSxOWNzRFdgEQl5Ww0ixTZ5sQVwpA5UGrhSjUFDjUak
	0zn7TMS6HaJhgphSXQWtlfOsJnasTZDaHPkSiioGu+RQEEjpmIF4cxFkCWGSJYOvO73BsxmCUyB
	6llFk9tkyXEMMDUhB9kSDDbAEiEps3dYWL8fDSipPOXMbmu5kjUA==
X-Received: by 2002:a05:600c:5297:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-488fb74a431mr174153045e9.8.1776619202672; Sun, 19 Apr 2026
 10:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417101623.1281-1-joshua.crofts1@gmail.com>
 <20260417101623.1281-3-joshua.crofts1@gmail.com> <20260419175202.7f0cec54@jic23-huawei>
In-Reply-To: <20260419175202.7f0cec54@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 19 Apr 2026 19:19:50 +0200
X-Gm-Features: AQROBzB6fnr7Ss4G7awlJzAyQFITQs63jTfcox3zLeOlVJ8sLIVYelg24pQ775Q
Message-ID: <CALoEA-wu9U62RUrRm4V94eL1KZBzZMcQ5znZVetOxUN6keeOsA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: frequency: ad9832: simplify bitwise math
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, gregkh@linuxfoundation.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Apr 2026 at 18:52, Jonathan Cameron <jic23@kernel.org> wrote:
> > -     unsigned long long freqreg = (u64)fout *
> > -                                  (u64)((u64)1L << AD9832_FREQ_BITS);
> > +     u64 freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS);
> https://sashiko.dev/#/patchset/20260417101623.1281-1-joshua.crofts1%40gmail.com
>
> So does this actually improve readability?  Sashiko had fun with this one and
> I'm somewhat inclined to agree with it.  The suggestion it made was that
> the following was more readable still and avoided oddity of using BIT_ULL as
> a multiplier.
>
>         u64 freqreg = (u64)fout << AD9832_FREQ_BITS;

Fair enough, the suggestion seems valid. IMO my initial patch did improve the
readability as it removed two u64 casts in the expression, but sure, I'll send a
follow up patch.

Thanks for the reviews on the other patches, these are my first ever ones
that I've submitted.

-- 
Kind regards

CJD
