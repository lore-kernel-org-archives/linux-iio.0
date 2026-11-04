Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779216;
	b=QEQ79hOdcr7ENL/RO34/NXuearFt9LDbP+QITL/muJenbYof7uwuXXKPf8AdV1GNWl4n
	 FGPhzntk8H4m2w2iZhhomJz92lgcYgZYFV5hn+WtvAhExTPqNv4DpwNjjoiHpjUXbBQtH
	 OnS00tIm5QWCavjDZ5a9frEGefLpJBBo2AS1DEL/qtmXjRNegQMxUWruuSbFj7pF7OYqg
	 /4VhGJTpvWwmnjW/u0fy59XKPid4wd4wUG6IxIcsKhTwaZ26Y40fAHyQNPFEIVh1T5J/6
	 PorAN8upmZatd+i5+9E/uINtjPGsNhI/FxJCF39WnRnJJG5Zd/G5bYM19z5lcWTmJgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3J5U2FAeFLLXR6CG2lJiwfFE52kTArm5g7+TkN7ZkP4=;
	b=ouneKr6gaCxextx4fwgF8FQX76mXYYT/KXieFQlhI2WxRxZgLsd3ysdqAROOqBxcss2U
	 UMyDFOvZoUhx+/+dAnmTHChIe/S7iSX0zsSLv3Ar2grFspZqydK30X4ug9QkA8KS3I59r
	 lzXywJgo1IZRhAb52ju8nPLhPdda9fESofFqyxW58dgq80OWXtgkr73epQkPgOpDZ8eqd
	 0eLgDykfDhEfJK/VwhkdIjkCcvtc1bedEhzoQs2DCf+QasK+7uioWt/dueD4UMSLvz+7z
	 k45IpbLx7Ybmklc45wrj1Bf6ZA5LxSoq+45fTJORes5u10Sp1tDXNrkKAnhUQ6FObJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQZuSX0g;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1F5606A329
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 08:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C1F5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQZuSX0g
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e00eee27dso180758f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 00:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793779215; x=1794384015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3J5U2FAeFLLXR6CG2lJiwfFE52kTArm5g7+TkN7ZkP4=;
        b=SQZuSX0g91oWeZSAP/p1U9aBnfZPE4Yzg8WfAvzS6pjsOG8d5mgQs8vqxpuSjDoxdp
         RRt682n1RcNg8uAgeBawgF7qNEbDESSSI+RjNsdkB3O6FqwxEvRzmzTAPbndKR0tAmjx
         47R/FpUfbrKsit8Do9I3PFqUdtQijOq+OQq+HQNz21Z1ouQTNJucNEfZgj0Uxdop2JOC
         iUaGjLr561695Bgh8ZH4IE1C5nIRPEE2HDfExE94944zTlCvR1OO44qqPAvW4AAT/lIv
         vJymfrHZeoOJTzFrS4iucUswnaSshPEGLsRyqESzvADPSoT+PHhG+jq50Rn9PN+DmOT3
         REMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793779215; x=1794384015;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3J5U2FAeFLLXR6CG2lJiwfFE52kTArm5g7+TkN7ZkP4=;
        b=cx40c8cnEGu37soXCZstoa/DnW/7OiZGE+JssnmZW7TqL4c9adihZhJtleZKPUZYkK
         UICAWZGeycYXJcO58wwPb2a5yE+lSUuwhptswiGrlQN/yjLrF9jR8oMsCN7udvyjOc6b
         11xcWoTqczoFiaLIas5ANbM8YU7vK1R8GO9Zuz89AGnoQEk8Ry2r0cnGIVqlih0WdHuz
         7dPhVeSU7aPay+1iNUEh5EpsPhlnHP3QB6ws/dJ0+JKecNWZNR7bkZZc2pYpVDmo4bIY
         Xl5H5J7oCWYPSnvbXlB2/QOGsnXCP77AtLbP+7zNK2W8EFysn55QM1aWMr8FuzJkx6sK
         rRew==
