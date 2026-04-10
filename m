Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27E3DD504
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857615; cv=pass; b=O6y9t8Jvi1a1+goH0MYllWiP8b4AfkPMeuB7QjBoxg3lpi7Rs2/ojbbC0Kp4YH87H2FwknG4phYu/t9stAAc/kvTPQ7KIpyF+DMlbhTO9tk1iPpQFCKTCcWM7jItIAr8oiJRPuw2nkXFbNQdIfK8glbXp25oFdVbATBxOXXSkWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857615; c=relaxed/simple;
	bh=KsJWVKEvxSkGZGaFB58Y+SOR07exaiEWZVpJnRiIgUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmjCsZemwKxc44DluYJJCWYiWFY2jZ6P623qba1Vdjxs72CJp3YfTrUUP41WZZz/KC/l60uYVuzEuObTNFjnqppbdePkdhPZe0/A/O7agRnItimw0+RqhB5mh36rnoljAl+JffS3XgGzdWC9zhqk0L4NKD2NKRP+6Z//VnZN1d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjQuYuMf; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjQuYuMf"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a1307438ddso2537651e87.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 14:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775857612; cv=none;
        d=google.com; s=arc-20240605;
        b=lPQqHNzxNTNEmfMbNhNRigGIT+gkM7/V8MK8MW+nyn0D/JD8ElNndtGn0ADd0MELed
         idBMUi4hxhPbxUGCwheWKQAsZq0qyKMbXDiHG/FslC77j5byRO13nj4bwh98aNGnkFcN
         k6QPjnzEbI8mKbJSQlTzZxtGIEuCKOZot17WLOvnSuc89T//leu8nEvFXWit6ZeTDgH6
         tLoDBHe7/yLFXVnd++ma0ObQJv00GqQjryjvMa2ihpD7OdzTfgIOn2rv19iinc52FNrX
         CU4nw7Ydz0FDKHbXi0iHOWba4Wf5pF8YyS1FmwBosTHZ3TfivZ68pWPOLGNlxYescUKb
         53rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KsJWVKEvxSkGZGaFB58Y+SOR07exaiEWZVpJnRiIgUU=;
        fh=sXIhyEIwG2+jx8aDrUCKOTVKB/W47FGZfFxrR8aTYSg=;
        b=YxYnozMAuIU3R40EnZrzohzXDPHjb9trt4l6wYuIZwQ+eYyoMVUEtcLt7wnNpqTWr+
         W2ogwFPsM/RzUWpIwgLvwbJQ/VOW9jVCHZ9sAFoROxd5PVOpa87ON5NWl4S4a7ZRmlB9
         64nqVYLvdA7lh2f5yt9bQh1qhhfvAJoiFtq0VstywGbCsWRDsfnWhCw35NyLIoGFVrLp
         mz1iMdjhTOTtYtyXin4B0SGP2bzafzg7OYM2p+6xL/OzZzz9qzabn0Dj2w8x0rs8n0mS
         nWC7jfChDmJ6HSuP3jq186JZDigbL9U76nFcZcQWAX4DbJqwSEFJ+wGkKfVOizI44+NX
         3HgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775857612; x=1776462412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KsJWVKEvxSkGZGaFB58Y+SOR07exaiEWZVpJnRiIgUU=;
        b=sjQuYuMfxh03rKRWv5vWdfgWaL2nBmcPQEFYiG8FUEzF5wHEY1ifcGAKkWG8TsnC9L
         BRsA0dJ99mnHGDD6yTMaC/cgur+AdDk1fjTs2vA8RL2mjL//8AnAXrB3iha8bC3SJSeH
         lBPJzSTJLPrppDVOqWP9YtQ8S0fHy2LlP9uQnwGcMR6U7R51DNSSsXc0mhVFfiHxWl8N
         oTlAzrMjpxlNN0aeL9E3lWVLcJY1Vg+eZmDvtAvWN3wNHJrXtjG/B8fVS0t7C3kiO9BG
         pCXwPFq6TjohAFedZFR4mawqj9FtUWE5ZylEJedPhn1fsgqxRXhsRCcMfTbf0vWOJqpp
         x3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775857612; x=1776462412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsJWVKEvxSkGZGaFB58Y+SOR07exaiEWZVpJnRiIgUU=;
        b=FbjBCt9jQ536NsRK4xLONlhMhqhEzQIbSz6hJZwrCOYopBWihC+7BcZem81xgQAZbr
         tJbZnOVClIUlZLJv3fUGJciluA6dmd+F/EUYvzE/iThuDM0BaXm04pHLF6fo++B0AzXt
         ktG9zuV0htcQB2km7eUwSK36yKDXrHUB12XIGOFEORm5itoMCeBePrlRdX123KO8xq9h
         gX9II2e4h9tfnPmxa7VCdR8HjulLBhH8BF5kjpawaTE/THvCk9K1igBHgGe/sloVFFl9
         JGRe91q6EAxIKV1kpb4ZHRgyC+udQJlQnmdC0M+fC+dY2p5yuurhZykd7KWUqYoOZ7mP
         i+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUN70tWoCk9S0IrAl9tAUcQ1ZnE0Lo6sbOTJc0wyhQvaFbMsy1g3kzNNUNP5l/yr7jc7cPa5Fbsn/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2CWRibepMPoe/awA4shxp84NjvRSXFykGt1HHR4IqltLcczk
	3AYGlkIQm+AuOB24MsPpkmuOkjLL416W6Z+spqBIr2FHM173NFSya8/2Lapm4vQcUOUQUYv8xg5
	7QRIK/aakQD69HKMK0VwVVafxojaFNVo=
