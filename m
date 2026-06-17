Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569E37BE93
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723102; cv=none; b=S2J3ePFw9OIi50KpQIpfowfgZLkB1yU+iYm2tLLR2LbIcsuzMzFrHqWPds+CaRxVwVdzQxhAiN88M/POOajsJwcnVEP0kDRNHjGbQfntI3/YICwpOL98p8Nng31myVLs+329Q2uihHdivCpwpv/l/fZkPomYD0/Htw9Wohb2vO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723102; c=relaxed/simple;
	bh=u+UvYY9UrxxjoueL+zkhTKOfBiuOgVDHJZSucBSfauU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HifxUyDDmXNmhXO237GullL6I8KSsu2XKwep8FEJSGL2eoymkNJoeV6Ws03EetQkWVYyL35L64+6Zd366cO9oXkI6zqmmr6AykZvc8CduUH0JuRTCbohmE9QqxyPK7motzR3Yb/+fpRjPg1/8xpoSo6odwXcY2YQ4AmPj6PgJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kN58Hflz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN58Hflz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c6b3f71648so2063495ad.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781723099; x=1782327899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WWb5EDD7Z8+iTmdCvkmtSJcYVuqqEa89gpURDIob5KI=;
        b=kN58HflzSk4liSYDXCwGuR0rcdjrHhNVrOeSg3hYJWgXpbxe8v/RbKjdOS9IclQ8gq
         2gTcPqrNAXXo6mP0icuMms/ZqaaQCN9EBT7F6xajDqK9ApSKWL1o7d0nwQlrVppIEAfq
         YV6bQH5yxgpQa5+FOf4yCZ1ZLsGvGGFyKPp9YFUHg53rleFLEmyhW95bxkBNDZlX1GKO
         UUoN4EcFcGhrh3HQqPgJy+cnwJtzSK8ZV89b4SxcKJZqP/PfLRKRMKEDpWP3A+QJdCUl
         HwgQAPvK5yvXFcAH7JmK8auj0/ZD2/R3qW0PEWm/KPZfg9QuRO6u4PX36AkyAAh6cTya
         SyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781723099; x=1782327899;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWb5EDD7Z8+iTmdCvkmtSJcYVuqqEa89gpURDIob5KI=;
        b=SJjrcuUMTDp+cICjodS1CZUkIJTy6rjBswjNVgnw0zhW9mahCnt/kZmi6/MSw/xDt1
         hYCaTphn/jmAjXBjuXQAQG0SptQkBh61/bbovYN3QVRufmsBu46xo8mZ36W7imQMzwto
         FFQDdTfryfvrOYxGC9sdnl4G0RvMdgxotnHe8XTXW2gvY0/NRbXqBtwo+rZrBbaEC7v1
         nqC1g+qZoXfne9gfiPeoF0Hz6ZaNrDPWVF6/a6xVz0buAMgj4PzuAHPnl9MP/8X76edW
         mH07fFHFEyvqsJlfY0M1HXmT9Rd6xpwd5+XbRcyj5lSD/yiCiVBRlhX6F/svYRfYQjLS
         OIUg==
X-Forwarded-Encrypted: i=1; AFNElJ8hMfL/AAMIhNiJSKo8GFN/5elZT6zXcie5QFvvdVeN7Ntpp4/r6F/QtZA7OEqr1SySQky4gJ4mQ6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQjQCOnfaumoUSS+fvOTe3PSeqeySd9QCD7i7Y+5oSn2OO4dIU
	9Dy5Zp3McoRedo+sjcvlSpKUZ0gTxUq4aom4h03aimzqzIoPQjaDe4DhRuJiIw==
X-Gm-Gg: AfdE7clXwiETyp2T7/MD1J+T5zmxrX3TaYABAS+XfnlVNkQ0dQOPfe49YCH2RbHhdPP
	UctPddYlrtcb78rteFyhvPixLJOUxc1K6QXyk00+yRURTTJB6rdFxhf6yG993EtF5uWL0GkMKwV
	fm90X13BizBbav0mgDokRb4/s0lYt57V9XGrgz5TaUexcrGKcockw2hJDs9pDJPYco4JPqelNQ2
	DtNjR1TOMFz8gEpGqyiFAsPUc3LdWkvVnfp7a6oIp/xL4W9LV8HhmY6ZfcrVjcJImovzIeDLrXq
	iqEPQCZI81x3wk09CjvO4zEClzPVGEWl63bKO7dLguNaSLCqPAX6tc7/8mydls95+L6FOvc07v2
	elm2mACNt8fk0qDmOKx4+QQloRbrg5pxAUk58fx5n9ksOvMI/+LMlJglXkeSiWtjDu5YA1NVyWs
	4HbuAfx7g+IezkbHtSrezVd9WgQpdOHm3kFJs=
