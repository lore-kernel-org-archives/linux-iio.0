Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523A37700F
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774887478; cv=none; b=mPmTA48GfVBRlsLZTQOMz1xipo7l0Kh2/fdzorUX+yzpISP0/yebl385y8ktE77sg9coxyKSiHv245Lcj0694EbrlPBAUl9HUnNa+LUn+OEPH/cw0nMCPyypDW/ScUmTaD8z215REiJZqAb+yUbiANx//MwGSlWypGNEFLnUKqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774887478; c=relaxed/simple;
	bh=55Fpi3YNRzveKBEZXjkbJEpoQx1wD5kZYI8GBMZimyM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=m6xhqiAmmtFSMcfKGlMoydw3x+7aDxE9JUG/wm5b1K8xQ3LzcKY3uN+g9VafpVr2jVSPEY8vXiyGg813tSYGlZC36FYeUt2s/ZLyjlr9VjH1JbsvIxHu7RcBNN+HsNaPRA83ZF7LnsL13FcUGMzZC7OX48aY9hyRDsFq/3vYqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfgyTz8L; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfgyTz8L"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76864f4e58so1345598a12.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 09:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774887477; x=1775492277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MjSk1KnGXpIUBj4+4g/qAzrW90+WoFTFqElwxB+FxB4=;
        b=LfgyTz8LnGHu9MYI77A+dA4YC0SSaQ6dhOUWIe+tfQY13Te4WTiHeyuwQhgEUmd9x+
         ZTU+k9svLBAPEGZy3yrCBdTcQQAEEJiPtiOlxoFKGNceDzEftf/tLerxfZDMl+G532nq
         94b+vdLLu0zTi5JJTEJk0+kkYJWxMISBAH+eLCqMUPDFtTv8Wk3f9Mui+y9cOIotxHCB
         CBlQWoqDelAgnHTh/9f5qJC+VLbC1+qKfw9ZbsQw0dKR4/YE6dnRvt7vhYxBEaLDBvYn
         oPdcZvyfb7mRhKaRFwELyOy3TJfZTOLgYhXao2dFVgYDcZIDS0O7M8IA6/WTq79t8af9
         Yg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774887477; x=1775492277;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjSk1KnGXpIUBj4+4g/qAzrW90+WoFTFqElwxB+FxB4=;
        b=iHlvi7C0qovpv3ebPem7ATsJ5x5HH4bhqXJv0Q8N5Puxg9Wczi2YkIgY6pOleA3GA2
         EFRdbLJ/nunPstSp4IUvd0tH1uobQGZ7ZU5a0hhnPnFnX5qc6obCVnJI5KXMQp1x8+cs
         x9Xo6PV0baxhwQ4lsVkeMb+oqC1xQYvEt/VUQ/qv/uj6M0znbX/fClFExxHI4UG4gr4Z
         FCD04h2ioDM6O0ycU1L8IEDQ8lBIZR+nik59u2gQhAhWMb5nMTX6wwQjwv8TkdottScA
         hUAAad8lw+9YIq0bUYuMm3OisHxfFwn9W3KpLQrRWIWGSHIFO9fHcNpC26OStO5h3S1G
         t2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0p7Ti6Ia1VCigwWrER+Y9hJi1A2Aj/wxMtixGX3pD11nLow6Cj/FchINT3RyBudep2078A8QTems=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjb1KnNJ3lX9SiXBt+pIQApgG44foYf/KhgStmRBDYAJX3pCw
	PwlrL8NXM8vkWjudSexdWo8Zd10tSI8jG92/cCYDVlzGLpkfEpkTq+G6
X-Gm-Gg: ATEYQzw+mfFuixYm3R/nDYgBCYU6DzJ7Jl7jTNdaKzpKgVlRsz6VV8zV8DcCna37+X0
	BffmMmdpQ9dW4t/Psv8fimTi53oGVozC6u5NHRjgiUYHAerAdOGFOkf3PZq4+9A8wWe5OaAwAVL
	BLXlKjQLu3IN9/BUGEUOLjgByeFOzeE/IbeuXoN8lMxnzrLryPllfSxdCEX5C8w9GO/KoFcpgZM
	GrnI42Q2A09IeE5h6UW1UNSvdLw1TYMq+XpKJGPoWtgzaZZB4lDO3Tlxvl4R4thHg7/28Bt5yuH
	7xTNTMTj5I1oYN2p/WUSiNnfsZgCKhOYaXFRxFnNVFo/a7TJuP1uMQ4rrk9qNa3OeZTOmsZBZhI
	OPk2ylYEOVPeDXrghBC1GSTurvkn1k2n1GtYsnyV9wRvLTweW3bg6m96rUcH5YoXFAc6fzuGUYT
	XK9HEcqeLW8kLfkTlvNRvW4chWkNKlWEgS94Y=
