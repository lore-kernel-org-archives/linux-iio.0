Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779415;
	b=g2Ge3ymLQefrotTtAiV7OsZX5v448e8y73U5JkyP71VRsjwXqjZvhXNLXflkMOZeOtYU
	 ez1riBW3i3AAbD2NnHsLPW6jcROjp1eEJIssYw0kqYBw+pVcE7Bg055qLOgvOLWwaSndc
	 dAfPGTP+DzmOYwlYsTJpd70d7rgP59fxItwp541qu2Qi2Y00RoNKfuLWjNWNBNJgISZJl
	 MMipk5IiCT+8ppOXyK2Ue16qZCs6m3un+Fyq+O5HVNzRbIUhppgIHyc6PLzUEbTHr4kcg
	 cbj6jBnBaO9/I6S111eSkpGeTWjay5LCcUlKYiG42/60OzpJS5FdGm6loReYpFt+uWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DKhKnChRRvEIqs8abBQ2ImMZ5jJiR20dxd3W+JwXAzQ=;
	b=1m6JCFRwbaB2nrs9ersYi3fgAlxsO3rVlFxcMoLzL//EtOwAN+sz2Aw2DleVyAycpVSO
	 zCEEKYjzDp0Fe3e1NcXywrLkpnM75T7+Ew/uTh3JyYRe2/lv1Ph2phVyODrXMtcwm/cvF
	 ghy/LQTSo4+q7LnAoTMA40azccQPGrnVBvDhVWF+oBK2KiBo73ENjE7PXl4niPas3LK76
	 JVGBywRySY1rkTym8g7YiX4OikaQqXshqWsRDCEJBTbVSGCkKyLkJITqPcByv0t3pLrxK
	 w+dySmlIlGnvbzuwxc0mJe+aOVW6Q+CeqI/S0spOeCkSMQkkhKkhsVx7YFTL6buWMRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dGcpDxt6;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC8606A31E
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 11:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2CC8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dGcpDxt6
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b2f59de176so5886726b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795779414; x=1796384214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DKhKnChRRvEIqs8abBQ2ImMZ5jJiR20dxd3W+JwXAzQ=;
        b=dGcpDxt67m68ow34PrY5ZqHfznuQpvk+9cNVbc2dm9cC2UjYP3+IzM+9K5CtI97mR5
         fRUzsGNjp2/uDzhYXxDHRcA9kHsIjUa3Ah5wGce8cZfQB8HHOfVj4+jdifI9Pi2Hb5P1
         lC+Soa4SOplY6SQme54wu1EDDmScsvowQRcYOURR2qsVrgglY6sml1YPVIptdDnAL7Na
         X1Ju/g20kqurfxesaNwqD3/CvcRw/vm1iWzDu+r1L/rt6nZ/wgG+8tR6mPtBLqWJG+R5
         sY5VxvR/zXlTS8KfOjwHkpm48MsIdr3gpEZ5eWT5HsEAyb/IdE4UcK3Lj1yvYf1FpLwl
         MvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779414; x=1796384214;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DKhKnChRRvEIqs8abBQ2ImMZ5jJiR20dxd3W+JwXAzQ=;
        b=mnb98Ze6Qvy+TjadzKrvLHwZYJAYROHdwb8YH27HLVcUYq9RxvztfBRDfYutFmLtjl
         g2MHl0TZnPMC7Zui+D4bPhsNphjg3okzpkUW4FrI8SVptqV9cLvC04t/qBow5uxLA8c4
         wh8g+WbO8gM/Rt1bUlMrSmOQxRDuxpB9OxibACLwvrzYAT/gIXnNXEVeoPHWRedpkwlj
         aOosuU6dB2r46OTkw9OEPq//aiGHp1t2Rzr+YKY7+Wak1PREhmQ1cdDgiDmX/fFRpVRk
         O34QBCZfFZ3kIN1yrtNqjBS8nHZUCT1BIGgl5nOubti2RiTWLE7jgXHyOl7x8xvi5pDN
         GlxQ==
