Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653D283C89
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195498; cv=none; b=CpvWQOMti98IGVuXHHhrhgr6UoPw+8HRbY5p5P5L/z5woM7GIU30kb4iDiu4vyOtq54v2tuFJOFSt5SBCnqn59RSmC71tLUHGih5BRF7aSc9WCnJHKZ9uZmSg4BO4G3RdOscu9AdlaQ2pf4c7UaD4SuNcmeG2pda9xLbfgI+lq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195498; c=relaxed/simple;
	bh=+/dHpzDdvnXv9XvCFyqZfCQUq6sgyPwg/78YsLVfcJ8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZwZO2d8HNvqidcQ7y/JC6aI28/kUwMy0kdksi7Kto4Bt09afgm9yaZllRxo50yK3IphrmIkUhBwEgIXSZoKDy1Lv+a39dMn+R361Y6zXELei22Nnlo7q/bePtSUgdu+aCruHw6z9GG6YDwLRUQsPayScawFB8M6dpjR96KoYNH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvSKyg0D; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvSKyg0D"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6e2355739dso5512220a12.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 19:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773195497; x=1773800297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ZAqF770CjctREhKahUCDqzMAEkw+GXfuiDNjYlwSLk=;
        b=fvSKyg0D0WfL/vzr9Cx5vJtutHyS2zyBDrgY+VRcTqz1DcJwn3lM2Y8uF8N8UAqBK2
         bdETDCx+d2sNjHBfAebcNpBL6hJJn8e60zBt8yIUzmQ+26hJT7kQ8hlERQDXCsi1hH9/
         kzzikvy3SQ+VayGNhQqv5kCVuwATD6j3rBkca+qYvqazKuYg6466as/ASq2rfdi04rmo
         kQ6AChj+ypwTBF3lpFirsL2emJtQF9olWt9gLcHB9bqFfkF/Nbua5FQ9vsA6Hfo0vh8t
         PnsuNnFBT0OYeAU47bdPH7dWapocF/3WdLPxpl7rHMOHJMpexIzRW+OQnKOe7EktAZqu
         t9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773195497; x=1773800297;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZAqF770CjctREhKahUCDqzMAEkw+GXfuiDNjYlwSLk=;
        b=v3teHcjGvgS7VppGfm7v7sOYxK+JlSM9RxmEWH3xeZFrTPcSboOLXl2DxKV2bLwhoS
         ogN7kaJgnQdz4LYurFBNC72iAM/kH9zTvwskNHZeybfuCSPLb70JAiADPtnzFrYBYkbO
         kZ4Zx6sB+RQQ2DYE8mo3OUfGXTP9Xqr/leRTazN7Qe3VP5J9DehW7ZzHXHaGsegHdKTO
         PJveowAbqaFCJ+cFcXNZ/wIWEP6BO1TYvkXezs6QnRJ9x9CGZ6WZLdmdER5pVWgnhnMP
         h8U1xEMjYpL9bJJNfdonnpCpbxBTUNCnYSKLaV8wpbAqR8wRHCdwNiDbn0hLaUIiNnxs
         r+mg==
X-Forwarded-Encrypted: i=1; AJvYcCULKp6CjnflQwruv7PGAYZIK0rZUx6H3lrRULG9AirjirCJBeTBYhvqK+4XrbxHZZGLA7LLsk0GhV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPOwlK7HCRaBEe6150wBzIp0Zwvc7YknupAeXRu9UHRVX6Cfli
	w3ANL4FiuJR7TZYLn5D8nNwaz3S8myCL3s5N7GYHTJihA6HyUkZN7F03
X-Gm-Gg: ATEYQzxv/Tq+U6nkeyNPomYf8rtWE8Tr8j4Nh0yqeVPfHT64WAwf/nRfsU4ijwYfB/d
	UJd+TbcaNILRFy541CE397zsduJrGgiLzK7Kjt4+cl04QMuiq7wyNA6YVv4uAqj7F9SVdiXU88L
	klmAmSw0Rg/FVNDjv2LubOstKGwi7ssdKpmGz8wiVuyj4amh7h7161mQ0SvvsZgFIutCMC3I9vL
	Pmc/5WnQuQIlUMrzhkIEP/KkCKTw8r+3Ce666yzTcKBlDWrj2rMQPvsHIQuUuf6hIQ1LgyCmopK
	tW07GhlC0GtlSdn9dON+NFJl01QKeqBXHdc/AtE5N2KK2ree31dFsb6qJQCTXjyfSPBIIs9BLM5
	fpJdhgsaTCu483NXV4m3ara7kBIPckn9Q5zcaYQeNyX9XK1Ww+90u+C26PlR2pwPD15hinJ6jdl
	HcrxIb+vVZldCCBtmaGL3Nxn4C1mhjW6laOZw=
