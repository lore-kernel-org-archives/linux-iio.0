Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA174AD4DA;
	Fri, 25 Sep 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347141; cv=none; b=pqtRh4FOXJ4r1TM/xBlQukSJ2Ub/qby3dk0Hw9WqS1xaBFvIfb9NG9vnVET8ikc82tMiovTdyQIGTapRu4yPYh8dYVpVekaL+TvXwZvQM1uH1hfRBOUqEzUQil9AojZD5IUuS9YEhF/j4MA3gIfjCrcZvqK5HD73ll1bEXcYO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347141; c=relaxed/simple;
	bh=alasBzH/CbaGowjvqdfp37bzoQoRMriv8SHRTpAoWYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=emnjD0EoqN7MSDnJMcahSWRu7kgY/eSYsOLmYY7zcLr+UQAxi0BPrWJO2hQmLIzP83Lgk1soVvDkwZnoA3IZc86Ll4EBVdJlek4l9GtPbu71SEShWT96xskRcCF3iWhiiyURLroPwHM5r+ZuHRsGmnuZEJNdjfLlvg4ccaDqfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FozzSAqk; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FozzSAqk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=alasBzH/CbaGowjvqdfp37bzoQoRMriv8SHRTpAoWYY=; b=F
	ozzSAqkVToCIq3/y/8QXwVIrLRod/3dBm9BBQNDy39QxCoSnRbb69PLXRaor93aq
	yae2LHMXAF5dDdyXVZE1LKl9EbIrT1re11DvDaSp/fbx1J1CM+aHd2v1O2X/57DR
	5gjkGkYUftppb5BmuvR6tTU/aEkdRvgYcP/YNNyw6g=
Date: Fri, 25 Sep 2026 22:38:07 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,
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
In-Reply-To: <araCbz928KEnAamY@ashevche-desk.local>
References: <20260925140945.2254656-1-yaojiale02@163.com>
 <araCbz928KEnAamY@ashevche-desk.local>
X-NTES-SC: AL_Qu2SAv+fuEgj4SKeY+kcn08ShO49XMOyvfoi2YFTc+AEpw/V5gsNWXNaI3v47dizETqAszmbVQhh4+98RrJ6JInPFRTYZri5bgLl5fRaPw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <21e57d3a.1d0c.1a0d9008daa.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aygvCgAX1ARPh7ZqXsVOAA--.46874W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzg89d2q2h08gQgAA39
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wOS0yNSAyMjoxNzoxOSwgIkFuZHkgU2hldmNoZW5rbyIgPGFuZHJpeS5zaGV2Y2hl
bmtvQGludGVsLmNvbT4gd3JvdGU6Cj5PbiBGcmksIFNlcCAyNSwgMjAyNiBhdCAxMDowOTo0M1BN
ICswODAwLCBKaWFsZSBZYW8gd3JvdGU6Cj4+IFRoZSBJSU8gY29yZSBkb2VzIG5vdCBmaWx0ZXIg
ZHVwbGljYXRlIHdyaXRlcyB0byB0aGUgZXZlbnQgZW5hYmxlCj4+IGF0dHJpYnV0ZS4ga3hjamsx
MDEzX3dyaXRlX2V2ZW50X2NvbmZpZygpIGFscmVhZHkgaWdub3JlcyByZXBlYXRlZAo+PiBlbmFi
bGUgcmVxdWVzdHMsIGJ1dCBhIHJlcGVhdGVkIGRpc2FibGUgcmVxdWVzdCBzdGlsbCBjYWxscwo+
PiBreGNqazEwMTNfc2V0X3Bvd2VyX3N0YXRlKGRhdGEsIGZhbHNlKSwgZHJvcHBpbmcgYSBydW50
aW1lIFBNIHJlZmVyZW5jZQo+PiB0aGF0IHdhcyBub3QgYWNxdWlyZWQgZm9yIHRoaXMgcmVxdWVz
dC4gVGhpcyBjYW4gdW5kZXJmbG93IHRoZSBydW50aW1lCj4+IFBNIHVzYWdlIGNvdW50IGFuZCB0
cmlnZ2VyIGEgIlJ1bnRpbWUgUE0gdXNhZ2UgY291bnQgdW5kZXJmbG93IiB3YXJuaW5nLgo+PiAK
Pj4gUmV0dXJuIGVhcmx5IHdoZW4gdGhlIHJlcXVlc3RlZCBzdGF0ZSBhbHJlYWR5IG1hdGNoZXMg
ZXZfZW5hYmxlX3N0YXRlLgo+Cj5Tb3VuZHMgbGlrZSBhIGJ1ZyB0aGF0IG5lZWRzIHRvIGJlIGZp
eGVkIGFuZCBoZW5jZSBGaXhlcyB0YWcgdG8gYmUgYXBwbGllZC4KU3VyZSwgSSdsbCBhZGQgdGhl
IEZpeGVzIHRhZyBpbiB2MiwgMjRoIGxhdGVyLCAgZm9yIGFueSBvdGhlciBjb21tZW50cyBiZWZv
cmUgc2VuZGluZyBpdC4KPgo+LS0gCj5XaXRoIEJlc3QgUmVnYXJkcywKPkFuZHkgU2hldmNoZW5r
bwo+Cg==
