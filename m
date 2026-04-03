Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E063090C5
	for <linux-iio@vger.kernel.org>; Fri,  3 Apr 2026 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237480; cv=pass; b=BMNEgHKBZPRpZ09Ye+5nr5TtKSCCPdPHKeSB7fLOazD8Bo7MFgXB0PglA6VkVE6xMOtpsS1hXOF9f46+Sb7jD9hrhbIUfPskBWOcHnuBmMggsDhZzr3mQWzEexwZWZxqX4O5mNYsM+X5eCDBuzr2R1zyAXJaH1ZzrLeMDdtE1hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237480; c=relaxed/simple;
	bh=A1TThcqxkmPRTc4liPUJFeM2RDiMHK5vI8dYvpyttFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qElxEtrrJNQ6Xofi8tocS8vQHLoqWJknnk2k10DsYRsVGDg7A2xigLUnnDHrcOrw9BND5E5MQqE4eqSHSfmfzR3P4lYXVXvSWPC6Bz2Rz/Qg64TaEgjeZ+GjAtZ4SMl4YsxnYHPINL2MlHnGTMwvkYxQVEJU3lTGJXhuMiCelTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3J5uPYJ; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3J5uPYJ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35c2fe0d90fso1237200a91.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Apr 2026 10:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775237479; cv=none;
        d=google.com; s=arc-20240605;
        b=JCGCJZq1C+oIwEF0bd2SEjddkboBYfao6uaUJjyHDxDqyEC2s3JVAIgNcR/p2uR/oG
         ByxI5rM0CC1jsJkXh6RR6uBzSzOke5Qf34LPOlM4DV7Z+l4yilk0utNG1mnthJxiR9xV
         V7wFNZnXxQmjS8YJRmc6AoAVumfI8sYyH3bCLcGBibF4fgGpJBge71sRAqK312TLzWok
         kfL/K8mJvNlXon29VzFyO4OctmhPulZTuKLtq3M6eJXf2wqE6W3PtgozcYmOYkXluSf8
         Lm5gsK+DFzX0YcN9Ei6pyVs9OzbluuMvopuidgzvgMDrT9gFZ1RKWPrbQ1gbJJOdeH0k
         yLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A1TThcqxkmPRTc4liPUJFeM2RDiMHK5vI8dYvpyttFs=;
        fh=tWX0WBzoRNrKpswXLskp1/scJZUbGkLV+LeUW2aVgOU=;
        b=bUlxQJq4uGagNIAwptt913sC6dUQs0HZLst5uWkN3/Shecwlkm+z3YhpyQ4tKa9IJN
         /H+MvipI65UmL0Q7IUS2sBLfF+HdBLMBGPQBfCjDSR/Ur/l92sTEBqE6xueKzRA3x5/J
         JWa9+wenOW+aBXMzzHarZgnob12OgDflQ4VQerM5KNc+oDQ2VvWSoPT9eox9rG46EZ2t
         VW1wsKAM10xmc9zzzgGS6l0HIrLuHlKrMldrLw8Q830qRulvS3YaMpSMYGeRIPh6iRu1
         6r4mkfhrj32pPG2CG5UBekmIHWviXNE84W+LNP1PVJ6Os4vxgfa4+rH4KENzfD8LWrDZ
         AnKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775237479; x=1775842279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1TThcqxkmPRTc4liPUJFeM2RDiMHK5vI8dYvpyttFs=;
        b=C3J5uPYJmJawMmS6sg7uvvgM41FC1lNsbFGRX++lI8QUwCsgUtCWmkmhqt+pDbqZNR
         Y/BQ8oLqG7ml0xqm+u1ZNCqDQQ0MJI3WiSWx6Ugm8uRESBIUWvD3qQEVkq/SxLlAEIDs
         Nj0Sz+Pw2nlmJv6zmpSbKSfCCTRnKjWBdO9WfHz3h0xi0+Mv/7W7sxzBh3aGqCcqjuI0
         maRVJGSjxZU8zR+lqpWi3lGqNOZVCVA8Fun1cPr7P0QqSkB7uYId0ZCpErkNlMxxvkmj
         tDjaci0IPkXNfpN8BBdz+nxsNUhqAY6OXq1qI8lBWzg1r+dHB9JoLy2F3KDh9r/TFRiy
         6jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775237479; x=1775842279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A1TThcqxkmPRTc4liPUJFeM2RDiMHK5vI8dYvpyttFs=;
        b=Sw5Gwc7JafHqo3GYBXXLidVxNqANV2qvG2d22Wop9FGTTcWUy3yA5H4j7OxBdodsKq
         Dd3o1Ads8tFsJ6YGbQpn7c/ZBgA3ylsE9fIPHiO+sFUc44a2nRxHh7QSAAT5uXw6LXdI
         H8Xlgvj3muzpk4fHu+esvkBA0U6QmEDVuclXLuvqxH3SCAHsU4Aqs3ojkmLtZaJncbld
         SxwrZCHoT8vWVXPNuR3zQ1pcyQ3hcjYCiRjTBW+/uCThrgyln6Y/F+rlBwzQjkf3qWNT
         L2jyakIRPsUCvJpzstTpJmgZHquneuLzMaTBHBuQG9b/1AW0myVwugDoRJ85yVcEd5Yp
         b9yA==
