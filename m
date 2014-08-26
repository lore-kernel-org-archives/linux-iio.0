Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.151]:34995 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751669AbaHZOmr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Aug 2014 10:42:47 -0400
From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>,
	Guenter Roeck <linux@roeck-us.net>
CC: Jonathan Cameron <jic23@kernel.org>,
	"Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: core: Propagate error codes from OF layer to
 client drivers
Date: Tue, 26 Aug 2014 14:35:45 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB510FA9@SW-EX-MBX01.diasemi.com>
References: <1408971437-10751-1-git-send-email-iivanov@mm-sol.com>
		 <53FB5FF7.8020504@kernel.org> <20140825165430.GB14614@roeck-us.net>
	 <1409039490.5256.75.camel@iivanov-dev> <53FC8AB3.2080603@roeck-us.net>
 <1409060908.5256.83.camel@iivanov-dev>
In-Reply-To: <1409060908.5256.83.camel@iivanov-dev>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gQXVndXN0IDI2LCAyMDE0IDE0OjQ4LCBJdmFuIFQuIEl2YW5vdiB3cm90ZToNCg0KPiBPbiBU
dWUsIDIwMTQtMDgtMjYgYXQgMDY6MjUgLTA3MDAsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+ID4g
T24gMDgvMjYvMjAxNCAxMjo1MSBBTSwgSXZhbiBULiBJdmFub3Ygd3JvdGU6DQo+ID4gPiBIaSwN
Cj4gPiA+DQo+ID4gWyAuLi4gXQ0KPiA+ID4NCj4gPiA+IEFub3RoZXIsIGxlc3MgaW50cnVzaXZl
LCBzb2x1dGlvbiB3aWxsIGJlIGlmIHdlIHJldmVydCBsYXN0IHBhdGNoIGFuZCBleHBsaWNpdGx5
DQo+ID4gPiBjaGVjayBmb3IgRVBST0JFX0RFRkVSIG9uIG9mXyBieV9uYW1lKCkgcmV0dXJuLiBI
b3cgdGhpcyBzb3VuZHM/DQo+ID4gPg0KPiA+IEhvdyBpcyB0aGF0IGRpZmZlcmVudCB0byB0aGUg
anVzdCBhY2NlcHRlZCBwYXRjaCA/DQo+IA0KPiBZb3UgbWVhbiB0aGlzIG9uZVsxXS4gSSBoYXZl
IHByZXBhcmVkIGZpeCBsYXN0IEZyaWRheSBhbmQgZm9yZ2V0IHRvDQo+IGNoZWNrIGFnYWluIGJl
Zm9yZSBwb3N0aW5nIGl0LCBzb3JyeS4gUGxlYXNlIGlnbm9yZSBteSBwYXRjaC4NCj4gDQo+IFRo
YW5rcywNCj4gSXZhbg0KPiANCj4gWzFdIGlpbzppbmtlcm46IGZpeCBvdmVyd3JpdHRlbiAtRVBS
T0JFX0RFRkVSIGluIG9mX2lpb19jaGFubmVsX2dldF9ieV9uYW1lDQo+IA0KDQpBcG9sb2dpZXMg
b24gbXkgcGFydCBmb3IgZml4aW5nIG9uZSBwcm9ibGVtIGFuZCBpbnRyb2R1Y2luZyBhbm90aGVy
LiBEaWRuJ3Qgc2VlDQp0aGF0IGluIG15IHRlc3RpbmcsIGFuZCBtaXNzZWQgdGhhdCBwb3RlbnRp
YWwgcmV0dXJuIHZhbHVlIHdoZW4gZXhhbWluaW5nIHRoZQ0KY29kZS4gQXQgdGhlIHRpbWUgSXQg
bG9va2VkIGxpa2UgdGhlIHBhcmVudCBmdW5jdGlvbiB3b3VsZCBvbmx5IGV4cGVjdCBOVUxMDQpw
b2ludGVycyBmb3IgZmFpbHVyZSwgZXNwZWNpYWxseSBnaXZlbiB0aGUgbm9uIENPTkZJR19PRiBk
ZWZpbml0aW9ucyBvZiB0aGUNCmZ1bmN0aW9ucy4gU2hvdWxkJ3ZlIGRlbHZlZCBmdXJ0aGVyLiA6
KA0K
