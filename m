Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A4481652;
	Thu,  4 Jun 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590213; cv=none; b=evhtAb8wr2LIp0WR38uPDujuXcJBVw8r5QGaECXW4Bxo/hrjVTqmn9bEgvcFgi4vywhtt1ndjNVBztjL3S5x51BNArR6LPLGHNkKwyEKZ2nMVX9dx/kfYN4aVfBgwuGEdq3siSSwl8APh27i9QLdTZE7uFZEwE91K6N0Iak985U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590213; c=relaxed/simple;
	bh=ago0IsttniLPoHs380XOhEolUwIybbsuQfzHAUDUALw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DNZBeCIUT3PF7rWarxVj9icfMeZucYbDzf9JzK74Kb36BYp4YhIhrr447jh/ZTIxAhk+MFKWZyxKkgTS91US1ImPTbP1nY4TqZh5mwFx6GKOHeFeTx9FYKvjT2+zxpS0hkn/JG3RfafgxBO29oqe1yy1ntRyDIx+1/8Mj7QWfGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 4 Jun
 2026 18:23:27 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.061; Thu, 4 Jun 2026 18:23:27 +0200
From: Andreas Kempe <andreas.kempe@actia.se>
To: David Lechner <dlechner@baylibre.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Thread-Topic: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Thread-Index: AQHc9CXmt5PDPY90VUWMABLjTdSxxbYuTrCAgAADbYCAAAMsAIAADqyAgAAMk4CAAAKXgA==
Date: Thu, 4 Jun 2026 16:23:27 +0000
Message-ID: <aiGmfzaSj3bNyXkM@w570anl.actianordic.se>
References: <20260604132646.1099072-1-andreas.kempe@actia.se>
 <aiGH7x531jwzOVxF@lore-desk> <aiGKz9iMAUfFqxUP@w570anl.actianordic.se>
 <aiGNeKTzOR30w-Qf@lore-desk> <aiGZxzz8DF-E-tux@w570anl.actianordic.se>
 <CAMknhBG+u__qiLv0aRLYnUW3iYXkYDLHveQ-bs2gGZfBAD6Viw@mail.gmail.com>
In-Reply-To: <CAMknhBG+u__qiLv0aRLYnUW3iYXkYDLHveQ-bs2gGZfBAD6Viw@mail.gmail.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2955B1445F637764
Content-Type: text/plain; charset="utf-8"
Content-ID: <C607DC0ACCA8C14DBA14C4A6ED0BD030@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCBKdW4gMDQsIDIwMjYgYXQgMDY6MTQ6MTFQTSArMDIwMCwgRGF2aWQgTGVjaG5lciB3
cm90ZToNCj4gT24gVGh1LCBKdW4gNCwgMjAyNiBhdCA1OjI54oCvUE0gQW5kcmVhcyBLZW1wZSA8
YW5kcmVhcy5rZW1wZUBhY3RpYS5zZT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUaHUsIEp1biAwNCwg
MjAyNiBhdCAwNDozNjo0MFBNICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3RlOg0KPiA+ID4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+ID4g
Pg0KPiA+ID4gPg0KPiA+ID4gPiA+IElzIGl0IGVub3VnaCwgaWYgdGhlIHNodWIgaXMgYXZhaWxh
YmxlLCB0byBqdXN0IGFsd2F5cyBydW4NCj4gPiA+ID4gPiBzdF9sc202ZHN4X3NldF9wYWdlKCwg
ZmFsc2UpIGJlZm9yZSBjaGVja2luZyB0aGUgd2hvYW1pPw0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+
ID4gPiA+IEkgdGhpbmsgdGhhdCBzaG91bGQgYmUgZmluZSwgeWVzLiBJIG9ubHkgYWRkZWQgdGhl
IHJlYWRvdXQgdG8gbGVzc2VuDQo+ID4gPiA+IHRoZSByaXNrIG9mIHVubmVjZXNzYXJ5IHdyaXRl
cyB0byBwb3RlbnRpYWxseSB1bmtub3duIGRldmljZXMuDQo+ID4gPg0KPiA+ID4gSSBndWVzcyB5
b3UganVzdCBuZWVkIHRvIGNoZWNrIHRoZSBzaHViIGlzIHN1cHBvcnRlZCwgdGhlbiBpdCBpcyBm
aW5lIHRvDQo+ID4gPiBkaXNhYmxlIHNodWIgcmVnaXN0ZXIgYWNjZXNzIGF0IHRoYXQgcG9pbnQg
KGl0IGlzIHN1cHBvc2VkIHRvIGJlIHRoYXQgd2F5KS4NCj4gPiA+DQo+ID4NCj4gPiBZb3UgYXJl
IHRoaW5raW5nIG9mIGdhdGluZyBzdF9sc202ZHN4X3NldF9wYWdlKCkgb24NCj4gPiBzaHViX3Nl
dHRpbmdzLnBhZ2VfbXV4LmFkZHIgbGlrZSBJIGRvLCBidXQgd2l0aG91dCB0aGUgcmVhZD8gT3Ig
ZG8geW91DQo+ID4gd2FudCB0byBnYXRlIG9uIHNvbWV0aGluZyBlbHNlPw0KPiANCj4gSG93IGFi
b3V0IHNldHRpbmcgdGhlIFNXX1JFU0VUIGJpdCBpbiB0aGUgQ1RSTDNfQyByZWdpc3RlciBkdXJp
bmcNCj4gcHJvYmUgdG9vIHRvIGVuc3VyZSB0aGUgcmVzdCBvZiB0aGUgcmVnaXN0ZXJzIGFyZSBp
biBhIGtub3duIHN0YXRlPw0KPiANCg0KV2hpbGUgdGhlIHNodWIgcmVnaXN0ZXIgZmlsZSBpcyBz
ZWxlY3RlZCwgdGhlIHJlc2V0IHJlZ2lzdGVyIGlzDQpzaGFkb3dlZCBzbyBpdCBjYW4ndCBiZSB3
cml0dGVuIHdpdGhvdXQgZmlyc3Qgc2VsZWN0aW5nIHRoZSBub3JtYWwNCnJlZ2lzdGVyIGZpbGUu
IEEgcmVzZXQgaXMgYWxyZWFkeSBjYWxsZWQgZnJvbSBwcm9iZSBpbg0Kc3RfbHNtNmRzeF9pbml0
X2RldmljZSgpIGFmdGVyIHRoZSB3aG9hbWkgY2hlY2sgaGFzIHBhc3NlZC4NCg0KPiA+DQo+ID4g
SSdtIHdpbGxpbmcgdG8gc3VibWl0IGEgdjIgaWYgeW91IHdhbnQgaXQuDQo+ID4NCj4gPg0KPiA+
IEJlc3QgcmVnYXJkcywNCj4gPiBBbmRyZWFzIEtlbXBlDQo+ID4=
