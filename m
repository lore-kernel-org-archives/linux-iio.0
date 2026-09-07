Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3A33B0AD0
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765584; cv=none; b=l6HItim5bdR2UMimhBa9hU4q690UotTjOS4gq41nkzZ26rbNaLYt66Q1u5mUxoo24qD23xZHf8NKm3JZKmjXAU+2Z7CLDwE2Je2/DPluhFhmHfoJxiVKK+zZJbKcieCRnnQ2Dae25GzeqPKaZmNE0gx1a2Lh933n1sk1fbPJlrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765584; c=relaxed/simple;
	bh=72SRx5dQmS01bTMQVm/HGfMNhXBTFVXE4RIoO8me+Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTaA4FDtJelPfg52Tis6CYf2u0hJvn6glh9pQlQzS17xGoi1t4rYoJegCeY61VGSQvk8ltW5X8MRKXFoyxO4yJfLDPb+UMgeJtcDhVBXg7zAHlrtomP4Iq8pw7SeRabwlehnXAHp+lbQy0DJoGgD/ecFSXLN4jATIu+b1w05pCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pU+re5v1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pU+re5v1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956869750eso27291665e9.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 00:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788765581; x=1789370381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n21XKk1J4MiPxr+otl4pfstKwkgN0uVP1mEum83myf0=;
        b=pU+re5v1LDvj2u40csJsm355ldrgwrlQJWX4ajABN9UYOkT2IKcS5u085h/5TIPf9Q
         pLgPrvTMOsTxlSYdCSF6zT8a6m6z7sMZRmh9mGrO3rdIGAeU7uio5ExE5gKCrEn1ZbNg
         8KWxG2B9rGlfs/++4frq2ZELStOpo1jt2n6YxAceNlCbTWaK3720WyvjZ9TnkFr5B/Tf
         YQGj0QyyhEwXXqTdWFHZ6Uc5MYYHXMg1ITO/a39gkwUfIPGXnWiCCcf1S/7r6QWAmqrS
         CVc5dogtF2qWtRTMph9KaWQ9xy8IvSU/Uz5zGhZHWvX1l6yxlYmHj+vdHHA2ZmI0sKp6
         urmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765581; x=1789370381;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n21XKk1J4MiPxr+otl4pfstKwkgN0uVP1mEum83myf0=;
        b=kDfnkakLLGmoInJRJ7pLcooW/eHw4qE6rshBB8Z74AsYQUTJlJOID5Tm0Y/2noVsjz
         QDqwrMwK6XNOzxJ5cQfRjLbW/nC/WeYk5XrMMP4/URRcqrYIDetx9MAAYM37+YyJj72T
         W4DeM1lRq2yW5mw4cx2nma0+hwMEChVKi91JQ24HfNI1jE7dRrTmNtFkDa2oHfYzOMdV
         gpUKv90EPyoyy3Fj94CTnjxmxGUo5p+o3Fp/Dww1p0dKE0ipteXi9kXIFlfU/mZbgpKC
         EIpmgI4QgS491g6BdhTC8suftFswTMjIVwXwv3nnsifE0dkecvsWDJ3PzwJJ1JkVl6fQ
         iy6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzj03slX65MdX4EXBpZ/gjVUMIeNyWb4Oq7ewyRp3FeBB/CqLIsl4GZXdvG1Sum/jmTRJXqflH0ylQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mmquFfFbmudldg+tjQ/6aMFwKsITvJqnE4YiuhCKApYBAgK50U
	rptNbIguWQuqiz8Q/xQ0VIxgZ8tTqgh5fkxCpVlkLJ//MLxXiHJFxceM
