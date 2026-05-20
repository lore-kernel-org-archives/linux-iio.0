Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA542F83A0
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295867; cv=pass; b=WoSadv4B9Rr1TU6vaqxVUHsLEbJ5bwzAn1H/UQuHK/PVma706Upwhdjlpvbdg4UbgHwAoAt+Mvt3AASX8lmkvYP2lmyVtRA4VdfN4Ss8vrcrfMNQR4n2tX88j+27d4VUYkMAaI0q8Oby3+vXy34NW5LP6j/fvhwq2S3CVZnvyC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295867; c=relaxed/simple;
	bh=gd+1p3lzzF9MKF9AIXrMd9VPtA+MiW6T3xqSmR2TnJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLZiUM3iv2Iwol/M4PYBysz6+mw8hbAYZspcakPP80Gr0zdrO/WzJxVI9m67bxA7cgzbdlJBt+nUg8WoRI575lUjfV+sZ3DL6sE2mc9qmgODWcmKoVpWtAlDRmzeODYvICU01BgHcLwj9peomVZzObACJZO7JUOXjFF8gjHvYSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmxuU4h/; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmxuU4h/"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7c307937816so44148357b3.0
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 09:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779295865; cv=none;
        d=google.com; s=arc-20240605;
        b=S10o9FISKxjGsvlP08k/LhOOsfS0rsN7D6FRqG+tp6mYU8pK3Y+wGBIyTnEhnHjJT+
         d2DtRmE2JsuPGzeyEp+FDueHxPKGIp8Arxo6xaRw02t1lq6nKkUh9bctxtjaqtReY5rt
         7YiGaqjraEsvMJyV+sq1LSofMgQp5B72FhEk95XXoklEu/C85FVIf75qg4R1Yvy7VyCz
         DnVmMWPnkRtoItp3Lc9RKxAvBdokDP4CIsq0nITwtPLXxYg+oT/BQRQsayMaUTOKwIZu
         c3PVCJ86wL5+L2QEGdpcOl2ZqFZR2t67KGohRDjRwMA8wbptjij8dSLnBXL27AeDDJWU
         mfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gd+1p3lzzF9MKF9AIXrMd9VPtA+MiW6T3xqSmR2TnJE=;
        fh=NGveLK1mrWWObDCouU1V5VOXo5aYIlSDZz5Mm47l4s8=;
        b=MiK6a9KG3hkPx1hQoAOoAqlLs6V41opUoKhFYCkM0LXP0eUYcAuBgdL4ZEJz3WMZey
         sCRdKHrwvnXsEYmCnn7+50SO5pN7kGF7zkJsA1cNVYapzvJOMY/06JvMy7DXB2NqyRo7
         BfZxmanmaVcaWAUx+QXWArqyWkKMoZAUoGFLnOiAX30dWk4cnFQN+ez6d9Wp787ZZvGS
         ttIpYxtUvd09f2VqGn12GARmJt6n5DtjX0AQW5KwBRLOb0yFuoZWvS8JYK4J0qXvXaEv
         7l5KuIoNgJrI2CwzUxr+hoAScgTnSNSgN3k6RuT2RHvMwj9pMmkGXjYoNR6D85Crxpld
         Z5ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779295865; x=1779900665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd+1p3lzzF9MKF9AIXrMd9VPtA+MiW6T3xqSmR2TnJE=;
        b=MmxuU4h/Ng2RJirZwGlssMyuApybL8FQbyCiw+x0kCK8QdGy2mCBUhjpsF/mbPDCxN
         lIL/obcKt2MKctjhVvARBclmxqMa9sq0483k0yYnekngPEPEOMhCOBumpHDK+2Pj4DdB
         nLgX7k5q7UtioHtel+OUK8/J2L8+Z9geGKGCx8coaW/HLBRWdXFUiA5pwhQPoeBuncfD
         a8rPfcajy7Iglv/U0sfriVRnpsnSb29pBBUh5cidEx7isBUYQLDMnt/G+79MVvTbXVX1
         LBQA8f15tSgSMc/DOnKCjO2GYDkah+RxjJmLjsKxyuk7GLDZGCXKZfhfbC08gIrxtejm
         +4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779295865; x=1779900665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gd+1p3lzzF9MKF9AIXrMd9VPtA+MiW6T3xqSmR2TnJE=;
        b=Zh8QMonhMkEHXim78iWMs77HT1IZt5L8tZOrRvM+0m6d2PAwBwe88Ote+WqaETLia3
         KQ9F3oiCdEy/OFZrMoMZfJenIwIxLvr+9FGlBMcrM/VOtuiQ2qlHuxPmrKRgB4MO5Pbh
         BWR9k6teFhARysSSzoRnNvLuO/xPBWS1/3J1u1s7nCfqfiSqKsfKPGxgHEX+sW9sPNLD
         SMbKzqnf20piZPiffapZ+xIBkYtMgXKuUAYGzkYA4I9ve051HTXOII2rw7oKWDnpzenS
         oQMDqJ4WQZEt51f7SNcSHpl8dnbk9QRkUiwjjrdGfMoYHYqU6xNRvpRsI1M7FnNEyyn4
         8D8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Q6gNTH/gN30ADjhJrxHpM4hJT2Id8gYMyrhv5buyNPMX05X1jbNnyTRXcHqQvs4n7tFrvSQilPYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0rAMyDzMTa/QF3UKAEWlR6/Ts12z+Bv/BNcDgKG+EFnRBIum
	8MsjVqX/f6eTgXaFarFDGMfkNRXdPqVvILD6jkfqxP/9b/b/0yG+dov/O5UBQTwX2bKs2rWsgiB
	nzi/BtMgN6QWNY5ROiOcdgwLzGPWzWs6thdJLQsBxRQ==
