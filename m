Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40842E738B
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122603; cv=none; b=rm+Evdaxud7rLIeOTzjb5LLbSMIxXn30kK49YkL6ehSg9QSEk1xOCBQZ/CR5jCU2LlLenTsjiV8W8XrNs9xCX1z1dXC8b1WvuWRfyaIftPbMsL+kB4DgxKekGOejfc7wy1y0CP2gkw5ln/lXwjOho98DuBcrgMOVPgw5gTWKTg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122603; c=relaxed/simple;
	bh=XLqyfkl+3GBSFWeake4sCVQ88Ce6Vv06IguMAS7Lv38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSwww61MLzj19FbkUTI5OpZCrAF/9o7tYd//dMeRvaZQ31+tDfn7EKftxEXSa/ShR6Q2+YgfIH/J00KUVnzlKU//RcOKZcGCbcTLSKQMmOVNce4Eejp2L+kaTN8SFWpm97FUFvJ+DRO4VfyUjP21kC60qK1j53+iVMh/5qgHjOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOEv9aFw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOEv9aFw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4953ddae026so4313875e9.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 06:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122600; x=1784727400; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:content-language:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XLqyfkl+3GBSFWeake4sCVQ88Ce6Vv06IguMAS7Lv38=;
        b=KOEv9aFwroQyrOCs8JWedoxmWmF5m0efryNftpVb0UY5rzP6hDHoZIwde1rAJI0LvD
         0Bz7pnQE/FBk95YDV/Z1j4MnwsBio4ZZMiAS+5aM/7CEDC/dgPt24lj9DBU9JcqpDAOU
         kNICMkXCHRP7ahq8vV5S2pdGbmt3aiPQQhlNZdtZlBs6r/5noX//vqA4CTUWc6ThW2/y
         KVxfZMlmb2sU1iDwnt8Py9uTOQSnTN0Df+WPtMAQKOlh0e6nrNdSbPuGU781/pihoUe0
         7amvwqLHxNsG6LCysyThOniDU6L8FIpq0w8B5lRZF1H7bVMhl1TFaX1qLwohhy6yHDEl
         lmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122600; x=1784727400;
        h=content-type:in-reply-to:autocrypt:content-language:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLqyfkl+3GBSFWeake4sCVQ88Ce6Vv06IguMAS7Lv38=;
        b=b/jERWbuekUJ+hDHWB1n7qrj1ol53csQa0Ju3gFMGVbPb+2kPCzRoQyhtfYpbZPz4p
         bQ7LuF06KSVRR7UxeqhEUFjcTUX3bKrE0dOQA6vE+ssOuv1RCR3xtzgORVyEBUYu9OTc
         R/C0Ax2bL7I726OF+dhl7JNxoWOqFAbvAExURrsTE7gJcXsuccw4wt0fJ6vTxNQuqVMX
         JKlfN0WXV32dI3M3EGqB99sRv3lhrm7EBQRbC4mP6IAKL9kfk9J2xBA1uUw2+Pd0GpqQ
         VzXp/Ax7NAK1z4ELWkoIAZ2Zr2Jyrbb203qV5P/xjg3QQZBMIj4qN6sFAkebC90hLmpV
         pAVw==
X-Forwarded-Encrypted: i=1; AHgh+RqmCAw+aHIgz14IoY5E+YW8cPdsBM2jPxM86nI7uxQ6E2XgghUqxQAtOXSj9HbX8G3zLZ5gEVhyAt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyt7DaXC9dvJ/cgbF14Ii6PyF6mvREd2lMcikqALhxm7DaqOk
	OKfZUQ+nTA6m+uuJh/3F0UjosidgiqNEOlF0uTN1EFcjHPNoJWxH5Cfk
X-Gm-Gg: AfdE7cnzHvyzmqWQ6jt0rarx7xKNX+vm+nhrhaKWtGfPrX7R8nWxr/tpmnAxTavdfaO
	ah+BCq5In8SSoVNa+Lr2Gyo66mAELy9YwrATGUmHzacaPTNw2JX53KiBm2LAioAxcgcLF87oZTi
	R7gIvRdFVggR+GC2crEpID8HnBC6CkOjNjT/YcN2o4LpPGepHP5VlJU/G++6mibpFFfIiuEBp4t
	h2yWmsEzsH/4Wk3QVGeE+e+AhvDCiAnaUXQoGaWXvLXJ/xww1W84P2LyKwyoXCSU/056bXT1bqj
	UzuxRT3Q1wcZtE1KgAxiP6bK8B2XCQl0BiGmPuxdCkR5LeIAy83NvhiHPXD1BFZCWG3VQ6EQUhQ
	pmm1yj6M7LPlKEpXVEuQ1/x3g8slQ9pOdZp2BPADdpq7BADrxX0Qcpy1jpOutfRqmUCQzQw6D61
	SwE6p+VgEC5u6SHvHZBVAukONy2oIZCA==
