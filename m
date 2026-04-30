Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF6352F95
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777578194; cv=pass; b=nNgb2vhfsv1A6YjDebqMNSEtdZL+zThk++LCwitonZhQCLK2D9RPH4QAUgNncNFuXvIa3c6uwRWghqmnOs/5ZnqJq3+yh/cBPP9Ird8f26lHpW8sVgtn/KlZ4+1KctVEpElqRWPWxLnmAdRhrah8iRbMmVIlu8bQrgeiyJFP6cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777578194; c=relaxed/simple;
	bh=ORRizA41sT7cUE9szskQe0XuyKPYDyP1q1s4j3nEEBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQDCCpAGejJNiLxsy/qL3qB49qmckXvg/YEHYECa58dr+JoiEfVu55jPGRwEE/j4pz31Adwm/6KwuC73pIaLpxvUL9TJjwkhSf2w90kQjeTc1cDyMe4YXyGwG//aM/CyRzfxNBbru2CPSxQdl2AlVism45kZFzTk9IA1abbLiNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFz+MIec; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFz+MIec"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44a74032ff8so59029f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 12:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777578191; cv=none;
        d=google.com; s=arc-20240605;
        b=SDNviRNJtUFyd7ZcRyrGpLswJQM5MtHa2/Ev3VkIzT2jUf0ym6+WwOWzERskWkFYRa
         B7jccWMYMB1IkgDtcWYDhUPIyQgZSyTcZWCGuqaxEBFuCEDC1nMKz5eI3qn7QsJZJHNJ
         R0lduokQ49zcf3s9pGvY5HUSyhR+0d1TrdzpuHqK8Qh6AqTN4VlPfsbGmKwLdSiRB8UX
         wtDd477jWdjCDsexhYiG9IFVjBXhoSjJKJc58ZTkeSs6EqbdgN9jUmAqXd3ncLJ/n8Ys
         3wtaZKaFufM60mOD+yjQ36ASZlnRIH+GUVz/ZSezeIo9VQ2Xytj9a0fMB09zhHnNCTsE
         D3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1Slg+P9GqnxtmMX9YMDB+rlGhqwPbPZNVbFeg0TcV3k=;
        fh=wCdRTziyCfHoshJeNQDPLOoihO33q2zECk1dfu7XYTA=;
        b=TzshcGJ4KZsSDxVONbdIZNXAz7s1cveaEopgtAGzPnbLjX4un3HHOuWHG19hPRfapz
         aqDvuqqt40CFGRMAO7jUDQAATkJqpiBpxQka5uiEJTrlXQsoOw3235Dji6IJ8jXQJT2g
         l1N+aeAijxkTVURuckVKJttZe5Xst96YKtsF7ONEHrpCAiKSfDkInJHy1/B7Ab82P6EM
         BlDZw7h4h2zNBhrhO5gW5cyTRlQVRRlH7vXz+aDzOguMBz39kIqnFDjLKYbCGg51FPQJ
         KUGC2wL66Md2lHZL/NgLD68vK9Xr4k0ojtqRbt87vDRd5GQDe1wRKTSqreTAsh8cLNkN
         GUbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777578191; x=1778182991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Slg+P9GqnxtmMX9YMDB+rlGhqwPbPZNVbFeg0TcV3k=;
        b=fFz+MIecunmu7cxSCr/gTXroexvt6w+apl7llMT/iHDx4Mprn+R3OmyzeI3uY44VhR
         EZbCrQLoRORRd4Kqla1mKyxCO19tsA8XCpKwmGS2C9SSp/sPXZy+t0TCeMbdzRGS04Tb
         MX+SApScqV86IALmpm4W2l5vT5w2kp8aZPl2nciqdiOxTjOy/18nlK5qrGWI+8OWlNlA
         Stmkay8YINfMjqeBhcgG89GRVEuaqiHRZWeW5VIn+EmK27NK+43N9QT5jHxB5FEf7bTZ
         GArEpNZ/5q9Cjm794YQI/WndJfLflZXdZ97sJpj7dZqW0CIIoJKO/NGDw9KtqR8cdN4a
         0MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777578191; x=1778182991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Slg+P9GqnxtmMX9YMDB+rlGhqwPbPZNVbFeg0TcV3k=;
        b=pgRYGt9lXEEmpgze2zdkqifkSNtQW7Fr/TPF7JEvIADs1QEfZpkz6YhdBT9X/w7/FK
         X1JBtxfp/B7c90Aol5vCkkdZvfjFuIN6GXj8oMv/5t9wcpQ4xFvsv69KKGpgghq68Za9
         w8sC+XoScK7BpZc/Ajw7EQ9WNM7pnoZEUWskOG8FJCPfX17ggvBlg4USrWJdRS1d8woY
         IRNG9Dj5MG/2EhroHZsKkWpFlQ9ZZINLHB+wN0PQT5Cza9f/n1PTHxGcwe+j5/oHpZHe
         12ge/Ml//gVdzY+cBVfRFZjA4wVCLp4bpILZTcPeNP02nidCguMnsjEpwWXRWR1ar00H
         JUIg==