X-Received: by 2002:a17:903:950:b0:2c6:b816:43ba with SMTP id d9443c01a7336-2c6bc21ee45mr52773185ad.21.1781723098901;
        Wed, 17 Jun 2026 12:04:58 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1f3f:6e5a:a26:1f1f:d75c:bc14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac80asm155502625ad.39.2026.06.17.12.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 12:04:56 -0700 (PDT)
Date: Thu, 18 Jun 2026 00:33:09 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Maxwell Doose <m32285159@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, Zhang Lixu <lixu.zhang@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_00/11=5D_HID=3A_iio=3A_warning_c?=
 =?US-ASCII?Q?lean_up_and_prefer_kernel_coding_style?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAKqfh0GEeyQ3UMuMupevgPfCon+zccAv302sV5YKCETWMua-xA@mail.gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com> <CAKqfh0GEeyQ3UMuMupevgPfCon+zccAv302sV5YKCETWMua-xA@mail.gmail.com>
Message-ID: <AB598E72-247E-46F8-910C-DB7E8AF42FB1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17 June 2026 1:00:37=E2=80=AFpm IST, Maxwell Doose <m32285159@gmail=2Ec=
om> wrote:
>On Tue, Jun 16, 2026 at 5:26=E2=80=AFAM Sanjay Chitroda
><sanjayembeddedse@gmail=2Ecom> wrote:
>>
>> Hi all,
>>
>> This series updates HID IIO drivers to resolve checkpatch and
>> kernel coding style issue=2E
>>
>> This improves readability and follow standard kernel coding style
>> No functional changes are introduced=2E
>>
>> Testing:
>>   - Compiled with W=3D1 for each patch in the series
>>
>> ---
>> Sanjay Chitroda (11):
>>       iio: hid-sensors: add missing blank line after declarations
>>       iio: humidity: hid-sensor-humidity: align parenthesis for readabi=
lity
>>       iio: gyro: hid-sensor-gyro-3d: align parenthesis for readability
>>       iio: magnetometer: hid-sensor-magn-3d: align parenthesis for read=
ability
>>       iio: humidity: hid-sensor-humidity: use common device for devres
>>       iio: position: hid-sensor-custom-intel-hinge: use common device f=
or devres
>>       iio: temperature: hid-sensor-temperature: use common device for d=
evres
>>       iio: hid-sensor-magn-3d: use ! instead of explicit NULL check
>>       iio: hid-sensor-rotation: use ! instead of explicit NULL check
>>       iio: hid-sensor-incl-3d: use ! instead of explicit NULL check
>>       iio: hid-sensor-accel-3d: use ! instead of explicit NULL check
>>
>>  drivers/iio/accel/hid-sensor-accel-3d=2Ec            |  2 +-
>>  =2E=2E=2E/iio/common/hid-sensors/hid-sensor-trigger=2Ec    |  3 +
>>  drivers/iio/gyro/hid-sensor-gyro-3d=2Ec              | 58 ++++++++----=
----
>>  drivers/iio/humidity/hid-sensor-humidity=2Ec         | 48 ++++++------=
-
>>  drivers/iio/magnetometer/hid-sensor-magn-3d=2Ec      | 80 +++++++++++-=
----------
>>  drivers/iio/orientation/hid-sensor-incl-3d=2Ec       |  2 +-
>>  drivers/iio/orientation/hid-sensor-rotation=2Ec      |  2 +-
>>  =2E=2E=2E/iio/position/hid-sensor-custom-intel-hinge=2Ec   |  2 +-
>>  drivers/iio/temperature/hid-sensor-temperature=2Ec   |  4 +-
>>  9 files changed, 102 insertions(+), 99 deletions(-)
>
>Firstly, for all of the style patches  (1-4, 8-11):
>
>Reviewed-by: Maxwell Doose <m32285159@gmail=2Ecom>
>
Hi Maxwell,
Thank you for the review=2E

>with Andy's comments=2E
>
>Secondly, the style fixes are all churn=2E It would honestly be much
>much better if you were to squash those (even despite the
>one-logical-change-per-patch rule)=2E
I agree with squashing 1-4, common HID drivers-specific changes which cove=
r all HID IIO drivers=2E

However, this series updates 4 HID drivers, while several other HID IIO dr=
ivers needs coding style cleanup=2E
I'd like to ask Jonathan for his opinion on whether all alignment coding s=
tyle should be handled in single change, individual change or some logic sp=
ecific HIO IIO drivers split=2E

Additionally, 5-7 haven't received any comment/tag=2E I can consider all c=
hanges in v2 and also rebase on latest iio/testing tree to incorporate u32 =
usage_id change=2E

Thanks, Sanjay
>
