Return-Path: <SRS0=8HRq=KH=xilinx.com=MNARANI@kernel.org>
From: Manish Narani <MNARANI@xilinx.com>
To: Lars-Peter Clausen <lars@metafoo.de>, "jic23@kernel.org"
	<jic23@kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "pmeerw@pmeerw.net"
	<pmeerw@pmeerw.net>, Michal Simek <michals@xilinx.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Anirudha Sarangi <anirudh@xilinx.com>, Srinivas Goud <sgoud@xilinx.com>
Subject: RE: [PATCH 4/4] iio: adc: xilinx: Use devm_ functions while
 requesting irq
Date: Mon, 23 Jul 2018 09:27:03 +0000
Message-ID: 
 <SN6PR02MB4959DB7E5C4D148D21F81E42C1560@SN6PR02MB4959.namprd02.prod.outlook.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
 <1531912331-26431-5-git-send-email-manish.narani@xilinx.com>
 <32791313-d317-c9c3-0760-34d4a4a691f9@metafoo.de>
In-Reply-To: <32791313-d317-c9c3-0760-34d4a4a691f9@metafoo.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

SGkgTGFycywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXJzLVBl
dGVyIENsYXVzZW4gW21haWx0bzpsYXJzQG1ldGFmb28uZGVdDQo+IFNlbnQ6IFRodXJzZGF5LCBK
dWx5IDE5LCAyMDE4IDEwOjA4IFBNDQo+IFRvOiBNYW5pc2ggTmFyYW5pIDxNTkFSQU5JQHhpbGlu
eC5jb20+OyBqaWMyM0BrZXJuZWwub3JnOw0KPiBrbmFhY2suaEBnbXguZGU7IHBtZWVyd0BwbWVl
cncubmV0OyBNaWNoYWwgU2ltZWsNCj4gPG1pY2hhbHNAeGlsaW54LmNvbT47IGxpbnV4LWlpb0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEFuaXJ1ZGhhIFNhcmFuZ2kgPGFu
aXJ1ZGhAeGlsaW54LmNvbT47IFNyaW5pdmFzIEdvdWQNCj4gPHNnb3VkQHhpbGlueC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80XSBpaW86IGFkYzogeGlsaW54OiBVc2UgZGV2bV8gZnVu
Y3Rpb25zIHdoaWxlIHJlcXVlc3RpbmcNCj4gaXJxDQo+IA0KPiA+IEBAIC0xMzEwLDcgKzEzMDgs
NiBAQCBzdGF0aWMgaW50IHhhZGNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gPiAq
cGRldikgIHsNCj4gPiAgCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYgPSBwbGF0Zm9ybV9nZXRf
ZHJ2ZGF0YShwZGV2KTsNCj4gPiAgCXN0cnVjdCB4YWRjICp4YWRjID0gaWlvX3ByaXYoaW5kaW9f
ZGV2KTsNCj4gPiAtCWludCBpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+DQo+
ID4gIAlpaW9fZGV2aWNlX3VucmVnaXN0ZXIoaW5kaW9fZGV2KTsNCj4gPiAgCWlmICh4YWRjLT5v
cHMtPmZsYWdzICYgWEFEQ19GTEFHU19CVUZGRVJFRCkgeyBAQCAtMTMxOCw3ICsxMzE1LDYNCj4g
QEANCj4gPiBzdGF0aWMgaW50IHhhZGNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ID4gIAkJaWlvX3RyaWdnZXJfZnJlZSh4YWRjLT5jb252c3RfdHJpZ2dlcik7DQo+ID4g
IAkJaWlvX3RyaWdnZXJlZF9idWZmZXJfY2xlYW51cChpbmRpb19kZXYpOw0KPiA+ICAJfQ0KPiA+
IC0JZnJlZV9pcnEoaXJxLCBpbmRpb19kZXYpOw0KPiANCj4gVGhpcyBvcGVucyB1cCBhIHJhY2Ug
Y29uZGl0aW9uLiBUaGUgSVJRIG5lZWRzIHRvIGJlIGZyZWVkIGJlZm9yZSBhbnkgb2YgdGhlc2UN
Cj4gb3RoZXIgdGhpbmdzIGJlbG93IHRoZSBmcmVlX2lycSgpIGFyZSBleGVjdXRlZC4NCldpbGwg
bG9vayBpbnRvIGl0IGFuZCBzZW5kIHdpdGggdGFraW5nIGNhcmUgb2YgdGhlIHNhbWUuDQoNCj4g
DQo+ID4gIAljbGtfZGlzYWJsZV91bnByZXBhcmUoeGFkYy0+Y2xrKTsNCj4gPiAgCWNhbmNlbF9k
ZWxheWVkX3dvcmsoJnhhZGMtPnp5bnFfdW5tYXNrX3dvcmspOw0KPiA+ICAJa2ZyZWUoeGFkYy0+
ZGF0YSk7DQo+ID4NCg0KVGhhbmtzLA0KTWFuaXNoDQo=
