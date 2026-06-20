Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165D2374E79
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781938518; cv=none; b=b+97AwjaMMMOq3p5huqoFBLZOHO6rdvSjXMhR7cnuYVlepid47H4FEbdjqSi+V/IcdSy6PnjYv6DBnS6NvTwPR/09KRu8mT0VCvX1Htoj+hE85oOkZjFcyB4QCrCbW718Ioa8imTCOUfutiTx1aoh6T1P7mEu/uSyNJtZYGCpYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781938518; c=relaxed/simple;
	bh=Eu5hwo/aQJWFOJIc8OIKWbkjcr4t55Q9ozKsp5ZpZWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2uYfts5lvyVBudhPThexGh+J+sln4SofQ0MBECPyo5kn4u7CwSime4wLArZjV5hJYZLa+P6VSsmJOEbZC9wb7UbFFzVBVRWTlLFxlAcebULiGhn4WekZ3uPt5WV4GVOpbziDDc5rrjkrpVUimB1+y5Y8Xhh59EQ3hNjakQo9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv4SbBXa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv4SbBXa"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-492329c5514so11362285e9.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 23:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781938514; x=1782543314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0SEq/QbmbcQ6YtknHdBf+w0K+ITaHYqqBKA+0keeKs=;
        b=Dv4SbBXaZ29myz3zHvnkabDVWlrMgd6+PRKq6YJMOPl/1B89JLXs7McVG6aRpZA1V0
         1mW/+LqF3+a8AzjFVrAl8qEYkFWqJ8crEzcGQzRCpy+Ldhloko4E0t+iLHB7JCip8Xhg
         VVpUoNmjV3SmBd4wmPkIqLSbStC4ZUgAixMhcD3jeCfEB8heQVYZa60yExbi5uua5pvz
         XXJvVuS+0HPUOjle3J76MYtcDx5QIF1HeqG0NBv9H2voQibejbihcSKq6IVuC3EvNjN6
         o2qzazhMU3Op5EgXsJlo90wczuyw3dk4maKQJHjjOiEDOjjVwvr46vpTqNjhvWJ7Jl9I
         zR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781938514; x=1782543314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b0SEq/QbmbcQ6YtknHdBf+w0K+ITaHYqqBKA+0keeKs=;
        b=LWzDJnBUYzfK3z5Ktv8l/ezhR7x6M19Cr9uzXQjUGbbSlebX1GYSvhhs48fKXAR5yj
         IGOcSLI1Dm6CWLdsANtiou7WNIBX8Tp0l1sxI9G+x/m1TihpXbwcQr74du3NmjDKxRyM
         MtEtogJnhL1M39PmItLK8s0p2NX1UWKa0ruXVbEdRe5HpdjOlDBAIxcXlIAzQNFn1pBP
         Q0nSWp498QwUWhdmML4qB1DqSj0D8fU6PDoDo9wG6dGz/eVSxA0/LIyxQtdJNEhCzQOI
         sN5i40eewRRhbiB5mrDdCtz1Ra8ax2DKc5KGrMXvGYc7mltoKKQnjeH1VeiPdcLRPPrD
         H3rA==
X-Forwarded-Encrypted: i=1; AFNElJ9eiEA+gUMZJP39X41Z332h04T4XWkvQgBPZ/yKmXYlyfucmdtPYh995K1G2Ybg/mfHeAsEyAzsQE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIv8ulgGwFwZgYI9dVL3GTYfnaxLSaIY8SxSWw1okPdWOx2bhc
	bxk13YRLC4hObCbTzNR5TkdD3kEUTmTrNTtN0fhVcNb7qqw6q3eH1CgI
X-Gm-Gg: AfdE7ck8NQ1ob/fa6sm8hUCBuikuSx1/naJmXiGFPL1/3QWMLtAYz1nyeq1TE6KMS+z
	RsDP8add08vU2P6pcAhKuBsr0myDMVsYgEPc1UypUe/a8d5gv4ZEEaT+o3AQT9ko4X+R0a1xetu
	HqFLrPhKkRMgKdkru0g5Y5WjYutuXrpiwaIhBzBz8HLJcjv1eO8k8nKyETlkcz/zv5h92zwGS/2
	D0RFIRGUYGMXFb3fSMa3OWehYyNLBNtXkK/dpvKECPxqj0cOTTymVMt2o8+lLvJ9idk74KO67Dy
	UVhxarLgFS7NE6BWJCREtF7Z0vhV/YZDXlci4r/gE7TjTUjisL+J4iBjFx/f+b5GWQCIeoFE+Fk
	Rjlc8cmUhtAftCnSF+U1Tu0M4B43aCsN/L3iSBIANIPQLyOSZGzy7edfRYlOvpysQTV4QMoUpy6
	oUN6GerTcaKmFTLAaLBUcfxb0AGqvmLJjlDmabk6KyRNiEOKaLwzIgHIjd6wYoAkSCJAxxUvV0V
	nEFnmFJclH+BiGGAzV2S5fyYizwOvzATx+8RYQLWQAlAkQntpNaXfFJ3WvvNcb2wrWvu0yNLFNw
	4n8W2A==
X-Received: by 2002:a05:600c:4e4f:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-49240a486cemr82447215e9.16.1781938514101;
        Fri, 19 Jun 2026 23:55:14 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd21dbdsm113804735e9.6.2026.06.19.23.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 23:55:13 -0700 (PDT)
Date: Sat, 20 Jun 2026 08:55:12 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, marcus.folkesson@gmail.com, dixitparmar19@gmail.com,
 bigeasy@linutronix.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miao Li <limiao@kylinos.cn>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4] iio: accel: stk8ba50: Update includes to match IWYU
Message-ID: <20260620085512.4a3c2748@systembl0wer>
In-Reply-To: <20260620015940.27636-1-limiao870622@163.com>
References: <20260620015940.27636-1-limiao870622@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026 09:59:40 +0800
Miao Li <limiao870622@163.com> wrote:

> From: Miao Li <limiao@kylinos.cn>
> 
> Update the list of included headers in stk8ba50.c using
> Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
> and add missing headers such as array_size.h, bitops.h,
> dev_printk.h, etc.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Miao Li <limiao@kylinos.cn>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
