Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203C53B9DA5
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281857; cv=none; b=HNZkgP8UpC19g5iCVuwMLKTa12J1JrNyxguyv1WxzMjnkBMsQ2gzp+GT6VdbYheUSjTqYy/KWYYC/REO8Mpp0Uaz3HQkq5FQh56c573VBfASy/BonrDmHQYHYzHOavfZDgC1mmbfN07++0xCHrsxTGYQaidiQ3HEcWuO6lCa4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281857; c=relaxed/simple;
	bh=8ha1A3Upqoft3A/vZsGBrxpfXd8ABWmzhRsBL16vIYU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nmx+xKeyhalnKl+dLTjRnVbCEGU6RnQDNtuxwCJwxl3+eLkJkYOoDNWMLsUTNXL99J7l83bXYBRwUq6+tZcLQLOeOnguYWkwLuo74dRV0TZcWmswFU15E92b0B8impUIR5YAARcuM9QHC4+gyltFvY0F53NP5LiEFSzwbKjYlJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kS+QmkK7; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kS+QmkK7"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b4915161fso2929279f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774281853; x=1774886653; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ha1A3Upqoft3A/vZsGBrxpfXd8ABWmzhRsBL16vIYU=;
        b=kS+QmkK7qwGvF8EIctTG4pvdoWb4tMqENHrQzXCkQyiBiJfhhL9/Y1DW/hOyW1+Wzs
         iinuqwrE9/4Wrk3M+LvkN73bRUMZXFFqKZPlJAPQYTNrBG++GCodqIy0CY83BKGsPbfy
         Id/ojcwcGtSM9Ia0/1ya5/o5lQzIEypIY59uvjm2N7gCi0bcfc9b0ZNAMdbVwFZGHerK
         qOkBtCfNYoZWUrVf6waLJnRwbiE7whghztMqyqlGw6ztW8pxzeKfTmku+ArcysLqdafF
         G0xMLFuWLtR683fiK9Wk3IN9YAkzpSlVjINKfC64EdJI4Usz1hq/vRJK7EQCUpiFCxXh
         XWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281853; x=1774886653;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ha1A3Upqoft3A/vZsGBrxpfXd8ABWmzhRsBL16vIYU=;
        b=VnOfL7ypHlthfWWG5UnlXCVvtS/bEIBxb4WgoRVbF01Q62vFVOebCxdPSwaXJzXiH+
         RMRU3dpFGRLwxkx0dN549bHPh0C27QTilbXeBxRgoo91yCyYXmqTCsfV95zxSAz97fMH
         5UhbczbbftprDiQXC11yzVe5uDUpR2TAbbfTTqFsgdiFPZzOnZJOIEZ4/D0LzQotCLj7
         8LrCfdiMO0zL0Fryj7Jln8s+y1jwWvyoXwViSPffa2M/+xvQe8AZKft7RkaJ06XzubF+
         EXG573rnUSunRHXzNDdajaHCoY+0R2FRl2GQW9JalQ38Hrt+XGRYUoHhYURL+dvQFLoB
         3ojA==
X-Forwarded-Encrypted: i=1; AJvYcCXBolgGewBOaA+hisKvpOjDYq8N1UEDApCkafW368tg4kkpTWn1rwjl8SojdR1DjtzFIlA1FZdvE4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmqRZyTyyWmcH6NLGyQ6Fhu6hTbFctVqHB8P+Cw3kxhyD08G6v
	f52DEzC6x2Ea/Pan98HJ2XjTQtbP17V+V68TrLxQ/KuzF+raWOuhr/bOZkucGD3+jEY=
X-Gm-Gg: ATEYQzxf6dPoRY2qcpgGH2GvkNKQwJqBEtLdoMVitmxr74DH3PhWUqjS8UkMKxayTS1
	Zexp35UAOVXA9u971xO0lgmKCmZcvZjH6+eVUhCWFXojsLlLTQgNbKkvVVYU3jvfigQ26UMINAR
	32mUcIUh7rjvUJ0Cj24XqVJsFAP8TzvbW3BFYAHAyQjcj+fG7qXfeVTu3fJw+YopBXsZul7cJ/W
	EyDFhcmI9gkmrKJ00UTDidE6R2UzuL0+iyFMuizlneRJECJc00M7R5SH3IYZssVbcCtaHu2biGF
	3uxaudZgqPpu8NWgaZfaqLyRfnjWcf15uw2II+mWB3ceqRgvl6RfRfCmoCMMuRjuvfL6RPzC4yA
	lCV+LY2bt8XIst4TuF/VyATyRtFdqnh1PEG/f4CGOCaBhMrkl873Eh3NtEoR2UIW5qniecZu2zl
	uWXbgP