X-Gm-Gg: AYBFou296+YVy9PLCx8G+hF5dxUQSHfYOnoE5H/WgNT09gcvK9aZkuQ5Oy7kxj0Zc1c
	eOZi1eTkATn2QoZbqDBWF++SEaCam7/TJl3nIlbtQVcFG3WAUcTTTnX8V6raBPj4vFpKBTp07RR
	SBWFCRpPGamoHmKC7BiiJKP7nSRn9sY/2MpKqGeeCsTHqTREvg0i3jfnzKALdoJf8BGbnGg+RqK
	M353p5mSMQ6Np8I+W60j7GyMBvxFGi2pdaDb5r3HTQlf0xqMo0xNSl9FKHtrogJweLGlhIImHmR
	Lw3bizMKjgrRX+cnqDF2tK17kjB/grttlMr65aRx784Ae+a5zAJ3Zw1uj+qgckglSxD1+lO9lQy
	xlWduiwEivRP2bT9w9Mudb0UX1/I3vs/k8E+O4oFFaesZntvLPK9qUulhStzOhnhzPcvzoLLgiW
	AzrHFZUkrLkpztHoS39sadwslvXWZ62Py8cvF0XdALdhSH6dpyGOdL0AFi8UKgGTKqH3ujCmRmI
	ahrirE6+gFyFb46q/kRYuW5JCS/MWG7SsDqeGa+hqrpR15+tIVkMYuBYk7YMkVyZxkhZnnWVxoP
	KL235bzHg/ipd/x1yBOXx07T/dtSub3FUq3AdsNUR9qyo6ncn2Xr4rZLShPtKZb0ihYzz7aCE87
	+4G1PBjMOK0UftciqSwyfyzSterQcaWS2MfX9PqKRaOh7EGhgmn6ZhbqnIWwbhJKOCRsyog==
X-Received: by 2002:a05:600d:8443:10b0:49c:fa20:cc09 with SMTP id 5b1f17b1804b1-49cfa20cd42mr139379245e9.32.1788765580299;
        Mon, 07 Sep 2026 00:19:40 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5563c6csm324187735e9.4.2026.09.07.00.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:19:40 -0700 (PDT)
Date: Mon, 7 Sep 2026 09:19:38 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Fabio Cesari <fabio.cesari@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Brian Masney <bmasney@redhat.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: isl29028: fix runtime PM reference leak
 on error paths
Message-ID: <20260907091938.00006748@gmail.com>
In-Reply-To: <20260906223737.206730-1-fabio.cesari@gmail.com>
References: <20260906131203.125407-1-fabio.cesari@gmail.com>
	<20260906223737.206730-1-fabio.cesari@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 00:37:30 +0200
Fabio Cesari <fabio.cesari@gmail.com> wrote:

> Both isl29028_read_raw() and isl29028_write_raw() take a runtime PM
> reference with pm_runtime_resume_and_get() and are supposed to drop it
> again with pm_runtime_put_autosuspend() before returning. On their error
> paths they return directly instead, leaking the reference.
> 
> The usage count is then never balanced, so the device stops entering
> autosuspend for the rest of its lifetime. The effect accumulates: every
> failed access leaks another reference.
> 
> In isl29028_write_raw() this is reachable from userspace with a single
> rejected sysfs write, for example
> 
>   echo 200 > in_proximity_sampling_frequency
> 
> which is outside the accepted [1:100] range. It returns -EINVAL with the
> reference still held. In isl29028_read_raw() the leak is reached when
> the underlying regmap access fails.
> 
> Take the reference with PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND()
> instead. It is then released when the function returns, on every path
> and without an explicit call, so no error path added later can leak it
> again.
> 
> This also stops the result of pm_runtime_put_autosuspend() from reaching
> userspace, which fixes a second problem: that value reports whether the
> device could be suspended right away, so -EAGAIN or -EBUSY turned a
> successful access into a failure. With CONFIG_PM=n it is a stub
> returning -ENOSYS, so every read and write fails today.
> 
> PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND() is v6.19 and later, so this
> does not apply as-is to older trees. The adjustment there is to keep
> pm_runtime_resume_and_get() and drop the reference on the way out with
> an unchecked pm_runtime_put_autosuspend(), which fixes both the leak and
> the return value.
> 
> Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for < 6.19
> Assisted-by: LLM coccinelle
> Signed-off-by: Fabio Cesari <fabio.cesari@gmail.com>
> ---

Please don't send a new version as a reply to the previous version,
it breaks certain tooling and workflows (b4 for example).

-- 
Kind regards,
Joshua Crofts
