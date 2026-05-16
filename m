Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0872F7EEA
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778967561; cv=none; b=Ofv2lx5RTHnzGOdpkQS8jSv6y46MUBD1XZRxMNqBnz5lXqoFegb0oAACx0lCBDaKB66UVEw2Yuh9wC5RFKrRCYyrF7Nj9tAaaB2BPdJ1gmzXHjgAw+7o9/DymDOEmd06zQBa1P3m1rcqw//xzwCepBxqj6nV/jG23EeMsKITOaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778967561; c=relaxed/simple;
	bh=F5L2BjlPr/7mAEq89skRFFgFrAn8VGedWsV2emdfjtg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=KYz8fzP0E/0fD+Eb312NqfVaz1TBc1QRSImiaXpowWFUyAlrNHboeul9WUPdUWwhgrR8pSQGBwo3TUbs0Ae0JVAtK/0Sd+yKEG3ka8Op1H4YbFwfFcuWKo181QjFbkiPT6bQWN8tLLyw0Z1rF+0g2F5NfA+IYQHieSRl0bNp+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBeIbF8y; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBeIbF8y"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-394413a63d3so10609551fa.1
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 14:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778967558; x=1779572358; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5L2BjlPr/7mAEq89skRFFgFrAn8VGedWsV2emdfjtg=;
        b=mBeIbF8yaInD25qC1mm7qbAyLSvS7jGWK5B/cZlAdYlDvqzj6gzm5Mw/5PXT5V2cEx
         +wQch4B5zSGuJD5eeU/xkkhcGvOjl12ct1lUacUxpHvvjIsr0rPf3LBUUlpEzRPsIDKE
         wUwIUi+4akSWQqL+VN/AXS7lPsWvtEbefdfePnYE39ErDFmrW3Pc6dl1Z4mwGjOA71Wy
         96Q8dFaC9HRlUUHVi94fezV4WNT0elffC2zg0YzBxoFU2BPeCkP1iTyXsWv+OHmFZwz4
         n/1q6LjzYy1aJBea8fCgDuw73W6LR8kw/z1L4OxLC7DeSziBU+dkcaGPgDy5OdoO35BD
         edxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778967558; x=1779572358;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5L2BjlPr/7mAEq89skRFFgFrAn8VGedWsV2emdfjtg=;
        b=fQneUZQcaIDhJlEaEryUdWfEjaO0hPMNCl58jzuRWFPPnniwLvimTGHdr+w+ihxfy5
         XvdJAYnxoioES7YnnfMR9B3dee6wEAAHW71cFXjzXqDwyRKEFd33q6aj6gz/skGSDjb6
         GUnE2U/ie2ZvTMiho/s5GEIktWqMAwYtMkDPXRSaqhbkEcGuyO/W0uSfWKPlvcH7B1Ih
         rC+nDAnoLMQLCba/U/AWsyWSrY6x2fFmtduiT+r5iKTL9P06OWc3ALgqlhhLCTwrpj7V
         OJrbrPSF7h/DUUltSjVi9m9ZnfFU8vExcZJhys4NYlB47c2MO8JJiveioid+xEp0mbY4
         7ucg==
X-Gm-Message-State: AOJu0YzVKULz7tU4vv4nB1y7DebISSx0XhUE690VmrZ4psm1bXAN26DF
	4BCa53jEsWPzeFQyzy4xrCuUzKfv00VNA7R9oW0tOj4h/F33rHxqmskb
X-Gm-Gg: Acq92OEiLPNf20pvzjNtZNVXtSA42OJvLEIolZmECHyZ3flbOotVpbAjgJJrTWyddcI
	5JjYDDTkxmmLAzPfwHxBvY4aY7VcvlAaUWIUZU1YByZ94inU06U+rjzM/v8oD6R/JsJEx5fAs4b
	zBaan0BMalvvdII+YvIg72QBPvysVusST1xDBp+SO55tYBI5oYPFY+T2C3FO0krtDwwIf9HV/jc
	l3rz0U/5MZG7xeo1xwksAkvATvpFpz8uFXMlZxLsTL10LCVDZT4kWnNsOkXa8jDiltwTqtwmsqC
	EZc0k2qM+UtexKEmmX4c8bSRdbkP/GhrzKvikSDmkFfDi1vJ9B5pyxsMf5mRnYJP7W3kiLwCz/9
	qOZyPaQZI64Y+NkCEz2zESA0nEB58ZWjPkPX1Gg1PTjhmGhSkcnz0hPzEwYhMiS0n8j9ixiy4U7
	SnA5guOQVQGWOeLq2MYlak7Ak3t379HfKvGtBJrDqdVEDIhCrd/md3tbkDLeJ5W+YU/Q==
X-Received: by 2002:a05:6512:15a2:b0:5a4:1918:20e with SMTP id 2adb3069b0e04-5aa0e741f89mr2632922e87.30.1778967557776;
        Sat, 16 May 2026 14:39:17 -0700 (PDT)
Received: from Shofiq.localdomain (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164cf0a5sm2201586e87.75.2026.05.16.14.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 14:39:16 -0700 (PDT)
Message-ID: <6a08e404.9cb0d8e3.2c93a2.545b@mx.google.com>
Date: Sat, 16 May 2026 14:39:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: health: max30102: Add timestamp to FIFO data
In-Reply-To: <20260515160434.7749e240@jic23-huawei>
References: <20260514200309.1597-1-shofiqtest@gmail.com>
 <20260515160434.7749e240@jic23-huawei>

T24gRnJpLCAxNSBNYXkgMjAyNiAxNjowNDozNCArMDEwMApKb25hdGhhbiBDYW1lcm9uIDxqaWMy
M0BrZXJuZWwub3JnPiB3cm90ZToKCj4gR2VuZXJhbGx5IGRvbid0IGFkZCBmZWF0dXJlcyB0byBh
IGRyaXZlciB5b3UgYXJlbid0IHVzaW5nIC0gdGhleQo+IGVuZCB1cCBhcyBkZWFkIGNvZGUuCgpV
bmRlcnN0b29kLiBEcm9wcGluZyB0aGlzIHBhdGNoLiBUaGUgc2Nhbl9pbmRleCA9IC0xIGRlc2ln
biBhbmQgdGhlCnBlci1zYW1wbGUgdGltZXN0YW1wIHByb2JsZW0gYm90aCBtYWtlIHRoaXMgYSBu
b24tc3RhcnRlciB3aXRob3V0IGEKbXVjaCBtb3JlIHN1YnN0YW50aWFsIHJld29yay4KClRoYW5r
IHlvdSBmb3IgdGhlIHJldmlldy4KCk1kIFNob2ZpcXVsIElzbGFt

