Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795169510;
	b=Fnx5K4mv4USU2Z0umpCPsZpgFJmetYJ+nHHN0EbypLARriTLrhYsiHpot0/aueD1DM9j
	 05KMNj9tvRwGeT4ACHlY8REpSktVokzyYwhsN825vq12HZ+RDTWoU/c6HztzVNIwLUXLD
	 DoKjTxTF8p90B9UGf4Zc8/LkCbpVOT5SdwPaYx5KpmmHF9+2L8OAV+qDoEfsyvdLFzr1Y
	 OZqYXuB7LxKBEkgsnWtzCnoj7j3P1GH3aBIbAeIwBAyOEQCwt5iePUZ/dYTnCw2DIzuP2
	 2jQB4bHATTGznHmpHwMU2uICuQCLdjsON3/g5Mewhj5nSsUA+G7LFzyljCA15X/3trw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ix8YIlBo26S4kxfvPK6KnFVjqAYai4bV9psmx/ur3O4=;
	b=T92ng3vT2JIvqr9hKABj2jbvqB7dQEqrXdRbcVtb1wV8ayJCVe+wHXU91k0gNXuncfvH
	 vYOC81TWGx9iqp+HiT0Ac9TXZIGAWIOHdnmMj5J5FizpYlCWp5r5ZB/goO3AzpbYfnS2U
	 EpjyVlvPaogaDLfVmpeUo1bKojSIBO3D3YQvPY7KNen9KnxNvT6LenaUojaSQDMh65hZs
	 KC1d6UpqLroag9XyWIBp7XPkt64IQubBtrLoa+x43y46X9YrTjOtBG262C1elTDZEusWQ
	 79hzbb0StOZJw8CQFhSjwiO3hhiU7NWd1O7opIa2h3pwC2YKKHq2QZtKllOGFtiHrUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxPvif+t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5E606A333
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 10:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72D5E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxPvif+t
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so128267666b.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 02:11:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795169509; cv=none;
        d=google.com; s=arc-20260327;
        b=VN60S6xfv7ugoG3SCk4/Z3bTeOBe23ABUEstvaHBcrELdR4iDNTFGByzEk1y8cjdgc
         /3lsBLqN1hfRiMMfVKxnwBnmLsMJeHah4JScVkPC+DIu1tCQeoewSvJBR6/I16z1gL2/
         bwzomKhS65TzOKt4dNwWt6Q1RdnNg7S2hVJr1cyb10hLDpTdmWq3al59JNYceNbOkCmW
         MSkMA0Mi/VW/pmLnnYT0HwQqtnfEWeV2g4xcPYIz4IxVpeCIrrwsYcPYRE7HFvdZsHTv
         sA3V0erIJPV6aS7NotiEdXrzlLF8zqZJa6HoQJbtXLrln9HgJ+92iFRSsxhkmzfz46Tq
         N0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ix8YIlBo26S4kxfvPK6KnFVjqAYai4bV9psmx/ur3O4=;
        fh=1GZ3gJEUrq5aHqFz6peyVBWyVutYamvcuUdcpIoqOIw=;
        b=Wbnf34eNUHX8p8GWJRyWDhdzt4PrPd+l76CW3Sr4g3tFuauRXxWML/XiJy1TscFcTK
         sco8xwlkiOt02SW/lisRGnDQWPbhOBSct5GjPCv8XNW2GQVdC7V/5xQwkwkvism8vdSW
         4Av5QuzoX+T/YOdI/5CUB/NxK1tLeitdIhFKwIoYf+sJaSmMQA5/0J1fV5OWHlZqfxpj
         EnfgHKvpt30VeP17Y0q+XE5hJkuek/YJe5vk9bFSHFMaKNawS7T0XzadSSg6RPfBwKBM
         2SvIfq5aLLUWgb0h1rwiw3TxrPvPZeyLvZyuis0fRCe+oJZfD0Vj0hbhYlVMhrwZQJJm
         hcPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795169509; x=1795774309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ix8YIlBo26S4kxfvPK6KnFVjqAYai4bV9psmx/ur3O4=;
        b=yxPvif+tZPAvRMgcMplx3IQmTtPu8rr6zukYavto1fOrs44pE2IQl6asTUIPhm/iUQ
         piV0Cb2ASbmBsKDRXzBRa2V84q2jJWU7pHeqX47oGqDSpNZ0bIN9wRBpfHiBNufVbPh0
         2AWbv1OYPvxBLlqFk/HWSP36uqg1eGQ41qVEMiKIV04hhp5I/ipYf210YSOJ1qtyEI0/
         E1K9xyn63fkRqAH/rIOm3mArDhIRH6tDUVG8SEnmTJnrr/RJzwws85SHGXTe9vLq01rR
         cDKMp5DMnF1P9+/lH/UZ24c5v147dSiUMPkLBlSUUUSjrd9BfKU4mQkDiH3LgU99547q
         11+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795169509; x=1795774309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ix8YIlBo26S4kxfvPK6KnFVjqAYai4bV9psmx/ur3O4=;
        b=b1VuPWkkiT9StcwMWaF2/vARTsNzxf50DQ18l8yNJPhmMP+80WEhqPjInabDGaZYjV
         YTOC6c5/Mbri1wEd7WIwSqyzyIdXv892VPvr+HXL1wCdbmtLZiSyS3Tg3dwV1U0D6iOt
         sYrbXP5fq6QlzKJsPENGoM4Vm2CrrlnmHy2j8gzd1OK0Gzm8V2A6kyQr1RBsL5GnSs97
         5PT1DmoRnHUQ8hrBAaQyQgiiX2FPdZ8R2sjv8uOqVbKljCpKoO61Hxf75X9AuefzTerl
         nk6f1Kxy10dE9wY4TsyVtGC6oSq7hq3zPVCbyudpD5xlgxWDqXmLvizNX/up6TMsDGEO
         HY4Q==
