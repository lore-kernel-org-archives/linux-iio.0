Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5803264E7;
	Thu,  8 Oct 2026 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425001; cv=none; b=Y4J9XB/zS5rnf58mf8QiIJZskHbM9AVLbtc4kpgCZpWFaYlV+wc9/WuKpGRWPSQ42nFOUp1lgvAcFNzL1vwPcYJmN3boEveyWG8lYjYP7CnNmHPUHK7jPvn1DFHBhqm0A5/8WIo3eWd0Qex4yUyGUg7WqR+A8CuxOPIDrN8hTVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425001; c=relaxed/simple;
	bh=rL8Acz1Q7vlCIkj9Yc5uI4wETM/1zgTGezUY+fXz8X4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=tWRY7yAq7kSXapJxtRaD4d/QFEt0fkwSuN6dlpRc+79kIzhvUPQQ3sY3ThrkkruLHJO5wmMUeyvlsWO969yQHIFww7RM2jat/4x2TtLQcx5cYpzKk3dvNLgYhbTSAAekn9YVnJVuI8wyXZocbUWe8PS7sE/qfpLCiyVUYtMWsHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GVL2G8hF; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GVL2G8hF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=rL8Acz1Q7vlCIkj9Yc5uI4wETM/1zgTGezUY+fXz8X4=; b=G
	VL2G8hFIyIsQmvZhM2Ee0U16Ghn9OOS1U5b0pJW1+k2IGdUeakIQgV355/WtzVPR
	q4Gudt6mNh/fNhzH3CDMMcEGj7GC00h3hH1zvdWkvpLkB9Q3oagm5YGqvKebB0So
	5hOKWa3wliJvgJ9QtOJ7lVIKhm4z8C2sAdB4PlXRqM=
