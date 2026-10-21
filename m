Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618388;
	b=fOiAvQGQkno4hdIqCneEU44zM4ZmL54q4DZ2q2KRNK5+kQ8wjpQj83JjxBX7W+zJX9tk
	 yaNT54QhA7yxzngPqTZoxV1l2gffJIpc2xcnx01TBxeCu8Z7/J2rPYqV94WB3dhC89RyR
	 YPtb98cKwRbFALEoIZmwf7DapH7nDMvLBdhzjKqMMfUM3NP35wU0mZFpJ8ECMQxHU0GIJ
	 fa0pNjzQr8wvpnZ2TJjepN9o6NJCxWCGw1Zju1HDYrEPFIdeav/t1TWTEBvHwC5+dGbBG
	 lBD6ngV5k5I+Iz6jGERaNYkeJy9ZtI0AsRzgcVhwmDBvCU6viH82tQOW8BtVUvmDgKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=UCwQNMxH+F/zPUwqh6Mzh/IhhNr8THI51anSCThLEEg=;
	b=cOCDDDS2Ja9heCK3/XDoccC/e5pDXl/0p3AcLvrflsklLPXnWYXOz7gjt1HvYNolBpOZ
	 +9EJVc5pd/Y6rxqKSjhnsWJrOqXqU3wIxuCJgKP4BeEQDcl0uosZpnRjODf/SbsrP2u/v
	 RHcCAE951MrynRolJJR+qKUoZYjQcUpwvAJphmjZbSwU9emCXCbsZo/mmF757F8gTXI0w
	 SleHjtTMrxits3/FAC1wcmILwLajK/MTIJSASOu3R2tPyp0Q9KJTGXzIIeSqH45+sdXFO
	 x+deNeO9o5l82LKUyn2jhkuLpfLB+Rr14yNCrnDsUKB7ckM6Zo/TtY098ENaxAYsY1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SsntEoPx;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667D0606A31A
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 21:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 667D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SsntEoPx
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1931ff67a29so333253c88.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792618386; x=1793223186; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UCwQNMxH+F/zPUwqh6Mzh/IhhNr8THI51anSCThLEEg=;
        b=SsntEoPxNYjf59X7OOg/LdIMa8dn6XV3gAPoqbAmwMfpoB75Xd/teNGbBc7/pZzBeq
         Un+x6HCULBezBckOVhQ7iqYX86Q0Csw2zo0KnodTe93mReqvdNe4iWwzlVt2SXZuHDl0
         e8wtjwjh+lzY98rroows9JxtQ1Pc1hh+myBfYo+iUxFTyGKzPSqiTtlwSmDBV2cQAUNo
         5WDgIrs58BennY9eVCaVYc6jMujI5u7pUKdTSIoSwinvN/VxnT6NgWoV/Te/DUxMDEot
         QnXVQVe/MOn9UJDgmNSDaJBAtEPZUK5xfk3ig10ZSme41lcOb5Nyng1gx0pG0G/AEBGs
         p48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792618386; x=1793223186;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCwQNMxH+F/zPUwqh6Mzh/IhhNr8THI51anSCThLEEg=;
        b=sZq1cDuz8bG/EtklKTsO1yj/KJYUyMfY7Inbh7WnjZaJ7VegI8HagQEUSEyCeeBT9c
         12/0VXzuI+kUmsh6s/lkpfUIOLhCCBf7+hajc/x0O5HTPVoHHUwzxckbmQpkbW7wi8Nd
         /X3oOTdwky6S/3nbW1oB0HxN5Mx0iAtAcVK045j7IVigfQP8dAtUTq15YMQIzDQ3UkJ+
         6Qyk8BpE+LDr9ElQstkwqirtpZcv8pNvyS36SMytEKhK3BRDXLr66pKoUBX7GpquPurq
         MkYfVXE/1FEzK7giOS3tR5bQthJRYFp0BCkLHf+GuVAh6kJptYFhLR6awLKa6afQZGIG
         mPfQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+78s8R0aYcjLiVihW/meP/Y6VnCqFk7LFM0+vC8Pr8lPQBl58HZh065TOdHTdWMTiFGtY2fSILJY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7dXeMW6ZTlmfH1o/qgdNcgMRq87cpPeJNtg+lKJChH1JTBCw+
	adWm5olFfyjf69xtYIesrz5CUg70aoVDUVbNLUnMqD/3KVMZbdRNgzTE