X-Received: by 2002:a05:6a20:a126:b0:39c:c07:144a with SMTP id adf61e73a8af0-39c87a3c3a9mr13271334637.36.1774887476689;
        Mon, 30 Mar 2026 09:17:56 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ab01:67b0::55cf:3611])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca843bd8bsm7694484b3a.10.2026.03.30.09.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 09:17:56 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:47:52 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_3/4=5D_iio=3A_ssp=5Fsensors=3A_s?=
 =?US-ASCII?Q?sp=5Fspi=3A_use_guard=28=29_to_release_mutexes?=
User-Agent: Thunderbird for Android
In-Reply-To: <ackQpuBPZva28ZMd@ashevche-desk.local>
References: <20260326081815.925373-1-sanjayembedded@gmail.com> <20260326081815.925373-4-sanjayembedded@gmail.com> <acT6vokgYuUTsWcj@ashevche-desk.local> <4017E54C-B25B-41AC-B4E1-F28576C2D64C@gmail.com> <ackQpuBPZva28ZMd@ashevche-desk.local>
Message-ID: <DE911B14-E6C9-4E90-8494-DB0501A9375A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29 March 2026 5:14:38=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Sat, Mar 28, 2026 at 12:24:11PM +0530, Sanjay Chitroda wrote:
>> On 26 March 2026 2:52:06=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshev=
chenko@intel=2Ecom> wrote:
>> >On Thu, Mar 26, 2026 at 01:48:14PM +0530, Sanjay Chitroda wrote:
>
>> >> Replace explicit mutex_lock() and mutex_unlock() with the guard() ma=
cro
>> >> for cleaner and safer mutex handling=2E
>> >
>> >NAK=2E Please, be very careful when do such changes=2E
>
>=2E=2E=2E
>
>> >> -	mutex_unlock(&data->comm_lock);
>> >> -
>> >
>> >Pzzz! See what you are doing here=2E=2E=2E
>>=20
>> Thank Andy for pointing this out =E2=80=94 you=E2=80=99re right, using =
"guard(mutex)" here
>> unintentionally extends the lifetime of "comm_lock" and can hold it acr=
oss
>> the completion wait, which is not safe=2E
>>=20
>> I=E2=80=99ve reworked the change to keep the original locking semantics=
 intact:
>>=20
>> - "comm_lock" is still explicitly unlocked before "wait_for_completion_=
timeout()"
>> - No sleeping paths are executed while holding "comm_lock"
>> - Introduced small helpers to simplify the flow:
>>   - "ssp_send_and_enqueue()" for SPI write + pending list add
>>   - "ssp_dequeue_msg()" for safe removal from the pending list
>>=20
>> Updated flow looks like this:
>
>If you are going to mix mutex_lock() with guard()(), it's even more NAKis=
h
>solution (id est worse than no change)=2E
>

Thanks =E2=80=94 agreed on not mixing "mutex_lock()"/"mutex_unlock()" with=
 "guard()"=2E

This patch is intended as a cleanup to switch to "guard()", not to change =
locking semantics=2E

I=E2=80=99ll rework this so that it=E2=80=99s a consistent conversion:

- convert it fully to "guard()" without changing the lock scope (e=2Eg=2E,=
 by restructuring the critical section appropriately or limiting scope with=
 {} )=2E

Will update the patch accordingly=2E


>> This keeps the synchronization boundary unchanged while reducing duplic=
ation
>> around pending list handling=2E I=E2=80=99ve also limited "guard()" usa=
ge to short,
>> local critical sections only=2E
>>=20
>> Please let me know if you=E2=80=99d prefer keeping the list operations =
inline instead
>> of helpers=2E
>