Date: Thu, 8 Oct 2026 10:02:55 +0800 (CST)
From: =?GBK?B?wO7T07roIA==?= <dayou5941@163.com>
To: "Cosmin-Gabriel Tanislav" <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: "Biju Das" <biju.das.jz@bp.renesas.com>,
	"William Breathitt Gray" <wbg@kernel.org>,
	"liyouhong@kylinos.cn" <liyouhong@kylinos.cn>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re:RE: [PATCH v2 00/15] MTU3 counter fixes and improvements
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <TYRPR01MB15619D1AC671680E50A8EF92585962@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20261004174752.507499-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <TY3PR01MB113462D03DD936D3A21D13A2486962@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TYRPR01MB15619D1AC671680E50A8EF92585962@TYRPR01MB15619.jpnprd01.prod.outlook.com>
X-NTES-SC: AL_Qu2SA/iZu0Es4yWbbekckk4Wjug8Wcexufwj34NTc94Fgyr94yIvQXFsLUbb/M2PAC6lmjK1fR1K4892frFa4/eyUZFZSGQ0k7+xXRn0aw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <66575d8d.214d.1a1193fd2ba.Coremail.dayou5941@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jCgvCgD3p7XQ+cZqOD1TAA--.15759W
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3hD+rWrG+dARPQAA30
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCgoKCgpBdCAyMDI2LTEwLTA1IDE5OjQ3OjA0LCAiQ29zbWluLUdhYnJpZWwg
VGFuaXNsYXYiIDxjb3NtaW4tZ2FicmllbC50YW5pc2xhdi54YUByZW5lc2FzLmNvbT4gd3JvdGU6
Cj4+IEZyb206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4KPj4gU2VudDog
TW9uZGF5LCBPY3RvYmVyIDUsIDIwMjYgMTE6NDUgQU0KPj4gCj4+IEhpIENvc21pbiwKPj4gCj4+
IFRoYW5rcyBmb3IgdGhlIHNlcmllcy4KPj4gCj4+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0KPj4gPiBGcm9tOiBDb3NtaW4gVGFuaXNsYXYgPGNvc21pbi1nYWJyaWVsLnRhbmlzbGF2Lnhh
QHJlbmVzYXMuY29tPgo+PiA+IFNlbnQ6IDA0IE9jdG9iZXIgMjAyNiAxODo0OAo+PiA+IFN1Ympl
Y3Q6IFtQQVRDSCB2MiAwMC8xNV0gTVRVMyBjb3VudGVyIGZpeGVzIGFuZCBpbXByb3ZlbWVudHMK
Pj4gPgo+PiA+IFRoaXMgc2VyaWVzIGRvZXMgc29tZSBjb2RlIHF1YWxpdHkgaW1wcm92ZW1lbnRz
IHRvIHRoZSBNVFUzIGNvdW50ZXIgc3ViZHJpdmVyLCB3aGlsZSBhbHNvIGZpeGluZwo+PiBidWdz
IGFuZAo+PiA+IGFkZGluZyBjYWNoaW5nIHN1cHBvcnQgc28gdGhhdCByZWdpc3RlcnMgYXJlIG5v
dCB0b3VjaGVkIHdoZW4gdGhlIGNvdW50ZXIgaXMgZGlzYWJsZWQsIGFzIHRoZXJlIGlzCj4+IG5v
Cj4+ID4gcmVxdWVzdCBBUEkuCj4+IAo+PiBJIGJlbGlldmUgeW91IG5lZWQgdG8gcmViYXNlIHRo
aXMgc2VyaWVzIG9uIHRvcCBvZlsxXS4KPj4gCj4+IFNpbmNlIHRoaXMgcGF0Y2ggc2VyaWVzIGlz
IGNhY2hpbmcgdXNlcnNwYWNlIHZhbHVlcyBpbiBtZW1vcnksCj4+IEl0IGNhbiBzdXBwb3J0IHN1
c3BlbmQgdG8gUkFNIGFzIHdlbGwgYXMgaW4gc3VzcGVuZCB0byBSQU0sd2UgbG9zZQo+PiB0aGUg
cmVnaXN0ZXIgY29udGVudHMsIHRoaXMgcGF0Y2ggc2VyaWVzIGNhbiBhZGRyZXNzIHRoYXQgbGlt
aXRhdGlvbi4KPj4gQ2FuIHlvdSBhbHNvIHBsZWFzZSBwcmVwYXJlIGEgZm9sbG93IHVwIHBhdGNo
ZXMgZm9yIFNUUiBzdXBwb3J0Pwo+PiAKPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDI2MDkwMzA5MDcxOS4zNDk4OTU1LTEtZGF5b3U1OTQxQDE2My5jb20vCj4+IAo+Cj5IaSBC
aWp1Lgo+Cj5UaGUgY2hhbmdlcyBmcm9tIHBhdGNoIDEgb2YgTGkncyBzZXJpZXMgd2lsbCBzaW1w
bHkgYmUgZHJvcHBlZCBieSB1cyBpZgo+SSByZWJhc2Ugb24gdG9wIG9mIGl0Lgo+Cj5UaGUgY2hh
bmdlcyBmcm9tIHBhdGNoIDIgb2YgTGkncyBzZXJpZXMgYXJlIHN1cGVyc2VkZWQgYnkgb3VyIGNs
ZWFudXBzLgo+Cj5UaGUgY2hhbmdlcyBmcm9tIHBhdGNoIDMgb2YgTGkncyBzZXJpZXMgZGVwZW5k
IG9uIGhpcyBwYXRjaCAyIGNoYW5nZXMsCj5hbmQgYXJlIGVxdWl2YWxlbnQgdG8gb3VyIHBhdGNo
IDEuCj4KPkkgdGhpbmsgaXQgd291bGQgYmUgYmVzdCBpZiBMaSByZS1zdWJtaXR0ZWQganVzdCBw
YXRjaCAzIGFsb25lIHdpdGhvdXQKPmFueSBkZXBlbmRlbmNpZXMsIHNvIHRoYXQgaXQgY2FuIGJl
IGFjY2VwdGVkLCBzaW5jZSBoZSBhbHNvIHN1Ym1pdHRlZAo+aXQgYmVmb3JlIHdlIGRpZCBhbmQg
d2UgZHVwbGljYXRlZCBoaXMgd29yayBhY2NpZGVudGFsbHkuCj4KPkFmdGVyIGhpcyBwYXRjaCBp
cyBhY2NlcHRlZCBJIHdpbGwgcmUtc3VibWl0IHRoaXMgc2VyaWVzIHdpdGhvdXQgcGF0Y2gKPjEu
Cj4KCj5XaGF0IGRvIHlvdSB0aGluaywgV2lsbGlhbSwgTGk/CgoKSGkgQ29zbWluLCBXaWxsaWFt
LAoKCkFncmVlZC4gSSdsbCByZXNlbmQganVzdCB0aGUgcnVudGltZSBQTSBwdXQgb24gdGhlIGlu
aXRpYWxpemF0aW9uIGVycm9yIHBhdGgsCmJhc2VkIG9uIHRoZSBjdXJyZW50IHBtX3J1bnRpbWVf
Z2V0X3N5bmMoKSBjb2RlLiBJdCBubyBsb25nZXIgZGVwZW5kcyBvbiB0aGUKb3RoZXIgdHdvIHBh
dGNoZXMuCgoKVGhhbmtzLApMaQ==