X-Gm-Gg: AYBFou2cRde3EgojymH4z05vv0X7Ty7YRVWzYHldGxEutIVMxoV+5bfnDRPpWJZYuD1
	hotUIGE6gVA8m6SamOgUmt45tWrm3F7AUV3ngwbOzWX82GL37FDYoWO+ZqkVqxi72jJ1QXjHyaE
	gKrkfJyj2clJbz444DCsYIzzYi/WdN2ucEi4zS85XjGfvSaYaTSMlWoFLgm4rEY/4z7HA+Wykot
	m2Zm9xqc2s6/SX96tqAKPfvVPpmINpLJHvkdCxwg1iJsMmSl7yl6PHE5syvAtfbs1qOoT5zRDIh
	7lQtC+VCRs/Qr4srdJ5ImycVrF9f1XPPshY0bC5tNvcLzCuYEFC1XnpLT2KUzbtQ0Qdm37BJdR5
	MYScTSBhp9CYCx5JMiD4oM5FYrSH6Qc9sTbnGOEiu4vztnKPQiRSlkMt+DfNjyp2dJQ/esFoiG+
	679lqOb+X8enQ8EGhO2wzmM+GjAyrxgH04PRfl/v3u9PWT48xPkd23RNBpdD5H6+YkqmbuTVUSM
	HEaYp/lL0uS0GRpI5XVmChsozdsQbGMLQSoCiGGNp/BS3+e8ZhKKsF+68Yw6ge3wjYJFx4jrI/o
	2ziui/t8jDeiTQ==
X-Received: by 2002:a05:7022:1709:b0:13b:4ab5:41d7 with SMTP id a92af1059eb24-190a051ddf3mr3686389c88.3.1792618386343;
        Wed, 21 Oct 2026 14:33:06 -0700 (PDT)
Received: from localhost (host-190-210-193-254.iplanisp.com.ar. [190.210.193.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903b3d0530sm9368959c88.11.2026.10.21.14.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 14:33:05 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 18:33:01 -0300
Message-Id: <DMAU6JSPOTMP.2LNR04HDVF43T@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Conor
 Dooley" <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 00/10] iio: adc: Add TI ADS126X ADC family support
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
 <20261018023129.3abeb679@jic23-hlaptop>
 <20261021195611.14cd0a2a@jic23-hlaptop>
In-Reply-To: <20261021195611.14cd0a2a@jic23-hlaptop>

On Wed Oct 21, 2026 at 3:56 PM -03, Jonathan Cameron wrote:
> On Sun, 18 Oct 2026 02:31:29 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Sat, 10 Oct 2026 03:52:39 -0300
>> Kurt Borja <kuurtb@gmail.com> wrote:
>>=20
>> > Hi all,
>> >=20
>> > I apologize for the long delays between versions. This month has been
>> > very busy at university plus some personal stuff. I expect to have mor=
e
>> > time now, so development should be faster. Thanks for your patience!
>> >=20
>> > Signed-off-by: Kurt Borja <kuurtb@gmail.com> =20
>>=20
>> I took another look through and it looks good.  However, give
>> the sheer scale of the driver I'll leave it a little longer before
>> applying in case anyone else plans to give it another look.
>> As normal, if anyone has it on their list but is snowed under
>> just reply to the thread and I'll let it sit longer.
>>=20
> Long enough I think.  Though given I'll be rebasing on rc1 any feedback
> people want to give is fine after this.

Thanks a lot, Jonathan, David and everyone that contributed :) I'll
submit the follow up series starting next month.

>
> Applied to the testing branch of iio.git.
>
> Thanks,
>
> Jonathan

--=20
Thanks,
 ~ Kurt
