Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9569357D02
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341963; cv=pass; b=f2CP1BHLm2dBgEtRjVEQQ2C8AnaLjA6biD3B2EkcbxTB+89OIP9bgVV7nwB2tznWHubfqg5x082slxcximzdf02AIxJhCANvMCnupU0DeojQ3M9GcLWP4yDx2lTLRaNb0DmahxYYNImlSoogyCgq4dXXPg7a9fI2/3MGEReE11c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341963; c=relaxed/simple;
	bh=43YsiMPMJQNvGlRGAuWjiHImu7cz7MQEtaKZXv/j6iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVT/4F0wwvVauVXeqJ/Iu/S7ZXweyhT8Ojba0BJkSB2hteXKsFXII+V95ZwHqE8eEOMapCD1LjE73LuLFKtd641bXfhMekOYy2+ofs6CqM2wczT10dfdbYstx3fTwbhARQAHWCUePBrX+smzby7DMhoOmgUgjFqVt6qYr6N2IGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfhkQYL5; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfhkQYL5"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-46019b190b6so5587f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 12:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780341960; cv=none;
        d=google.com; s=arc-20240605;
        b=Mf/yJc/0QW9UmKp/z3iY0LJn3beyJeOEHclbZPH5cRGQhxvSKBnKKlirmCgi80HpxD
         z5iQV+vIYJVZ5S5e8bdoIcPxbXqJdz5lNxZV2GonJm5rdm79GsQ4JrU46buSBh9El+ql
         XLPQ7tQl+yciyv/MhnCbZ0EMR4byEoz+LXPD46SxkEptq4ozMDbTyqfdyWC/H6kvmDvW
         SUTKNs2pIo6zs4ezps1Vz4NIW30wTg1YArzGMJXDQ6hjkawPmWZB3oJm5WBQDky1SVmp
         qpeIWJHQNsx9IRO/ihow1ydKxzb/QpY3ulHHQODpbtkyA0BER7j4YppqP2rTr/IrP5yE
         yfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+rzlZOGS9nnIhEqHHjozpYyAFuDLHbGFYjHzxtw11LU=;
        fh=VdL+e+Jnktk4nf3v7M/GzV8AU0HYAlC59m+1YHkJ8ew=;
        b=TTr52WSgn89GaUyL/iTvY0MRtNaTTjtJCsrbg2wh6djlRV6UmQZX2aMGNF8YfNNcjh
         m/d1K55GjOLx6LnAAjt0ZlldlkZa1QynXYLmxTYbIqkvHIcDpUaq27CrwFtT+V4evZ/D
         14p/eNV3s7Nhn+ccoJYxWq9a7HHSgscxZYVafMmyAQKpUah0hgGMb4ZMjm+ROVPz/sHP
         iKvJEMKK7qp468YLxt+ur/bBG/Foonc+2g/1NUodk5Wf160F8Jg6/CoZxUMID8agoVYB
         9on12ZfNCowuvqlMR0vqKCVknHy/WN2O0uSz4B7R/FyQ12rnmHvvI+1ff0idzXT+1/99
         KdCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780341960; x=1780946760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+rzlZOGS9nnIhEqHHjozpYyAFuDLHbGFYjHzxtw11LU=;
        b=jfhkQYL5kCvjUmQnHl5Ux5kSC5XArvayoJWdkpAcSys8LtxuuMlU72t/ZxipsmLYhT
         V7NhA3UEcwMG8cNylSAnUnV3J2l7sdVbXeMtxzedKay4G5HG6HsB15UXlVHKn6ZGchkV
         oFlUidhXCyM+TSoxuXK/hnZmCrVxnpGQjsZFRPpd3KLy6C0i0XGcbJh2tt5OLcDSKvWf
         VwUlQADcDGOAbg/LQDtfpQj1fB5qQuxZGC8J2QawDPO+7zTLzvRjZb2DQF3dNUa/1QZu
         wqjO3goAePGsqoT6kdk1fYabXBthH1FwbwoWDvWXmi4Gelc4FmC57SMhN938lr5z9R7t
         P3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341960; x=1780946760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rzlZOGS9nnIhEqHHjozpYyAFuDLHbGFYjHzxtw11LU=;
        b=MxXBJVU8wblLjdTg5sKPqwf6+bwUyM9CyZB8351ikyCO8gIWmVHnh71rdO/vNceOYy
         GPwG2sOViClAzijdB1uSJXtOpalKSPRWm+KX5rk+yX92T5/HW9Vgv9T4cbiGDQFVy2jZ
         MmGOPpnY6WL3AjIqvYzHr+uC7rzSAL5pxYxhbycmCmCxSRbjLk6MsYvUrVrPsPW1I4xr
         OKR1s/osQpiVJaMwVJTtW4bWPv0mRHsj7qDArTBqS7I/n0JB2BUyZ22LOCuDLKfJyK5P
         wk+0gNB2KNzHYN5dl5QSsGOmCn0bHUPO4zojNFGJwSYnnrR4kZ5btz+c8gZjzcPCfadM
         DDaw==