X-Forwarded-Encrypted: i=1; AL+hErEYLXTJJ2+E1zzzNQxFM/QKbJCkBquQzK9u34gQEk5VOo/utIeUzC7sULgiyC1VaccR+mAGkk5V2ek=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FlmJb4ZhZCnDcmNNRrj1K2CSD+5og/wcjVTLIzeKn3YRAegOK
	pfYdJfajHdntyDTDQMbJ4OqxWEqMnHm0zMbKAg6zkw7qCvVX+MKP87oChkZQjzxkwG6vI5hP2bf
	cKsZohIX8n9ju/IqC6ihyYrQTqGbCk3KdtkdyiTk=
X-Gm-Gg: AYBFou0GosSgIyewM9nuwWBtE0+yzNBjZYplrOV2cCSm2oN2jMs5naaC0Z7LwihUTip
	1xi3KZuXB4Wwqv13uaVQIvIUrHqhSiqk2Dnnq4xu4xR9EmFPfMl6mupB9xyAKHhZJe17vbtaz0e
	j9gYQ5szvoa+PUlobi0lZxBArZs6IlQ+65ACMmk/zxmIbrNh4p/lemd7BIBfagM52SxJ4y97Zyf
	f83pYvR2MBLyf0k4033T+tEOnHn326KFP0FRhsEGsVhRaSp3aBTdQWzLb4lfpwhO/EFkxMWdlpa
	hspRNyyQ/FJKse/HJ5Db/H7ZvmHfaupsyxPiY867M8YoZqhbnNfMXWXcvYGR6I/+zq81Ur4ngf/
	rTmIuCeL+BMGQbGcpcIlagnKRw1OLSkQbZSSjbpqsBHGgcV5oCvxa
X-Received: by 2002:a17:907:6eab:b0:c29:f5d8:9c78 with SMTP id
 a640c23a62f3a-c513aab17ebmr257797166b.39.1795169508635; Fri, 20 Nov 2026
 02:11:48 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-b4-abp060mg-fixes-v1-0-2baf026cde47@gmail.com>
 <20261120-b4-abp060mg-fixes-v1-3-2baf026cde47@gmail.com> <awAY5umCN-RiP2Iy@ashevche-desk.local>
In-Reply-To: <awAY5umCN-RiP2Iy@ashevche-desk.local>
From: Alejandro Lucero <aleszlucero@gmail.com>
Date: Fri, 20 Nov 2026 04:11:35 -0600
X-Gm-Features: AclHuK_hK9Pb3fKXJf98nIHgs2WSxmybSSy0H6uomMHlQet0kFLOAGc-ZNoZhl4
Message-ID: <CAHDi9tp-3g_HQT0jSqVxA5KBUuSe2tpJBhmdrrPW+Pz9iD8WSg@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: pressure: abp060mg: Use msleep() instead of msleep_interruptible()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Marcin Malagowski <mrc@bourne.st>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

I checked the Honeywell ABP Series datasheet (Document 32305128,
Issue 2) and the sensor response time is ~0.46-1.5 ms rather than
40 ms, so the 40 ms value in the driver is just a conservative margin
from the original author. Since I do not have the hardware to verify
timing/signal behavior properly, I will drop patch 3/3 in v2 and keep
only the other two fixes (updating patch 1/2 with the datasheet
reference).

Thanks for the review!


El vie, 20 nov 2026 a la(s) 3:54=E2=80=AFa.m., Andy Shevchenko
(andriy.shevchenko@intel.com) escribi=C3=B3:
>
> On Fri, Nov 20, 2026 at 01:11:39AM -0600, Oscar Alejandro S=C3=A1nchez Lu=
cero wrote:
> > The return value of msleep_interruptible() is ignored. If a signal
> > arrives while waiting for the sensor conversion, the thread wakes up
> > early and reads the sensor before the 40 ms response time has elapsed,
> > resulting in stale data or an -EIO error.
> >
> > Use msleep() to ensure the full conversion delay is respected.
>
> It should clarify better why uninterruptible call is better.
> Do you have any datasheet reference that states that this time has to
> be at least 40 ms?
>
> Also we have tons of the IIO drivers doing the same. Have you studied
> the history to understand when it started and what the motivation was?
> Perhaps it may shed a light on this.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