X-Forwarded-Encrypted: i=1; AL+hErGbz/zk3SEjmzlyhBYAixql5876iPzFe3wbMUnOv0mK79WWx7bXmIQbMCz5F0RaKtDqC6zplC5kBm4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SkLevzCy9OOzeqcwYdic14Pt5OhsB8RFg8MCN0fkowt9ft7cv
	TOoBPSa8cFHyZIRMI0wU0RyChwoGnSw88mPbIn1aag99ASyxJoC+GIJj
X-Gm-Gg: AZFdTZfmxsUOYOH9VYrUxYkXNsZiYPgazOsadvyNIIder/8Xtis7ObDpBptsxjZNtv0
	DGfnnBcHtFZLPG0un5nPV4Qs21/Z0xwHI/L+Bdsr3TmKFdxMiWvnQGqbsaFqsoHbccL/bQuKIlF
	z55YhGQp2/ANOt7wW2bW+QtszA5Qk0rioMn2I0AlEhgDeXZsii/WI4GCA0pwByDeWkxyAFO5ZQ5
	dYuL6verdNhHvZObAovxEfRjOQbs3edSBX9yyLR8Cxng2yKwQ041o9vzdadVNkOuNscoJMEg3Hh
	L5dX3xnavUlQfQRZh96LOIsG3ynrUpiOFAcMYpgU3LmSRcsIOIFPCPFel9K848zMqTPh93O4DMP
	g1t8+TKUsrp//e9PrX5f+BofVmvvIfTNpbl6aCG37uWP1NVGpvhabymOgRjaK0QY81LCu9YnJFR
	rmtRBMMr1yWo1wBlhepbsZgNfoFbBAbLxx410GEzrOnbp1FjxEUCAGfXkdDXdIt1aKCsKiPVp2d
	4mCAb+OGoNWTEcpeY8VvxsQ6ZGHcgqFmGusNpnaBfa4n1pPWTr5DvXrYoJ7eH6WcalbV3CbTrBl
	1zv7uFeFLfbTETh8p4Zz4Qx5DmFhzKDwgEtPZ1ALo5v4HNJgfSSdiXLoLXAx55xEXiBF9nqY2lO
	A6z0/ONj2gqw8ha+VoguZ7y87l5s9ixRofurytzEYnmKQG0TSVK24qGEhsGI+FSmygOrTvjqdxt
	EU+kdkMVcnEDqEiS/luJ8wERY=
X-Received: by 2002:a05:6a00:2d06:b0:882:e3a6:27c9 with SMTP id d2e1a72fcca58-8c87c28e012mr23070308b3a.30.1795779414330;
        Fri, 27 Nov 2026 03:36:54 -0800 (PST)
Received: from kapoor ([149.40.62.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873f16b41sm12398520b3a.56.2026.11.27.03.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:36:53 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Marco Chen <marcochen.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 0/2] tools: iio: iio_generic_buffer: fix exit status
Date: Fri, 27 Nov 2026 17:06:39 +0530
Message-ID: <20261127113640.215803-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127085722.126797-1-marcochen.dev@gmail.com>
References: <20261127085722.126797-1-marcochen.dev@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Nov 27, 2026 at 03:57:20AM -0500, Marco Chen wrote:
> This series fixes a wrong exit status in two cases for
> iio_generic_buffer.

Both look right to me. For 1/2, the exit status of 1 with -e comes from
write_sysfs_int("enable", ..., 1): without verify it returns the
fprintf() count, which is 1 for "1". Without -e it is poll()'s return
value, so resetting ret before the error label covers both, and the
read() error path now matches the poll() one.

For 2/2, -ENOENT is fine, it matches the "No channels are enabled" path
right below.

The reason you get that far as non-root, though, is that
enable_disable_all_channels() ignores failed writes: it stores the
write_sysfs_int() result in ret, only prints a message, and always
returns 0 (the ret = -ENOENT at the top is never used either). So the
"Failed to enable all channels" check in main() can't fire for a write
failure. Returning the error from there, as a separate patch, would
make the non-root case fail earlier with -EACCES. Your 2/2 is still
useful as a safety net.

Both apply to iio testing, build cleanly and are checkpatch --strict
clean.

For the series:
Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