X-Forwarded-Encrypted: i=1; AKwUvBylC4TpUKSzcAxPrOC/yJn4NjVDXXjYH+d5gMUgeBg2QuajvA0CrdeYNinyAUKPWtgFDUd5Uxt4FDU=@vger.kernel.org
X-Gm-Message-State: APuU4Z87mH0LjZnTjYqnDMbmRdvZXSQsCt30FPTDIy4EzERj5pJOUa0O
	Q8iFWPeJIJKX1mthBb09ZPlPY4yWYMTetuKtBhv79zrLttO1aXb/N0co
X-Gm-Gg: AYBFou1heI1scUGIZgbUSeQyOOEnul/eR7aGCKs31VYWzFI2ZTMhc/M88okLck1FkDX
	DD4kBT0OBbbtoFmo9kDUENoZ6d1UAr++ec6KM/CjvBrqpeVVdDkYPdYVLExsfSLYailddVhflkd
	+2q9E32D0uAZLGMvseM3B9TZUIVfRUcpmY+9GivPZoSNv+Rl1mHlezi8butCVO2ehtjkDBTKG8u
	6u71Zi1E/4aosApxLU3Skg6Dp0kubd/mEmq9lRWP4aZWvMaN4cRZchKuKUIzaj276UiioCD212O
	y3EjBSxsUUSWC8DGHUcWZ85a6RL/b/GpzUub1FZTa1oJbF4xLLVZRzGLeQU1XVMNJaFHNuUC1r5
	Akksg5NdESr+8fFSzUg7RYZiFpszCEtUT0WVV0HYZjPqMa65cD+JiPWJnCpotDBHCpE6eZ3uEOC
	DVzP91/GSMwi/tjyb/sZF2VnaYbGrw5jH7vnce2Q6YzpkptV9hM8LCKdMbg8IfDJ1A1V5/ld5UX
	B2HFJlgGonfdMAcXlCsc2bCUUAssklWuzVV6b3yKTOwQFYJDN3eZdOQ/nZ/BzujaIIDMKI9Q9Br
	lsd9S/v/UD8S1IPqXjNdC2eSMfeVRtRT4ro1bJcR/DdMBOHgkqkNBjwYu5UFZ97mz9FTadFxqt9
	sMs1H5iNuiHopfcHDDNvovcKi13j26zROcs8wVlu8zKmYr64I2AKkEIPYDJZiE2DwpcK9GH1onP
	oSsKKjXdtdL/y8pG5lL5hD0pEWds8yOoT9k46R39zI4f8WGDt7z/o0/nCP63PRP3aN/QspP/3eL
	LRMVjHbUW7W0JdH48ypp7M=
X-Received: by 2002:a5d:5f89:0:b0:490:2033:1477 with SMTP id ffacd0b85a97d-49020331482mr1365594f8f.56.1793779212966;
        Wed, 04 Nov 2026 00:00:12 -0800 (PST)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea18104bsm2588704f8f.6.2026.11.04.00.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 00:00:12 -0800 (PST)
Date: Wed, 4 Nov 2026 09:00:08 +0100
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Maria Sheikh <mariasheikh812@gmail.com>
Cc: outreachy@lists.linux.dev, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com,
 andy@kernel.org, gregkh@linuxfoundation.org, linux@analog.com,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: addac: adt7316: return 0 in
 _adt7316_store_enabled
Message-ID: <20261104090008.00002b25@gmail.com>
In-Reply-To: <20261104041237.7978-1-mariasheikh812@gmail.com>
References: <20261104041237.7978-1-mariasheikh812@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Nov 2026 09:10:45 +0500
Maria Sheikh <mariasheikh812@gmail.com> wrote:

> _adt7316_store_enabled() writes the config register and returns -EIO if
> the write fails. When execution reaches the final "return ret;", the
> write has succeeded, so ret is always 0. Return 0 directly to make the
> success path obvious.
> 
> Found with cppcheck (identicalConditionAfterEarlyExit). All callers
> either check for a negative return value or pass it through, so
> behavior does not change.
> 
> Compile-tested with W=1. The disassembly of adt7316.o is identical
> before and after this change.

I'd move the testing info below the ---, as it's only compile tested.
No need to resend however, this can be fixed up when applying.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
