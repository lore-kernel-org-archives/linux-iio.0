Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB07478842;
	Mon, 28 Sep 2026 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584265; cv=none; b=On33tL4EJ+7aiDiwa25S4P4I5GUseYuFhlS+cIfLlpvZC8KmvcmNzNSYqwb6jrIkCb486mNC4TZvJxW1WJPDERfbzcE4vpMuaf31B1Q7CZPnz32GEEdgNPF10ss4ciDp5jiezHT2mvdr0YDfbxGtMFGGOvguze1rBUGTAhHqU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584265; c=relaxed/simple;
	bh=C/TzPf/qbsxjybdQpJhCXH/4GQXEgN8uIr2/1O5Kl/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=EuIA4kO2ODEiYCySbYsDjjbxuwmYlFqegkFUdEly4mSS7SRbIhHsjmJSWvL0dPlwyb1vM5sx3GOhpSbrXM5lxz/JDfSQIgNPaWwjeOwcCh/ZD5UAdDReHfZzZJmLHtEc2G/DJNhYc8DUE3sDIdjQkr5zQ1+VtHWFTEr6SrDppYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B5MuTM7K; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B5MuTM7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=C/TzPf/qbsxjybdQpJhCXH/4GQXEgN8uIr2/1O5Kl/Y=; b=B
	5MuTM7KRoTauYLOG845zIh2GZpAPrN2wk+o/oNCMpHbqRxQRof/L1kFnlEas0aQe
	XBv1AkEjxyxrOUkto/ekSgrF+MCGxSmPz6zdornpEeEpgQM4nsPWHVskMbv59GAY
	koXqFK+oIZsbyv6axBKS4r99j9OSBAOIN/IymMeprw=
Date: Mon, 28 Sep 2026 16:30:02 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>,
	"David Lechner" <dlechner@baylibre.com>,
	=?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	"Andy Shevchenko" <andy@kernel.org>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
	"Takashi Sakamoto" <o-takashi@sakamocchi.jp>,
	"Siratul Islam" <email@sirat.me>,
	"Maxwell Doose" <maxwell@maxwelld.cc>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] iio: imu: kmx61: reject duplicate event disable
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260927182031.6d490331@jic23-hlaptop>
References: <20260925141006.2255067-1-yaojiale02@163.com>
 <araCxIGnZK0zuUSS@ashevche-desk.local>
 <20260927182031.6d490331@jic23-hlaptop>
X-NTES-SC: AL_Qu2SAvmTu0or5CaaZOkcn08ShO49XMOyvfoi2YFTc+gGmTzU3j0if1JyFELowOyzNySDujGrVSdF5ct2e7h6clEtY5e7xIvwOXm4AgBdQg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1024d805.7930.1a0e722a587.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iCgvCgDHZziKJbpq9Y5PAA--.50958W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQq07mq6JYoxxQAA3W
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wOS0yOCAwMToyMDozMSwgIkpvbmF0aGFuIENhbWVyb24iIDxqaWMyM0BrZXJuZWwu
b3JnPiB3cm90ZToKPk9uIEZyaSwgMjUgU2VwIDIwMjYgMTc6MTg6NDQgKzAzMDAKPkFuZHkgU2hl
dmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPiB3cm90ZToKPgo+PiBPbiBGcmks
IFNlcCAyNSwgMjAyNiBhdCAxMDoxMDowNVBNICswODAwLCBKaWFsZSBZYW8gd3JvdGU6Cj4+ID4g
VGhlIElJTyBjb3JlIGRvZXMgbm90IGZpbHRlciBkdXBsaWNhdGUgd3JpdGVzIHRvIHRoZSBldmVu
dCBlbmFibGUKPj4gPiBhdHRyaWJ1dGUuIGtteDYxX3dyaXRlX2V2ZW50X2NvbmZpZygpIGFscmVh
ZHkgaWdub3JlcyByZXBlYXRlZCBlbmFibGUKPj4gPiByZXF1ZXN0cywgYnV0IGEgcmVwZWF0ZWQg
ZGlzYWJsZSByZXF1ZXN0IHN0aWxsIGNhbGxzCj4+ID4ga214NjFfc2V0X3Bvd2VyX3N0YXRlKGRh
dGEsIGZhbHNlLCBLTVg2MV9BQ0MpLCBkcm9wcGluZyBhIHJ1bnRpbWUgUE0KPj4gPiByZWZlcmVu
Y2UgdGhhdCB3YXMgbm90IGFjcXVpcmVkIGZvciB0aGlzIHJlcXVlc3QuIFRoaXMgY2FuIHVuZGVy
ZmxvdyB0aGUKPj4gPiBydW50aW1lIFBNIHVzYWdlIGNvdW50IGFuZCB0cmlnZ2VyIGEgIlJ1bnRp
bWUgUE0gdXNhZ2UgY291bnQgdW5kZXJmbG93Igo+PiA+IHdhcm5pbmcuCj4+ID4gCj4+ID4gUmV0
dXJuIGVhcmx5IHdoZW4gdGhlIHJlcXVlc3RlZCBzdGF0ZSBhbHJlYWR5IG1hdGNoZXMgZXZfZW5h
YmxlX3N0YXRlLiAgCj4+IAo+PiBTYW1lIGNvbW1lbnRzIGFzIHBlciBwcmV2aW91cyBwYXRjaGVz
IG9mIHRoZSBzYW1lIHRvcGljLgo+PiAKPkZpeGVzIHRhZyBuZWVkZWQuCgpGaXhlczogZmQzYWU3
YTlmMjFjICgiaWlvOiBpbXU6IGtteDYxOiBBZGQgc3VwcG9ydCBmb3IgYW55IG1vdGlvbiB0cmln
Z2VyIikK
