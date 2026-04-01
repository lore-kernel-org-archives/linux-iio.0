Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366035DA43
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013605; cv=none; b=ouUyw48YY9vHQhTTXvh6ZEUusK3oI0HARLGpWGD6RuFeyTrPaR1rZOxT16o2dsD2zLfloF9oA9coWxsNTmRwJ+AndWs8lkMKkqOQILq1sOrSynIlc9OBVoKAPSZ5tju/iuy97ac+M8RqWQr8gP1vpdEilv2wmKAY7feR15n9MJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013605; c=relaxed/simple;
	bh=HGiDfapAhtuXluq1IFgXS0Dok2/LIuXf/4U3bjhLJbs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PQ/houCIsXxxEL+NrZDx2n74wdUJ03x95K5WwmotSFOqBPlgETFJ2iqiwmL3ywNLdyAX05jwX6HjnWk6AIfTCwFWtaPJG1AmwLyBwjOT5EJtpVAWoNMvvNc3igoQyQPZOSM8gW7g491vvfR90b+zKRFuc+fT8FmwkflWDu2vmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcsSRuPv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcsSRuPv"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b23f90f53aso39995455ad.0
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 20:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775013604; x=1775618404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=17IIdQbaWiCM4KvJxXBpWnaDw4MMr/Naj3oOivwpD20=;
        b=dcsSRuPvjY65nQyJCb6/BtA7MeVL4c9tdBHmy/gnrAYET+MYPGu3Zyy+9JlZU91lsC
         TpGmPVDo3aQPPv3oeN63K2wxQTYPg/AywrYtsOMnX4/1uY+XkibOM61ADpkpbk8foyPi
         1W+chCDwd+vzoBKKlYncVTAEiGfX8L5iW2Ekf3E63oz9x2VZYXz6NCxU0+gAG1wvmfsS
         ScWqw8awMefrzCKWF5yZCuxY5oJNYoozQrO6/oc/EINws4Iz8257xTuCYh3YlhykvNHf
         ZgWYZnOf2HdQ7lxrymsvv3hjujXBfP7/K0ncLTyPPof6RU/Pr967Re8l4x7M/ZVjF3ox
         LDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775013604; x=1775618404;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17IIdQbaWiCM4KvJxXBpWnaDw4MMr/Naj3oOivwpD20=;
        b=OSzefW6MI38NsVDmnTCUv7MRpfVr56pCtZl3hmxni31mBJtFSsQ0O+u7YxODK1hSLe
         gvBWCBZ0hVLyBwXNMTiYwbif4B7KK8X8CKETKyhIPAWkrBWfvQJbj/OucFk5SF5O84JX
         xLyOscvvaLEXU/lu1u815GZ/cSmW4xmUWtNao42f/wsva9yqQAbfXFlV20lv+6KtPG9l
         JLfVjprbJzqJjjlSkufQJNZY9DnXKld09jKc3A3lisVsK5iqlqI5lNLoebzU0l4dSWm9
         u9sfSL0T9KaXkOxFrmTasrdGc8JdPULzUKPyKJ0dBjGBZdU5dgMzJ6cWqDg1cu6FCBfx
         0J/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHW4OK3IX+HH3hJRcRXrpnyoh13QYs0h1mCyJyoI0ag2Lt5CuUe01TkkyCLRCPLdHc4kAgkIfu5uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuviYjbOoLKHGPhJf9MXoQgA6Zjk/a8g2/59eB1XAgEw705IPp
	JaxDu0jlg8KDJ1IUOoGZFEFF+6vBNsCfzeYNA+m53PuMXWtlmiExNcAu
X-Gm-Gg: ATEYQzyGscloSMAG8UrSiRZ9CEkF9vqEMqEb/gwWE9wyzOlWT3zwRlXDwjA99IGkJBt
	NtPKG//JdpZobiQZJRRkVKQZqEInGXIhTaNBntTy8Z6T6ImMskLZCV4EFYZbVc3S5F724NqN5e6
	j8sq3fVlwS5uiXmfUFbn4TNGl5bDTTz3TEylv4O46EpiMlJ4MtuwF3XiVGm3xFlHCBtiZT9WABz
	D37QqCYz5QxSc4L781XbYooNXpmUajZMpuayu2miitK/okeJe5wObsZLH6z39aPwzIjthLzNESW
	uYHEepjtC/H+UY7NinLpApSPuzmSgTxEn4UgwSYIt6wQeaDmP5GVHkreqb3ebHo7zdJ6J+HoRrL
	r84NbSzubXksw1ad00tJjyZyG7cyy0r/jZk6QLIrhYNC1BQiNBNuaVGTZKmqdCMsGYTliFiNwGs
	j1Uo8EE7Vu8RGa5d2VVMO0zcho2sm3zA/fnEk8Qo/4u7zg2w==