X-Forwarded-Encrypted: i=1; AFNElJ8FtPid7yJwkzUf5KtX8r7AOWC0Zchg7RJwBlvT/RKzMyhxirFyAKWtGXJPSkddCrhvrk7ACYIEnw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YychVbu2RUiwsiARQI4HFHugNWXkIQvqErDWYvP1VLptPiNLLyV
	mqSOviVlqNXc1vkIS4aYbsvwakInfdtI68tHmfZzdN97uPMEAF1J2THO6yqjWC9UZQpswrnZIwX
	YedsTi2juKw+mZM25308cB6KgfCQoOCk=
X-Gm-Gg: AeBDieuUMP0C7XPqM6QPNotkOLtgxMMofDSRy+Oy9osszIo48r5qbE7k4WQHpadugI/
	L/YgRAQ+X8SxEZtLLH9eJfWfwWym8qzjaSXHcdfe6ieC5laJ0Zie/61nlHFvohPFr1CNH0CUNW2
	Y6yKQsUP19+pe7Ol0cMFPQABAqQ4/LLKdCrgBrslGNnxKU/WY9keHDAEVpjozHba6MAwEjbBvRn
	D2k0nyI7ZJghomyOUeClXEwDPnn/igITMZCTK0ytaXOHcQo+iuuUNd1xhXVHy4x46ROAduG/0+f
	NzVEEFag9uEsiRD/mVjrm2Kt9G/GE9WB3LvGv4DDiVjLwrc0hozm5GG9WrMLmeJp0wTdqtsFcuu
	llcGKG3UpWFuP+v8YbleYNAtScl3jWGbsEfWTSwmwhzTQim21MkHoNS/27fwq9plYQUb+qnpFH7
	a+JCwQb8WmPcS03UkKxtsmQiZft9Y+Y0pHg9IdwBYeCj+CUO5PGA==
X-Received: by 2002:a05:6000:2c11:b0:43d:6787:992f with SMTP id
 ffacd0b85a97d-4493d02a39bmr7378191f8f.10.1777578190956; Thu, 30 Apr 2026
 12:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com> <20260430-si1133-checkup-v4-5-fb3e9dce41bf@gmail.com>
In-Reply-To: <20260430-si1133-checkup-v4-5-fb3e9dce41bf@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 30 Apr 2026 21:42:59 +0200
X-Gm-Features: AVHnY4Ky9U5bL6S59bN5xxobzTWQ5NSAJWqQ-eBe-5lPAzv1wo_Q0dejAsWSe0A
Message-ID: <CALoEA-xMOYq4MKhQKycets-W4DJxKmvZWrr-dUa0KVct_6DBDw@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] iio: light: si1133: add missing include headers
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Apr 2026 at 17:05, Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Add missing include headers to prevent compilation relying on transient
> dependencies (array_size.h, bitops.h, completion.h, dev_printk.h, err.h,
> irqreturn.h, jiffies.h, math.h, mutex.h, types.h).
>
Minor issue - I forgot to remove irqreturn.h from the commit message and
add mod_devicetable.h.

-- 
Kind regards

CJD