X-Received: by 2002:a05:600c:1382:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-4953de834e4mr23856825e9.16.1784122599760;
        Wed, 15 Jul 2026 06:36:39 -0700 (PDT)
Received: from [192.168.1.102] ([5.83.201.220])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4950a2ed840sm146975255e9.10.2026.07.15.06.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 06:36:38 -0700 (PDT)
Message-ID: <58361942-9082-4778-a3a6-cd0bc4034644@gmail.com>
Date: Wed, 15 Jul 2026 14:34:50 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] iio: adc: make read-only const array config static
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Dan Carpenter <error27@gmail.com>
Cc: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260714165012.184651-1-colin.i.king@gmail.com>
 <alZs-uLJug_rnRnq@ashevche-desk.local> <aldfaM2aks7qOz2C@stanley.mountain>
 <aleL2gmDZDJRhjVo@ashevche-desk.local>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Content-Language: en-US
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <aleL2gmDZDJRhjVo@ashevche-desk.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------V8QJUFgMs1sbkoZups6Xaocd"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------V8QJUFgMs1sbkoZups6Xaocd
Content-Type: multipart/mixed; boundary="------------Hv2k0aXDZOaE2064KSpMFbh9";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Dan Carpenter <error27@gmail.com>
Cc: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <58361942-9082-4778-a3a6-cd0bc4034644@gmail.com>
Subject: Re: [PATCH][next] iio: adc: make read-only const array config static
References: <20260714165012.184651-1-colin.i.king@gmail.com>
 <alZs-uLJug_rnRnq@ashevche-desk.local> <aldfaM2aks7qOz2C@stanley.mountain>
 <aleL2gmDZDJRhjVo@ashevche-desk.local>
In-Reply-To: <aleL2gmDZDJRhjVo@ashevche-desk.local>

--------------Hv2k0aXDZOaE2064KSpMFbh9
Content-Type: multipart/mixed; boundary="------------ZLVJg4Vx5NkmT45100Nqde0Y"

--------------ZLVJg4Vx5NkmT45100Nqde0Y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUvMDcvMjAyNiAxNDozMiwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBXZWQs
IEp1bCAxNSwgMjAyNiBhdCAwMToyMjozMlBNICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3Rl
Og0KPj4gT24gVHVlLCBKdWwgMTQsIDIwMjYgYXQgMDg6MDg6MTBQTSArMDMwMCwgQW5keSBT
aGV2Y2hlbmtvIHdyb3RlOg0KPj4+IE9uIFR1ZSwgSnVsIDE0LCAyMDI2IGF0IDA1OjUwOjEy
UE0gKzAxMDAsIENvbGluIElhbiBLaW5nIHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPj4+IElu
IGFsbCBwYXRjaGVzIGxpa2UgdGhpcyBpdCdzIGFsd2F5cyBhIGJpa2VzaGVkZGluZyBwb3Nz
aWJsZSBvZiBtb3Zpbmcgc3RhdGljDQo+Pj4gZGF0YSBvdXRzaWRlIG9mIGEgZnVuY3Rpb24u
IEkgaGF2ZSBubyBzdHJvbmcgb3BpbmlvbiBpbiB0aGVzZSBjYXNlcyAod2hlbiB0aGUNCj4+
PiBkYXRhIHNvbGVseSB1c2VkIGJ5IGEgc2luZ2xlIGZ1bmN0aW9uKSwgYnV0IGluIGdlbmVy
YWwgaXQgbWlnaHQgZ2l2ZSBkaWZmZXJlbnQNCj4+PiByZWFkYWJpbGl0eSBleHBlcmllbmNl
IChpdCdzIGhhcmRlciB0byBub3RpY2Ugc3RhdGljIGRhdGEgaW4gdGhlIGxvY2FsIGZ1bmN0
aW9uDQo+Pj4gZGVmaW5pdGlvbiBibG9jaykuIFNvIEkgbGVhdmUgdGhpcyBleGVyY2lzZSB0
byB0aGUgbWFpbnRhaW5lcnMgb2YgdGhlIHJlc3BlY3RpdmUNCj4+PiBwaWVjZXMgb2YgdGhl
IGNvZGUuDQo+Pj4NCj4+DQo+PiBJdCdzIGFuIGludGVyZXN0aW5nIHBvaW50Li4uDQo+Pg0K
Pj4gQXQgb25lIHBvaW50IFNtYXRjaCBkaWRuJ3QgdHJhY2sgc3RhdGljIHZhcmlhYmxlcyBh
bmQgaXQgdXNlZCB0bw0KPj4gZ2VuZXJhdGUgb2NjYXNpb25hbCBmYWxzZSBwb3NpdGl2ZXMu
ICBBbmQgaXQncyBsaWtlIHlvdSBzYXksIHRob3NlDQo+PiBsaXR0bGUgInN0YXRpYyIgcXVh
bGlmaWVycyBhcmUgaGFyZCB0byBzcG90IGluIGEgd2FsbCBvZiBkZWNsYXJhdGlvbg0KPj4g
dGV4dC4gIEkndmUgbmV2ZXIgY29uc2lkZXJlZCBtb3ZpbmcgdGhlIGRlY2xhcmF0aW9ucyBv
dXQgb2YgdGhlDQo+PiBmdW5jdGlvbiBzY29wZSBidXQgaXQgbWlnaHQgYmUgYSBnb29kIGlk
ZWE/DQo+IA0KPiBNYXliZSwgYXMgSSBzYWlkLCBJIGhhdmUgbm8gc3Ryb25nIG9waW5pb24g
aGVyZS4gSSBhbSBhbGwgZWFycyB0byBoZWFyDQo+IHdoYXQgb3RoZXJzIHRoaW5rLg0KDQpG
b3Igc21hbGwgYXJyYXlzIGl0J3MgYSBtb290IHBvaW50IGlmIHRoaXMgdHlwZSBvZiBjaGFu
Z2UgaXMgdXNlZnVsLCBzbw0KSSdtIE9LIGlmIGl0J3Mgbm90IGFjY2VwdGVkLiBJIGFwcHJl
Y2lhdGUgdGhlIGZlZWRiYWNrLg0KDQpDb2xpbg0KDQo+IA0KPj4gQnV0IGluIHRoaXMgY2Fz
ZSBzaW5jZSB0aGlzIGRhdGEgaXMgY29uc3QsIHRoZSBzdGF0aWMgdnMgbm90LXN0YXRpYw0K
Pj4gZG9lc24ndCBhZmZlY3QgZmxvdyBhbmFseXNpcyBvciByZWFkYWJpbGl0eS4NCj4gDQo+
IEl0IGRvZXNuJ3QgYWZmZWN0IGZsb3cgYW5hbHlzaXMsIGJ1dCB3ZSBhbHNvIGhhdmUgRGF2
aWQncyBwb2ludCBhYm91dA0KPiBhbW91bnQgb2YgZGF0YSB0byBiZSBzdGF0aWMgbWF5IGFm
ZmVjdCB0aGUgY29kZSBnZW5lcmF0aW9uLg0KPiANCj4gLi4uDQo+IA0KPiBUaGUgbWFpbiBw
b2ludCBJIGhhdmUgaXMgdGhhdCBzdHVtYmxpbmcgb3ZlciB0aGUgJ3N0YXRpYycgaW4gdGhl
IGRlZmluaXRpb24NCj4gYmxvY2sgbWlnaHQgcmlzZSBzb21lIGFkZGl0aW9uYWwgcXVlc3Rp
b25zIGFuZCBzbG93IGRvd24gdGhlIHVuZGVyc3RhbmRpbmcgb2YNCj4gdGhlIGNvZGUgKGJ5
IHJlYWRpbmcpLg0KPiANCg0K
--------------ZLVJg4Vx5NkmT45100Nqde0Y
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------ZLVJg4Vx5NkmT45100Nqde0Y--

