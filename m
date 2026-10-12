Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F8381EBD
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813439; cv=none; b=p9qA5vdbG4VFuqNfCXDIfDnFStn19c6SN8Qb78SQB9CXUakiklSJWRDW0dLRgkYV4Hg0fCPxCJUnic7HLcPBlFpt7mLfyQ9iVwVPmjnz94OvSwo8O61CA/edAB55WOGr9I/tEadCch+2yL98XrvKRCS1mr6zjav8HKd6xb5LtqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813439; c=relaxed/simple;
	bh=/iY5j2p4b5QwDQlKEMYgEYpvGS9pC1Ctd69uP/eW8Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGvBNwUwGTnqj+Ufw2D8rfK2vCKZ3PFbZtOQLm7//kWlGAsD8CHZ0ldj0Y0HC2fjkUPf9fTnj4zX8ExJuNB7eN3VEJT7ZgvDzuFJgzf3oidBMy48y+/6feylJHawPaHUIzybpdxnV+zbenN8i3Y+bUsqXt1d86lWglsiv4MPJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leArUqYg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leArUqYg"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dd33a7bd4so287554f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791813436; x=1792418236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=34EJoNLsVra8nCHZLNhyhOI+5/614M9XjyOHIoY4piw=;
        b=leArUqYgKp6Zd79qG6MdtrHyxPewrSZjNC85UQSCUIvHmdNa4v2XkiKGyU9fWcusc8
         2+S/Bw9tm8LviyF+HLFf1yAA9F/VRweoQxLUWwEHqybMTKygMbvwLziu6lI+ryOoNcA2
         OEAL7DrsDrtn3WrXuD5hoWIfnHraHhBYy4agYxTutQzfV3pYmy6IhdGflq/1Q01LgJT0
         R9hiKPsNxIuQn27E6qN9oiLxt1lQZy6c70/32UBRLkfFpLKd3W35F9g1ElPAPTQ8wGyA
         IfwdPwbsCsGz5Tza8jNBFfvGwQiAz/z2f1tYZV4xyMNU5jPc5qYFDZq/dbwF8M2RuFmV
         jDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791813436; x=1792418236;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=34EJoNLsVra8nCHZLNhyhOI+5/614M9XjyOHIoY4piw=;
        b=DrJ16BX6otGEY8KPSJ1wqiW14uqX8pC9OpKU3DZHu225zpnn9s1/wmN5H386PcoYN1
         z7TIYzJVFfykRlc6eZp3U1UE2oPgIsImyrm6P6G9kImrwjca7Cg5kaiYf7Z56I2tjCR2
         iNAW+6BaHlq1t2TQPckDC1uCGLH07lxt7obDN86gYcV+yJ9wDWU3LZAgIkzhD9BvSiyW
         XhrA2Gww9QAnIz8SmxwYVy19FE3jivc+ZR2g9/NV+yTD5axD22ffJNk57tN38simlkPk
         VfTkqnS1xYcv73E6+raI9QFV+hGdHBHLijXsUzHWFVBXsAk4GOzgSFAJwLGfUAGpxWcU
         UO6A==
X-Gm-Message-State: AFq9FYIa+VEgtpgpttIaIKvNoU3zYBkXcws2ZPd8dhOVxB11Zca6f0Sg
	M5zREH6+qjJmpwCwQl6vYMPWgHjOC0GiTFXX6pFIQ3wCUo7KrK23YZvf
X-Gm-Gg: AYBFou2UaxrJSU/oVFSAKJCVA+KCpVgb63FocHR+KbQf3i/QjuDRVdvf98SDH34zjGK
	OS6l+VRMeeGRyJXIJ5Nyuz7PfXX+fMeFW6LXj16ZfMlKBN7SzW0aRiYpijl93FZJQ+qEcG9EMF0
	8Ro4TCvlXGuB1NiiuhFAyKZZ7pIAXPSiUTWHEPEYPIseIXX5lnhckrJA7v2qmlfsG6S/iOL/jQp
	UUJczszZwl2cOG31rWy7ZHGHZ4QwWfEu1zvza4le6ZYdgxp9hcIs3fF0mwCrKP9ob+9PvWVhdw2
	2tY/VEHsXwFckyDY9y/Zhs1ohmKw/uLqh7uyBIerZ2iGT3c/oDQ8sz5TzvQTk6TA00z2JywSQFM
	7pZwDU+7+BAzphXj73FeNBudOPRk13WxZSpdXbbWhYgERh5FIeB8BysNushpGhQ7mvpaQqXIWpK
	w2a0aBJizRoRGGkaDtECqBubEbTf3Atg1YoRJLqeXiHtx3ShL+A9TLmRwyQfiznjLALxSg0PnsJ
	nvOi2F30KLMQy/IRi7gGBbpuI7PD6vXtRkgwjxP402EbLaXIsGKuastsaqxgoXA4qxZelLvX2M2
	p39sbSZBfG0HzIBMLxioBJwFZOF8mZTkHRbH+gM+B+WfA5MdseIqfSVVZWALSI2Ecd5XEwicIOV
	vqH7PjzbIysfOFwWfIgXaPJhQd1YL9yird05idcnLa/ewpGI+FsFPbNRHK69hjG8/jvaHJeCC7N
	bSflt7VDpRUHijT9I=
X-Received: by 2002:a05:600c:3b99:b0:4a0:1ea2:10c6 with SMTP id 5b1f17b1804b1-4a18e48eeb6mr236849945e9.17.1791813435810;
        Mon, 12 Oct 2026 06:57:15 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2343asm539977905e9.9.2026.10.12.06.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:57:15 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:57:13 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
Subject: Re: [PATCH 0/1] iio: atlas-ezo: Fix humidity channel read support
Message-ID: <20261012155713.00003254@gmail.com>
In-Reply-To: <20261012114553.3327-1-nikhilgtr@gmail.com>
References: <20261012114553.3327-1-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 17:15:52 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> The atlas_ezo_read_raw() function currently rejects channels whose
> type is not IIO_CONCENTRATION. As a result, the relative humidity channel
> cannot access the raw or scale values, even though the driver defines support
> for IIO_HUMIDITYRELATIVE.
> 
> Remove the early channel type check so that both concentration and
> relative humidity channels can be handled by the existing mask-specific logic.
> 
> Nikhil Gautam (1):
>   iio: atlas-ezo: Fix humidity channel read support
> 
>  drivers/iio/chemical/atlas-ezo-sensor.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

No need to add a cover letter if you're just sending one patch.

Thanks.

-- 
Kind regards,
Joshua Crofts