X-Gm-Gg: Acq92OGekj+556/TjxMKiieF4X7gL1fHrslkT8pFmd52BTQI6hyqh2Z0WXByvyLryqu
	KvwG7SBns+QS7jQw145qp9Mu/1tXDfcf+4PqoqxeUaAtJhmvmNlXoWCLjo2+JPj4MYqPtgfTwZq
	4iyns64frEO1PfHDNtaQBccgE7Vkacu6zdJmFUu0WVrOh0AS+tmrmEpqwsUmkvbSiCP5GiA/Opw
	E5tp68PgrNE9DKevgvXNX3UF1+su/zk6LMOl2ZIwyy9baLkGm7iVlwzM+AyQ+9N5K/lmyYwkauR
	MHhjXw==
X-Received: by 2002:a05:690c:6510:b0:7d0:6660:1608 with SMTP id
 00721157ae682-7d0666025ffmr55848987b3.34.1779295865479; Wed, 20 May 2026
 09:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519212602.30541-1-m32285159@gmail.com> <20260520122229.15326-1-sozdayvek@gmail.com>
In-Reply-To: <20260520122229.15326-1-sozdayvek@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 20 May 2026 11:49:33 -0500
X-Gm-Features: AVHnY4KSvzimm5epreAoU_b1KNZC3eJ_z6SJdnuuLIeErUkKrfjqyr1I834bieg
Message-ID: <CAKqfh0G43HY9Mt5WW=0evk4Rveh_4hqkMdragdZcd+cQBNGr2g@mail.gmail.com>
Subject: Re: [PATCH v4] iio: chemical: sps30: Replace manual locking with RAII locking
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, tomasz.duszynski@octakon.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 7:22=E2=80=AFAM Stepan Ionichev <sozdayvek@gmail.co=
m> wrote:
>
> The hunk in sps30_read_raw() adds an empty line before "default:" in
> the switch, which is unrelated to the RAII conversion and probably
> worth dropping.
>

First one is a stray change, my bad.


> Also, moving guard(mutex) into sps30_do_meas() changes its contract:
> previously callers had to hold state->lock around the call, now the
> function takes it itself. A line in the commit log would help future
> readers avoid the obvious "I'll just wrap it in mutex_lock()" pitfall.
>
> Stepan

See:
>> Add guard(mutex)() into sps30_do_meas() as every caller locks it's call.

Basic but still denotes that sps30_do_meas() holds the lock.

best regards,
max
