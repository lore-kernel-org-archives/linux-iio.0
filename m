Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B253DA7D4
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266405; cv=pass; b=Jie3M011UPJ8qnbzpgrH3CNOJZPEYKlM5ikPoEsbcOefigd5CFdH0GeotLUiT4XkoWUdyoV42DfAhtJC7qsh1hTEXqy8FbtCKD4dSpNXprVeG2kcvh1PLyDI+4Nom4U6minKyRJ0LrdpcJ3HTEciMyaYq9BjeZgke4Nu13eERDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266405; c=relaxed/simple;
	bh=vwKbiyHlwGwbovjlmx3b/YRsCDUYzrm+ibkGPEQXGFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaBr402HI9CAA3zuRd4iWOgetqBA7s6CN7cqyPNozH3K+KVcITTwYQebaoh1O460lviT+r4yUoK16cRSDNGGWD31RIin68u5p5VYpbgU3DiU5bUs2D2EwRam9/CxN0YJQshhd+0wjYa3h2mrS63dSl0KbEkvH1klFcZOP4oIpFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGj6OhR8; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGj6OhR8"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c52bb5dd7so2366260d50.2
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 11:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778266403; cv=none;
        d=google.com; s=arc-20240605;
        b=EkXc7gdMVTN4dK59gwSerNLj9Zvst0r0USRm5SKGklOmGSOAaiWXfbFEOPnNrnoDZm
         UwVkF4Yrpp/fFnhfs3qWVUuLxNqFWzfzQ2R9JbsfiMPkA5r//5TvI9dhhxI9FjX90tpS
         GccEmqhJ+icah8SjGaTDEhQ8Iz2K6Ig9axveA5PSysfR+72Jn96xd8knYy5VXTWfDazz
         /JFPlB7KBHgrfsXAB4zDLLxH/ermG+trTffAatRS1tCMsm3QcGxXFxtTJUv2fGrWHk9Z
         7501O/5bjfMIv0H5zo53lSEW9fC20atO3RRNUJQ43i34OMg5HKvQlpQpSvzkpcDkU0ji
         lcrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vwKbiyHlwGwbovjlmx3b/YRsCDUYzrm+ibkGPEQXGFE=;
        fh=wotmHINMN9/WyeV3oFXWmvesIBFtyya8mfgOMX+Ehrs=;
        b=fdC5MVgpS3wI1TSeo/LNHHd1jFNLzDUKxed58mW711ALs2l/i5UqBACXGSIIEobqeE
         lTVU4yODHQcx63Gq0CaU6Kc1qvKWyNTxOpfNhI/aQjmzYbF+ETAv1Xm+uFNZAGnAPD8X
         ecX4AD9ZL39yQAtMsP+hO4KKnJkbcCO1oMmw1MKYmLJy6IJ1mCxLv16EGgTgk2zXR+iz
         kg8KSqBREUSB4vHBPvThs5ZYF7+/rjftkFdoxpfPj1vJC6jimO1X7PcftDcpqh3sZDWJ
         K1kZF9RO0xEat3GXNLRD8V4Wjz59acOphFEF0mfioGlVn+gJQwUf9yJlE04b6S688eA9
         2wpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778266403; x=1778871203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwKbiyHlwGwbovjlmx3b/YRsCDUYzrm+ibkGPEQXGFE=;
        b=AGj6OhR8UXw9q3ftfyKWc9yAPDhEukJxlzAsTxuxk54pvKmpS71l3wKtJjXEvJY4KI
         Tbxb3uCnlPpfgDylP0n+QG9VZZavrWKhfWbK0Uo3dT1+4xlgqUxYI41YPTSfTmxjGPF2
         RIu4NOAK/i1weI1d/96XwS2+9ZfP66zHvl3mY5l1qNmKxAhvOH1Vh0M9EeRF2WKbLNwc
         84vCQYiBEczaZ0sw1X29vE99rBEHahZMtzIp2z/T/0nhQQUQh6Zws4oznDTgDDgh7gqk
         oMQ1OyULxAc6pQXD4vYFodqJrTJAlgV9WL6tcJpMbTzA5hlL9uNP+FDUDSbNMxc+SRre
         V0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266403; x=1778871203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vwKbiyHlwGwbovjlmx3b/YRsCDUYzrm+ibkGPEQXGFE=;
        b=Z4mIdtyewuLOKDJ7jySo2GM9uGR57Qid9opcrm62B+M/bkJ5kY+6xi6ikEEN9hX7Ib
         7hOtzpQEa1uULcRNAz2+JvSTV3nu+CEFhqtsYcP6g/KL80hIYmhmAxJ3vkeLX3ifkvLP
         3XLqCpjF3GL4zumbxglSd1U+81IUAUWvIuv48CpSJU/a/1gpv8E9D33Z2Xbt4gVzDZUT
         0AjehontzI/L1Puyq1G7KJfVrnlBwos+2uJ44Eh7TkbW4iiF8aHRnLW+1m2PcEhCUM8e
         9bEzWt5GvsgTfo/0oR7wwf+hQgwih2XMGU9wYWUFlLL8vZvaJVLU6Z8ryVPqe0sZBtba
         oDDg==
