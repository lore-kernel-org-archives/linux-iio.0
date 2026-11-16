Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811328;
	b=U8+mHB/eV4skzINNsW/JoMx+T3yRDn9k8x14Iw07TbnoJlpja06zGwl+oWupqtLM8mwS
	 XwqPEbWLhDRhOjGladzi5ySEjTPcrYflRrO+tped2CK5S/52tBsCNQI2yD7HEPN8s/jVK
	 28fUVhPz/DB1RLun+0PCbHCabGAgcwg0y5K2fo69TK/fyyIES4lM6hr8DSEoUxwyIi4kC
	 pTmQN3eHP0+/+DhVAn+b0rcLbMcvvmB+x4yRU+ZWnxkBsUE55Sq2e9r7yn/9OOeE+QQBe
	 pZtFBwcp6XgYk79ez3WT6OXkGhgsMi2stCCtg4Xtbnz1B9d+jLppXACTprUb3CU4PAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wRWcbRGa0lw5+zrHUwoAEHoN60ejoMH5x9ja73muYZA=;
	b=d3Hy86ynJfBmJvME4Tke7csVGNJ9YU21kRlJeaRfgFvrIf2H1Zn9QGdLpqCTvc1syibu
	 fUhsEmhRenZ+qJ7kVCtvT+/D1M79p9BQAgn5777+2XTrRqOGV9y8rX97ASlStkv2l2hM/
	 JL967mMozH1DBDE1AhJ6yxpUKp083EfMhjZO9+Q3aaWziU5XB8lt7Sswn1HVh8Rwt0Kpu
	 KuyMjmfFniQFmPpT8DhbcmrlFlIvRA9E01OFTE9duQn8/t5CGP0Z0Z/sUBbFnCAkgglK+
	 eoV3P0xhoMXGX0qDaTz7BanxoQ5wWtgB//WU1E3FNHsFESMn7w6cvzjg7FuO6AZZr0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifZf+Fwd;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C05606A329
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 06:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50C05606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifZf+Fwd
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so2049545a91.0
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 22:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794811327; x=1795416127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wRWcbRGa0lw5+zrHUwoAEHoN60ejoMH5x9ja73muYZA=;
        b=ifZf+FwdSDqg952lqdRo/+g480XgHdVYCnHVDpT/TyiaidyOuqYX8xE8J0JJguMUZo
         uKqHgl1Thu1cLd6z6/nqK+p8Y9+rRhdgTQb83+trn98vVrQ+vYgXI1eNxgEpif/R1V25
         f32rYfrseR+mgJltUArzqJlHFUNNzxVt/c9fzCoK2gPkMJkk33qyzsV6LinbqoWzN6fN
         70xcz3xTSeN0u8Ozxq/NdqqY8gNaTm2f4lBIx0q+JCPrIAfAZ0AeS80QgQRCCfoFJJ0p
         eM76MzSbQfcDm/rG7f69Lv3FIxV8cg5HYnWBBcs/CyZX2IkWDp98l2FYJTmOA7RfGs/G
         iKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794811327; x=1795416127;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wRWcbRGa0lw5+zrHUwoAEHoN60ejoMH5x9ja73muYZA=;
        b=2U4dXCcSjeKBKkVpoiY9xutAqXm5+uQsh4Ub2jl6KBZaC6t4mbazgmv8hZbEhGMsP4
         srr6QG/uSU8OJ20KwBylR502na4tAQLNqisX0sRuONVVFm0WnZ9UoCG6dKnctWuGfgtX
         9dsIU5uSnRtPwzHkVTBiHtd+1pD8IP8ljxrdbi7e8cCG0XKyBdfE/YkedDcu4tNngyA0
         b7dwqZI0Y2jB76rgUP3XKeIxGfVRsHgzaeWB+eIazojbfcutOo7P3YJ3mxg3E417JgxG
         xLoBtLtvqyUoWQLv6eUFbjQqkOnJTVdnMjCrjIWO+nHkwS645PuI404/+zvNkD/xyy0I
         pbJQ==
X-Forwarded-Encrypted: i=1; AL+hErE7Vk+11MovIaG9Q1wKRk/KQkJXKTVeuPDCf7nr8+WaEu+QLw1vLfPWu1PYrQieMsbEIFEz9gl8DKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LcT4LZXPnYTj/Y0byH2A7niwkhb0/VZulMB9/5puU6GUhf1zP
	MYor0FVj0JFxAyWOIw0j7Xp/lGAulsZqLxGRAtUZOLNVD/auH+HF7lNw
