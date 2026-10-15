Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF3A598C0E
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096874; cv=none; b=Mxayp1xOkeYVDX6H76T/hQks+mxVR5taaDqh51fvNOmxbomHv47nw9Jq0l1UC8AlDLN7LVuvPel21Hng9ZS2kYGCEDY5DvRaY6pGodkoK0CBHW9wfqMT+HzI5gM/5mwZoCBlK0zFmaV7Jy5lAkvtqsGly+yp9SZ0ZrHX0us6Hlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096874; c=relaxed/simple;
	bh=XBa7XjRKeJ3NbqHnarNo98CmUhjOgDxizD3P7JuqFN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slUYg4Vc+VcAbCPApQRdqmtUWhEZr1JwfDjsK5THMcUjDu1Y+Z8D2kT94xTU9izQ1E4FN8DwLePeQVaxd49BlSU3075BKEpkKS/3+sBPxmeZbgTMhxse73Mj05bcF/C+r+mC9WykQEo9Wjx11HiTzjKPP0O+3D0WxkDiKoCQyzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT7ErP8S; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT7ErP8S"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso884935f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792096870; x=1792701670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2W/kXlm5ND7ClrDzBFtvNJDZO1bLmd3mgAbbGVfKnFM=;
        b=KT7ErP8SrE69QPgiqBh+lusvVt+J6U1wnon0AitSEzMy6xF8ZXNmZ9EmAbqU1YNGTv
         7Mo1Il8YkGIkPjxmImyeZ/g+gvnYJrxhTB3izP/ofQFkdn74qg+nY2+m2La8Ttp1L9jo
         q81tBZUgpg7ZCIKcZtmhR0SjHKD/FbuO76SvCGHo28L6Sd8HkxTpq5YgvddCQXvKd95s
         fmBioHlN0p5D9VXWGzxyeeIkXfcEeHvFzWramlpe8b9Dmg89t5kvYK4zwrcHHUiV/eMN
         nD9jow8Fr/qtZ87CLF+jd9WuB8BUiDx2DUTyX9a0MYINAt8IDJvILxjVs1LOAul0Muuz
         045A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792096870; x=1792701670;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2W/kXlm5ND7ClrDzBFtvNJDZO1bLmd3mgAbbGVfKnFM=;
        b=c7/SqIBsqicAxoGQj+SMkEAEabJaEstfeuFRTrezWjIl34RSRYgUwtkddwSACM+FYi
         JHdutS+nlkvG23UIyKPkA1HDa7TZc3b2mRWO+e6MfD16D1t375BG6hA2giKXcObFOoNa
         2w5RuCo2NafqXbXRCJRRMvd3V9sA4DvVrJl0VgFx5v81wLh5IYStSbkO1JQzrX5iq0ZN
         wxRwPJtSbNZwM/NvyoZ/CfLGssaweWU+FHO8p+XNB78qPmRcGomg4GX/BbbRjH3Bbkyf
         zqGuo/qbxBGtmDKya6pJ6KfJ6S0k+LfH08OSS4xP/L6hCNgFhcdf9LD/2tiQxr+VVxMN
         Z3ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvVPRV4xBNx4yDUOxUrgb9dzEeJ9IXJ8n0HPvHWeBgIRsuAehf7nNt1/sswnXKn26uSbpp+6t3Tb8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIY5C9z7OnQty+Kg1x4/6Kb20ElCa3qQAWilflnEqzEMdoJIuGh
	r7z1DBZB+O/qbX3v8PeP5ISc8GJWIY1jFB/ceLTEUWlYMdpI/cJozt0d
X-Gm-Gg: AYBFou1oe8L3zAJOuikO3OTYOhVNHurursgidPeprOnr62zObE9mgC5qmkR2Jtb7n9a
	Yv67U7Tn75dFC4CPRq4WrLkEVZdE9zSIuWZhwdZgvYYIRA1XBp6G5AO5FYBs7aghzOjClXMhqGJ
	GtFZ13K5lny55+kOTmXSunXBvgEcSexwnK/Zv1y3LaJSVt2v0Otpd7AyD3RbhYE3mB5UTMc4chv
	Ov3oy7lPIfKpWGzWGZgI1Y2KM/YNGxdqNJj2S6LGSzW4Mb8wQ3Mn1OV+j1wc2mKV9ErFBt4Rd0T
	Za5pmfz1AiySIJzWnKPHA8iz95TNEvsxD4HxfYXkY3OQL/Y5CClxa6FQW8uECUE2F8fuskQIBN0
	9u6wH+nwnClJOX5Wbc0GWjFyylEfuExTKDJZAlWaCGRrVGP81iaXJAI++zqLgWZfKcWwvLVMUni
	1JFKFazlz4sIqeX+hgi4eNJErxF9poOFzOt9LkjYb4mQs/JogYS2ni3EvCDev7FSstanmU3FhRA
	Nm4YDrawxDbAJYBeuOZmuT31wyh87gje73kUb/6kA4cI9hUHyh3o5g/06fnEL7md9DeN9lni4wr
	MotvxQpNKy3VxOHy7KX3+lyTJePPgb5ROPBR0ATNza+HLMzmXujGZFLV9ebbssXMrWNdFMItnH2
	P9lGnY8hAkD2sIwqQeU6ZNY655mUdHs6jswR/lkNrAQ==
X-Received: by 2002:a05:600c:19cf:b0:4a1:7b56:1151 with SMTP id 5b1f17b1804b1-4a18e48f00dmr402724835e9.18.1792096869665;
        Thu, 15 Oct 2026 13:41:09 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b35a6sm91136205e9.6.2026.10.15.13.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:41:09 -0700 (PDT)
Date: Thu, 15 Oct 2026 22:41:05 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Dingisoul <dingiso.kernel@gmail.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
 linusw@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: mpu3050: add missing trigger cleanup on
 remove
Message-ID: <20261015224105.7b27d7f4@systembl0wer>
In-Reply-To: <20261015203559.2125485-1-dingiso.kernel@gmail.com>
References: <20261015221818.09527ff6@systembl0wer>
	<20261015203559.2125485-1-dingiso.kernel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 16:35:59 -0400
Dingisoul <dingiso.kernel@gmail.com> wrote:

> Applied it, rebuilt, and reran my reproducer: the trigger now gets
> properly unregistered on unbind, so the attack just gets -EINVAL
> instead of a UAF. No KASAN report, no warnings.

Good to hear, thanks for testing!

-- 
Kind regards,
Joshua Crofts
