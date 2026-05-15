Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860BB406285
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834325; cv=none; b=kQRkL7pFC0lMBMKJjUKKhTcKPB/2u7qROQpYCj2hwiPJ88XPhLt4SoKS9eXR0GPOJY9rb1F9bXXAJUSS00afU2zOQwD5Kj1gTThRgiLVgk3Y+2upLotUUxMhUIi+vcAmHQCza/e/cSLE/q/q6UJ4AUnsryAhtxMQ0LuLtZLdGF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834325; c=relaxed/simple;
	bh=wHVFFQuni1Bmyv0ukBm6GFOTLEKyn7Fu5Rzb+RhpfdE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MdITM+LMqtjlL7pF0cROGT4dFYp88TNkTMxyCLuGR45aBMWwW5cq8oyegMlMdyqST0GlvR37YrM2z89ydgy80fsyOO5XSsWIQvT+C9rGz+W4Vz19f3X34RnwsPma8y6pYIfi1La+8UZY7mo/XFySARnCBT6A9NAhddYmK0LWn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=XnCH9tEi; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="XnCH9tEi"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67c4aaf76ecso3392118a12.3
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778834323; x=1779439123; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHVFFQuni1Bmyv0ukBm6GFOTLEKyn7Fu5Rzb+RhpfdE=;
        b=XnCH9tEibCB4OFRxMSKUdoxKHAzecRpRT5QmOd8qRNroqODThNy2TEYpN+YeaSQ40N
         WBZYpKZpfu/BMY/dmkD/rgUYfU71l58GY60aisMYvx/HRJREm3AuOx+D3yHTLHh9TgCv
         ZmgdbgoJeR+raqzSD83jl74YNhR0b44fjZfWNWDnM1BGZcmn7PUMOeSqDC11rVFC4AWD
         yyJYrZVy8OW4RBYYWC43SByiH3dFUgGSWGanX2mJdrT3i10Dwfc0UCsNU7YKxcZSnMdU
         0J7Xurz5baTJEf7EVw45hZ/qViUXmFPd61YBoFViApK/OS9pqwUmKiFdvNt4k0dWMjQu
         T+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834323; x=1779439123;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHVFFQuni1Bmyv0ukBm6GFOTLEKyn7Fu5Rzb+RhpfdE=;
        b=bTaxJMlU0hwtAnNh/cPzDsDF3hc2s+I1SpGTwKc2KLof/aNV+WyT5WEnzDL6Wy4f5O
         KGzXCjDbA/Sp82nzZzbVJaX0VJwi1ED94Ic/HfczYqd/gAG2fWamGwoiTCQqmnHyshcx
         7cU15typkH/zbMRtQ1t8IguPmT62Y5eheJsBScTapzEmtA1/+SsS2en1ab3bXE+4yuED
         V/Rtuahj+AZ3K0bvX9zNKxj3xfCQ2kPHnHWeNqOmod8IBZD9r5mgL15IiM+Q5WTLtskP
         HlS5494zKprs0FlDqQG6E0IY+okynUP+x/Bb6a/lyRIVc7lc7rl7Ex95nZsds5ZjS79M
         NQ2g==
X-Forwarded-Encrypted: i=1; AFNElJ/YAONgN1mXicUXKCT/hQien8S6XFYkZ+vvYXHYCpFN21zfGTj9tourslAIuR/GSOwHqCGsgelghQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjRPrZJrbACQB95FVuWQcUI/6Fenm99W9gH7exBmtya4hWk8W
	ogJ9E0XWQfzi4OlNUK83B4UEPHm/Zjg59WErmoSmll2/MqUFFoz7g6q/kdgBet5ipm4=
X-Gm-Gg: Acq92OEtGONITCoJf0qfggpbjIwk/0NbsnyzjDDpO8xD+2ivXBUmvdGuL1Wxk/vFaLL
	EaVIbqvjyiqHcp3m96cnV7fLCdo1S5zBc+MZeRxlsjmF0jhxxdtsHOOwxHMiF+DEM0M1K3EEBb3
	eWJwAcYskQUoVvcYZIccIqeYwxgPY+8WiU/BA7xDG+ktDjeU8ag6rRulDjxERuTF9VUXF2mHSOj
	kt1+rnIeey8ZbB1ddqZbD8fTYvIm+6VzbVv1YET2u8n4w/jLpuGViKuMP2YwfErSezdHfm2zYC2
	KxTsecGPbrDUuoS5zctPRWllxg9MjYfNUnO3nxBG5nXkSTgsQgKR1Rg6ApCJUMmBq/IvX7ssl2r
	xaidB0XULM89QsDqAc8Ey831gjwNmDNqwOisAYUDhPBAtNsJLMwC/iApawwKEkl+SkaIkDtaq7t
	sy/mgD
X-Received: by 2002:a17:906:f5a1:b0:bd5:7c3:ac9f with SMTP id a640c23a62f3a-bd517aa8204mr143148766b.47.1778834322928;
        Fri, 15 May 2026 01:38:42 -0700 (PDT)
