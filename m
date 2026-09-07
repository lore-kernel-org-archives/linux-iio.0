Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7746F486
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793002; cv=none; b=HgY28lvgGeHAmqjkXC0GwlckovK4Bp5LGq2m9HWCDPtufW0RqBDAMsgCzIva/KZvfv3Vfc2gR90IvESV17Ewj91ZnS/1UAL02SimRlHVbiBQuThrfHQ6BjAbEmQlGR3yPoqW8p78l4Mes3rfKrtMXZAHH4yGIa5D0iqUyvYfyak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793002; c=relaxed/simple;
	bh=+J14SNkIJcgl5o5mcOmI50R/KCvTRGedgzOnLKvHaJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpLaIULRScphQzTtBbvTtZHOdSK0/e1+y/M+vZWUh2gd8o/QdqRjiAfouXVdLc4HUYY/hUFSLFm/6YBDaAFvoAmEGTCh9xgYH5Eu8rOz4S2A8WcWnbRiZCy+7mVGTeC9918tYg4jivKmFnlE725HMTOSAPirQ9g3I8B9l+QmDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgjuLR3R; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgjuLR3R"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482f9309813so3255432f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788792999; x=1789397799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g48hwSF5lt99YYul2mb7fuDrefFoNQOf9CLbuEcDZMg=;
        b=fgjuLR3Rca3kO4RlH/vo4Hb/mEb/LPfmGQ8KHUN8IHeQin5ry34aTwMnCXjP8zqAwM
         iFssGqEepIpzvQA9N49/UqwuNGVfbXVNlrrGsnpw6NOujwjBv9zUIKux7WTSFr2KfbiQ
         LcdLUfBrqiwF3mNFnQckkzaDSzV2wsXSylcVvkmbW2I0o4QP9qeR7wanX8Nz+cWVfGID
         Jhfz1rNYHQYlVGPqDk9Fpr37pd5xilBAZkl78dZWZ5ij2RRZjZElVzzLZ3p2FXa3bJhl
         0STBKQTpOQZ7D4z7snpn6LJd1Q9nZxmhDjKuKh16Wdd3B61xS9OXdHjjAk9dU2gEfU1l
         dDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788792999; x=1789397799;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g48hwSF5lt99YYul2mb7fuDrefFoNQOf9CLbuEcDZMg=;
        b=l8pthH6kIIPFI9ZuhSQxbwbYl8oenOzoUeqh/CC19TOSkrdk+QIxu9HV+STfFNqfog
         idw2zp2UTFxoCwnSR3zft3xFaKRCGN1ZpDybaFNDN7Yh1hGOvqVNARN/H3ovsKI+ypTz
         QkHiIArMlrSlg4olHMo2aopmpCh5b94Vjm/R4xNQgMtLNOC1ERai79SpzIR7P9PCbb/n
         wBTA6dgC4LgBdS3ra0pq4aoMkX3lN+nSQ24ERe3u9Y8528Q7u2S/KEN9POgftbkbPeSa
         rbvWbgJk4tnBeR5cuGzwTPWQcU2yiF/2chbOKukdn1OYKJwZIXyzd96XbL3/27pqiQGa
         5z0Q==
X-Forwarded-Encrypted: i=1; AKwUvBywNDDWEOFHdBzc+2hOckT7O1lCQEE4E9L70/+0FrtXaE6MEghD/kaScIAluh29B0q61+OwnNVzpio=@vger.kernel.org
X-Gm-Message-State: AFuF++nfWesM9/L+xpMrXM8T9en8lta77dr84tILAT6SRH1PC1NaA4Dj
	jiVTY3gEp04mio80QvgWbLiGwtcsBPgHwzgtU2AjOqWMHJOSFMSOzs9G
X-Gm-Gg: AYBFou0/I/Vl3rWLk8ODtlnaiE9M8UlTmP85ZVLRqUpsWrXXTNQBlQmxFzjcEzLXr9G
	mfKkx4KPCrV0+nLVaE+TuE3QI/SfTVpS/vC5C41FdDM2PW3lDEVgULtjrrPaL8dM9omPG5ae9YT
	PO0/71s+CfC8LxAzDosRPtw80ng5HHOgXkxDP/EsGETTsyWl7ypDaY2ngfUDUUEtlubMgiBtZ6w
	z/06cQxlNp12Rsg8FieiblouZRGhHohAF9TLNHrFrj8Fi5GkWLGAcuqlgX1Z2ULDQUrZZXn97Q2
	w05Fftug3Ge625VCasZwIzbgi9GNVqck27FbkuATPdQEINB5ZgpRKWERnsyKDukABQfF4YZxxC2
	QytgHyLKq6bKnwQ8wO87I6gaE/LzaMqorCrVNlHK0JR6kHOMKmVeCdaKMUeo+T0MQlIaI3B1opd
	WGE24ZABjF8effSL7kGTwfhqrSePAaqe1u+VqaGtYFGdRPqEOXUwAERuUAP2DeKliYUsieLgG7d
	hIbQTMs/Eeq7nit6rc8hyd7uiMQZCDqGv2ZINLfThLkXPWyX5Xpn/SBWkm2swUYGX1w1VtZd/T0
	aQMv4DkV1RwrAVOEQBIMMv8EauQoB+GmCPEzu5WPJjERKNXj62igyRSLHhxykN9s4wccXD+i0JG
	fqlsZ2kBcP+HEerd3jLTJiS5RBRySZTDwr+42A4qGLK2a23cSdA0AFEEZW9Lvs7jxW9FL/g==
X-Received: by 2002:a05:600c:1914:b0:49c:ff23:a6d5 with SMTP id 5b1f17b1804b1-49cff23a70bmr191567445e9.0.1788792999098;
        Mon, 07 Sep 2026 07:56:39 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm316801845e9.0.2026.09.07.07.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 07:56:38 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:56:37 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 <linux-iio@vger.kernel.org>, <linux@analog.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: adxl367: resolve interrupt mapping before
 device setup
Message-ID: <20260907165637.0000348b@gmail.com>
In-Reply-To: <20260907082313.3054-1-antoniu.miclaus@analog.com>
References: <20260907082313.3054-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2026 11:23:13 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> adxl367_set_int_map_reg() uses fwnode_irq_get_byname(), which can return
> -EPROBE_DEFER. Running it after adxl367_setup() made every deferred probe
> repeat the reset and power the device up needlessly.
> 
> Move it ahead of the regulator enable and reset; the lookup only reads
> firmware properties, so a deferral now returns before any hardware access.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