X-Received: by 2002:a17:903:1b6d:b0:2b0:bebb:1081 with SMTP id d9443c01a7336-2b269cffdfamr15228455ad.28.1775013603888;
        Tue, 31 Mar 2026 20:20:03 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:c01b:b139:b0d:529c:e26d:b48d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24ddc0afbsm128280835ad.64.2026.03.31.20.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 20:20:03 -0700 (PDT)
Date: Wed, 01 Apr 2026 08:49:58 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_3/4=5D_iio=3A_ssp=5Fsensors=3A_s?=
 =?US-ASCII?Q?sp=5Fspi=3A_use_guard=28=29_to_release_mutexes?=
User-Agent: Thunderbird for Android
In-Reply-To: <DE911B14-E6C9-4E90-8494-DB0501A9375A@gmail.com>
References: <20260326081815.925373-1-sanjayembedded@gmail.com> <20260326081815.925373-4-sanjayembedded@gmail.com> <acT6vokgYuUTsWcj@ashevche-desk.local> <4017E54C-B25B-41AC-B4E1-F28576C2D64C@gmail.com> <ackQpuBPZva28ZMd@ashevche-desk.local> <DE911B14-E6C9-4E90-8494-DB0501A9375A@gmail.com>
Message-ID: <9403348A-7EC9-45E5-B4AF-9ED29CA7B634@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 30 March 2026 9:47:52=E2=80=AFpm IST, Sanjay Chitroda <sanjayembeddedse=
@gmail=2Ecom> wrote:
>
>
>On 29 March 2026 5:14:38=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevch=
enko@intel=2Ecom> wrote:
>>On Sat, Mar 28, 2026 at 12:24:11PM +0530, Sanjay Chitroda wrote:
>>> On 26 March 2026 2:52:06=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshe=
vchenko@intel=2Ecom> wrote:
>>> >On Thu, Mar 26, 2026 at 01:48:14PM +0530, Sanjay Chitroda wrote:
>>
>>> >> Replace explicit mutex_lock() and mutex_unlock() with the guard() m=
acro
>>> >> for cleaner and safer mutex handling=2E
>>> >
>>> >NAK=2E Please, be very careful when do such changes=2E
>>
>>=2E=2E=2E
>>
>>> >> -	mutex_unlock(&data->comm_lock);
>>> >> -
>>> >
>>> >Pzzz! See what you are doing here=2E=2E=2E
>>>=20
>>> Thank Andy for pointing this out =E2=80=94 you=E2=80=99re right, using=
 "guard(mutex)" here
>>> unintentionally extends the lifetime of "comm_lock" and can hold it ac=
ross
>>> the completion wait, which is not safe=2E
>>>=20
>>> I=E2=80=99ve reworked the change to keep the original locking semantic=
s intact:
>>>=20
>>> - "comm_lock" is still explicitly unlocked before "wait_for_completion=
_timeout()"
>>> - No sleeping paths are executed while holding "comm_lock"
>>> - Introduced small helpers to simplify the flow:
>>>   - "ssp_send_and_enqueue()" for SPI write + pending list add
>>>   - "ssp_dequeue_msg()" for safe removal from the pending list
>>>=20
>>> Updated flow looks like this:
>>
>>If you are going to mix mutex_lock() with guard()(), it's even more NAKi=
sh
>>solution (id est worse than no change)=2E
>>
>
>Thanks =E2=80=94 agreed on not mixing "mutex_lock()"/"mutex_unlock()" wit=
h "guard()"=2E
>
>This patch is intended as a cleanup to switch to "guard()", not to change=
 locking semantics=2E
>
>I=E2=80=99ll rework this so that it=E2=80=99s a consistent conversion:
>
>- convert it fully to "guard()" without changing the lock scope (e=2Eg=2E=
, by restructuring the critical section appropriately or limiting scope wit=
h {} )=2E
>
>Will update the patch accordingly=2E
>

Following up on my previous reply =E2=80=94 after reconsidering, I=E2=80=
=99ll drop the guard-based conversion to keep the locking style consistent =
with the existing code=2E

Instead, I=E2=80=99ll keep the explicit mutex usage and, if needed, simpli=
fy the repeated pending_list handling via small helper functions without ch=
anging any locking semantics=2E

I=E2=80=99ll send a revised version accordingly=2E

>
>>> This keeps the synchronization boundary unchanged while reducing dupli=
cation
>>> around pending list handling=2E I=E2=80=99ve also limited "guard()" us=
age to short,
>>> local critical sections only=2E
>>>=20
>>> Please let me know if you=E2=80=99d prefer keeping the list operations=
 inline instead
>>> of helpers=2E
>>