X-Gm-Gg: AeBDieue0DRXZ3M73jzgi9AD3NhpcM//8qlNXXO3FDpsn9yvFd9ViEtGuz13CgBcu1h
	mVH1SEk2vWBb0epcQctXqmpfggyNJATqVplwTVRx0gixCIqH9T7d6YifIyh+WhkQc37R4o6s0Lx
	wqU36BKnXDZPnEsTX5QE7sCxYif4Tx3slfSdrtdfxEeIHexw+j2TcgDo77XFSzeGe/3YGfBRKgy
	PRTvPQ1tZ7Rv7ZWkdXX4zJDIAjK4nqsMi6yAQdLZXXM6vn9kW1gkbGtf/nM/btptUaCaOO8PoiG
	vdjmI2xGUjOs6GKoawEcNl8VjBJsiesmg81eWKDN93ylnnY2/9m0LMKbg6h2vL5ru7eLPQ==
X-Received: by 2002:a05:6512:2305:b0:5a2:c742:7a76 with SMTP id
 2adb3069b0e04-5a3efe8e7afmr1739017e87.44.1775857611387; Fri, 10 Apr 2026
 14:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410211329.185147-1-piyushpatle228@gmail.com> <c885c62c-f0d0-4dae-87d2-e6fb7257cafc@baylibre.com>
In-Reply-To: <c885c62c-f0d0-4dae-87d2-e6fb7257cafc@baylibre.com>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Sat, 11 Apr 2026 03:16:12 +0530
X-Gm-Features: AQROBzCvirS9u-CDrv9qFVUZ1qDIBSjCNulX2ZXfUscCm1STR12CPHuohw5Mfq4
Message-ID: <CAMB+xkagi9m6-5PAJeor4vbrS+oV6eoVrqdOQEwNU364mbk3Bg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: use field_get() for EOC bit check
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>, Felix Gu <ustc.gu@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On 4/10/26 4:13 PM, Piyush Patle wrote:
> > The driver uses FIELD_GET() for constant-mask fields but falls back
> > to a raw bit test for the per-channel EOC bit, as the mask depends
> > on the runtime channel index. A TODO notes that this should switch
> > to field_get() when available.
>
> Could drop this first paragraph, it is a bit redundant.
>
> >
> > Use field_get() here now that runtime-mask support exists, and drop
>
> We like for commit messages to start with the verb like this, so
> this would be ideal for the first paragraph of the commit message.

I have addressed all your comments.

>
> > the obsolete TODO. Since NXP_SAR_ADC_EOC_CH(c) is BIT(c), the
> > resulting !-test is semantically identical.
> >
> > No functional change.
> >
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > ---
> Reviewed-by: David Lechner <dlechner@baylibre.com>
>

Thanks for the review. Sent v2!

>
> And if you are interested in doing more like this, search the IIO
> subsystem for __ffs. If it is used with << or >> then there is a
> good chance it could be replaced with field_get() or field_prep().
>

I'll also look for similar __ffs() patterns in IIO and convert them
to field_get()/field_prep() where appropriate.
