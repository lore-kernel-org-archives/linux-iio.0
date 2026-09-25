Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D04AF668;
	Fri, 25 Sep 2026 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346879; cv=none; b=LGNoBauqpwiDY3wm04daxY2rzLp3wN/vupYcXMmFpfFVLoi3Pi+oE/jYGqN9BSFi0jB5JJBXawv4VrkVp3IqWT9ZfnO/deCvSvAcXHwIaIe+LEdfi17KchyMw2RXtg96lruEfyJXb/FdyqF4m0ip1hdTPyP6xpYmYtg1wQutTaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346879; c=relaxed/simple;
	bh=fNFwouyuN5DVd06s5GrpnjN9Pq6bvDaUuCGbqo9Qduw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=kpIOK0BH4MnzdcFytqsO62xNt5mzAv/W9raneKYEqoXHlziy8fnsDeyBqDiMKZLKn/T22XMkPoEVR5Fmwg3vS+J3TkTemcrnahNa0nZ6KtzxVmsAwMr36hSFBGW0cdpwGkx8Sg2N8iByAJSzRQDAF5N40NPrtZgqtRx8+NWiqow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V1pnkyCU; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V1pnkyCU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=fNFwouyuN5DVd06s5GrpnjN9Pq6bvDaUuCGbqo9Qduw=; b=V
	1pnkyCUjcLnwTy+gi3oUTs2c2HPmKOTHR8kJ/zQ+sXatnfgvKMRC2bVSLtrAIzOw
	jDzK56wF1dOtASEmRexj6EaEcuqEJSK/iYPow8u5XnmdPgrbNvUMZq7YKKOeGbhn
	qL6YVwLYYyJrS7d7aMgAQvbXV69J/Qo5HRbW/V+YFo=
Date: Fri, 25 Sep 2026 22:33:48 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,
	"David Lechner" <dlechner@baylibre.com>,
	=?GBK?Q?Nuno_S=A8=A2?= <nuno.sa@analog.com>,
	"Andy Shevchenko" <andy@kernel.org>,
	"Stepan Ionichev" <sozdayvek@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] iio: gyro: bmg160: reject duplicate event disable
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <araCndRmAqnX1K9k@ashevche-desk.local>
References: <20260925140956.2254877-1-yaojiale02@163.com>
 <araCndRmAqnX1K9k@ashevche-desk.local>
X-NTES-SC: AL_Qu2SAv+fuUAp7iSfY+kcn08ShO49XMOyvfoi2YFTc+AEpw/V5gsNWXNaI3v47dizETqAszmbVQhh4+98RrJ6knnKkoYHKaK1gJr9ayXbiQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6b2f4eef.1cf6.1a0d8fc9ac6.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aygvCgDXv4dNhrZqQMVOAA--.47007W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzg38N2q2hk0R-gAA3w
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wOS0yNSAyMjoxODowNSwgIkFuZHkgU2hldmNoZW5rbyIgPGFuZHJpeS5zaGV2Y2hl
bmtvQGludGVsLmNvbT4gd3JvdGU6Cj5PbiBGcmksIFNlcCAyNSwgMjAyNiBhdCAxMDowOTo1NFBN
ICswODAwLCBKaWFsZSBZYW8gd3JvdGU6Cj4+IFRoZSBJSU8gY29yZSBkb2VzIG5vdCBmaWx0ZXIg
ZHVwbGljYXRlIHdyaXRlcyB0byB0aGUgZXZlbnQgZW5hYmxlCj4+IGF0dHJpYnV0ZS4KPgo+Q2Fu
IGl0IGJlIGRvbmUgdGhlcmUgb25jZSBmb3IgYWxsPwoKSSBkb24ndCB0aGluayB0aGUgY29yZSBj
YW4gc2FmZWx5IGRvIHRoaXMgZ2VuZXJpY2FsbHksIHNpbmNlIGl0IGRvZXNuJ3Qgb3duCnRoZSBw
ZXItZXZlbnQgc3RhdGUgYW5kIHJlYWRfZXZlbnRfY29uZmlnKCkgbWF5IHJlZmxlY3Qgc2hhcmVk
IGhhcmR3YXJlIHN0YXRlLgoKVGhlIHJ1bnRpbWUgUE0gYWNjb3VudGluZyBpcyBkcml2ZXItc3Bl
Y2lmaWMsIHNvIGhhbmRsaW5nIGR1cGxpY2F0ZSB3cml0ZXMgaW4KdGhlIGRyaXZlciBzZWVtcyBz
YWZlci4gZ3AyYXAwMDIgZG9lcyB0aGUgc2FtZSBpbiBjb21taXQgNTc5YzA0OWI0Y2I2LApyZWZl
ciBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA3MjAxOTM5MTEuNzQ5MTktMi1uaWto
aWxndHJAZ21haWwuY29tLwoKPgo+PiBibWcxNjBfd3JpdGVfZXZlbnRfY29uZmlnKCkgYWxyZWFk
eSBpZ25vcmVzIHJlcGVhdGVkIGVuYWJsZQo+PiByZXF1ZXN0cywgYnV0IGEgcmVwZWF0ZWQgZGlz
YWJsZSByZXF1ZXN0IHN0aWxsIGNhbGxzCj4+IGJtZzE2MF9zZXRfcG93ZXJfc3RhdGUoZGF0YSwg
ZmFsc2UpLCBkcm9wcGluZyBhIHJ1bnRpbWUgUE0gcmVmZXJlbmNlCj4+IHRoYXQgd2FzIG5vdCBh
Y3F1aXJlZCBmb3IgdGhpcyByZXF1ZXN0LiBUaGlzIGNhbiB1bmRlcmZsb3cgdGhlIHJ1bnRpbWUK
Pj4gUE0gdXNhZ2UgY291bnQgYW5kIHRyaWdnZXIgYSAiUnVudGltZSBQTSB1c2FnZSBjb3VudCB1
bmRlcmZsb3ciIHdhcm5pbmcuCj4+IAo+PiBSZXR1cm4gZWFybHkgd2hlbiB0aGUgcmVxdWVzdGVk
IHN0YXRlIGFscmVhZHkgbWF0Y2hlcyBldl9lbmFibGVfc3RhdGUuCj4KPi0tIAo+V2l0aCBCZXN0
IFJlZ2FyZHMsCj5BbmR5IFNoZXZjaGVua28KPgo=