X-Forwarded-Encrypted: i=1; AFNElJ9KZoAFc7e7IW0y7a/UGB/xrsNm9YaO/UBWHZug1gWZGTnrjjzHsnNrDm8MLFrE7wJ5zeT62gVbBWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUXQKClk2U9e+pFpEepVFp6ei7RwHRz98HSMSCDFIdCrEoDnVj
	t7sf6Nl9KUxoQIWBD4LYCiexB6rw0kIRiLoqzNPu+qfJ5+ItcYxaMCYAncrXRhicbWmwNnJsYf+
	56zdZTUR18DpFar2LD5rkeWQRRSicsUV/ymTuupo=
X-Gm-Gg: Acq92OGORVROBQUV1NYiH/OhuTsvUdog6YCL6xDE3BbW+P14NN2a2GMq9VnppmfZ5wX
	xvrBcvgfH27gSrs0nsWKdAkcBlxkeCkW8ozR9tyfqbu+mned+ttRNCikpZIuMdn4AVTYDwmeY+D
	QlTRlhILIqiy9rv8ucIaHaXfnCVXxbrI+KFdLc2J5U9CMQwlIPuJNw4DwNXeocS+k5YFRFjUvYo
	rr/Wx0Rgo6PZcuRFsAksF/7K3XhfYWCRCyLvACV2y5hjsg7hDl4ams7vGzgxpjd1Ntnzgna+Kcf
	dgGLq/nm/g==
X-Received: by 2002:a53:c7cc:0:b0:65c:6897:26e4 with SMTP id
 956f58d0204a3-65c799defd8mr10248971d50.56.1778266403159; Fri, 08 May 2026
 11:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508124513.17752-1-m32285159@gmail.com> <F98D1BE6-7B28-4A36-A372-2431EA151E1E@gmail.com>
In-Reply-To: <F98D1BE6-7B28-4A36-A372-2431EA151E1E@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 8 May 2026 13:53:11 -0500
X-Gm-Features: AVHnY4I1DIa3PLbL-302Uohv4QH5c75pDs0f5bfSZhMVGMyA6hyHYjDxMjEv8J0
Message-ID: <CAKqfh0Hmchpq5zvK6Fd=VCqWXN+1FKyWxNyF1O=3zsVEM7HJUw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: xilinx-ams: Replace spin_lock() and unlock()
 calls with guard(spinlock*)()
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: salih.erim@amd.com, conall.ogriofa@amd.com, jic23@kernel.org, 
	michal.simek@amd.com, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 1:50=E2=80=AFPM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
>
> Hi Maxwell,
>
> Thanks for the resource cleanup change.
>
> Overall looks good.
>
> Also, there is opportunity for guard(mutex)().
>

Thanks, of course I'd also be happy to do the transition to
guard(mutex)() but it seems like something for tomorrow evening since
I've already submitted a lot to the mailing list.

best regards,
max




>
> Thanks,
> Sanjay Chitroda
>
>
