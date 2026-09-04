Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A802DB78B
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527009; cv=none; b=L8Aj14KiL+wMO9B+KUx5ORs4i0thR8hQZZvYO8uAU2ScMZhir/e4QuMr/dYvrXK1Vwdae3y2RfiYJRHeyfHY4bVGAFFfkKAuz0BTPFG5+c1Crc73qbMDKRqG4D7Wk9wR/W2tLSfpMlfKczCO8HBn+jHIacgVV7YUZ/heaak2avM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527009; c=relaxed/simple;
	bh=EoVmxPlvDSLv8qMbJW5aJY0ku0MjfA0utKXWMDjSjNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KupcOjwvD0Yuc5+j6NmFkM+ywUtyiNI7YV3RWxWdD0kbRoNk5mwQIurZhrCUihIaA+/ai0W2ck0ICUMXc0TDqj2/yXU6KpKulB1USeUhcdmOS6ygSeUc+HazYoUcrWIOxk1PZnU5HpVLO/C4tNK5RPLxgKX0DYoWpz6s2NOEJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0ue/P7m; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0ue/P7m"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4843e397f74so1194890f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788527006; x=1789131806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fAzeAZ+MiP033Y7nFGVkOgPTbAdaeAlI54k0sa4zxbs=;
        b=b0ue/P7mNCajQfdBSvScFgm6TUUiLuzE4FgSPQrR+bv2p92ac0wdAbRkWjrVzUVyig
         PqlzAhKpbW5kFrtUE8vqiJzHoAEWZXuzkDDFEDCgt1aMAyysk/rFc2i119E1U53A/Mlj
         nx09tjg7l6N5H6UBjpfABzR69xuodNzIcWWKtEUe8h3IIr7eeieM2+I4se2rvJWQ/Ynb
         xKORmyr/E9OdtNmMACVLcBb1PbJUDCjswXpbv1kG42v6Mi2HG1cSAZHARmsqzgmKfsb2
         zEcMkrJV2h0hi6jssIqJtQMxlr98FZ5ScoTEUSWP6nmnwRvfNI2LyHup9DrIIU43Locc
         nwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788527006; x=1789131806;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fAzeAZ+MiP033Y7nFGVkOgPTbAdaeAlI54k0sa4zxbs=;
        b=pJYONI+Gjpoo4ltpXj/V7KrSG9wKBe3Zx28rvFdoREswtmPWgiYlSHts4VYGc/hJVg
         3xgKSCRb3wqf+4Om43gI2trC1H+iDIfZisI+hv/8fnyrCYzFzI21mWxLjCUlg1kxXcjW
         fQ+9dSSSqFENF+tE+uMVYE0OdY+G+YJlu5XtFCDM4jYFmzjxEPFxyV747B8pMSUPb/PM
         +vOKSzExFsKrC46rqFA8DMUsS9i2jwSR7iiRbcaoTl1ZeS+H8lABvx43m7iJcUQMG2gw
         6yFa1ygOQOTmfGAb52Fb6EJBGmFho/MheynpdhjNbmd2KsEwYgNWRLIrE9YRxDzmPs5q
         E1uQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsQ1emuZ0+CfziZJOdokvS3wasNNt+HAE2qDqLQvEV0ufcZz+z0Qir8LI3PmuRdRO43nt0yDSnaUs=@vger.kernel.org
X-Gm-Message-State: AFuF++kor0ZulpsoZgTIfcHakHSeMf9/udm8okrXjJqoZTGABYI/67cw
	alDG4IlmZaYr28LApozuhsIptLxiv103dkJO21IueKBoz1ftbSkOXtjC1l1CS4Ju
X-Gm-Gg: AYBFou3Hg+ZkOuIyv9T3v2w1SoFEKth+wJbAwFNTR0PwpIQSlYE6a9CkfuAd04LRg9E
	aMhHBnH+WIuYeUBsQM21f+b/QXc1mY0Cu+swalV0AUPdG000nxMAYpNWxD/gYi3XPi1i5ArxwtB
	BOwYwE8NVtCGsUjkqRcQkbPG0NcBTjfScR4ERbSsNhTKl0ABdW5KQ9o1n+5mXWbccm8Rlj/L/5B
	e4ZWt/ioZizMsTU38Up5IaRSmLsymYQ2BBVTalOQI4i3OO3ZUAJMPFVzHom6/ZuhAQo9ZUDCBmb
	ywEbltHJgGaU4eiq5KWA9K17ZuUAUvMLRZ/PXUldJt5R569ZC6J+CxCwh2gkW7hSGPaX8Hk7ZqT
	3L826q/+xyWXICnM24oXWHVWdH1RP8rhWZ9j7YsWVg4p+B9h7qJWA5faIuUzOlEvyG1B9S51rj1
	vUWQOHe1fwm1MRc/Jop0GNb/MG66kV62iGEeMYQaRph9AHRmSyl7bpdoksHNg6nJTKwxgj4nGwe
	dyrQwbGwhCE2RWgXq/8taJ4FCuMYh2waahg6CNW57WFONUag8Ro/K5yX7k+ElQM/Qc6xf4PC+Rn
	Q1akzAU0iVZpy0X2Jo23NxoxyE2XFnuO8DZTWPT5nupajNkcrqKPG5u1599iQJLkTu8ntd5+YfX
	Ylgd+1FK4Y6nldhRSO348IXXFtBsOr88w/Kr9IYlVhK9voUE0G44Zr140GwrElrPyZEsgjg==
X-Received: by 2002:a05:6000:2487:b0:485:8639:d58e with SMTP id ffacd0b85a97d-485891e752amr5013026f8f.8.1788527005575;
        Fri, 04 Sep 2026 06:03:25 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883959f0sm6679927f8f.10.2026.09.04.06.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:03:25 -0700 (PDT)
Date: Fri, 4 Sep 2026 15:03:24 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Tuna" <tuna@tunakilic.com>
Cc: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: mcp47a1: Allow full-scale output
Message-ID: <20260904150324.000034f2@gmail.com>
In-Reply-To: <1788525776688344002.1788525776@tunakilic.com>
References: <20260904122513.175298-1-tuna@tunakilic.com>
	<20260904143848.00000d7d@gmail.com>
	<1788525776688344002.1788525776@tunakilic.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 12:43:04 +0000 (UTC)
"Tuna" <tuna@tunakilic.com> wrote:

> I noticed it while reviewing the driver's range handling and then compared it with the MCP47A1 datasheet. AI was used as an aid during the analysis, but I manually verified the datasheet values, in_range() semantics, and the final patch before sending it.
> 
> I don't have MCP47A1 hardware available, so the testing was limited to build and static checks.
> 

Okay, that's fine, I have the hardware so I will test it.

Also, please don't top-post (inline comments are preferred) and please
wrap your lines to ~75 characters.

Thanks.

-- 
Kind regards,
Joshua Crofts