X-Forwarded-Encrypted: i=1; AFNElJ9g6jnbKFEtORKSBedFrc4SSrkYC9v2XT2jqcTrOmwYtE0ZFrOU6a4FHkQrVf9BNDHSFDZ2S4tvRrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq8PUBUlvwzXFoNRAMrAY/H7nZgkX1EPghW55a3uBCHkJ+fCsx
	9unGdZJRbHJUViEA8N64P9EP9oZ84obP27jrqJqKbX2JH2qi0ZWqsBpKeTCQ5CTpXUWnVqEjEku
	+WxF2btlAGQ0vRLf1GLkWX14LwK0xbF4=
X-Gm-Gg: Acq92OGVdfuZ/R4bKqwcJXs4CU89elheq5Xx3BGTAK4GCdOJZ/uuHe1Z/dgWxoWs5D3
	nFzheKjhA6WaaZunnlz9E5x2Ab2uG4ttY45dTBXdwvOT6LcSSCnAolsAlX2UWK7h4qnatDwxSCI
	NhNgP+3b9bYsWzut6I++aLOHd6bz4i4R3/Vi6BKJVMPj5c7waFraAUUEL3I0jYf8r3HgRrghe/8
	EtJslfY0dvgslluPzDBAbOYjH5Nd1khQq6DQ33D70TjuPqpE2GdfJKFOuHCMcRJIpAmkDugXbBc
	e8pQmioBK6QJ8tRSwfptZbYfzlM89qWoE0e/nGxjlcpynwy52R6n8Dz/I5Z0x/NhWDOjbnJY0Pq
	UeBBhsmlr/T0cCQkkx2jmqQxkqwRaJnwO5HICFKVjM2GIqlsJJmD9mEybUO0Aomj60UALJPYslw
	lbXQpWMVgdL3tEnw2RRncZHu1pLvwzUnn/thRof3Dikhv+nk9SoQ==
X-Received: by 2002:a5d:6a09:0:b0:452:11f9:bc40 with SMTP id
 ffacd0b85a97d-45ef6aecca3mr17732093f8f.2.1780341960163; Mon, 01 Jun 2026
 12:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531233828.60697-1-m32285159@gmail.com> <e0a07428-9931-42d5-8b29-f92806ec39a9@web.de>
 <20260601115234.36867d97@linuxescape>
In-Reply-To: <20260601115234.36867d97@linuxescape>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 1 Jun 2026 21:25:48 +0200
X-Gm-Features: AVHnY4LKElkJR_K67_VQDNOhU9kJuGEg-BZ9Zszzagi3wi-WOezAH8c0VCsdJUw
Message-ID: <CALoEA-xoW66J6e5DmnUGTn3Px5+1uHghmeN=HbvwMWCzTnEJ7A@mail.gmail.com>
Subject: Re: [PATCH v6] iio: chemical: scd30: Replace manual locking with RAII locking
To: Maxwell Doose <m32285159@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-iio@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Tomasz Duszynski <tomasz.duszynski@octakon.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 at 18:52, Maxwell Doose <m32285159@gmail.com> wrote:
> > How does such an information fit to a known patch requirement?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.1-rc5#n81
> >
>
> Good point. However, I think that it's such a small change that nobody
> is going to care that much. We'll see what Jonathan has to say, I
> suppose.

Considering the patch went through six iterations without anyone
mentioning this, I'd say this point is moot.

-- 
Kind regards

CJD
