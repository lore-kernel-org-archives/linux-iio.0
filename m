Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FFC34FF49
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 03:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774494818; cv=none; b=HUFgYEFie8eDmfhdS3DS0vABo8PEhFEBivdIrQoHUy71Y1cz2k9Sf/f+mXebIkurDkZXe7u7HNeIGQ7mgla/kvm6ja4NzKhQTcI37nyFxCFA+a0KD6/aYsIdMvW7Ojwct/w+Fge+S/apBGiRSYPfIgW6IzG0BNWdCKbvK6UGNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774494818; c=relaxed/simple;
	bh=KNd5H0HW2yYn97l4s3SshAZFIpQFZEGzyxj8f7S9idA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bI2pBnSVR0KS/GgusenMhLNjY1NoL9dVDiVCOznrpczT/fAMAUaARma5gFpcA9i0Lv4kA2B4p8Tdi0lp4HyZnb71V1SqCe3CDKhKHgL8K9eorutiagpN9kn9fovONWYOFbU2PWTIvdMDJfVHMjadPZx74yZFhKjM0fxzxDFfvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pc9NjPOy; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pc9NjPOy"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so185241a12.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 20:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774494817; x=1775099617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vo46AZnsszZKsdkfKV5WDFNiWI2N10p9McsEgKt+fnI=;
        b=pc9NjPOy20JvTjBGHm/sgbBet0d+Mt4ZECO+p76Ki1H2rgI+QUmt0BTvLmSfK3mjvo
         wU6b+EjWRnm5HYKol/HUC+jXYolsEDqZnETRQXydHqwjJ3JHqxDT2etJfcyQ9qY7GmeJ
         vL8UsY5DgHqkiQ9P6vRR++24nIDvcCY54H/fDCYlNIdjUlRsEsEMKq5ifGHgII0lNzvt
         5ARl+rHtmwpWMHu3scQyqTw94RoUmuOrpiThJWAmA5O7i9/ewbONskUsr5+27BnsrvIw
         LF6POF2euDUVqDPV/HT97DB5C/ooXlFdur7FQSQ3aK1lQftUEQGCuBuf4GpGvD7rS2mI
         oZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774494817; x=1775099617;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vo46AZnsszZKsdkfKV5WDFNiWI2N10p9McsEgKt+fnI=;
        b=ToqkNRK4dYmYirUhRO19URtWOtamFYzvHcb/7vt+g0558+qjF3jvlqSzsy1ye6qSbg
         qZfcPmrMZ8GAty9b/vpkNZ3YtwIAuF5BwPkop/A3KtVH5K/j4R7E8NIV0KxH9JKSac4l
         waWRH7KqoVJ6KYAGp4vm7LQqgIZ0ZpihUzs791RR4f2jhL/cYFcbWkGC0tvJS5+0N+P/
         IUE3Vc7YR+ohZVnisRlXyucTJKub/6ZL768wYQJaxkeU18n1UOkttVHD7NypiReX7iS3
         8rP7wEL5n4bzJvm1wMKjpOtQcQW78w2FElyGmNFrYiOhu3cm01U2efeFmKaahZPnTALY
         /Lyw==
X-Forwarded-Encrypted: i=1; AJvYcCV9XH6PRenv/KGUXPhUjKMVdAvQXM59E7qM8M3ILDJs071ZREFhaZ+0g78hfWaXAxcyvN15eWIplmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPqsjwlwU8PnsQVoFY+SLisEEbMviJfOTBX/vL9fHxF54f2HXU
	16LIuNqxqX6L/BVXh/ml1j0ZrDsmWZeAFKoNEnrgAyl7beolvvIRpjrG4JCyvg==
X-Gm-Gg: ATEYQzw2qOjxygHoXU34a/XN9gLtntkydNNdOhSxENUg3qQVbv7X6efHyIIGN3NLyaa
	YTW0wmHx1wXpx2FZ8cDvxQ8TCFzeMtz4mGBLV6rxCiEs7ZD2vNpxhtLCkPZLWr5Q5h2x2PscTbq
	DGpLn/ZO+YjH74sbqWvSv/c9qdeAywbvrAR8WyO2d+BXAAjOEOEtWLWPZiHxeG47ZZjlV7tyT2f
	OeWV6Z8a8Do/HR2J8wvhGIPLK8Qmwg5O3iOLgBW4xyPntIUiHnF1tES4LJ86UUMwOqA1mmryqbb
	FGi1EGm1GZJ8gQ6PUf0jbtECUWRMEcFreghAwAxwQKGZGxlFfn5NT8o5rgpwfMcJEdmjzqEjd9G
	dOQGWMsa26wvmTLi1geXmP0fmaDBSCk00r110k4fbSyevaOxh008f9WvRR2x31iynaztPc30WNY
	BuqWBSvsvNmyLKBD09CsYJjCH1JU25WTaq0z3DCP0STj1H
X-Received: by 2002:a17:902:e884:b0:2b0:6e4a:32d0 with SMTP id d9443c01a7336-2b0b0ab445dmr65515915ad.35.1774494816917;
        Wed, 25 Mar 2026 20:13:36 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ae31:5c:95dd:edfd:e524:5a9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc79c471sm13733555ad.22.2026.03.25.20.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 20:13:36 -0700 (PDT)
Date: Thu, 26 Mar 2026 08:43:26 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/3=5D_iio=3A_ssp=5Fsensors=3A_s?=
 =?US-ASCII?Q?sp=5Fspi=3A_use_guard=28=29_to_release_mutexes?=
User-Agent: Thunderbird for Android
In-Reply-To: <abgUaXpJOveAtAWF@ashevche-desk.local>
References: <20260315125509.857195-1-sanjayembedded@gmail.com> <20260315125509.857195-2-sanjayembedded@gmail.com> <abgUaXpJOveAtAWF@ashevche-desk.local>
Message-ID: <F181DFF2-DB16-4771-A0C4-30FD089D7FC7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 16 March 2026 8:02:09=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Sun, Mar 15, 2026 at 06:25:07PM +0530, Sanjay Chitroda wrote:
>
>> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
>> for cleaner and safer mutex handling=2E
>
>TBH I don't see much benefit in this form=2E What I am thinking of is to =
refactor
>to have the guard and timeout_cnt++ in the top level, and
>
>static void =2E=2E=2E(flag)
>{
>	if (flag)
>		return;
>
>	guard(mutex)(&data->pending_lock);
>	list_add_tail(&msg->list, &data->pending_list);
>}
>
>helper for three (*yes, 3) repetitive code snippets=2E
>

Thank you Andy for the review=2E

I understand your point about refactoring if pattern is repeated to simply=
 things=2E

Also, while revisiting the changes, I noticed that unintended mistake wher=
e list_del() was replaced with list_add_tail() in couple of place during gu=
ard() conversion=2E I'll fix that in v4 along with suggestions and input fr=
om you and Jonathan=2E

I=E2=80=99ll send an updated version shortly=2E