X-Gm-Gg: AZFdTZciD02zL1WXekyIrP/wfVcl/P7bwwvl65PvmjoqNn85k8wdoFwLgcfcWiI0s53
	wR6BftnYuyHocORY6o/o6hgs3JlH87j8D5bDQDu3MrUsA5jRHakzezlY0hi/LsV+OzEF+82OpjE
	0Q01Uv5tKBNG1ktQBwB09vYO4Kzxg2wZfeoEs07pG+JNGf9xa2oH6p06pYJMrWQfiFQ/f5C57EH
	Gw/83XHZBgXJudl5jJRQkFtmPVw0H8W7YQPOr3r0+3Z1Bl6MIVSLKCbRffAgrhWYanc5GF3aHaM
	YEZNDVmTcgNvW71XlsultmUH2/vwuiSyGGoIZ8fc4Rpqd+zpmzc8LtIaEr85ZX2NOJY319qqznI
	uDAoWp/XoPLbiduqjP44t0T0ktaXv7YcJAgUf2LKU2zrzAAR92lPw9t7t4drKmo4AfW71tb64Qq
	9p+m0aI0InfeJny7DvNtKlAnZ1SWSmwdyJGnjaU+neNE3JeAYXvc7G84Iq8kNAR4t2bGTBWcIzQ
	IP0Pej+2GwrKv3PS79WYh7cd0gRj2hnQ7TKElw+rsRwZlVj2/yxIoCqR5Vj3pNbCQD1P8/9Mslt
	KtfqZLvs2z3ZGr+71QLmJwc1KL/QimQbMLi1nbhXgdLYulGaZY+m/M0ttWes3n0uN3HFmKn/PbE
	=
X-Received: by 2002:a17:90a:908a:b0:3b1:bee2:223d with SMTP id 98e67ed59e1d1-3b1bee22478mr5477449a91.53.1794811327578;
        Sun, 15 Nov 2026 22:42:07 -0800 (PST)
Received: from ehlo.thunderbird.net ([2401:4900:8fc5:1e29:1b2c:eea1:7fdd:964b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec43699sm14960106a91.10.2026.11.15.22.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 22:42:07 -0800 (PST)
Date: Mon, 16 Nov 2026 12:12:02 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Joshua Crofts <crofts@kernel.org>,
 Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
CC: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/5=5D_iio=3A_Remove_redundant_pr?=
 =?US-ASCII?Q?obe_error_messages_for_HID_device_drivers?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261105165254.00000896@kernel.org>
References: <20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com> <20261105-19-oct-hid-iio-unified-print-framework-v1-1-0b360d9552d9@gmail.com> <20261105144036.00002e1e@kernel.org> <20261105165254.00000896@kernel.org>
Message-ID: <0CDD7FDE-6E03-473F-8910-2C33973F23E0@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 5 November 2026 9:22:54=E2=80=AFpm IST, Joshua Crofts <crofts@kernel=2E=
org> wrote:
>On Thu, 5 Nov 2026 14:40:36 +0100
>Joshua Crofts <crofts@kernel=2Eorg> wrote:
>
>> On Thu, 05 Nov 2026 18:11:43 +0530
>> Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse=2Egmail=2Ecom@ke=
rnel=2Eorg> wrote:
>>=20
>> =2E=2E=2E
>>=20
>> > @@ -377,20 +377,16 @@ static int hid_accel_3d_probe(struct platform_d=
evice *pdev)
>> > =20
>> >  	ret =3D devm_hid_sensor_setup_trigger(dev, indio_dev, name,
>> >  					    &accel_state->common_attributes);
>> > -	if (ret < 0) {
>> > -		dev_err(&pdev->dev, "trigger setup failed\n");
>> > +	if (ret < 0)
>>=20
>> You could also remove the comparison and just change the checks to `if =
(ret)`,
>> as devm_hid_sensor_setup_trigger() always returns zero on success=2E
>
>I suppose you could also add a precursor patch that changes `return ret` =
to
>`return 0` in devm_hid_sensor_setup_trigger() on success=2E
Hi Joshua,

Thank you the review and input=2E

I agree with your point to replace (ret < 0) with (ret) as devm API return=
s zero on success=2E

Do we find value to add new check and have `return 0` ?
devm_add_action_or_reset() is last operation in devm_hid_sensor_setup_trig=
ger() API which makes direct return as simple to follow=2E

Based on your suggestion will send v2 with additional changes as trailing =
in the series=2E
>