--------------Hv2k0aXDZOaE2064KSpMFbh9--

--------------V8QJUFgMs1sbkoZups6Xaocd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmpXjHsFAwAAAAAACgkQaMKH38aoAiZT
vg//VnQuKfCbz2sw8EbUnNSiSkb48szvzr29yiSGAQLYI1EG6DKyHvIMkSxdJUMioNErcTCkw4oa
+p/5xiekpduvLsmeZKV2js6DgmBFmoRPVksznl4nNJPTm22JOpe4P3J2IL830gb3gdPPF1MebcCs
p/t0qHxTXq18zz1Hsv0ehl6AOmfIGEvhYRmcuyVElMlSeCrI9pv8wSQHqEa6WL/6ISOx8AZO0cuV
BTcQmw3WL3xUagycA9sGm1g6qdg8LUkkR3oJL+kid300JhNVoWLcd30MiEZxzQ5ZaY6GF7/Zz2NB
+HqkGXR1OO4gxAy/LtffrcwRMYgKbs5NrhAtgaQb+joaxKR5zEEU9/x14Ce+nfsU0kJLQcGzsEQH
vWHECK43ea8EayP8A8Zgt8OOgWHiqYA60P1RKVUj4pKwIQ1WThGDzKOAeJ6TYvOz5HyOTbtsvvlK
u8MPBPes8TixrmsNvD2lQSq24A6eJ9bvDBYN/fYygpyq9FdP5CiWrnpgkLC+bHjjwH9j2rgYUps2
oBmHYZ+hVql67JJS1NMXqyg3x60+wiZRnpBYkvPakeeunkItGKGxl2WlTcQr24UTVfr6TddP0opS
zZ8+evCJbAtpORCQaKmqRf12+dB+6gBVhzBTNrxqsleGbg20A+Ib8QME4W1ZXLkGRVbbk7aQP1pI
PZg=
=nD4p
-----END PGP SIGNATURE-----

--------------V8QJUFgMs1sbkoZups6Xaocd--