X-Received: by 2002:a17:903:1666:b0:2a9:47ff:101c with SMTP id d9443c01a7336-2aeae8eb7dcmr9366255ad.46.1773195496591;
        Tue, 10 Mar 2026 19:18:16 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:aab1:729a::4bc6:faff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34e009sm5679355ad.46.2026.03.10.19.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 19:18:16 -0700 (PDT)
Date: Wed, 11 Mar 2026 07:27:18 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: David Lechner <dlechner@baylibre.com>, jic23@kernel.org,
 m.tretter@pengutronix.de, mchehab@kernel.org, p.zabel@pengutronix.de,
 tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
 yunfei.dong@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, johan@kernel.org, elder@kernel.org,
 gregkh@linuxfoundation.org, pure.logic@nexus-software.ie
CC: nuno.sa@analog.com, andy@kernel.org, kernel@pengutronix.de, kees@kernel.org,
 nabijaczleweli@nabijaczleweli.xyz, marcelo.schmitt1@gmail.com,
 maudspierings@gocontroll.com, hverkuil+cisco@kernel.org,
 ribalda@chromium.org, straube.linux@gmail.com, dan.carpenter@linaro.org,
 lukagejak5@gmail.com, ethantidmore06@gmail.com,
 samasth.norway.ananda@oracle.com, karanja99erick@gmail.com,
 s9430939@naver.com, tglx@kernel.org, mingo@kernel.org,
 sun.jian.kdev@gmail.com, weibu@redadmin.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 skhan@linuxfoundation.org
Subject: Re: [PATCH 0/7] drivers: Simplify cleanup paths using __free
User-Agent: Thunderbird for Android
In-Reply-To: <79bfac24-dcb4-4fb9-90d8-3ef2393f51e3@baylibre.com>
References: <20260310200513.2162018-1-sanjayembedded@gmail.com> <79bfac24-dcb4-4fb9-90d8-3ef2393f51e3@baylibre.com>
Message-ID: <7F16ED38-6BC1-4D31-B5B6-6C1E45D24C25@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 11 March 2026 3:22:28=E2=80=AFam IST, David Lechner <dlechner@baylibre=
=2Ecom> wrote:
>On 3/10/26 3:05 PM, Sanjay Chitroda wrote:
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Hi all,
>>=20
>> This patch series replaces manual cleanup and explicit kfree() calls wi=
th
>> the __free attribute from <linux/cleanup=2Eh>=2E This modernizes the me=
mory
>> management style and simplifies common error paths without altering any
>> functional behavior=2E
>>=20
>> The __free attribute provides automatic scope-based cleanup, making
>> resource management clearer and reducing the chances of missing cleanup
>> on early returns=2E
>>=20
>> No functional changes are intended in this series=2E
>>=20
>> Testing:
>>   - Compiled with W=3D1
>>   - Build-tested on i86_64
>>=20
>> Based on:
>>   <linux-v7=2E0-rc2>
>>=20
>> Feel free to share your valuable input in context of the cleanup API=2E
>>=20
>> Thanks,
>> Sanjay Chitroda
>>=20
>> Sanjay Chitroda (7):
>>   staging: greybus: simplify cleanup using __free
>>   iio: ssp_sensors: simplify cleanup using __free
>>   iio: st_sensors: simplify cleanup using __free
>>   media: mediatek: vcodec: simplify cleanup using __free
>>   media: chips-media: coda: simplify cleanup using __free
>>   media: allegro: simplify cleanup using __free
>>   staging: rtl8723bs: simplify cleanup using __free
>
>There is no reason to put patches from different subsystems
>in the same series when there is no dependency between them=2E
>It just make for more noise for everyone=2E
>

Thanks for the feedback=2E I will split unrelated patches into
separate series per subsystem or individual in future submissions=2E
