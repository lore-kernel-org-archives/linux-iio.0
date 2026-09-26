Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A368357CFB;
	Sat, 26 Sep 2026 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790405364; cv=none; b=S+dKc1VLpdU2lzyQ7afA2RMxbmt7kTeLDg+gev3qztunMlglrwHWR9Fzh5YYH4n/aanfn/bSiXjd/kabRXT3B8i279l9F1s36yxB4uCy0383x8goBgxmR5uYiY4xlJa14LWYgwK0qJ22DtRdUDFIuKtpHr1xRyP0AmSERTIJZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790405364; c=relaxed/simple;
	bh=3xHeHLyB416TpcO5aC4VBUsaX8fGmelwZ7v0vm88kNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=GzUGgAKEl/x3f0qPrVx/hjfhLPoFCO4F7x6PtofgssCyF9H/iEsOTfUlhp3FS9uVrBo7zhsBsYtPhxWeaJskQXpVHVxwEu9aQlhVwhnUvNCtgxqUcoXDI/7s3IFyUw4GrXyMzd3k3PD8BQqkPJFFPXcRcU9heQ/x2Z0H7NUybTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cTB+3aj8; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cTB+3aj8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=3xHeHLyB416TpcO5aC4VBUsaX8fGmelwZ7v0vm88kNE=; b=c
	TB+3aj8vLDoGqgPcQDiIWUgFgaMi2+T2zv6SmXYmOhU7JBxHsgu3bd1TmZsx0RVe
	Oxq81cJqS9FDfFDNj6ehX7KjnQl1H3ZGgyH2UxvuXBLpRORh7OjblhYLIuNPC7Vh
	s9+gBf/o4Zk0uD9+tvKD5AsAm8HjXJS/5vWt62ai/s=
Date: Sat, 26 Sep 2026 14:48:27 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>,
	"David Lechner" <dlechner@baylibre.com>,
	=?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	"Andy Shevchenko" <andy@kernel.org>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
	"Matti Vaittinen" <mazziesaccount@gmail.com>,
	"Danilo Krummrich" <dakr@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] iio: accel: kxcjk-1013: reject duplicate event
 disable
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260926014942.0af1a16e@jic23-hlaptop>
References: <20260925140945.2254656-1-yaojiale02@163.com>
 <araCbz928KEnAamY@ashevche-desk.local>
 <21e57d3a.1d0c.1a0d9008daa.Coremail.19888972804@163.com>
 <20260926014942.0af1a16e@jic23-hlaptop>
X-NTES-SC: AL_Qu2SAvibuksr4SKRZekdmE8Uges8WcC0svki1YJUc+sEpQzi3S4KQkN9B33x2/CwNjyeszGbWRNMz89fb690F9sid/HB1vRfWGIRhR9Afw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7fec18d8.e8d.1a0dc78eba2.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZCgvCgD3Z0K7ardqSwhPAA--.47816W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRtRi2q3art5lAAA3t
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wOS0yNiAwODo0OTo0MiwgIkpvbmF0aGFuIENhbWVyb24iIDxqaWMyM0BrZXJuZWwu
b3JnPiB3cm90ZToKPk9uIEZyaSwgMjUgU2VwIDIwMjYgMjI6Mzg6MDcgKzA4MDAgKENTVCkKPiJq
aWFsZSB5YW8iIDwxOTg4ODk3MjgwNEAxNjMuY29tPiB3cm90ZToKPgo+PiBBdCAyMDI2LTA5LTI1
IDIyOjE3OjE5LCAiQW5keSBTaGV2Y2hlbmtvIiA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29t
PiB3cm90ZToKPj4gPk9uIEZyaSwgU2VwIDI1LCAyMDI2IGF0IDEwOjA5OjQzUE0gKzA4MDAsIEpp
YWxlIFlhbyB3cm90ZTogIAo+PiA+PiBUaGUgSUlPIGNvcmUgZG9lcyBub3QgZmlsdGVyIGR1cGxp
Y2F0ZSB3cml0ZXMgdG8gdGhlIGV2ZW50IGVuYWJsZQo+PiA+PiBhdHRyaWJ1dGUuIGt4Y2prMTAx
M193cml0ZV9ldmVudF9jb25maWcoKSBhbHJlYWR5IGlnbm9yZXMgcmVwZWF0ZWQKPj4gPj4gZW5h
YmxlIHJlcXVlc3RzLCBidXQgYSByZXBlYXRlZCBkaXNhYmxlIHJlcXVlc3Qgc3RpbGwgY2FsbHMK
Pj4gPj4ga3hjamsxMDEzX3NldF9wb3dlcl9zdGF0ZShkYXRhLCBmYWxzZSksIGRyb3BwaW5nIGEg
cnVudGltZSBQTSByZWZlcmVuY2UKPj4gPj4gdGhhdCB3YXMgbm90IGFjcXVpcmVkIGZvciB0aGlz
IHJlcXVlc3QuIFRoaXMgY2FuIHVuZGVyZmxvdyB0aGUgcnVudGltZQo+PiA+PiBQTSB1c2FnZSBj
b3VudCBhbmQgdHJpZ2dlciBhICJSdW50aW1lIFBNIHVzYWdlIGNvdW50IHVuZGVyZmxvdyIgd2Fy
bmluZy4KPj4gPj4gCj4+ID4+IFJldHVybiBlYXJseSB3aGVuIHRoZSByZXF1ZXN0ZWQgc3RhdGUg
YWxyZWFkeSBtYXRjaGVzIGV2X2VuYWJsZV9zdGF0ZS4gIAo+PiA+Cj4+ID5Tb3VuZHMgbGlrZSBh
IGJ1ZyB0aGF0IG5lZWRzIHRvIGJlIGZpeGVkIGFuZCBoZW5jZSBGaXhlcyB0YWcgdG8gYmUgYXBw
bGllZC4gIAo+PiBTdXJlLCBJJ2xsIGFkZCB0aGUgRml4ZXMgdGFnIGluIHYyLCAyNGggbGF0ZXIs
ICBmb3IgYW55IG90aGVyIGNvbW1lbnRzIGJlZm9yZSBzZW5kaW5nIGl0Lgo+Rm9yIGEgc2ltcGxl
IHJlcXVlc3QgZm9yIGEgZml4ZXMgdGFnLCBJJ20gYWxzbyBmaW5lIHdpdGggeW91IGp1c3QKPnJl
cGx5aW5nIHdpdGggdGhhdCB0YWcuICBiNCB3aWxsIHBpY2sgaXQgdXAgKHRob3VnaCB0ZWNobmlj
YWxseSBpbiB0aGUKPndyb25nIHBsYWNlIHNvIEknbGwgbWFzc2FnZSB0aGluZ3Mgd2hpbHN0IGFw
cGx5aW5nKQpUaGFua3MuCkZpeGVzOiBiNGI0OTFjMDgzMmUgKCJpaW86IGFjY2VsOiBreGNqay0x
MDEzOiBTdXBwb3J0IHRocmVzaG9sZHMiKQo+Cj5GaXggbG9va3MgZ29vZCB0byBtZS4KPgo+Sm9u
YXRoYW4KPgo+PiA+Cj4+ID4tLSAKPj4gPldpdGggQmVzdCBSZWdhcmRzLAo+PiA+QW5keSBTaGV2
Y2hlbmtvCj4+ID4gIAo=