X-Received: by 2002:a05:600c:45c7:b0:485:3fd1:9936 with SMTP id 5b1f17b1804b1-486fede721amr164460475e9.5.1774281853328;
        Mon, 23 Mar 2026 09:04:13 -0700 (PDT)
Received: from [10.76.209.31] ([151.35.182.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe032a55sm555492685e9.7.2026.03.23.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:04:13 -0700 (PDT)
Message-ID: <af2128c68d2a14e1eb664ce9dc075ed02b640407.camel@baylibre.com>
Subject: Re: [PATCH v8 2/6] iio: Replace 'sign' field with union in struct
 iio_scan_type
From: Francesco Lavra <flavra@baylibre.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
  Shuah Khan <skhan@linuxfoundation.org>, Jonathan Cameron
 <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-iio@vger.kernel.org
Date: Mon, 23 Mar 2026 17:04:10 +0100
In-Reply-To: <4723284d-1e18-4a13-9ec1-878220af257e@baylibre.com>
References: <20260317150316.3878107-1-flavra@baylibre.com>
	 <20260317150401.3878294-1-flavra@baylibre.com>
	 <4723284d-1e18-4a13-9ec1-878220af257e@baylibre.com>
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

T24gU2F0LCAyMDI2LTAzLTIxIGF0IDEyOjIyIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOgo+
IE9uIDMvMTcvMjYgMTA6MDQgQU0sIEZyYW5jZXNjbyBMYXZyYSB3cm90ZToKPiA+IFRoaXMgZmll
bGQgaXMgdXNlZCB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gc2lnbmVkIGFuZCB1bnNpZ25lZAo+
ID4gaW50ZWdlcnMuCj4gPiBBIGZvbGxvd2luZyBjb21taXQgd2lsbCBleHRlbmQgaXRzIHVzZSBp
biBvcmRlciB0byBhZGQgc3VwcG9ydCBmb3Igbm9uLQo+ID4gaW50ZWdlciBzY2FuIGVsZW1lbnRz
OyB0aGVyZWZvcmUsIHJlcGxhY2UgaXQgd2l0aCBhIHVuaW9uIHRoYXQgY29udGFpbnMKPiA+IGEK
PiA+IG1vcmUgZ2VuZXJpYyAnZm9ybWF0JyBmaWVsZC4gVGhpcyB1bmlvbiB3aWxsIGJlIGRyb3Bw
ZWQgd2hlbiBhbGwKPiA+IGRyaXZlcnMKPiA+IGFyZSBjaGFuZ2VkIHRvIHVzZSB0aGUgZm9ybWF0
IGZpZWxkLgo+ID4gT3Bwb3J0dW5pc3RpY2FsbHkgcmVwbGFjZSBjaGFyYWN0ZXIgbGl0ZXJhbHMg
d2l0aCBzeW1ib2xpYyBjb25zdGFudHMKPiA+IHRoYXQKPiA+IHJlcHJlc2VudCB0aGUgc2V0IG9m
IGFsbG93ZWQgdmFsdWVzIGZvciB0aGUgZm9ybWF0IGZpZWxkLgo+ID4gCj4gPiBTaWduZWQtb2Zm
LWJ5OiBGcmFuY2VzY28gTGF2cmEgPGZsYXZyYUBiYXlsaWJyZS5jb20+Cj4gPiAtLS0KPiA+IMKg
RG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2lpby9idWZmZXJzLnJzdCB8wqAgNCArKy0tCj4gPiDC
oGluY2x1ZGUvbGludXgvaWlvL2lpby5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDE3ICsrKysrKysrKysrKysrKy0tCj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZHJpdmVyLWFwaS9paW8vYnVmZmVycy5yc3QKPiA+IGIvRG9jdW1lbnRhdGlvbi9kcml2ZXIt
YXBpL2lpby9idWZmZXJzLnJzdAo+ID4gaW5kZXggNjNmMzY0ZTg2MmQxLi5lMTZhYmFmODI2ZmUg
MTAwNjQ0Cj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvaWlvL2J1ZmZlcnMucnN0
Cj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvaWlvL2J1ZmZlcnMucnN0Cj4gPiBA
QCAtNzgsNyArNzgsNyBAQCBmaWVsZHMgaW4gaWlvX2NoYW5fc3BlYyBkZWZpbml0aW9uOjoKPiA+
IMKgwqDCoCAvKiBvdGhlciBtZW1iZXJzICovCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlu
dCBzY2FuX2luZGV4Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB7Cj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNoYXIgc2lnbjsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hhciBmb3JtYXQ7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1OCByZWFsYml0czsKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHU4IHN0b3JhZ2ViaXRzOwo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTggc2hpZnQ7Cj4gPiBAQCAtOTgsNyArOTgs
NyBAQCBmb2xsb3dpbmcgY2hhbm5lbCBkZWZpbml0aW9uOjoKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBvdGhlciBzdHVmZiBoZXJlICovCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnNjYW5faW5kZXggPSAwLAo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5zY2FuX3R5cGUgPSB7Cj4gPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnNpZ24gPSAncycsCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmZv
cm1hdCA9IElJT19TQ0FOX0ZPUk1BVF9TSUdORURfSU5ULAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucmVhbGJpdHMgPSAxMiwKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnN0b3Jh
Z2ViaXRzID0gMTYsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC5zaGlmdCA9IDQsCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9p
aW8vaWlvLmggYi9pbmNsdWRlL2xpbnV4L2lpby9paW8uaAo+ID4gaW5kZXggYTllY2ZmMTkxYmQ5
Li5kNDhhMGFiMDFiOGQgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lpby9paW8uaAo+
ID4gKysrIGIvaW5jbHVkZS9saW51eC9paW8vaWlvLmgKPiA+IEBAIC0xNzYsOSArMTc2LDE5IEBA
IHN0cnVjdCBpaW9fZXZlbnRfc3BlYyB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9u
ZyBtYXNrX3NoYXJlZF9ieV9hbGw7Cj4gPiDCoH07Cj4gPiDCoAo+ID4gKy8qCj4gPiArICogRm9y
bWF0IHZhbHVlcyBpbiBzY2FuIHR5cGUKPiA+ICsgKiBASUlPX1NDQU5fRk9STUFUX1NJR05FRF9J
TlQ6IFNpZ25lZCBpbnRlZ2VyICh0d28ncyBjb21wbGVtZW50KS4KPiA+ICsgKiBASUlPX1NDQU5f
Rk9STUFUX1VOU0lHTkVEX0lOVDogVW5zaWduZWQgaW50ZWdlci4KPiA+ICsgKi8KPiAKPiBXZSBj
b3VsZCBtYWtlIHRoaXMgcHJvcGVyIGtlcm5lbCBkb2MgZm9ybWF0IHdpdGggb25lIGNvbW1lbnQg
cGVyIG1hY3JvLgoKQWN0dWFsbHksIGEgc2V0IG9mIHJlbGF0ZWQgI2RlZmluZXMgY2FuIGJlIGRv
Y3VtZW50ZWQgd2l0aCBhIHNpbmdsZQpjb21tZW50LiBJIHNlZSBhIGZldyBleGFtcGxlcyBkb2lu
ZyB0aGF0IGluIGluY2x1ZGUvbGludXgvZ2ZwX3R5cGVzLmggYW5kCmluY2x1ZGUvbGludXgvZnBn
YS9mcGdhLW1nci5oCgoKPiA+ICsjZGVmaW5lIElJT19TQ0FOX0ZPUk1BVF9TSUdORURfSU5UwqDC
oMKgwqDCoCdzJwo+ID4gKyNkZWZpbmUgSUlPX1NDQU5fRk9STUFUX1VOU0lHTkVEX0lOVMKgwqDC
oCd1Jwo+ID4gKwoK

