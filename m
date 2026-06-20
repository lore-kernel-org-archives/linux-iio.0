Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D154652
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977181; cv=none; b=CBeZewpYEhFTUXU7EmAZaNtxzX+bl4FgxHPvdjGrHlRR5Zg9zdu2jqu+AmzGASehsX4e/OUgmgZAbPbKMAuSbxNSEgJrHaOvdYg4I+ePYXagRcLm3csiUHnBXTUVALBazz5ssbz/9zRfx3AMEJd5ovojOpVVhsqrCe2hXVnSV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977181; c=relaxed/simple;
	bh=3BSJ1Akf7OzVX8ACMEeMKor0GB+/w6NPuo/zquwy3Hc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lh1TvB94J7afa1ZQTeSe28yD1UejNg14P/Q5JtU00QLHHWTKudqd6YtnVnIAhKZAeQNPe4PZAaiEcBna86VeznJo5UcrMvW+3c7m4hsR32QvJxmL5QAgaHCzAiqP237INBJqTfn3K7ILozRqVWADaXShE3oiMD8iB/++BjIDMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUWAAMQ5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUWAAMQ5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c6d31bfc70so19612575ad.3
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781977180; x=1782581980; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BSJ1Akf7OzVX8ACMEeMKor0GB+/w6NPuo/zquwy3Hc=;
        b=EUWAAMQ5uJ6dqpFtmMMqFj6V1IOnTvuh5pydJ/kWzD10dcc/S3LqZm1hZjQvCwpUdT
         KxzGCR3N+S99xtYj3ORZgVJxmerg03NEDnodV3YfFbenTGTrWQIFQLuj+xLVJIUyedTK
         /h24zE+2kURyR33EhlC0IzzbFE6gcNQ9Z5/eVAS935qicTGoGHkHdYlQU6/aLtmpsgI1
         i6FPiZVT0H4BCmhN9GHwMgYVwpx2IIAhkzzZtIpAnPKb/TKWeBFgkdhan90FhD5RUMXM
         RIP9EAZLylqSsBVBdziVWc1C2CTOJKN4m9f/J1VypKZiq0Lb+JS0n9jswMuv04kc4QeQ
         OSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781977180; x=1782581980;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BSJ1Akf7OzVX8ACMEeMKor0GB+/w6NPuo/zquwy3Hc=;
        b=XNCTdDna4gWxkixZbVssHsPDrR9RnDpdtKqw7+tIBe7nNYduWaxJDmpnmltkyKddiM
         mVbdSm69KF9wMMGeuLKM1ql0byhY590JTsq5/qB9nlNN1Owd+BOLqKFE7VsOiFPr6hH/
         lQwxGt8hd/KYUCgEvn2O/aB1Ma91aEJdfFt435kMksgUStRu4XGZn9D18TYwl9rNgvMY
         BNQ262XUakQSWVMu2BkxrljrDmWrH82o/Idf9kzCXScM6LNm3LVXMV37nHrH7IyCDkXc
         4H3JAcJasABblBz+SGjmkLDMltoVwKfN3fC6OtRZCB7iiUPYwUFeNCu/4RzZx4RXH5Sn
         odPQ==
X-Forwarded-Encrypted: i=1; AHgh+Roezcyk/WDXLoOAzBu/3teq4QLpnPT4I/6GjI4pNhRlKju78ZK/jYsL4/hm5UGcyUZVAyMTXaT6Ao8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd6AIUNoG2XiqPT5MINI8RjnJD2PGbeA/FXRMr08dYXzowCYmi
	VNwYaRlzGkTgrvqhqswepHyOj20uYde2t5xkVcyFLb3kbL64mppMKIx2
X-Gm-Gg: AfdE7clRIxQb42KjqjH+VOWQMTrqy5wh1awO3mqC2vRd9EK13BKzgCw/yBf5xXaT/2A
	+iWHeKZfJ5mcx0C3bP5seH7sZYFs4UwoS39noffBrvzw9S7QHqrtrWzXylpjYn0b99Mr/c1TPqf
	lpbDQb51CuvFWucDeJo7Fuzo+oJe+QyoeIOBXD/fgGbNMyCQiWT+QLWYBHmn065vO3if4z78/vU
	kFyioroOh5hcFzlQug+Lo4WknO2fYWtLSgYRy93kcneXRLoRFjvpe393HfTk76Nb1AlQ5rBerAJ
	+oMsZztkaSXkHcQULhLxqq38i5emdvoivOHKExmipadZMpxXHuat6f6EdBKR1WUFjX2cWgwryM8
	ewK+JZkAJmooMQT4H4ZeZ9vWUA4/mvvVz9z9enTditqDx1rVPZ9r2hvaOcAdClzJnrqksh1d4N+
	e/uw8dJV4bcL/JP/UZInFg+LJSkII98FZ21E0hwAWjwXF7CqElNypJwjQ+BUBbeTHzRQn/pAibV
	j6wqdjPZQ==
X-Received: by 2002:a17:902:ce8b:b0:2c1:f262:495f with SMTP id d9443c01a7336-2c725daa093mr79325825ad.26.1781977180101;
        Sat, 20 Jun 2026 10:39:40 -0700 (PDT)
Received: from localhost ([2401:4900:8836:4853:6bd2:aa0a:1945:47e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm28931895ad.70.2026.06.20.10.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2026 10:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Jun 2026 23:09:33 +0530
Message-Id: <DJE26SAMN1BY.1I5Q94DSKD66G@gmail.com>
Cc: "Shuah Khan" <shuahkhan@gmail.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Petr Mladek"
 <pmladek@suse.com>, "Oleg Nesterov" <oleg@redhat.com>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, "John Ogness"
 <john.ogness@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] use dev_err_probe for probe time error
From: "Prashant Rahul" <prashantrahul23@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Prashant Rahul"
 <prashantrahul23@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>,
 <linux-iio@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
 <20260618231543.413771-1-prashantrahul23@gmail.com>
 <6b773354-6615-4cae-b7ad-d083d59133c8@baylibre.com>
In-Reply-To: <6b773354-6615-4cae-b7ad-d083d59133c8@baylibre.com>

On Fri Jun 19, 2026 at 8:18 PM IST, David Lechner wrote:
> Isn't this a v2 of [1]? It should have a changelog and link to the previo=
us
> discussion (and start a new thread instead of being in reply to the previ=
ous
> revision).
>
> [1]: https://lore.kernel.org/linux-iio/20260616130612.73122-1-prashantrah=
ul23@gmail.com/
>
> No need to send a new version for that, but keep it in mind for future
> submissions.

My apologies, will keep that in mind, I am still getting used to the whole
email based workflow.
