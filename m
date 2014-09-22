Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39469 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbaIVBCH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 21 Sep 2014 21:02:07 -0400
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Stanimir Varbanov <svarbanov@mm-sol.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Angelo Compagnucci" <angelo.compagnucci@gmail.com>,
	Doug Anderson <dianders@chromium.org>,
	Fugang Duan <B38611@freescale.com>,
	"Johannes Thumshirn" <johannes.thumshirn@men.de>,
	Jean Delvare <jdelvare@suse.de>,
	Philippe Reynes <tremyfr@yahoo.fr>,
	Lee Jones <lee.jones@linaro.org>,
	"Josh Cartwright" <joshc@codeaurora.org>,
	Stephen Boyd <sboyd@codeaurora.org>,
	"David Collins" <collinsd@codeaurora.org>,
	"Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: RE: [PATCH v2 1/2] iio: vadc: Qualcomm SPMI PMIC voltage ADC driver
Date: Mon, 22 Sep 2014 01:01:12 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998FBC4743E2@DQHE06.ent.ti.com>
References: <1410448403-19402-1-git-send-email-svarbanov@mm-sol.com>
 <1410448403-19402-2-git-send-email-svarbanov@mm-sol.com>
 <54138151.8010902@gmx.de> <54147E97.60808@kernel.org>
 <5416F3E2.3030009@mm-sol.com>
 <4dbc485f-599a-4b50-854c-c2e1c44d4810@email.android.com>
 <541AAC80.1090708@mm-sol.com> <541ED2C0.4040801@kernel.org>
In-Reply-To: <541ED2C0.4040801@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SGVsbG8gSm9uYXRoYW4gYW5kIFN0YW5pbWlyLA0KDQo+ID4+IFNlZSBEb2N1bWVudGF0aW9uL0FC
SS9zeXNmcy1idXMtaWlvDQo+ID4+IE1pbGxpdm9sdHMgSSB0aGluay4uLiBXZSBjb3BpZWQgaHdt
b24gd2hlcmUgcG9zc2libGUuDQo+ID4NCj4gPiBJJ20gYSBiaXQgY29uZnVzZWQgYWJvdXQgdGhl
c2UgdW5pdHMuIEkgc2VhcmNoZWQgcmVmZXJlbmNlcyBvZg0KPiA+IGlpb19yZWFkX2NoYW5uZWxf
cHJvY2Vzc2VkKCkgYW5kIGZvdW5kIGEgZmV3Lg0KPiA+DQo+ID4gVGhlIGlpb19od21vbiBleHBl
Y3RpbmcgbWlsaXZvbHRzLiBPbiB0aGUgb3RoZXIgc2lkZSBscDg3ODgtY2hhcmdlci5jDQo+ID4g
cmVnaXN0ZXJzIGEgZ2V0X3Byb3BlcnR5IG1ldGhvZCBpbiBjaGFyZ2VyLW1hbmFnZXIuYywgd2hp
Y2ggZXhwZWN0cw0KPiA+IG1pY3Jvdm9sdHMgaW4gZ2V0X2JhdHRfdVYoKS4NCj4gSXQncyBkZWZp
bml0ZWx5IG1lYW50IHRvIGJlIG1pbGxpdm9sdHMgKGxpZnRlZCBmcm9tIGh3bW9uIGEgd2hpbGUg
YmFjaykuDQo+IFNlZSBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8NCj4g
DQo+IExvb2tzIGxpa2Ugd2UgaGF2ZSBhIGJ1ZyBpbiBscDg3ODgtY2hhcmdlciAtIGl0IG1pZ2h0
IGJlIG1hdGNoZWQgd2l0aCBvbmUgaW4NCj4gbHA4Nzg4LWFkYywgYnV0IHRoZW4gdGhlcmUgd2ls
bCBiZSBhIGJ1ZyB0aGVyZS4uLg0KPiANCj4gQ2MnZCBNaWxvIEtpbS4NCg0KJ2xwODc4OC1jaGFy
Z2VyJyByZWdpc3RlcnMgbm90IGNoYXJnZXItbWFuYWdlciBidXQgcG93ZXItc3VwcGx5IHN1YnN5
c3RlbS4NCidscDg3ODgtYWRjJyBpcyB0aGUgSUlPIGRyaXZlci4NCidscDg3ODgtY2hhcmdlcicg
aXMgdGhlIElJTyBjb25zdW1lciBvZiBscDg3ODgtYWRjLg0KDQooSG93IHRvIGNvbW11bmljYXRl
IGJldHdlZW4gbHA4Nzg4LWFkYyBhbmQgbHA4Nzg4LWNoYXJnZXIpDQoxLiBBcHBsaWNhdGlvbiBy
ZXF1ZXN0cyB2YmF0dChiYXR0ZXJ5IHZvbHRhZ2UpIGJ5IGFjY2Vzc2luZyAvc3lzL2NsYXNzL3Bv
d2VyLw0KMi4gbHA4Nzg4LWNoYXJnZXIgYXNrcyBscDg3ODgtYWRjIHRvIGdldCBjb252ZXJ0ZWQg
dmJhdHQgdmFsdWUNCjMuIGxwODc4OC1hZGMgZ2V0IHRoZSBiYXR0ZXJ5IEFEQyBmcm9tIHRoZSBk
ZXZpY2UuDQogICBJdCByZXR1cm5zIGNhbGN1bGF0ZWQgbWljcm8gdm9sdGFnZSB0byBscDg3ODgt
Y2hhcmdlci4NCjQuIGxwODc4OC1jaGFyZ2VyIHJlcG9ydHMgdGhpcyB1ViB2YWx1ZSB0byB0aGUg
YXBwbGljYXRpb24NCjUuIEFwcGxpY2F0aW9uIHVzZXMgdVYgb3IgY29udmVydHMgdG8gbVYgb3Ig
ViB1bml0LiBJdCdzIHVwIHRvIHRoZSBhcHAuDQoNClBsZWFzZSBub3RlIHRoYXQgYmF0dGVyeSBh
cHAgYWNjZXNzZXMgbm90IC9zeXMvYnVzL2lpbyBidXQgL3N5cy9jbGFzcy9wb3dlci8uDQoNCkJl
c3QgcmVnYXJkcywNCk1pbG8NCg==