X-Forwarded-Encrypted: i=1; AJvYcCWa4BtTy3Mg/76xFNwImpNKq7qtSGDk6GTWiOTPo/NmH+caYntSHFs3xKyzIY1cae5Bkfid0c+QfXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqsz5XN6ETdFq4IJoaCRLYcM1kmFWamnoMBVwGV95g7i7B7HdC
	EDrS2g725pDlRZ4C39P0zLCeiU75roi4yAAwVM3xxWkOSYs7FevHE7GArH4gAIyh9dCyF5HY5uY
	WW3X7u9Bo1g14izR5wZ3chXevmcOksU2DfpGc
X-Gm-Gg: AeBDieuhgiotVtvV3bR805AcAPeaJ7yEXyN8+xjnh1OoPq0XM02ejd8Z4Z5GBww1aRD
	pv8RovKZt3itKZ2x9uYcQq29prIdREW4W0ZT0llABACXONkJVrL3+FHzQkY1BQBFrNUoXWlZLpB
	jpHKyOv1uxqOkswdekyCVUfEPnkuNKwbeh7JgQ2aF8CxCRx6BmITa+nfkkK6fmE05hPkVfgMHeO
	yN95hGpVINIENGqVcIwgkaOkJc99jLVBHSvQFHdolhdujDlKiIS/6uixF536e1NU7u628TUX6wl
	xd/GMQ==
X-Received: by 2002:a17:90b:3c06:b0:35c:cba:3453 with SMTP id
 98e67ed59e1d1-35de695812bmr3439780a91.22.1775237478766; Fri, 03 Apr 2026
 10:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402054015.38565-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260402054015.38565-1-pengpeng@iscas.ac.cn>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sat, 4 Apr 2026 02:31:07 +0900
X-Gm-Features: AQROBzBq-G3K7Iu3SdUwQAauw-NXAjNW1cKYpe7UpnGAu1jlS1PY2GUWpTnAkOg
Message-ID: <CAKbEznuqCs+4VKgyup2N4T2xf_Mz10xNE344DhmwUnic2=ofkQ@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: mhz19b: reject oversized serial replies
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Apr 2, 2026 at 2:40=E2=80=AFPM Pengpeng Hou <pengpeng@iscas.ac.cn> =
wrote:
>
> mhz19b_receive_buf() appends each serdev chunk into the fixed
> MHZ19B_CMD_SIZE receive buffer and advances buf_idx by len without
> checking that the chunk fits in the remaining space. A large callback
> can therefore overflow st->buf before the command path validates the
> reply.
>
> Reset the reply state before each command and reject oversized serial
> replies before copying them into the fixed buffer. When an oversized
> reply is detected, wake the waiter and report -EMSGSIZE instead of
> overwriting st->buf.
>

Acked-by: Gyeyoung Baek <gye976@gmail.com>

--=20
Thanks,
Gyeyoung