Received: from [10.169.209.7] ([151.19.40.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c23feasm196932266b.14.2026.05.15.01.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:38:42 -0700 (PDT)
Message-ID: <fe013c5a2a1e62a9d1085a4ed16cfb08837a313a.camel@baylibre.com>
Subject: Re: [PATCH v2 7/7] iio: temperature: ltc2983: Add support for
 ADT7604
From: Francesco Lavra <flavra@baylibre.com>
To: Liviu Stan <liviu.stan@analog.com>, Jonathan Cameron <jic23@kernel.org>,
  David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com,  devicetree@vger.kernel.org
Date: Fri, 15 May 2026 10:38:40 +0200
In-Reply-To: <20260514144712.64374-8-liviu.stan@analog.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
	 <20260514144712.64374-8-liviu.stan@analog.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI2LTA1LTE0IGF0IDE3OjQ2ICswMzAwLCBMaXZpdSBTdGFuIHdyb3RlOgo+IEBA
IC0xMjY5LDYgKzE1NzksMTYgQEAgc3RhdGljIGludCBsdGMyOTgzX3JlYWRfcmF3KHN0cnVjdCBp
aW9fZGV2Cj4gKmluZGlvX2RldiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAvKiAyXjIxICovCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgKnZhbDIgPSAyMDk3MTUyOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBJSU9fVkFMX0ZSQUNUSU9OQUw7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhc2UgSUlPX1JFU0lTVEFOQ0U6Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiB2YWx1ZSBpbiBv
aG0sIDEwIGZyYWN0aW9uYWwgYml0czogZGl2aWRlIGJ5Cj4gMl4xMCAqLwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKnZhbCA9IDE7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqdmFsMiA9IDEwMjQ7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gSUlPX1ZB
TF9GUkFDVElPTkFMOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjYXNlIElJT19D
T1ZFUkFHRV9QRVJDRU5UOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLyogdmFsdWUgaW4gcGVyY2VudCwgMTAgZnJhY3Rpb25hbCBiaXRzOiBkaXZpZGUK
PiBieSAyXjEwICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAqdmFsID0gMTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCp2YWwyID0gMTAyNDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiBJSU9fVkFMX0ZSQUNUSU9OQUw7CgpUaGUgYWJvdmUgdHdvIGJy
YW5jaGVzIGFyZSBpZGVudGljYWwsIHlvdSBtaWdodCB3YW50IHRvIGp1c3Qgc3RhY2sgdGhlaXIK
bGFiZWxzLgoKCj4gQEAgLTE2NTgsMjUgKzIwMTgsMzQgQEAgc3RhdGljIERFRklORV9TSU1QTEVf
REVWX1BNX09QUyhsdGMyOTgzX3BtX29wcywKPiBsdGMyOTgzX3N1c3BlbmQsCj4gwqBzdGF0aWMg
Y29uc3Qgc3RydWN0IGx0YzI5ODNfY2hpcF9pbmZvIGx0YzI5ODNfY2hpcF9pbmZvX2RhdGEgPSB7
Cj4gwqDCoMKgwqDCoMKgwqDCoC5uYW1lID0gImx0YzI5ODMiLAo+IMKgwqDCoMKgwqDCoMKgwqAu
bWF4X2NoYW5uZWxzX25yID0gMjAsCj4gK8KgwqDCoMKgwqDCoMKgLnN1cHBvcnRlZF9zZW5zb3Jz
ID0gTFRDMjk4M19DT01NT05fU0VOU09SUywKPiDCoH07Cj4gwqAKPiDCoHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbHRjMjk4M19jaGlwX2luZm8gbHRjMjk4NF9jaGlwX2luZm9fZGF0YSA9IHsKPiDCoMKg
wqDCoMKgwqDCoMKgLm5hbWUgPSAibHRjMjk4NCIsCj4gwqDCoMKgwqDCoMKgwqDCoC5tYXhfY2hh
bm5lbHNfbnIgPSAyMCwKPiArwqDCoMKgwqDCoMKgwqAuc3VwcG9ydGVkX3NlbnNvcnMgPSBMVEMy
OTgzX0NPTU1PTl9TRU5TT1JTLAo+IMKgwqDCoMKgwqDCoMKgwqAuaGFzX2VlcHJvbSA9IHRydWUs
Cj4gwqB9Owo+IMKgCj4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IGx0YzI5ODNfY2hpcF9pbmZvIGx0
YzI5ODZfY2hpcF9pbmZvX2RhdGEgPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoC5uYW1lID0gImx0YzI5
ODYiLAo+IMKgwqDCoMKgwqDCoMKgwqAubWF4X2NoYW5uZWxzX25yID0gMTAsCj4gLcKgwqDCoMKg
wqDCoMKgLmhhc190ZW1wID0gdHJ1ZSwKPiArwqDCoMKgwqDCoMKgwqAuc3VwcG9ydGVkX3NlbnNv
cnMgPSBMVEMyOTgzX0NPTU1PTl9TRU5TT1JTIHwKPiBCSVRfVUxMKExUQzI5ODNfU0VOU09SX0FD
VElWRV9URU1QKSwKPiDCoMKgwqDCoMKgwqDCoMKgLmhhc19lZXByb20gPSB0cnVlLAo+IMKgfTsK
PiDCoAo+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBsdGMyOTgzX2NoaXBfaW5mbyBsdG0yOTg1X2No
aXBfaW5mb19kYXRhID0gewo+IMKgwqDCoMKgwqDCoMKgwqAubmFtZSA9ICJsdG0yOTg1IiwKPiDC
oMKgwqDCoMKgwqDCoMKgLm1heF9jaGFubmVsc19uciA9IDEwLAo+IC3CoMKgwqDCoMKgwqDCoC5o
YXNfdGVtcCA9IHRydWUsCj4gK8KgwqDCoMKgwqDCoMKgLnN1cHBvcnRlZF9zZW5zb3JzID0gTFRD
Mjk4M19DT01NT05fU0VOU09SUyB8Cj4gQklUX1VMTChMVEMyOTgzX1NFTlNPUl9BQ1RJVkVfVEVN
UCksCj4gK8KgwqDCoMKgwqDCoMKgLmhhc19lZXByb20gPSB0cnVlLAoKWW91IGFsbW9zdCBjZXJ0
YWlubHkgZGlkbid0IG1lYW4gdG8gYWRkIHRoaXMgbGluZS4K

